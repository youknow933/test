package dev.mvc.deal;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.product.ProductProcInter;
import dev.mvc.product.ProductVO;
import nation.web.tool.Tool;
 
@Controller
public class DealCont {
  @Autowired
  @Qualifier("dev.mvc.deal.DealProc") // 할당되는 Class 객체의 이름
  private DealProcInter dealProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc; 
  
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc; 
  
  public DealCont() {
    System.out.println("-> DealCont created.");
  }
  
  //http://localhost:9090/dawara/deal/create.do
  // 거래 등록 폼
  @RequestMapping(value = "/deal/create.do", method = RequestMethod.GET)
  public ModelAndView create(HttpSession session, int pr_no) {
   ModelAndView mav = new ModelAndView();
//   System.out.println("create(int pr_no, int mem_no) GET called!");
//   System.out.println("- pr_no  = " + pr_no);
   
   int mem_no = (Integer)session.getAttribute("mem_no");
//   System.out.println("- mem_no = " + mem_no);
   
   Tool tool = new Tool();
   mav.addObject("tool", tool);
   
   // 참조하는 테이블 객체로 저장
   ProductVO productVO = productProc.read(pr_no);
   mav.addObject("productVO", productVO);
   System.out.println("productVO mem_no: " + productVO.getMem_no());
   
   // 판매자 정보
   MemberVO sellerVO = memberProc.read(productVO.getMem_no()); 
   mav.addObject("sellerVO", sellerVO);
   
   // 구매자 정보
   MemberVO buyerVO = memberProc.read(mem_no); 
   mav.addObject("buyerVO", buyerVO);
   
   mav.setViewName("/deal/create"); // /webapp/deal/create.jsp

   return mav;
 }
  
  // 거래 등록 처리 
  @RequestMapping(value="/deal/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpSession session, DealVO dealVO) {
    System.out.println("create(DealVO dealVO) POST called!");
    ModelAndView mav = new ModelAndView();
    
//    int buy_no = dealVO.getBuy_no();
//    int pr_no = dealVO.getPr_no();
    int deal_no = dealVO.getDeal_no();
    System.out.println("-[create POST] deal_no: " + deal_no);
    
    int mem_no = (Integer)session.getAttribute("mem_no");
    dealVO.setMem_no(mem_no);
    System.out.println("dealVO mem_no:" + mem_no);
    
    if(dealProc.create(dealVO) == 1){ // ERROR!
//      msgs.add("거래를 등록했습니다.");
      
//      mav.setViewName("redirect:/deal/message_create.do"); 
      mav.setViewName("redirect:/deal/searchList_paging.do"); // 바로 페이지 이동 - redirect: 확장자를 명시해줘야!!
//      mav.setViewName("redirect:/deal/list.do?pr_no="+pr_no+"&buy_no="+buy_no); // *********************** 수정할 곳 ***parameter 보내야 함
    } else {
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();
      
      msgs.add("거래 등록에 실패했습니다.");
      msgs.add("죄송하지만 다시 한번 시도해 주세요.");
      msgs.add("고객 센터: ☏000-0000-1111");
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do';\">목록</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      mav.setViewName("/deal/message");
    }
    return mav;
  }
  
