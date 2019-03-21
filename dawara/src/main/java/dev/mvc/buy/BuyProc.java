package dev.mvc.buy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.reply.ReplyVO;

@Component("dev.mvc.buy.BuyProc")
public class BuyProc implements BuyProcInter {
  @Autowired
  @Qualifier("dev.mvc.buy.BuyDAO")
  private BuyDAOInter buyDAO = null;
  
  public BuyProc() {
    System.out.println("--> BuyProc created.");
  }

  @Override
  public int create(BuyVO buyVO) {
    return buyDAO.create(buyVO);
  }
  
  @Override
  public List<BuyVO> list_by_mem_no(int mem_no) {
    List<BuyVO> list = buyDAO.list_by_mem_no(mem_no); 
    
    return list;
  }
  
  @Override
  public List<Product_BuyVO> list_by_buyno_prno(int mem_no) {
    List<Product_BuyVO> list = buyDAO.list_by_buyno_prno(mem_no); 
    
    return list;
  }
  
  @Override
  public int delete(int buy_no) {
    int count = buyDAO.delete(buy_no);
    return count;
  }

}