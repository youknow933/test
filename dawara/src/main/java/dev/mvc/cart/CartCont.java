package dev.mvc.cart;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryProcInter;
import dev.mvc.category.Categrp_CategoryVO;
import dev.mvc.categrp.CategrpVO;
import nation.web.tool.Messages;

@Controller
public class CartCont {
  @Autowired
  @Qualifier("dev.mvc.tool.Messages")
  private Messages messages = null;
  
  @Autowired
  @Qualifier("dev.mvc.cart.CartProc") // 할당되는 Class 객체의 이름
  private CartProcInter cartProc;
  
  
  public CartCont() {
    System.out.println("cartCont created.");    
  }
  
  // http://localhost:9090/ojt/cart/create.do
  // http://localhost:9090/ojt/cart/create.jsp
  @RequestMapping(value="/cart/create.do", method=RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cart/create"); // /cart/create.jsp
    
    return mav;
  }

  @RequestMapping(value="/product/cart_create.do", method=RequestMethod.POST)
  public ModelAndView cart_create(CartVO cartVO, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    int mem_no = (Integer)session.getAttribute("mem_no");
    cartVO.setMem_no(mem_no);
    hashMap.put("mem_no", mem_no);
    hashMap.put("pr_no", cartVO.getPr_no()); 
      if(cartProc.pr_count(hashMap)==0){
        cartProc.create(cartVO);
      }
    mav.setViewName("redirect:/product/cart_list.do");
    
    return mav;
  }

  
  @RequestMapping(value="/product/cart_list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product/cart_list"); // webapp/category/list.jsp
    
    int mem_no = (Integer)session.getAttribute("mem_no");
    
 /*   CategrpVO categrpVO = cartProc.read(categrpno);
    mav.addObject("categrpVO", categrpVO);*/
    
    List<Product_CartVO> list = cartProc.list_by_mem_no(mem_no);
    

    mav.addObject("list", list);
    
    return mav;
  }
  
  @RequestMapping(value="/product/cart_delete.do", method=RequestMethod.GET)
  public ModelAndView cart_delete(int cart_no, int mem_no) {
    ModelAndView mav = new ModelAndView();
    
    System.out.println("cart_no : " +cart_no);
     
    cartProc.delete(cart_no);
    
    mav.setViewName("redirect:/product/cart_list.do?mem_no="+mem_no);
    
    return mav;
  }
  
}