  /*
  // 거래 목록
  @RequestMapping(value = "/deal/list.do", method = RequestMethod.GET)
//  public ModelAndView list(int buy_no, int mem_no) {
  public ModelAndView list() {
    System.out.println("list() called!");
    ModelAndView mav = new ModelAndView();
    
    List<Member_Product_DealVO> list = dealProc.list();
    mav.addObject("list", list);
    
//    List<Buy_ProductVO> bp_list = dealProc.bp_list();
//    mav.addObject("bp_list", bp_list);
//    
//    List<Buy_MemberVO> bm_list = dealProc.bm_list();
//    mav.addObject("bm_list", bm_list);
    
    List<Buy_ProductVO> BPList = dealProc.BPList_by_buy_no(1);
    mav.addObject("BPList", BPList);
  
    List<Buy_MemberVO> BMList = dealProc.BMList_by_mem_no(1);
    mav.addObject("BMList", BMList);
    
    List<BuyMember_DealVO> bm_dealList = dealProc.bm_dealList();
    mav.addObject("bm_dealList", bm_dealList);
    
    mav.setViewName("/deal/list");
    
    return mav;
  }*/
  // 6/25 ---------------------------------------------------------------
  
//  @RequestMapping(value = "/deal/_list.do", method = RequestMethod.GET)
//  public ModelAndView list_by_deal_no(int deal_no){
//    ModelAndView mav = new ModelAndView();
//    
//    List<Product_BuyMember_DealVO> list = dealProc.list_by_deal_no(deal_no);
//    mav.addObject("list", list);
//    mav.addObject("/deal/list");
//    
//    return mav;
//  }
  
  @RequestMapping(value = "/deal/read.do", method = RequestMethod.GET)
  public ModelAndView read(int deal_no) {
//    System.out.println("--> read() GET called!");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/deal/read");

    Tool tool = new Tool();
    mav.addObject("tool", tool);
    
    DealVO dealVO = dealProc.read(deal_no);
    mav.addObject("dealVO", dealVO);    
    
    ProductVO productVO = productProc.read(dealVO.getPr_no());
    mav.addObject("productVO", productVO);
    
    return mav;
  }
  // 6/26 ---------------------------------------------------------------
  
  @ResponseBody //자바 객체를 HTTP 요청의 body 내용으로 매핑하는 역할
  @RequestMapping(value="/deal/update.do", method = RequestMethod.GET,
                  produces = "text/plain; charset=UTF-8") // 응답 페이지에 대한 UTF-8 인코딩이 가능하여 한글 깨짐을 방지 할 수 있음.
  public String update(int deal_no){
    System.out.println("--> update() GET called!");
    System.out.println("- deal_no: " + deal_no);
    
    DealVO dealVO = dealProc.read(deal_no);
    
    JSONObject obj = new JSONObject();
    obj.put("deal_no", deal_no);
    obj.put("d_state", dealVO.getD_state());
    obj.put("d_way", dealVO.getD_way());
    obj.put("d_check", dealVO.getD_check());
    
    return obj.toJSONString();
  }
  
