package dev.mvc.cart;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.category.Categrp_CategoryVO;

@Component("dev.mvc.cart.CartProc")
public class CartProc  implements CartProcInter {
  @Autowired
  @Qualifier("dev.mvc.cart.CartDAO") // 할당되는 Class 객체의 이름
  private CartDAOInter cartDAO = null;
  
  public CartProc() {
    System.out.println("--> CartProc created.");
  }

  @Override
  public int create(CartVO cartVO) {
    int count = cartDAO.create(cartVO);
    return count;
  }
  
  @Override
  public List<Product_CartVO> list_by_mem_no(int mem_no) {
    List<Product_CartVO> list = cartDAO.list_by_mem_no(mem_no);
    
    return list;
  }
  
  @Override
  public int delete(int cart_no) {
    return cartDAO.delete(cart_no);
  }
  
  @Override
  public int deleteByPr_no(int pr_no) {
    return cartDAO.deleteByPr_no(pr_no);
  }
  
  @Override
  public int pr_count(HashMap hashMap) {
    int count = cartDAO.pr_count(hashMap);
    return count;
  }

}





