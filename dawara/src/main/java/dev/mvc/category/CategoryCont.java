package dev.mvc.category;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.categrp.CategrpProcInter;
import dev.mvc.categrp.CategrpVO;

@Controller
public class CategoryCont {
  
  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpProc") // 할당되는 Class 객체의 이름
  private CategrpProcInter categrpProc;
  
  @Autowired
  @Qualifier("dev.mvc.category.CategoryProc")
  private CategoryProcInter categoryProc = null;
  
  public CategoryCont() { 
    System.out.println("--> CategoryCont created.");
  }
  
  // http://localhost:9090/ojt/category/create.do
  // http://localhost:9090/ojt/category/create.jsp
  @RequestMapping(value="/category/create.do", method=RequestMethod.GET)
  public ModelAndView create(int grp_no) {
    ModelAndView mav = new ModelAndView();
    
    CategrpVO categrpVO = categrpProc.read(grp_no);
    mav.addObject("categrpVO", categrpVO);
//    if (categrpProc != null) {
//      System.out.println("--> categrpProc: " + categrpProc.hashCode());
//    }
    mav.setViewName("/category/create"); // /category/create.jsp
    
    return mav; 
  }

  @RequestMapping(value="/category/create.do", method=RequestMethod.POST)
  public ModelAndView create(CategoryVO categoryVO, HttpSession Session) {
    ModelAndView mav = new ModelAndView();
    
//    if (categrpProc != null) {
//      System.out.println("--> categrpProc: " + categrpProc.hashCode());
//    }
    
    int mem_no = (Integer)Session.getAttribute("mem_no");
    mav.addObject("mem_no", mem_no);
    categoryVO.setMem_no(mem_no);
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    // System.out.println("categoryVO.getCategrpno(): " + categoryVO.getCategrpno());
    // System.out.println("categoryVO.getTitle(): " + categoryVO.getTitle());
    
    if (categoryProc.create(categoryVO) == 1) {
      // msgs.add("카테고리 그룹을 등록했습니다.");
      mav.setViewName("redirect:/category/list.do?grp_no=" + categoryVO.getGrp_no());
    } else {
      msgs.add("카테고리 등록에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

      mav.addObject("msgs", msgs);
      // request.setAttribute("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/category/message"); // /categrp/message.jsp
    }

    return mav;
  }

  @RequestMapping(value="/category/list_all.do", method=RequestMethod.GET)
  public ModelAndView list(){
     System.out.println("--> list() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/list"); // webapp/category/list.jsp
    
    List<Categrp_CategoryVO> list = categoryProc.list();
    mav.addObject("list", list);
    
    return mav;
  }
  
  @RequestMapping(value="/category/list.do", method=RequestMethod.GET)
  public ModelAndView list_by_grp_no(int grp_no, HttpSession Session){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/list"); // webapp/category/list.jsp 
    
    CategrpVO categrpVO = categrpProc.read(grp_no);
    mav.addObject("categrpVO", categrpVO);
    
    List<Categrp_CategoryVO> list = categoryProc.list_by_grp_no(grp_no);
    mav.addObject("list", list);
    
    return mav;
  }
  
  @RequestMapping(value="/category/list_index.do", method=RequestMethod.GET)
  public ModelAndView list_index(HttpServletRequest request){
    // System.out.println("--> list_index() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/category/list_index"); // webapp/category/list_index.jsp
    
    List<CategrpVO> categrp_list = categrpProc.list(); // 카테고리 그룹 목록
    
    // Categrp: name, Category: title 결합 목록
    ArrayList<String> name_title_list = new ArrayList<String>();   
    
    StringBuffer url = new StringBuffer(); // 카테고리 제목 링크 조합

    // 카테고리 그룹 갯수만큼 순환
    for (int index = 0; index < categrp_list.size(); index++) {
      CategrpVO categrpVO = categrp_list.get(index);

      name_title_list.add("<LI class='cgrp_title'>"+ categrpVO.getGrp_title() + "</LI>"); 

      List<Categrp_CategoryVO> category_list = categoryProc.list_by_grp_no(categrpVO.getGrp_no()); // 카테고리 Join 목록
      
      // 카테고리 갯수만큼 순환
      for (int j=0; j < category_list.size(); j++) {
        Categrp_CategoryVO categrp_CategoryVO = category_list.get(j);
        String gory_title = categrp_CategoryVO.getGory_title(); // 카테고리 이름
        int cnt = categrp_CategoryVO.getCnt();
        
        url.append("<LI class='category_title'>");
        url.append("  <A href='" + request.getContextPath()+ "/content/list_by_category.do?gory_no"+categrp_CategoryVO.getGory_no()+"'>");
        url.append(gory_title);
        url.append("  </A>");
        url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
        url.append("</LI>");
        name_title_list.add(url.toString()); // 출력 목록에 하나의 category 추가 
        
        url.delete(0, url.toString().length()); // StringBuffer 문자열 삭제
        
      } 
    }
    
    mav.addObject("name_title_list", name_title_list);
//    mav.addObject("total_count", contentsProc.total_count());
    
    return mav;
  }
  
  /**
  <Xmp>
    수정 폼 
    SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
    FROM category 
    WHERE categoryno=#{categoryno} 
  </Xmp>
  * 
  * @param categrpno
  * @return
  */
 @ResponseBody
 @RequestMapping(value = "/category/update.do", method = RequestMethod.GET, 
                           produces = "text/plain;charset=UTF-8")
 public String update(int gory_no) {
// System.out.println("--> update() GET executed");

   CategoryVO categoryVO = categoryProc.read(gory_no);

   JSONObject obj = new JSONObject();
   obj.put("gory_no", gory_no);
   obj.put("grp_no", categoryVO.getGrp_no());
   obj.put("gory_title", categoryVO.getGory_title());
   obj.put("gory_seqno", categoryVO.getGory_seqno()); 
   obj.put("gory_visible",categoryVO.getGory_visible());
   obj.put("gory_ids", categoryVO.getGory_ids());
   obj.put("gory_rdate", categoryVO.getGory_rdate());

   return obj.toJSONString();
 }

 @RequestMapping(value = "/category/update.do", 
                            method = RequestMethod.POST)
 public ModelAndView update(CategoryVO categoryVO) {
// System.out.println("--> update() POST executed");
   ModelAndView mav = new ModelAndView();
  
   ArrayList<String> msgs = new ArrayList<String>();
   ArrayList<String> links = new ArrayList<String>();

   if (categoryProc.update(categoryVO) == 1) {
     // msgs.add("카테고리를 변경했습니다.");
     mav.setViewName("redirect:/category/list.do?grp_no=" + categoryVO.getGrp_no());
   } else {
     msgs.add("카테고리를 변경에 실패했습니다.");
     msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
     links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

     mav.addObject("msgs", msgs);
     mav.addObject("links", links);

     mav.setViewName("/category/message"); // /webapp/categrp/message.jsp

   }

   return mav;
 }
 
 /**
  * 삭제 처리
  * @param categrpno 카테고리 그룹 번호
  * @param categoryno 삭제할 레코드 번호
  * @return
  */
 @RequestMapping(value = "/category/delete.do", method = RequestMethod.POST)
 public ModelAndView delete(int grp_no, int gory_no) { // CategoryVO categoryVO
   // System.out.println("--> delete() POST executed");

   ModelAndView mav = new ModelAndView();

   ArrayList<String> msgs = new ArrayList<String>();
   ArrayList<String> links = new ArrayList<String>();

   int count = categoryProc.delete(gory_no);
// System.out.println("categoryno: " + categoryno);
// System.out.println("count: " + count);

   if (count == 1) {
     // msgs.add("카테고리를 삭제했습니다.");
     mav.setViewName("redirect:/category/list.do?grp_no=" + grp_no);     
   } else {
     msgs.add("카테고리 삭제에 실패했습니다.");
     msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
     links.add("<button type='button' onclick=\"location.href='./list.do?grp_no="+grp_no+"'\">목록</button>");

     mav.addObject("msgs", msgs);
     mav.addObject("links", links);

     mav.setViewName("/category/message"); // /webapp/categrp/message.jsp
   }

   return mav;
 }

 @RequestMapping(value = "/category/update_seqno_up.do", method = RequestMethod.POST)
 public ModelAndView update_seqno_up(int grp_no, int gory_no) {
   ModelAndView mav = new ModelAndView();

   if (categoryProc.update_seqno_up(gory_no) == 1) {
     mav.setViewName("redirect:/category/list.do?grp_no=" + grp_no);
   }

   return mav;
 }

 @RequestMapping(value = "/category/update_seqno_down.do", method = RequestMethod.POST)
 public ModelAndView update_seqno_down(int grp_no, int gory_no) {
   ModelAndView mav = new ModelAndView();

   if (categoryProc.update_seqno_down(gory_no) == 1) {
     mav.setViewName("redirect:/category/list.do?grp_no=" + grp_no);
   }

   return mav;
 }

 /*@RequestMapping(value="/category/list_index_left.do", method=RequestMethod.GET)
 public ModelAndView list_index_left(HttpServletRequest request){
   // System.out.println("--> list_index() GET called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/category/list_index_left"); // webapp/category/list_index_left.jsp
   
   List<CategrpVO> categrp_list = categrpProc.list(); // 카테고리 그룹 목록
   
   // Categrp: name, Category: title 결합 목록
   ArrayList<String> name_title_list = new ArrayList<String>();   
   
   StringBuffer url = new StringBuffer(); // 카테고리 제목 링크 조합

   // 카테고리 그룹 갯수만큼 순환
   for (int index = 0; index < categrp_list.size(); index++) {
     CategrpVO categrpVO = categrp_list.get(index);

     name_title_list.add("<LI class='categrp_name'>"+ categrpVO.getCategrptitle() + "</LI>");

     List<Categrp_CategoryVO> category_list = categoryProc.list_by_categrpno(categrpVO.getCategrpno()); // 카테고리 Join 목록
     
     // 카테고리 갯수만큼 순환
     for (int j=0; j < category_list.size(); j++) {
       Categrp_CategoryVO categrp_CategoryVO = category_list.get(j);
       String ntitle = categrp_CategoryVO.getNtitle(); // 카테고리 이름
       int cnt = categrp_CategoryVO.getCnt();
       
       url.append("<LI class='category_title'>");  
       url.append("  <A href='" + request.getContextPath()+ "/contents/list_by_category.do?categoryno="+categrp_CategoryVO.getCategoryno()+"'>");
       url.append(ntitle);
       url.append("  </A>");
       url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
       url.append("</LI>");
       name_title_list.add(url.toString()); // 출력 목록에 하나의 category 추가 
       
       url.delete(0, url.toString().length()); // StringBuffer 문자열 삭제
       
     }
   }
   
   mav.addObject("name_title_list", name_title_list);
   mav.addObject("total_count", contentsProc.total_count());
   
   return mav;
 }*/
 
    
 
}


