package dev.mvc.payment;

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

import dev.mvc.buy.BuyProcInter;
import dev.mvc.buy.BuyVO;
import dev.mvc.cart.CartProcInter;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.product.ProductProcInter;
import dev.mvc.product.ProductVO;
import dev.mvc.shipping.ShippingProcInter;
import dev.mvc.shipping.ShippingVO;
import nation.web.tool.Tool;

@Controller
public class PaymentCont {
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private MemberProcInter memberProc;

  @Autowired
  @Qualifier("dev.mvc.product.ProductProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private ProductProcInter productProc;

  @Autowired
  @Qualifier("dev.mvc.shipping.ShippingProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private ShippingProcInter shippingProc;

  @Autowired
  @Qualifier("dev.mvc.payment.PaymentProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private PaymentProcInter paymentProc;

  @Autowired
  @Qualifier("dev.mvc.buy.BuyProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private BuyProcInter buyProc;
  
  @Autowired
  @Qualifier("dev.mvc.cart.CartProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private CartProcInter cartProc;
  
  public PaymentCont() {
    System.out.println("-> PaymentCont created.");
  }

  // http://localhost:9090/dawara/payment/create.do
  // ���� ��� ��
  @RequestMapping(value = "/payment/create.do", method = RequestMethod.GET)
  public ModelAndView create(HttpSession session, int ship_no) {
    ModelAndView mav = new ModelAndView();
    // System.out.println("create(int pay_no, int mem_no) GET called!");
    // System.out.println("- pay_no = " + pay_no);

    int mem_no = (Integer) session.getAttribute("mem_no"); // session
    // System.out.println("- mem_no = " + mem_no);

    // �����ϴ� ���̺� ��ü�� ����
    MemberVO memberVO = memberProc.read(mem_no);
    mav.addObject("memberVO", memberVO);
    ShippingVO shippingVO = shippingProc.read(ship_no);
    mav.addObject("shippingVO", shippingVO);
    ProductVO productVO = productProc.read(shippingVO.getPr_no());
    mav.addObject("productVO", productVO);
    System.out.println("- pr_no = " + productVO.getPr_no());

    mav.setViewName("/payment/create");
    return mav;
  }
  // 7/18
  // ---------------------------------------------------------------------------------
    
  // ���� ��� ó��
  @RequestMapping(value = "/payment/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpSession session, PaymentVO paymentVO) {
    ModelAndView mav = new ModelAndView();

    int mem_no = (Integer) session.getAttribute("mem_no"); // session
//    System.out.println("-- mem_no: " + mem_no);
    paymentVO.setMem_no(mem_no);
//     System.out.println("create(PaymentVO paymentVO) POST called!");
//     System.out.println("paymentVO.getPay_no(): " + paymentVO.getPay_no());
//     System.out.println("paymentVO.getPay_way(): " + paymentVO.getPay_way());

    // ��� ó��
    if (paymentProc.create(paymentVO) == 1) {
      
      int ship_no = paymentVO.getShip_no();
      ShippingVO shippingVO = shippingProc.read(ship_no);
      
      int pr_no = shippingVO.getPr_no();
      shippingProc.create(shippingVO);
      int pay_no = paymentVO.getPay_no();
      
      System.out.println("-- ship_no:" + ship_no);
      System.out.println("-- pr_no:" + pr_no);
      System.out.println("-- pay_no:" + pay_no);
      
      // ���� ������ ��ǰ create
      BuyVO buyVO = new BuyVO();      
      buyVO.setPr_no(pr_no);
      buyVO.setMem_no(mem_no);
      buyVO.setPay_no(pay_no);
      int buycount = buyProc.create(buyVO);
      
      if(buycount == 1){
        productProc.update_visible(pr_no);
        cartProc.deleteByPr_no(pr_no);
        System.out.println("buyProc.create() count:" + buycount);
      }
      
      mav.setViewName("redirect:/payment/searchList_by_mem_no_paging.do");
      // ȸ�� �������� ������� �ٷ� ������ �̵� - redirect: Ȯ���ڸ� ��������!!
      // mav.setViewName("redirect:/payment/searchList_by_mem_no_paging.do?mem_no="
      // + paymentVO.getMem_no());
    } else {
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();

      msgs.add("������ �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ� �ѹ� �õ��� �ּ���.");
      msgs.add("�� ����: ��000-0000-1111");
      links.add("<button type='button' onclick=\"history.back();\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do';\">���</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      mav.setViewName("/payment/message");
    }
    return mav;
  }

  // ���� ����
  @RequestMapping(value = "/payment/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/payment/list");
    // System.out.println("--> list() GET called!");

    List<PaymentVO> list = paymentProc.list();
    mav.addObject("list", list);

    return mav;
  }

  // ȸ�� ���� ����
  @RequestMapping(value = "/payment/list_by_mem_no.do", method = RequestMethod.GET)
  public ModelAndView list_by_mem_no(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/payment/list_by_mem_no");
    int mem_no = (Integer) session.getAttribute("mem_no"); // session

    // System.out.println("--> list_by_mem(int mem_no) GET called!");
    // System.out.println("- mem_no: " + mem_no);

    List<PaymentVO> list = paymentProc.list_by_mem_no(mem_no);
    mav.addObject("list", list);

    return mav;
  }

  // �������� ����
  @RequestMapping(value = "/payment/read.do", method = RequestMethod.GET)
  public ModelAndView read(int pay_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/payment/read");
    // System.out.println("--> read(int pay_no) GET called!");

    PaymentVO paymentVO = paymentProc.read(pay_no);
    mav.addObject("paymentVO", paymentVO);

    return mav;
  }

  // �������� ���� ��
  @RequestMapping(value = "/payment/update.do", method = RequestMethod.GET)
  public ModelAndView update(int pay_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/payment/update");
    // System.out.println("--> update(int pay_no) GET called!");

    PaymentVO paymentVO = paymentProc.read(pay_no);
    mav.addObject("paymentVO", paymentVO);

    return mav;
  }

  // �������� ���� ó��
  @RequestMapping(value = "/payment/update.do", method = RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes, HttpServletRequest request, PaymentVO paymentVO,
      @RequestParam(value = "keyword", defaultValue = "") String keyword,
      @RequestParam(value = "nowPage", defaultValue = "1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    System.out.println("--> update() POST called.");
    int pay_no = paymentVO.getPay_no();
    System.out.println("pay_no: " + pay_no);

    if (paymentProc.update(paymentVO) == 1) {
      // redirect�� �ּ� �̵�. forward(x)
      mav.setViewName("redirect:/payment/message_update.jsp");

      redirectAttributes.addAttribute("count", paymentProc.update(paymentVO));
      redirectAttributes.addAttribute("pay_no", pay_no);
      redirectAttributes.addAttribute("keyword", keyword);
      redirectAttributes.addAttribute("nowPage", nowPage);
    } else {
      ArrayList<String> msgs = new ArrayList<String>();
      ArrayList<String> links = new ArrayList<String>();

      msgs.add("�������� ������ �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ� �ѹ� �õ��� �ּ���.");
      msgs.add("�� ����: ��000-0000-1111");

      links.add("<button type='button' onclick=\"history.back();\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do\">���</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);

      mav.setViewName("/payment/message");
    }

    return mav;
  }

  /*
   * // �������� ���� �� ajax���
   * 
   * @ResponseBody //�ڹ� ��ü�� HTTP ��û�� body �������� �����ϴ� ����
   * 
   * @RequestMapping(value="/payment/update.do", method = RequestMethod.GET,
   * produces = "text/plain; charset=UTF-8") // ���� �������� ���� UTF-8 ���ڵ��� �����Ͽ� �ѱ�
   * ������ ���� �� �� ����. public String update(int pay_no){
   * System.out.println("--> update(int pay_no) GET called!");
   * System.out.println("- pay_no: " + pay_no);
   * 
   * PaymentVO paymentVO = paymentProc.read(pay_no);
   * 
   * JSONObject obj = new JSONObject(); obj.put("ship_zipcode",
   * paymentVO.getShip_zipcode()); obj.put("ship_addr1",
   * paymentVO.getShip_addr1()); obj.put("ship_addr2",
   * paymentVO.getShip_addr2()); obj.put("ship_rname",
   * paymentVO.getShip_rname()); obj.put("ship_rtel", paymentVO.getShip_rtel());
   * obj.put("ship_memo", paymentVO.getShip_memo()); obj.put("ship_date",
   * paymentVO.getShip_date()); obj.put("ship_check",
   * paymentVO.getShip_check()); obj.put("PR_NO", paymentVO.getPr_no());
   * obj.put("MEM_NO", paymentVO.getMem_no());
   * 
   * return obj.toJSONString();1 }
   */

  // �������� ���� ��
  @RequestMapping(value = "/payment/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int pay_no) {
    ModelAndView mav = new ModelAndView();
    // System.out.println("--> delete(int pay_no) GET called!");
    // System.out.println("- pay_no: " + pay_no);

    mav.setViewName("/payment/delete");

    PaymentVO paymentVO = paymentProc.read(pay_no);
    mav.addObject("PaymentVO", paymentVO);

    return mav;
  }

  // �������� ���� ó��
  @RequestMapping(value = "/payment/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, HttpServletRequest request, int pay_no,
      @RequestParam(value = "keyword", defaultValue = "") String keyword,
      @RequestParam(value = "nowPage", defaultValue = "1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    System.out.println("--> delete() POST called!");
    System.out.println("pay_no: " + pay_no);

    int count = paymentProc.delete(pay_no);
    if (count == 1) {
      mav.setViewName("redirect:/payment/message_delete.jsp");

      System.out.println("count: " + count);
      System.out.println("pay_no: " + pay_no);
      System.out.println("keyword: " + keyword);
      System.out.println("nowPage: " + nowPage);

      redirectAttributes.addAttribute("count", count);
      redirectAttributes.addAttribute("pay_no", pay_no);
      redirectAttributes.addAttribute("keyword", keyword);
      redirectAttributes.addAttribute("nowPage", nowPage);
    }
    return mav;
  }

  // ��ü �������� �˻� ���
  @RequestMapping(value = "/payment/searchList.do", method = RequestMethod.GET)
  public ModelAndView searchList(String keyword, String searchItem) {
//    System.out.println("searchList(String keyword, String searchItem) called!");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/payment/searchList");
    
//    System.out.println("keyword: " + keyword);
//    System.out.println("searchItem: " + searchItem);

    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("keyword", keyword);
    hashMap.put("searchItem", searchItem);

    List<PaymentVO> list = paymentProc.searchList(hashMap);
    mav.addObject("list", list);

    // �˻��� ���ڵ� ���� 
    int search_count = paymentProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    mav.addObject("keyword", keyword);
    mav.addObject("searchItem", searchItem);

    return mav;
  }

  // ȸ�� �������� �˻� ���
  @RequestMapping(value = "/payment/searchList_by_mem_no.do", method = RequestMethod.GET)
  public ModelAndView searchList_by_mem_no(HttpSession session, String keyword, String searchItem) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/payment/searchList_by_mem_no");
//    System.out.println("searchList_by_mem_no (int mem_no, String keyword, String searchItem) called!");
//    System.out.println("keyword: " + keyword);
//    System.out.println("searchItem: " + searchItem);
    
    int mem_no = (Integer)session.getAttribute("mem_no"); // session
//    System.out.println("mem_no: " + mem_no);

    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no);
    hashMap.put("keyword", keyword);
    hashMap.put("searchItem", searchItem);

    List<PaymentVO> list = paymentProc.searchList_by_mem_no(hashMap);
    mav.addObject("list", list);

    // �˻��� ���ڵ� ���� 
    int search_count_by_mem_no = paymentProc.search_count_by_mem_no(hashMap);
    mav.addObject("search_count_by_mem_no", search_count_by_mem_no);

    mav.addObject("keyword", keyword);
    mav.addObject("searchItem", searchItem);

    return mav;
  }

  // ȸ�� �ù�ŷ� �˻� ��� + �˻� + ����¡
  @RequestMapping(value = "/payment/searchList_by_mem_no_paging.do", method = RequestMethod.GET)
  public ModelAndView searchList_by_mem_no_paging(HttpSession session,
      @RequestParam(value = "keyword", defaultValue = "") String keyword,
      @RequestParam(value = "searchItem", defaultValue = "") String searchItem,
      @RequestParam(value = "nowPage", defaultValue = "1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/payment/searchList_by_mem_no_paging");
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

    // ���� ����
    List<PaymentVO> list = paymentProc.searchList_by_mem_no_paging(hashMap);
    mav.addObject("list", list);
    
    Tool tool = new Tool();
    mav.addObject("tool", tool); // tool.comma() ���

    // �˻��� ���ڵ� ����
    int search_count_by_mem_no = paymentProc.search_count_by_mem_no(hashMap);
    mav.addObject("search_count_by_mem_no", search_count_by_mem_no);

    String paging = paymentProc.paging(mem_no, search_count_by_mem_no, nowPage, keyword, searchItem);
    mav.addObject("paging", paging);

    mav.addObject("keyword", keyword);
    mav.addObject("searchItem", searchItem);

    return mav;
  }
  // 7/19
  // ---------------------------------------------------------------------------------
}