  // 거래 수정 처리
  @RequestMapping(value="/deal/update.do", method=RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes,
                             HttpServletRequest request, 
                             DealVO dealVO,
                             String startDate,
                             String endDate,
                             int nowPage){
    System.out.println("--> update() POST called!");
    System.out.println("- dealVO.getDeal_no(): " + dealVO.getDeal_no());
    System.out.println("- dealVO.getD_state(): " + dealVO.getD_state());
    System.out.println("- dealVO.getD_way(): " + dealVO.getD_way());
    System.out.println("- dealVO.getD_check(): " + dealVO.getD_check());
    ModelAndView mav = new ModelAndView();
    
    if(dealProc.update(dealVO) == 1){
      mav.setViewName("redirect:/deal/list_by_dates_paging.do");

      redirectAttributes.addAttribute("startDate", startDate);
      redirectAttributes.addAttribute("endDate", endDate);
      redirectAttributes.addAttribute("nowPage", nowPage);
      
    } else{
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();
      
      msgs.add("거래 수정에 실패했습니다.");
      msgs.add("죄송하지만 다시 한번 시도해 주세요.");
      msgs.add("고객 센터: ☏000-0000-1111");
      
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do\">목록</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/deal/message");
    }
    return mav;
  }
  // 6/27 ---------------------------------------------------------------
  
  //http://localhost:9090/dawara/deal/delete.do
  @RequestMapping(value="/deal/delete.do", method = RequestMethod.GET)      
  public ModelAndView delete(int deal_no){
    System.out.println("--> delete(int deal_no) GET called!");
    System.out.println("- deal_no: " + deal_no);
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/deal/delete");
    
    DealVO dealVO = dealProc.read(deal_no);
    mav.addObject("dealVO", dealVO);
    
    return mav;
  }
  
  // 거래 삭제 처리
  @RequestMapping(value = "/deal/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, 
                              HttpServletRequest request, 
                              int deal_no,
                              String startDate,
                              String endDate, 
                              int nowPage){
    System.out.println("--> delete() POST called!");
    System.out.println("- deal_no: " + deal_no);
    ModelAndView mav = new ModelAndView();
    
    if(dealProc.delete(deal_no) == 1){
      mav.setViewName("redirect:/deal/searchList_paging.do");
      
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("startDate", startDate);
      hashMap.put("endDate", endDate);
      hashMap.put("nowPage", nowPage);
      
      if (dealProc.search_count(hashMap) % Deal.RECORD_PER_PAGE == 0){ 
        nowPage = nowPage - 1;
        if (nowPage < 1){
          nowPage = 1;
        }
      }
      
      redirectAttributes.addAttribute("deal_no", deal_no);
      redirectAttributes.addAttribute("startDate", startDate);
      redirectAttributes.addAttribute("endDate", endDate);
      redirectAttributes.addAttribute("nowPage", nowPage);
      
    } else {
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();
      
      msgs.add("거래 삭제에 실패!");
      msgs.add("다시 시도해 주세요~!");
      msgs.add("고객 센터: ☏ 000-0000-1111");
      
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./deal/searchList_paging.do\">목록</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      mav.setViewName("/deal/message");
    }
    return mav;
  }
  // 6/28 ---------------------------------------------------------------
  
  /*
  // 검색 목록
  @RequestMapping(value = "/deal/list_by_dates_paging.do", method= RequestMethod.GET)
  public ModelAndView list_by_dates_paging(String startDate, String endDate){
    System.out.println("list_by_dates_paging(String startDate, String endDate) called!");
    ModelAndView mav = new ModelAndView();
    
//    System.out.println("- startDate: " + startDate);
//    System.out.println("- endDate: " + endDate);
    
    mav.setViewName("/deal/list_by_dates_paging");
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("startDate", startDate);
    hashMap.put("endDate", endDate);
    
    List<Product_BuyMember_DealVO> list = dealProc.list_by_dates_paging(hashMap);
    mav.addObject("list", list);
    
    // 날짜검색 목록 중 d_date만 추출
//    List<DealVO> searchList = dealProc.list_by_dates_paging(hashMap);
//    for(int i=0; i < searchList.size(); i++){
//      DealVO dealVO = searchList.get(i);
//      
//      String d_date = dealVO.getD_date();
//      System.out.println("- dealVO.getD_date(): " + d_date);
//      
//      mav.addObject("d_date", d_date);
//    }
//    mav.addObject("searchList", searchList);
    
    // 검색된 레코드 갯수
    int search_count = dealProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    return mav;
  }
  */
  // 6/29 ---------------------------------------------------------------
  
  @RequestMapping(value = "/deal/list_by_dates_paging.do", method= RequestMethod.GET)
  public ModelAndView list_by_dates_paging( // @RequestParam: defaultValue(String타입)를 줄 수 있음
      @RequestParam(value="startDate", defaultValue="") String startDate,
      @RequestParam(value="endDate", defaultValue="") String endDate,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage // 여기서 nowPage계산 x, Proc에서 계산
      ){
//    System.out.println("list_by_dates_paging(String startDate, String endDate, int nowPage) called!");
//    System.out.println("->nowPage: " + nowPage);
//    System.out.println("- startDate: " + startDate);
//    System.out.println("- endDate: " + endDate);
    ModelAndView mav = new ModelAndView();
    
    startDate = startDate.replaceAll("-", "");
    endDate = endDate.replaceAll("-", "");
//    System.out.println("- startDate: " + startDate);
//    System.out.println("- endDate: " + endDate);
    
    mav.setViewName("/deal/list_by_dates_paging");
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("startDate", startDate);
    hashMap.put("endDate", endDate);
    hashMap.put("nowPage", nowPage);
    
    List<Member_Product_DealVO> list = dealProc.list_by_dates_paging(hashMap);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = dealProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage      현재 페이지
     * @param startDate    검색어1
     * @param endDate      검색어2
     * @return 페이징 생성 문자열
     */ 
    String paging = dealProc.paging(search_count, nowPage, startDate, endDate);
    mav.addObject("paging", paging);
 
    mav.addObject("startDate", startDate);
    mav.addObject("endDate", endDate);
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  // 7/4 ~ 7/5 ---------------------------------------------------------------
  
  // 검색 목록
  @RequestMapping(value = "/deal/searchList.do", method= RequestMethod.GET)
  public ModelAndView searchList(
      HttpSession session,
      @RequestParam(value="startDate", defaultValue="") String startDate,
      @RequestParam(value="endDate", defaultValue="") String endDate,
      String keyword, 
      String searchItem){
//    System.out.println("searchList(String startDate, String endDate, String keyword, String searchItem) called!");
    ModelAndView mav = new ModelAndView();
    
    startDate = startDate.replaceAll("-", "");
    endDate = endDate.replaceAll("-", "");
//    System.out.println("- startDate: " + startDate);
//    System.out.println("- endDate: " + endDate);
//    System.out.println("- searchItem: " + searchItem);
//    System.out.println("- keyword: " + keyword);
    
    int mem_no = (Integer)session.getAttribute("mem_no");
//    System.out.println("- mem_no: " + mem_no);
    
    mav.setViewName("/deal/searchList");
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no);
    hashMap.put("startDate", startDate);
    hashMap.put("endDate", endDate);
    hashMap.put("keyword", keyword);
    hashMap.put("searchItem", searchItem);
    
    List<Member_Product_DealVO> list = dealProc.searchList(hashMap);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = dealProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    mav.addObject("keyword", keyword);
    
    mav.addObject("startDate", startDate);
    mav.addObject("endDate", endDate);
    
    return mav;
  }
  // 7/24
  
  // 페이징
  @RequestMapping(value = "/deal/searchList_paging.do", method= RequestMethod.GET)
  public ModelAndView searchList_paging( // @RequestParam: defaultValue(String타입)를 줄 수 있음
      HttpSession session,
      @RequestParam(value="startDate", defaultValue="") String startDate,
      @RequestParam(value="endDate", defaultValue="") String endDate,
      @RequestParam(value="searchItem", defaultValue="") String searchItem,
      @RequestParam(value="keyword", defaultValue="") String keyword,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage // 여기서 nowPage계산 x, Proc에서 계산
      ){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/deal/searchList_paging");
    
    System.out.println("searchList_paging(String startDate, String endDate, int nowPage) called!");
    startDate = startDate.replaceAll("-", "");
    endDate = endDate.replaceAll("-", "");
    System.out.println("- startDate: " + startDate);
    System.out.println("- endDate: " + endDate);
    System.out.println("- searchItem: " + searchItem);
    System.out.println("- keyword: " + keyword);
    System.out.println("- nowPage: " + nowPage);
    
    int mem_no = (Integer)session.getAttribute("mem_no");
    System.out.println("- mem_no: " + mem_no);
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no);
    hashMap.put("startDate", startDate);
    hashMap.put("endDate", endDate);
    hashMap.put("searchItem", searchItem);
    hashMap.put("keyword", keyword);
    hashMap.put("nowPage", nowPage); // Proc
    
    List<Member_Product_DealVO> list = dealProc.searchList_paging(hashMap);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = dealProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    String paging = dealProc.paging3(search_count, nowPage, startDate, endDate, keyword, searchItem);
    mav.addObject("paging", paging);
    
    mav.addObject("startDate", startDate);
    mav.addObject("endDate", endDate);
    mav.addObject("searchItem", searchItem);
    mav.addObject("keyword", keyword);
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  // 7/24 ~ 7/25 ---------------------------------------------------------------
}
