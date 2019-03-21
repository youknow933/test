package dev.mvc.shipping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.product.ProductProcInter;
import dev.mvc.product.ProductVO;
import nation.web.tool.Tool;

@Controller
public class ShippingCont {
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private MemberProcInter memberProc;

  @Autowired
  @Qualifier("dev.mvc.product.ProductProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private ProductProcInter productProc;

  @Autowired
  @Qualifier("dev.mvc.shipping.ShippingProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private ShippingProcInter shippingProc;

  public ShippingCont() {
    System.out.println("-> ShippingCont created.");
  }

  // http://localhost:9090/dawara/shipping/create.do?pr_no=1&mem_no=2
  // ��� ��� ��
  @RequestMapping(value = "/shipping/create.do", method = RequestMethod.GET)
  public ModelAndView create(HttpSession session, int pr_no) {
//  public ModelAndView create(int pr_no, int mem_no) {
    ModelAndView mav = new ModelAndView();
//     System.out.println("create(HttpSession session, int mem_no) GET called!");
//     System.out.println("- pr_no = " + pr_no);
    
    int mem_no = (Integer)session.getAttribute("mem_no"); // session
//    System.out.println("- mem_no = " + mem_no);

    // ��ǰ �Ǹ��� ���
//    List<Product_MemberVO> pmList = shippingProc.pr_mem_info(pr_no);
//    mav.addObject("pmList", pmList);
    
    Tool tool = new Tool();
    mav.addObject("tool", tool);

    ProductVO productVO = productProc.read(pr_no);
    mav.addObject("productVO", productVO);
    
    // �Ǹ��� ����
    MemberVO sellerVO = memberProc.read(productVO.getMem_no()); 
    mav.addObject("sellerVO", sellerVO);
    
    // ������ ����
    MemberVO buyerVO = memberProc.read(mem_no); 
    mav.addObject("buyerVO", buyerVO);

    mav.setViewName("/shipping/create"); // /webapp/shipping/create.jsp
    return mav;
  }

  // ��� ��� ó��
  @RequestMapping(value = "/shipping/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpSession session,
                             ShippingVO shippingVO,
                             @RequestParam(value="ship_memo", defaultValue=" ") String ship_memo) {
    ModelAndView mav = new ModelAndView();
//    System.out.println("create(ShippingVO shippingVO) POST called!");
//    System.out.println("shippingVO.getPr_no(): " + shippingVO.getPr_no());
//    System.out.println("shippingVO.getMem_no(): " + shippingVO.getMem_no());
    
    int mem_no = (Integer)session.getAttribute("mem_no");
    shippingVO.setMem_no(mem_no);
//    System.out.println("- mem_no: " + mem_no);
    
    System.out.println("ship_memo:" + ship_memo);
    shippingVO.setShip_memo(ship_memo);

    // ��� ó��
    if (shippingProc.create(shippingVO) == 1) {
      // mav.setViewName("redirect:/shipping/list.do");
      // ȸ�� �ù�ŷ� ������� �ٷ� ������ �̵� - redirect: Ȯ���ڸ� ��������!!
//      mav.setViewName("redirect:/shipping/searchList_by_mem_no_paging.do?mem_no=" + shippingVO.getMem_no());
      mav.setViewName("redirect:/shipping/searchList_by_mem_no_paging.do");
    } else {
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();

      msgs.add("�ù�ŷ� ��Ͽ� �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ� �ѹ� �õ��� �ּ���.");
      msgs.add("�� ����: ��000-0000-1111");
      links.add("<button type='button' onclick=\"history.back();\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do';\">���</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      mav.setViewName("/shipping/message");
    }
    return mav;
  }
  // 7/10 - 7/11
  // --------------------------------------------------------------------

  // ��� ���
  @RequestMapping(value = "/shipping/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/shipping/list");
//    System.out.println("--> list() GET called!");

    List<ShippingVO> list = shippingProc.list();
    mav.addObject("list", list);

    return mav;
  }

  /*
  // ȸ�� ��� ���
  @RequestMapping(value = "/shipping/list_by_mem_no.do", method = RequestMethod.GET)
  public ModelAndView list_by_mem_no(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/shipping/list");
//    System.out.println("--> list_by_mem(int mem_no) GET called!");
//    System.out.println("- mem_no: " + mem_no);
    int mem_no = (Integer)session.getAttribute("mem_no"); // session

    List<ShippingVO> list = shippingProc.list_by_mem_no(mem_no);
    mav.addObject("list", list);

    return mav;
  }
  */

  // �ù�ŷ� ����
  @RequestMapping(value = "/shipping/read.do", method = RequestMethod.GET)
  public ModelAndView read(int ship_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/shipping/read");
//    System.out.println("--> read(int ship_no) GET called!");

    ShippingVO shippingVO = shippingProc.read(ship_no);
    mav.addObject("shippingVO", shippingVO);

    return mav;
  }

  // �ù� �ŷ� ���� ��
  @RequestMapping(value = "/shipping/update.do", method = RequestMethod.GET)
  public ModelAndView update(int ship_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/shipping/update");
//    System.out.println("--> update(int ship_no) GET called!");

    ShippingVO shippingVO = shippingProc.read(ship_no);
    mav.addObject("shippingVO", shippingVO);

    ProductVO productVO = productProc.read(shippingVO.getPr_no());
    mav.addObject("productVO", productVO);

    MemberVO memberVO = memberProc.read(shippingVO.getMem_no());
    mav.addObject("memberVO", memberVO);

    return mav;
  }

  // �ù� �ŷ� ���� ó��
  @RequestMapping(value = "/shipping/update.do", method = RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes, 
                             HttpServletRequest request, 
                             HttpSession session,
                             ShippingVO shippingVO,
                             @RequestParam(value = "keyword", defaultValue = "") String keyword,
                             @RequestParam(value = "nowPage", defaultValue = "1") int nowPage) {
    ModelAndView mav = new ModelAndView();
//    System.out.println("--> update() POST called.");

    int ship_no = shippingVO.getShip_no();
//    System.out.println("ship_no: " + ship_no);
    
    int mem_no = (Integer)session.getAttribute("mem_no"); // session
    System.out.println("mem_no: " + mem_no);

    if (shippingProc.update(shippingVO) == 1) {
      mav.setViewName("redirect:/shipping/message_update.jsp");
//      redirect�� �ּ� �̵�. forward(x)
      redirectAttributes.addAttribute("count", shippingProc.update(shippingVO));
      redirectAttributes.addAttribute("ship_no", ship_no);
      redirectAttributes.addAttribute("keyword", keyword);
      redirectAttributes.addAttribute("nowPage", nowPage);
    } else {
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();

      msgs.add("�ù�ŷ� ������ �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ� �ѹ� �õ��� �ּ���.");
      msgs.add("�� ����: ��000-0000-1111");

      links.add("<button type='button' onclick=\"history.back();\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do\">���</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);

      mav.setViewName("/shipping/message");
    }

    return mav;
  }

  /*
   * // �ù�ŷ� ���� �� ajax���
   * 
   * @ResponseBody //�ڹ� ��ü�� HTTP ��û�� body �������� �����ϴ� ����
   * 
   * @RequestMapping(value="/shipping/update.do", method = RequestMethod.GET,
   * produces = "text/plain; charset=UTF-8") // ���� �������� ���� UTF-8 ���ڵ��� �����Ͽ� �ѱ�
   * ������ ���� �� �� ����. public String update(int ship_no){
   * System.out.println("--> update(int ship_no) GET called!");
   * System.out.println("- ship_no: " + ship_no);
   * 
   * ShippingVO shippingVO = shippingProc.read(ship_no);
   * 
   * JSONObject obj = new JSONObject(); obj.put("ship_zipcode",
   * shippingVO.getShip_zipcode()); obj.put("ship_addr1",
   * shippingVO.getShip_addr1()); obj.put("ship_addr2",
   * shippingVO.getShip_addr2()); obj.put("ship_rname",
   * shippingVO.getShip_rname()); obj.put("ship_rtel",
   * shippingVO.getShip_rtel()); obj.put("ship_memo",
   * shippingVO.getShip_memo()); obj.put("ship_date",
   * shippingVO.getShip_date()); obj.put("ship_check",
   * shippingVO.getShip_check()); obj.put("PR_NO", shippingVO.getPr_no());
   * obj.put("MEM_NO", shippingVO.getMem_no());
   * 
   * return obj.toJSONString();1 }
   */

  // �ù�ŷ� ���� ��
  @RequestMapping(value = "/shipping/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int ship_no) {
    ModelAndView mav = new ModelAndView();
//    System.out.println("--> delete(int ship_no) GET called!");
//    System.out.println("- ship_no: " + ship_no);

    mav.setViewName("/shipping/delete");

    ShippingVO shippingVO = shippingProc.read(ship_no);
    mav.addObject("shippingVO", shippingVO);

    return mav;
  }
  // 7/12
  // ---------------------------------------------------------------------------------

  // �ù�ŷ� ���� ó��
  @RequestMapping(value = "/shipping/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, 
                             HttpServletRequest request, 
                             HttpSession session,
                             int ship_no, 
      @RequestParam(value = "keyword", defaultValue = "") String keyword,
      @RequestParam(value = "nowPage", defaultValue = "1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    System.out.println("--> delete() POST called!");
//    System.out.println("ship_no: " + ship_no);

    int count = shippingProc.delete(ship_no);
    if (count == 1) {
      mav.setViewName("redirect:/shipping/message_delete.jsp");

//      System.out.println("count: " + count);
//      System.out.println("ship_no: " + ship_no);
      int mem_no = (Integer)session.getAttribute("mem_no"); // session
      System.out.println("mem_no: " + mem_no);
//      System.out.println("keyword: " + keyword);
//      System.out.println("nowPage: " + nowPage);

      redirectAttributes.addAttribute("count", count);
      redirectAttributes.addAttribute("ship_no", ship_no);
//      redirectAttributes.addAttribute("mem_no", mem_no);
      redirectAttributes.addAttribute("keyword", keyword);
      redirectAttributes.addAttribute("nowPage", nowPage);
    }
    return mav;
  }
  /*
   * // ��ü �ù�ŷ� �˻� ���
   * 
   * @RequestMapping(value = "/shipping/searchList.do", method =
   * RequestMethod.GET) public ModelAndView searchList(String keyword, String
   * searchItem) {
   * System.out.println("searchList(String keyword, String searchItem) called!"
   * ); ModelAndView mav = new ModelAndView();
   * mav.setViewName("/shipping/searchList");
   * 
   * HashMap<String, Object> hashMap = new HashMap<String, Object>();
   * hashMap.put("keyword", keyword); hashMap.put("searchItem", searchItem);
   * 
   * System.out.println("keyword: " + keyword);
   * System.out.println("searchItem: " + searchItem);
   * System.out.println("searchItem.length(): " + searchItem.length());
   * 
   * List<ShippingVO> list = shippingProc.searchList(hashMap);
   * mav.addObject("list", list);
   * 
   * // �˻��� ���ڵ� ���� int search_count = shippingProc.search_count(hashMap);
   * mav.addObject("search_count", search_count);
   * 
   * mav.addObject("keyword", keyword); mav.addObject("searchItem", searchItem);
   * 
   * return mav; }
   */
  /*
   * // ȸ�� �ù�ŷ� �˻� ���
   * 
   * @RequestMapping(value = "/shipping/searchList_by_mem_no.do", method =
   * RequestMethod.GET) public ModelAndView searchList_by_mem_no(int mem_no,
   * String keyword, String searchItem) { ModelAndView mav = new ModelAndView();
   * mav.setViewName("/shipping/searchList_by_mem_no"); System.out.
   * println("searchList_by_mem_no (int mem_no, String keyword, String searchItem) called!"
   * ); System.out.println("mem_no: " + mem_no); System.out.println("keyword: "
   * + keyword); System.out.println("searchItem: " + searchItem);
   * 
   * HashMap<String, Object> hashMap = new HashMap<String, Object>();
   * hashMap.put("mem_no", mem_no); hashMap.put("keyword", keyword);
   * hashMap.put("searchItem", searchItem);
   * 
   * List<ShippingVO> searchList = shippingProc.searchList_by_mem_no(hashMap);
   * mav.addObject("searchList", searchList);
   * 
   * // �˻��� ���ڵ� ���� int search_count = shippingProc.search_count(hashMap);
   * mav.addObject("search_count", search_count);
   * 
   * mav.addObject("keyword", keyword); mav.addObject("searchItem", searchItem);
   * 
   * return mav; }
   */
  // 7/13 ~ 7/17
  // ---------------------------------------------------------------------------------

  // ȸ�� �ù�ŷ� �˻� ��� + �˻� + ����¡
  @RequestMapping(value = "/shipping/searchList_by_mem_no_paging.do", method = RequestMethod.GET)
  public ModelAndView searchList_by_mem_no_paging(
      HttpSession session,
      @RequestParam(value = "keyword", defaultValue = "") String keyword,
      @RequestParam(value = "searchItem", defaultValue = "") String searchItem,
      @RequestParam(value = "nowPage", defaultValue = "1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/shipping/searchList_by_mem_no_paging");
//    System.out.println("searchList_by_mem_no_paging ( ... ) called!");
//    System.out.println("keyword: " + keyword);
//    System.out.println("searchItem: " + searchItem);
//    System.out.println("nowPage: " + nowPage);

    int mem_no = (Integer)session.getAttribute("mem_no"); // session
//    System.out.println("mem_no: " + mem_no);
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no);
    hashMap.put("keyword", keyword);
    hashMap.put("searchItem", searchItem);
    hashMap.put("nowPage", nowPage);

    List<ShippingVO> list = shippingProc.searchList_by_mem_no_paging(hashMap);
    mav.addObject("list", list);

    // �˻��� ���ڵ� ����
    int search_count = shippingProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    /**
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� ���� ������: 11 / 22 [����] 11 12 13 14 15 16
     * 17 18 19 20 [����]
     * 
     * @param mem_no
     * @param search_count
     * @param nowPage
     * @param keyword
     * @return
     */
    String paging = shippingProc.paging(mem_no, search_count, nowPage, keyword);
    mav.addObject("paging", paging);

    mav.addObject("keyword", keyword);
    mav.addObject("searchItem", searchItem);

    return mav;
  }
  // 7/17
  // ---------------------------------------------------------------------------------

}
