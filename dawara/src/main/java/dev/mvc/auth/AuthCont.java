package dev.mvc.auth;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryProcInter;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import nation.web.tool.Messages;

@Controller
public class AuthCont {
  @Autowired
  @Qualifier("dev.mvc.tool.Messages")
  private Messages messages = null;
  
  @Autowired
  @Qualifier("dev.mvc.auth.AuthProc") // 할당되는 Class 객체의 이름
  private AuthProcInter authProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;

  public AuthCont() {
  }
  
  // http://localhost:9090/ojt/categrp/create.do
  // http://localhost:9090/ojt/categrp/create.jsp
  @RequestMapping(value="/auth/create.do", method=RequestMethod.GET)
  public ModelAndView create(Locale locale) {
    // System.out.println("CategrpCont create() GET called.");
    
    ModelAndView mav = new ModelAndView();
    
//    if (categrpProc != null) {
//      System.out.println("--> categrpProc: " + categrpProc.hashCode());
//    }
    
    mav.setViewName("/auth/create"); // /categrp/create.jsp
    
    return mav;
  }

  @RequestMapping(value="/auth/create.do", method=RequestMethod.POST)
  public ModelAndView create(AuthVO authVO, Locale locale) {
    ModelAndView mav = new ModelAndView();
    
//    if (categrpProc != null) {
//      System.out.println("--> categrpProc: " + categrpProc.hashCode());
//    }
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    if (authProc.create(authVO) == 1) {
      msgs.add(messages.getMessage("auth.create.success", authVO.getAuth_info(),  locale));
      // mav.setViewName("redirect:/categrp/list.do");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">"+messages.getMessage("auth.button.list", authVO.getAuth_info(),  locale)+"</button>");
    } else {
      msgs.add(messages.getMessage("auth.create.fail", authVO.getAuth_info(), locale));
      msgs.add(messages.getMessage("auth.create.retry",  locale)); // 다시 시도
      links.add("<button type='button' onclick=\"history.back();\">"+messages.getMessage("auth.button.retry", authVO.getAuth_info(),  locale)+"</button>");
    }

    mav.addObject("msgs", msgs);
    // request.setAttribute("msgs", msgs);
    mav.addObject("links", links);
    
    mav.setViewName("/auth/message"); // /categrp/message.jsp
    
    return mav;
  }

  @RequestMapping(value="/auth/list.do", method=RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    
    List<AuthVO> list = authProc.list();
    mav.addObject("list", list);
    
    mav.setViewName("/auth/list"); // /categrp/list.jsp
    
    return mav;
  }
  
