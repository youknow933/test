package dev.mvc.buy;
 
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cart.CartProcInter;
import dev.mvc.cart.CartVO;
import dev.mvc.cart.Product_CartVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.product.ProductProcInter;
 
@Controller
public class BuyCont {
  @Autowired
  @Qualifier("dev.mvc.buy.BuyProc")
  private BuyProcInter buyProc;
  
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc;
  
  @Autowired
  @Qualifier("dev.mvc.cart.CartProc")
  private CartProcInter cartProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  public BuyCont() {
    System.out.println("-> BuyCont created.");
  }
  
  // http://localhost:9090/ojt/cart/create.do
  // http://localhost:9090/ojt/cart/create.jsp
  @RequestMapping(value="/buy/create.do", method=RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/buy/create"); // /cart/create.jsp
    
    return mav;
  }

  @RequestMapping(value="/buy/buy_create.do", method=RequestMethod.POST)
  public ModelAndView create(BuyVO buyVO, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    int mem_no = (Integer)session.getAttribute("mem_no");
    buyVO.setMem_no(mem_no);
    productProc.update_visible(buyVO.getPr_no());
    cartProc.deleteByPr_no(buyVO.getPr_no());
    buyProc.create(buyVO);
    
  
    mav.setViewName("redirect:/product/buy_list.do");
    
    return mav;
  }
  
  @RequestMapping(value="/product/buy_list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session){
    int mem_no = (Integer)session.getAttribute("mem_no");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product/buy_list"); // webapp/category/list.jsp
    
    List<Product_BuyVO> list = buyProc.list_by_buyno_prno(mem_no);
    
  
    mav.addObject("list", list);
    
    return mav;
  } 
  
  @RequestMapping(value="/buy/delete.do", method=RequestMethod.GET)
  public ModelAndView delete(int buy_no, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int mem_no = (Integer)session.getAttribute("mem_no");
    buyProc.delete(buy_no);
    
    mav.setViewName("redirect:/product/buy_list.do");
    
    return mav;
  }
}
  
  