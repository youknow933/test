package dev.mvc.mileage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;


import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.mileage.MileageVO;

@Controller
public class MileageConts {
  @Autowired
  @Qualifier("dev.mvc.mileage.MileageProc")
  private MileageProcInter mileageProc;
  
  public MileageConts(){
    System.out.println("--> MileageConts created.");
  }
  
 @RequestMapping(value="/mileage/create.do", method=RequestMethod.GET)
 public ModelAndView create() {
   ModelAndView mav = new ModelAndView();

   mav.setViewName("/mileage/create"); 
   
   return mav;
 }

 @RequestMapping(value="/mileage/create.do", method=RequestMethod.POST)
 public ModelAndView create(MileageVO mileageVO) {
   ModelAndView mav = new ModelAndView();
   
   ArrayList<String> msgs = new ArrayList<String>();
   ArrayList<String> links = new ArrayList<String>();
    
   if (mileageProc.create(mileageVO) == 1) {
     msgs.add("마일리지 충전완료");
   } else {
     msgs.add("마일리지 충전실패");
     msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
   }
   links.add("<A href='javascript:window.close()'>닫기</A>");

   mav.addObject("msgs", msgs);
   mav.addObject("links", links);
   
   mav.setViewName("/mileage/message"); 
   return mav;
 }
 