  @ResponseBody
  @RequestMapping(value="/auth/update.do", 
                            method=RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String update(int auth_no) {
    //System.out.println("CategrpCont update(int categrpno) GET called.");
    
    AuthVO authVO = authProc.read(auth_no);
    
    JSONObject obj = new JSONObject();
    obj.put("auth_no", authVO.getAuth_no());
    obj.put("auth_info", authVO.getAuth_info());
    obj.put("auth_seqno", authVO.getAuth_seqno());
    obj.put("auth_rdate", authVO.getAuth_rdate());
    
    System.out.println(obj.toJSONString());
    
    return obj.toJSONString();
  }
 
  @RequestMapping(value="/auth/update.do", method=RequestMethod.POST)
  public ModelAndView update(AuthVO authVO) {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    if (authProc.update(authVO) == 1) {
      mav.setViewName("redirect:/auth/list.do");
    } else {
      msgs.add("권한 수정에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/auth/message"); // /categrp/message.jsp
    }

    return mav;
  }

  @ResponseBody
  @RequestMapping(value = "/auth/delete.do", 
                             method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String delete_form(int auth_no) {
    System.out.println("--> delete() GET executed");

    int count_member = memberProc.select_count_member(auth_no);
    int count_login = memberProc.select_count_login(auth_no);
    int count_access_url = authProc.select_count_access_url(auth_no);
    
    JSONObject obj = new JSONObject();
    obj.put("count_member", count_member);
    obj.put("count_login", count_login);
    obj.put("count_access_url", count_access_url);
   
    return obj.toJSONString();
  }
  
  /**
   * 삭제 처리
   * @param categrpVO
   * @return
   */
  @RequestMapping(value="/auth/delete.do", method=RequestMethod.POST)
  public ModelAndView delete(int auth_no, Locale locale) {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    // 현재 삭제되는 그룹정보 읽어옴.
    AuthVO authVO = authProc.read(auth_no);
    
    // 자식 테이블 레코드 먼저 삭제
    int member_count = memberProc.delete_count_member(auth_no);
    int login_count = memberProc.delete_count_login(auth_no);
    int access_url_count = authProc.delete_access_url(auth_no);
    
    if (member_count > 0) {
      msgs.add(messages.getMessage("auth.delete.member_count", authVO.getAuth_info()+"/"+member_count, locale));
      if(login_count > 0){
        msgs.add(messages.getMessage("auth.delete.login_count", authVO.getAuth_info()+"/"+login_count, locale));
      }if(access_url_count > 0){
        msgs.add(messages.getMessage("auth.delete.access_url_count", authVO.getAuth_info()+"/"+access_url_count, locale));
      }
    }
    
    // 카테고리 그룹 삭제
    if (authProc.delete(auth_no) == 1) {
      // mav.setViewName("redirect:/categrp/list.do");
 
      msgs.add(messages.getMessage("auth.delete.success", authVO.getAuth_info(), locale));

      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");
    } else {
      msgs.add(messages.getMessage("auth.delete.fail", authVO.getAuth_info(), locale));
      msgs.add(messages.getMessage("auth.delete.retry", locale));
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");
    }

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    
    mav.setViewName("/auth/message"); // /categrp/message.jsp
    
    return mav;
  }

  @RequestMapping(value = "/auth/update_seqno_up.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_up(int auth_no) {
    ModelAndView mav = new ModelAndView();

    if (authProc.update_seqno_up(auth_no) == 1) {
      mav.setViewName("redirect:/auth/list.do");
    }

    return mav;
  }

  @RequestMapping(value = "/auth/update_seqno_down.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_down(int auth_no) {
    ModelAndView mav = new ModelAndView();

    if (authProc.update_seqno_down(auth_no) == 1) {
      mav.setViewName("redirect:/auth/list.do");
    }

    return mav;
  }
  
  // http://localhost:9090/ojt/categrp/create.do
  // http://localhost:9090/ojt/categrp/create.jsp
  @RequestMapping(value="/auth/create_url.do", method=RequestMethod.GET)
  public ModelAndView create_url(Locale locale) {
    // System.out.println("CategrpCont create() GET called.");
    
    ModelAndView mav = new ModelAndView();
    
//    if (categrpProc != null) {
//      System.out.println("--> categrpProc: " + categrpProc.hashCode());
//    }
    
    mav.setViewName("/auth/create_url"); // /categrp/create.jsp
    
    return mav;
  }
  
  @RequestMapping(value="/auth/create_url.do", method=RequestMethod.POST)
  public ModelAndView create_url(AuthVO authVO, Locale locale) {
    ModelAndView mav = new ModelAndView();
    
//    if (categrpProc != null) {
//      System.out.println("--> categrpProc: " + categrpProc.hashCode());
//    }
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    if (authProc.create_url(authVO) == 1) {
      msgs.add(messages.getMessage("url.create.success", authVO.getUrl(),  locale));
      // mav.setViewName("redirect:/categrp/list.do");
      links.add("<button type='button' onclick=\"location.href='./list_url.do'\">"+messages.getMessage("url.button.list", authVO.getUrl(),  locale)+"</button>");
    } else {
      msgs.add(messages.getMessage("url.create.fail", authVO.getUrl(), locale));
      msgs.add(messages.getMessage("url.create.retry",  locale)); // 다시 시도
      links.add("<button type='button' onclick=\"history.back();\">"+messages.getMessage("url.button.retry", authVO.getUrl(),  locale)+"</button>");
    }
    
    mav.addObject("msgs", msgs);
    // request.setAttribute("msgs", msgs);
    mav.addObject("links", links);
    
    mav.setViewName("/auth/message"); // /categrp/message.jsp
    
    return mav;
  }
  
  @RequestMapping(value="/auth/list_url.do", method=RequestMethod.GET)
  public ModelAndView list_url() {
    ModelAndView mav = new ModelAndView();
    
    List<AuthVO> list = authProc.list_url();
    mav.addObject("list", list);
    
    mav.setViewName("/auth/list_url"); // /categrp/list.jsp
    
    return mav;
  }
  
  @ResponseBody
  @RequestMapping(value="/auth/update_url.do", 
  method=RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String update_url(int url_no) {
    //System.out.println("CategrpCont update(int categrpno) GET called.");
    
    AuthVO authVO = authProc.read_url(url_no);
    
    JSONObject obj = new JSONObject();
    obj.put("url_no", authVO.getUrl_no());
    obj.put("url", authVO.getUrl());
    obj.put("url_info", authVO.getUrl_info());
    obj.put("url_seqno", authVO.getUrl_seqno());
    obj.put("url_rdate", authVO.getUrl_rdate());

    System.out.println(obj.toJSONString());
    
    return obj.toJSONString();
  }
  
  @RequestMapping(value="/auth/update_url.do", method=RequestMethod.POST)
  public ModelAndView update_url(AuthVO authVO) {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    if (authProc.update_url(authVO) == 1) {
      mav.setViewName("redirect:/auth/list_url.do");
    } else {
      msgs.add("권한 수정에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list_url.do'\">목록</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/auth/message"); // /categrp/message.jsp
    }
    
    return mav;
  }
    
   /**
   * 삭제 처리
   * @param categrpVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/auth/delete_url.do", 
                             method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String delete_form_url(int url_no) {
    //System.out.println("--> delete() GET executed");

    int count_access_url = authProc.select_count_access_url_urltb(url_no);
    
    JSONObject obj = new JSONObject();
    obj.put("count_access_url", count_access_url);
   
    return obj.toJSONString();
  }
  
  /**
   * 삭제 처리
   * @param categrpVO
   * @return
   */
  @RequestMapping(value="/auth/delete_url.do", method=RequestMethod.POST)
  public ModelAndView delete_url(int url_no, Locale locale) {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    // 현재 삭제되는 그룹정보 읽어옴.
    AuthVO authVO = authProc.read_url(url_no);
    
    //자식 테이블 레코드 먼저 삭제
    int access_url_count = authProc.delete_count_access_url_urltb(url_no);
    
    if (access_url_count > 0) {
      msgs.add(messages.getMessage("url.delete.access_url_count", authVO.getUrl()+"/"+access_url_count, locale));
      }
    
    // 카테고리 그룹 삭제
    if (authProc.delete_url(url_no) == 1) {
      // mav.setViewName("redirect:/categrp/list.do");
      msgs.add(messages.getMessage("url.delete.success", authVO.getUrl(), locale));
      
      links.add("<button type='button' onclick=\"location.href='./list_url.do'\">목록</button>");
    } else {
      msgs.add(messages.getMessage("url.delete.fail", authVO.getUrl(), locale));
      msgs.add(messages.getMessage("url.delete.retry", locale));
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list_url.do'\">목록</button>");
    }
    
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    
    mav.setViewName("/auth/message"); // /categrp/message.jsp
    
    return mav;
  }
  
  @RequestMapping(value = "/auth/update_seqno_up_url.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_up_url(int url_no) {
    ModelAndView mav = new ModelAndView();
    
    if (authProc.update_seqno_up_url(url_no) == 1) {
      mav.setViewName("redirect:/auth/list_url.do");
    }
    
    return mav;
  }
  
  @RequestMapping(value = "/auth/update_seqno_down_url.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_down_url(int url_no) {
    ModelAndView mav = new ModelAndView();
    
    if (authProc.update_seqno_down_url(url_no) == 1) {
      mav.setViewName("redirect:/auth/list_url.do");
    }
    
    return mav;
  }
  
  // http://localhost:9090/ojt/categrp/create.do
  // http://localhost:9090/ojt/categrp/create.jsp
  @RequestMapping(value="/auth/create_access_url.do", method=RequestMethod.GET)
  public ModelAndView create_access_url(Locale locale) {
    // System.out.println("CategrpCont create() GET called.");
    
    ModelAndView mav = new ModelAndView();
    
//    if (categrpProc != null) {
//      System.out.println("--> categrpProc: " + categrpProc.hashCode());
//    }
    
    mav.setViewName("/auth/create_access_url"); // /categrp/create.jsp
    
    return mav;
  }
  
  @RequestMapping(value="/auth/create_access_url.do", method=RequestMethod.POST)
  public ModelAndView create_access_url(AuthVO authVO, Locale locale) {
    ModelAndView mav = new ModelAndView();
    
//    if (categrpProc != null) {
//      System.out.println("--> categrpProc: " + categrpProc.hashCode());
//    }
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    if (authProc.create_access_url(authVO) == 1) {
      msgs.add(messages.getMessage("access_url.create.success", authVO.getAccess_url_info(),  locale));
      // mav.setViewName("redirect:/categrp/list.do");
      links.add("<button type='button' onclick=\"location.href='./list_access_url.do'\">"+messages.getMessage("access_url.button.list", authVO.getAccess_url_info(),  locale)+"</button>");
    } else {
      msgs.add(messages.getMessage("access_url.create.fail", authVO.getAccess_url_info(), locale));
      msgs.add(messages.getMessage("access_url.create.retry",  locale)); // 다시 시도
      links.add("<button type='button' onclick=\"history.back();\">"+messages.getMessage("access_url.button.retry", authVO.getAccess_url_info(),  locale)+"</button>");
    }
    
    mav.addObject("msgs", msgs);
    // request.setAttribute("msgs", msgs);
    mav.addObject("links", links);
    
    mav.setViewName("/auth/message"); // /categrp/message.jsp
    
    return mav;
  }
  
  @RequestMapping(value="/auth/list_access_url.do", method=RequestMethod.GET)
  public ModelAndView list_access_url() {
    ModelAndView mav = new ModelAndView();
    
    List<AuthVO> list = authProc.list_access_url();
    mav.addObject("list", list);
    
    mav.setViewName("/auth/list_access_url"); // /categrp/list.jsp
    
    return mav;
  }
  
  @ResponseBody
  @RequestMapping(value="/auth/update_access_url.do", 
  method=RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String update_access_url(int access_url_no) {
    //System.out.println("CategrpCont update(int categrpno) GET called.");
    
    AuthVO authVO = authProc.read_access_url(access_url_no);
    
    JSONObject obj = new JSONObject();
    obj.put("access_url_no", authVO.getAccess_url_no());
    obj.put("auth_no", authVO.getAuth_no());
    obj.put("url_no", authVO.getUrl_no());
    obj.put("access_url_info", authVO.getAccess_url_info());
    obj.put("access_url_seqno", authVO.getAccess_url_seqno());
    obj.put("access_url_rdate", authVO.getAccess_url_rdate());
    
    System.out.println(obj.toJSONString());
    
    return obj.toJSONString();
  }
  
  @RequestMapping(value="/auth/update_access_url.do", method=RequestMethod.POST)
  public ModelAndView update_access_url(AuthVO authVO) {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    if (authProc.update_access_url(authVO) == 1) {
      mav.setViewName("redirect:/auth/list_access_url.do");
    } else {
      msgs.add("권한 수정에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list_url.do'\">목록</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/auth/message"); // /categrp/message.jsp
    }
    
    return mav;
  }
  
  /**
   * 삭제 처리
   * @param categrpVO
   * @return
   */
  @RequestMapping(value="/member/delete_access_url.do", method=RequestMethod.GET, 
      produces = "text/plain;charset=UTF-8")
  public String delete_form_access_url(int access_url_no) {
    
    int count = authProc.delete_url(access_url_no);
    
    JSONObject obj = new JSONObject();
    obj.put("count", count);
    
    return obj.toJSONString();
  }
  
  /**
   * 삭제 처리
   * @param categrpVO
   * @return
   */
  @RequestMapping(value="/auth/delete_access_url.do", method=RequestMethod.POST)
  public ModelAndView delete_access_url(int access_url_no, Locale locale) {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    // 현재 삭제되는 그룹정보 읽어옴.
    AuthVO authVO = authProc.read_access_url(access_url_no);
    
    // 자식 테이블 레코드 먼저 삭제
    // int member_count = memberProc.delete_count_member(auth_no);
    // int login_count = memberProc.delete_count_login(auth_no);
    
    /*if (member_count > 0) {
      msgs.add(messages.getMessage("auth.delete.member_count", authVO.getAuth_info()+"/"+member_count, locale));
      if(login_count > 0){
        msgs.add(messages.getMessage("auth.delete.login_count", authVO.getAuth_info()+"/"+login_count, locale));
      }
    }*/
    
    // 카테고리 그룹 삭제
    if (authProc.delete_access_url(access_url_no) == 1) {
      // mav.setViewName("redirect:/categrp/list.do");
      
      msgs.add(messages.getMessage("access_url.delete.success", authVO.getAccess_url_info(), locale));
      
      links.add("<button type='button' onclick=\"location.href='./list_access_url.do'\">목록</button>");
    } else {
      msgs.add(messages.getMessage("access_url.delete.fail", authVO.getAccess_url_info(), locale));
      msgs.add(messages.getMessage("access_url.delete.retry", locale));
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list_access_url.do'\">목록</button>");
    }
    
    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    
    mav.setViewName("/auth/message"); // /categrp/message.jsp
    
    return mav;
  }
  
  @RequestMapping(value = "/auth/update_seqno_up_access_url.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_up_access_url(int access_url_no) {
    ModelAndView mav = new ModelAndView();
    
    if (authProc.update_seqno_up_access_url(access_url_no) == 1) {
      mav.setViewName("redirect:/auth/list_access_url.do");
    }
    
    return mav;
  }
  
  @RequestMapping(value = "/auth/update_seqno_down_access_url.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_down_access_url(int access_url_no) {
    ModelAndView mav = new ModelAndView();
    
    if (authProc.update_seqno_down_access_url(access_url_no) == 1) {
      mav.setViewName("redirect:/auth/list_access_url.do");
    }
    
    return mav;
  }
}








