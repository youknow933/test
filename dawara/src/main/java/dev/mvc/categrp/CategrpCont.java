package dev.mvc.categrp;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryProcInter;
import nation.web.tool.Messages;

@Controller
public class CategrpCont {
  @Autowired
  @Qualifier("dev.mvc.tool.Messages")
  private Messages messages = null;
  
  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpProc") // 할당되는 Class 객체의 이름
  private CategrpProcInter categrpProc;
  
  @Autowired
  @Qualifier("dev.mvc.category.CategoryProc") 
  private CategoryProcInter categoryProc = null;
  
  public CategrpCont() {
    System.out.println("CategrpCont created.");    
  }
  
  // http://localhost:9090/ojt/categrp/create.do
  // http://localhost:9090/ojt/categrp/create.jsp
  @RequestMapping(value="/categrp/create.do", method=RequestMethod.GET)
  public ModelAndView create(Locale locale) {
    // System.out.println("CategrpCont create() GET called.");
    
    ModelAndView mav = new ModelAndView();
    
//    if (categrpProc != null) {
//      System.out.println("--> categrpProc: " + categrpProc.hashCode());
//    }
    
    mav.setViewName("/categrp/create"); // /categrp/create.jsp
    
    return mav;
  }

  @RequestMapping(value="/categrp/create.do", method=RequestMethod.POST)
  public ModelAndView create(CategrpVO categrpVO, Locale locale) {
    ModelAndView mav = new ModelAndView();
    
//    if (categrpProc != null) {
//      System.out.println("--> categrpProc: " + categrpProc.hashCode());
//    }
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    if (categrpProc.create(categrpVO) == 1) {
      msgs.add(messages.getMessage("categrp.create.success", categrpVO.getGrp_title(),  locale));
      // mav.setViewName("redirect:/categrp/list.do");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">"+messages.getMessage("categrp.button.list", categrpVO.getGrp_title(),  locale)+"</button>");
    } else {
      msgs.add(messages.getMessage("categrp.create.fail", categrpVO.getGrp_title(), locale));
      msgs.add(messages.getMessage("categrp.create.retry",  locale)); // 다시 시도
      links.add("<button type='button' onclick=\"history.back();\">"+messages.getMessage("categrp.button.retry", categrpVO.getGrp_title(),  locale)+"</button>");
    }

    mav.addObject("msgs", msgs);
    // request.setAttribute("msgs", msgs);
    mav.addObject("links", links);
    
    mav.setViewName("/categrp/message"); // /categrp/message.jsp
    
    return mav;
  }

  @RequestMapping(value="/categrp/list.do", method=RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    
    List<CategrpVO> list = categrpProc.list();
    mav.addObject("list", list);
    
    mav.setViewName("/categrp/list"); // /categrp/list.jsp
    
    return mav;
  }
  
  @ResponseBody
  @RequestMapping(value="/categrp/update.do", 
                            method=RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String update(int grp_no) {
    System.out.println("CategrpCont update(int grp_no) GET called.");
    
    CategrpVO categrpVO = categrpProc.read(grp_no);
    
    JSONObject obj = new JSONObject();
    obj.put("grp_no", categrpVO.getGrp_no());
    obj.put("grp_classification", categrpVO.getGrp_classification());
    obj.put("grp_title", categrpVO.getGrp_title());
    obj.put("grp_seqno", categrpVO.getGrp_seqno());
    obj.put("grp_visible", categrpVO.getGrp_visible());
    obj.put("grp_rdate", categrpVO.getGrp_rdate());
    
    System.out.println(obj.toJSONString());
    
    return obj.toJSONString();
  }
 
  @RequestMapping(value="/categrp/update.do", method=RequestMethod.POST)
  public ModelAndView update(CategrpVO categrpVO) {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    if (categrpProc.update(categrpVO) == 1) {
      mav.setViewName("redirect:/categrp/list.do");
    } else {
      msgs.add("카테고리 그룹 수정에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/categrp/message"); // /categrp/message.jsp
    }

    return mav;
  } 

  @ResponseBody
  @RequestMapping(value = "/categrp/delete.do", 
                             method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String delete_form(int grp_no, Locale locale) {
    System.out.println("--> delete() GET executed");

    int count = categoryProc.countBygrp_no(grp_no);

    JSONObject obj = new JSONObject();
    obj.put("count", count);

    return obj.toJSONString(); 
  }
  
  /**
   * 삭제 처리
   * @param categrpVO
   * @return
   */
  @RequestMapping(value="/categrp/delete.do", method=RequestMethod.POST)
  public ModelAndView delete(int grp_no, Locale locale) {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    // 현재 삭제되는 그룹정보 읽어옴.
    CategrpVO categrpVO = categrpProc.read(grp_no);
    
    // 자식 테이블 레코드 먼저 삭제
    int category_count = categoryProc.deleteBygrp_no(grp_no);
    
    if (category_count > 0) { 
      msgs.add(messages.getMessage("categrp.delete.count", categrpVO.getGrp_title()+"/"+category_count, locale));
    }
    
    // 카테고리 그룹 삭제
    if (categrpProc.delete(grp_no) == 1) {
      // mav.setViewName("redirect:/categrp/list.do");
 
      msgs.add(messages.getMessage("categrp.delete.success", categrpVO.getGrp_title(), locale));

      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");
    } else {
      msgs.add(messages.getMessage("categrp.delete.fail", categrpVO.getGrp_title(), locale));
      msgs.add(messages.getMessage("categrp.delete.retry", locale));
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");
    }

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    
    mav.setViewName("/categrp/message"); // /categrp/message.jsp
    
    return mav;
  }

  @RequestMapping(value = "/categrp/update_seqno_up.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_up(int grp_no) {
    ModelAndView mav = new ModelAndView();

    if (categrpProc.update_seqno_up(grp_no) == 1) {
      mav.setViewName("redirect:/categrp/list.do");
    }

    return mav;
  }

  @RequestMapping(value = "/categrp/update_seqno_down.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_down(int grp_no) {
    ModelAndView mav = new ModelAndView();

    if (categrpProc.update_seqno_down(grp_no) == 1) {
      mav.setViewName("redirect:/categrp/list.do");
    }

    return mav;
  }
  
  
  
}








