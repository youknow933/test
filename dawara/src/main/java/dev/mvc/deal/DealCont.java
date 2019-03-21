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
  @Qualifier("dev.mvc.deal.DealProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
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
  // �ŷ� ��� ��
  @RequestMapping(value = "/deal/create.do", method = RequestMethod.GET)
  public ModelAndView create(HttpSession session, int pr_no) {
   ModelAndView mav = new ModelAndView();
//   System.out.println("create(int pr_no, int mem_no) GET called!");
//   System.out.println("- pr_no  = " + pr_no);
   
   int mem_no = (Integer)session.getAttribute("mem_no");
//   System.out.println("- mem_no = " + mem_no);
   
   Tool tool = new Tool();
   mav.addObject("tool", tool);
   
   // �����ϴ� ���̺� ��ü�� ����
   ProductVO productVO = productProc.read(pr_no);
   mav.addObject("productVO", productVO);
   System.out.println("productVO mem_no: " + productVO.getMem_no());
   
   // �Ǹ��� ����
   MemberVO sellerVO = memberProc.read(productVO.getMem_no()); 
   mav.addObject("sellerVO", sellerVO);
   
   // ������ ����
   MemberVO buyerVO = memberProc.read(mem_no); 
   mav.addObject("buyerVO", buyerVO);
   
   mav.setViewName("/deal/create"); // /webapp/deal/create.jsp

   return mav;
 }
  
  // �ŷ� ��� ó�� 
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
//      msgs.add("�ŷ��� ����߽��ϴ�.");
      
//      mav.setViewName("redirect:/deal/message_create.do"); 
      mav.setViewName("redirect:/deal/searchList_paging.do"); // �ٷ� ������ �̵� - redirect: Ȯ���ڸ� ��������!!
//      mav.setViewName("redirect:/deal/list.do?pr_no="+pr_no+"&buy_no="+buy_no); // *********************** ������ �� ***parameter ������ ��
    } else {
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();
      
      msgs.add("�ŷ� ��Ͽ� �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ� �ѹ� �õ��� �ּ���.");
      msgs.add("�� ����: ��000-0000-1111");
      links.add("<button type='button' onclick=\"history.back();\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do';\">���</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      mav.setViewName("/deal/message");
    }
    return mav;
  }
  
  /*
  // �ŷ� ���
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
  
  @ResponseBody //�ڹ� ��ü�� HTTP ��û�� body �������� �����ϴ� ����
  @RequestMapping(value="/deal/update.do", method = RequestMethod.GET,
                  produces = "text/plain; charset=UTF-8") // ���� �������� ���� UTF-8 ���ڵ��� �����Ͽ� �ѱ� ������ ���� �� �� ����.
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
  
  // �ŷ� ���� ó��
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
      
      msgs.add("�ŷ� ������ �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ� �ѹ� �õ��� �ּ���.");
      msgs.add("�� ����: ��000-0000-1111");
      
      links.add("<button type='button' onclick=\"history.back();\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do\">���</button>");
      
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
  
  // �ŷ� ���� ó��
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
      
      msgs.add("�ŷ� ������ ����!");
      msgs.add("�ٽ� �õ��� �ּ���~!");
      msgs.add("�� ����: �� 000-0000-1111");
      
      links.add("<button type='button' onclick=\"history.back();\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./deal/searchList_paging.do\">���</button>");
      
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      mav.setViewName("/deal/message");
    }
    return mav;
  }
  // 6/28 ---------------------------------------------------------------
  
  /*
  // �˻� ���
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
    
    // ��¥�˻� ��� �� d_date�� ����
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
    
    // �˻��� ���ڵ� ����
    int search_count = dealProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    return mav;
  }
  */
  // 6/29 ---------------------------------------------------------------
  
  @RequestMapping(value = "/deal/list_by_dates_paging.do", method= RequestMethod.GET)
  public ModelAndView list_by_dates_paging( // @RequestParam: defaultValue(StringŸ��)�� �� �� ����
      @RequestParam(value="startDate", defaultValue="") String startDate,
      @RequestParam(value="endDate", defaultValue="") String endDate,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage // ���⼭ nowPage��� x, Proc���� ���
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
    
    // �˻��� ���ڵ� ����
    int search_count = dealProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     *
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage      ���� ������
     * @param startDate    �˻���1
     * @param endDate      �˻���2
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = dealProc.paging(search_count, nowPage, startDate, endDate);
    mav.addObject("paging", paging);
 
    mav.addObject("startDate", startDate);
    mav.addObject("endDate", endDate);
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  // 7/4 ~ 7/5 ---------------------------------------------------------------
  
  // �˻� ���
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
    
    // �˻��� ���ڵ� ����
    int search_count = dealProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    mav.addObject("keyword", keyword);
    
    mav.addObject("startDate", startDate);
    mav.addObject("endDate", endDate);
    
    return mav;
  }
  // 7/24
  
  // ����¡
  @RequestMapping(value = "/deal/searchList_paging.do", method= RequestMethod.GET)
  public ModelAndView searchList_paging( // @RequestParam: defaultValue(StringŸ��)�� �� �� ����
      HttpSession session,
      @RequestParam(value="startDate", defaultValue="") String startDate,
      @RequestParam(value="endDate", defaultValue="") String endDate,
      @RequestParam(value="searchItem", defaultValue="") String searchItem,
      @RequestParam(value="keyword", defaultValue="") String keyword,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage // ���⼭ nowPage��� x, Proc���� ���
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
    
    // �˻��� ���ڵ� ����
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