 @RequestMapping(value="/mileage/list.do", method=RequestMethod.GET)
 public ModelAndView list() {
   ModelAndView mav = new ModelAndView();
   List<MileageVO> list = mileageProc.list();
   mav.addObject("list", list);
   
   mav.setViewName("/mileage/list"); 
   
   return mav;
 }

 
 /**
 <Xmp>
   수정 폼 
 </Xmp>
 */
@ResponseBody
@RequestMapping(value = "/mileage/update.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
public String update(int mileage_no) {
  System.out.println("--> update() GET executed");

  MileageVO mileageVO = mileageProc.read(mileage_no);

  JSONObject obj = new JSONObject();
  obj.put("mileage_no", mileage_no); 
  obj.put("mem_no", mileageVO.getMem_no());
  obj.put("cway", mileageVO.getCway());
  obj.put("cway_no", mileageVO.getCway_no());
  obj.put("char_m", mileageVO.getChar_m());
  obj.put("mymileage", mileageVO.getMymileage());
  obj.put("cmileage_date", mileageVO.getCmileage_date());

  return obj.toJSONString();
}

@RequestMapping(value = "/mileage/update.do", 
                          method = RequestMethod.POST)
public ModelAndView update(MileageVO mileageVO) {
 System.out.println("--> update() POST executed");
 ModelAndView mav = new ModelAndView();

 ArrayList<String> msgs = new ArrayList<String>();
 ArrayList<String> links = new ArrayList<String>();

 if (mileageProc.update(mileageVO) == 1) {

   mav.setViewName("redirect:/mileage/list_by_mileage_search_paging.do");
 } else {
   msgs.add("마일리지 수정에 실패했습니다.");
   msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
   links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
   links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

   mav.addObject("msgs", msgs);
   mav.addObject("links", links);

   mav.setViewName("/mileage/message"); 

 }

 return mav;
  }

/**
 * 삭제 처리
 * @return
 */

@RequestMapping(value = "/mileage/delete.do", method = RequestMethod.POST)
public ModelAndView delete(int mileage_no) { 

  ModelAndView mav = new ModelAndView();

  ArrayList<String> msgs = new ArrayList<String>();
  ArrayList<String> links = new ArrayList<String>();

  int count = mileageProc.delete(mileage_no);

  if (count == 1) {
    mav.setViewName("redirect:/mileage/list_by_mileage_search_paging.do");   
  } else {
    msgs.add("마일리지 삭제에 실패했습니다.");
    msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
    links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
    links.add("<button type='button' onclick=\"location.href='./list.do?mileage_no="+mileage_no+"'\">목록</button>");


    mav.addObject("msgs", msgs);
    mav.addObject("links", links);

    mav.setViewName("/mileage/message"); 
  }

  return mav;
}


///**
// * 검색 목록
// * @param 
// * @param word
// * @return
// */
//@RequestMapping(value = "/mileage/list_by_mileage.do", method = RequestMethod.GET)
//public ModelAndView list_by_mileage_search(String word, HttpSession session, String mileage_search) {
//  // System.out.println("--> list_by_category(int categoryno, String word_find) GET called.");
//  ModelAndView mav = new ModelAndView();
//  // mav.setViewName("/contents/list_by_categoryno"); // webapp/contents/list_by_categoryno.jsp
//  
//  // 검색 기능 추가, webapp/contents/list_by_category_search.jsp
//  mav.setViewName("/mileage/list_by_mileage_search");   
//  
//  int mem_no = (Integer)session.getAttribute("mem_no"); // session
//  // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
//  HashMap<String, Object> hashMap = new HashMap<String, Object>();
//  hashMap.put("mem_no", mem_no); // #{mileage_no}
//  hashMap.put("word", word);                // #{word}
//  hashMap.put("mileage_search", mileage_search);                // #{word}
//  // 검색 목록
//  List<MileageVO> list = mileageProc.list_by_mileage_search(hashMap);
//  mav.addObject("list", list);
//    // 검색된 레코드 갯수 
//  int search_count = mileageProc.search_count(hashMap);
//  mav.addObject("search_count", search_count);
//
//  MileageVO mileageVO = mileageProc.read(mem_no);
//  mav.addObject("mileageVO", mileageVO);
//  
// mav.addObject("word", word);
// mav.addObject("mileage_search", mileage_search);
//  
//  return mav;
//}
//
//@RequestMapping(value = "/mileage/list_by_mem_no.do", method = RequestMethod.GET)
//public ModelAndView list_by_mem_no(HttpSession session) {
//  ModelAndView mav = new ModelAndView();
//  mav.setViewName("mileage/list_by_mem_no");  
//
//  int mem_no = (Integer)session.getAttribute("mem_no"); // session
//  List<MileageVO> list = mileageProc.list_by_mem_no(mem_no);
//  mav.addObject("list", list);
//
//  return mav;
//}

/**
 * 목록 + 검색 + 페이징 지원
 * @param categoryno
 * @param word
 * @param nowPage
 * @return
 */
@RequestMapping(value = "/mileage/list_by_mileage_search_paging.do", method = RequestMethod.GET)
public ModelAndView list_by_mileage_search_paging(
    HttpSession session,
    @RequestParam(value="word", defaultValue="") String word,
    @RequestParam(value="nowPage", defaultValue="1") int nowPage,
    @RequestParam(value="mileage_search", defaultValue="") String mileage_search
    ) { 
  // System.out.println("--> list_by_category() GET called.");
  System.out.println("--> nowPage: " + nowPage);
  
  ModelAndView mav = new ModelAndView();
  
  // 검색 기능 추가,  /webapp/contents/list_by_category_search_paging.jsp
  mav.setViewName("mileage/list_by_mileage_search_paging");   
  
  int mem_no = (Integer)session.getAttribute("mem_no"); // session
  
  // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
  HashMap<String, Object> hashMap = new HashMap<String, Object>();
  hashMap.put("mem_no", mem_no); // #{categoryno}
  hashMap.put("word", word);                  // #{word}
  hashMap.put("nowPage", nowPage);       
  hashMap.put("mileage_search", mileage_search);       
  
  // 검색 목록
  List<MileageVO> list = mileageProc.list_by_mileage_search_paging(hashMap);
  mav.addObject("list", list);
  
  // 검색된 레코드 갯수
  int search_count = mileageProc.search_count(hashMap);
  mav.addObject("search_count", search_count);

  MileageVO mileageVO = mileageProc.read(mem_no);
  mav.addObject("MileageVO", mileageVO);
  
  // mav.addObject("word", word);

  /*
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param categoryno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  String paging = mileageProc.paging(mem_no, search_count, nowPage, word);
  mav.addObject("paging", paging);

  mav.addObject("nowPage", nowPage); 
  
  return mav;
}
}