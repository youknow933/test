package dev.mvc.buy;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dev.mvc.reply.ReplyVO;

@Repository("dev.mvc.buy.BuyDAO")
public class BuyDAO implements BuyDAOInter {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public BuyDAO() {
    System.out.println("--> BuyDAO created.");
  }

  @Override
  public int create(BuyVO BuyVO) {
    return sqlSessionTemplate.insert("buy.create", BuyVO);
  }
  
  @Override
  public List<BuyVO> list_by_mem_no(int mem_no) {
    List<BuyVO> list = null;
    list = sqlSessionTemplate.selectList("buy.list_by_mem_no", mem_no);
    
    return list;
  }
  
  @Override
  public List<Product_BuyVO> list_by_buyno_prno(int mem_no) {
    List<Product_BuyVO> list = null;
    list = sqlSessionTemplate.selectList("buy.list_by_buyno_prno", mem_no);

    return list;
  }
  
  @Override
  public int delete(int buy_no) {
    int count = sqlSessionTemplate.delete("buy.delete",  buy_no);
    return count;
  }
  
}