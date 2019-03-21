package dev.mvc.urlauth;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UrlauthCont {
  @Autowired
  @Qualifier("dev.mvc.urlauth.UrlauthProc")
  private UrlauthProcInter urlauthProc = null;
  
  public UrlauthCont() {
    System.out.println("--> UrlauthCont created.");
  }
  
  /**
  * 등록
  * @param urlauthno
  * @return
  */
  @RequestMapping(value="/urlauth/create.do", 
                            method=RequestMethod.GET)
  public ModelAndView create(int urlauth_no) {
    ModelAndView mav = new ModelAndView();
    
    UrlauthVO urlauthVO = urlauthProc.read(urlauth_no);
    
    mav.addObject("urlauthVO", urlauthVO);
    mav.setViewName("/urlauth/create");
    
    return mav;
  }
  
  @ResponseBody
  @RequestMapping(value="/urlauth/create.do", 
                            method=RequestMethod.POST, 
                            produces = "text/json;charset=UTF-8")
  public String create(UrlauthVO urlauthVO) {
    JSONObject obj = new JSONObject();
    JSONArray msgs = new JSONArray();
    
    if (urlauthProc.create(urlauthVO) == 1) {
      msgs.put("권한별 접근 URL을 등록했습니다.");
      msgs.put("등록된 권한별 접근 URL: " + urlauthVO.getUrlauth_address());
    } else {
      msgs.put("권한별 접근 URL 등록에 실패했습니다. 재시도 바랍니다.");
    }
    
    obj.put("msgs", msgs);
 
    return obj.toString();
  }
  
  /**
  * 수정
  * @param urlauth_no
  * @return
  */
  @ResponseBody
  @RequestMapping(value = "/urlauth/update.do", 
                            method = RequestMethod.GET, 
                            produces = "text/plain;charset=UTF-8")
  public String update(int urlauth_no) {
    UrlauthVO urlauthVO = urlauthProc.read(urlauth_no);

    JSONObject obj = new JSONObject();
    obj.put("urlauth_no", urlauth_no);
    obj.put("urlauth_address", urlauthVO.getUrlauth_address());
    obj.put("auth_no", urlauthVO.getAuth_no());

    return obj.toJSONString();
  }

  @RequestMapping(value = "/urlauth/update.do", 
                            method = RequestMethod.POST)
  public ModelAndView update(UrlauthVO urlauthVO) {
    ModelAndView mav = new ModelAndView();

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    if(urlauthProc.update(urlauthVO) == 1) {
      mav.setViewName("redirect:/urlauth/list_search_paging.do");
    } else {
      msgs.add("권한별 접근 URL 변경에 실패했습니다. 재시도 바랍니다.");
      links.add("<button type='button' onclick=\"history.back();\">재시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list_search_paging.do'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/urlauth/message");
    }

    return mav;
  }
  
  /**
  * 삭제
  * @param urlauth_no
  * @return
  */
  @RequestMapping(value = "/urlauth/delete.do", 
                            method = RequestMethod.POST)
  public ModelAndView delete(int urlauth_no) { 
    ModelAndView mav = new ModelAndView();

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    int count = urlauthProc.delete(urlauth_no);

    if (count == 1) {
      mav.setViewName("redirect:/urlauth/list_search_paging.do");     
    } else {
      msgs.add("권한별 접근 URL 삭제에 실패했습니다. 재시도 바랍니다.");
      links.add("<button type='button' onclick=\"history.back()\">재시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list_search_paging.do'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);

      mav.setViewName("/urlauth/message");
    }

    return mav;
  }
  
  /**
   * 목록
   * @return
   */
  @RequestMapping(value = "/urlauth/list.do", 
                            method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/urlauth/list");

    List<UrlauthVO> list = urlauthProc.list();
    mav.addObject("list", list);

    return mav;
  }
  
  /**
   * 목록 검색 페이징
   * @param urlauth_address
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/urlauth/list_search_paging.do", 
                            method = RequestMethod.GET)
  public ModelAndView list_search_paging(
      @RequestParam(value="urlauth_address", defaultValue="") String urlauth_address,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/urlauth/list_search_paging");
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("urlauth_address", urlauth_address);
    hashMap.put("nowPage", nowPage);       
    
    List<UrlauthVO> list = urlauthProc.list_search_paging(hashMap);
    mav.addObject("list", list);
    
    int urlauth_search_cnt = urlauthProc.urlauth_search_cnt(hashMap);
    mav.addObject("urlauth_search_cnt", urlauth_search_cnt);
    
    /*
     * 페이징
     * @param urlauth_search_cnt
     * @param nowPage
     * @param urlauth_address
     * @return
     */ 
    String paging = urlauthProc.paging(urlauth_search_cnt, nowPage, urlauth_address); 
    mav.addObject("paging", paging); 
 
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
}
