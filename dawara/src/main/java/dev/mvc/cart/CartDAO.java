package dev.mvc.cart;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dev.mvc.category.Categrp_CategoryVO;

@Repository("dev.mvc.cart.CartDAO")
public class CartDAO implements CartDAOInter{
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public CartDAO() {
    System.out.println("--> CartDAO created.");
    
//    if (sqlSessionTemplate != null) {
//      System.out.println("--> sqlSessionTemplate 할당됨.");      
//    }
  }

  /**
   * <Xmp>
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="CartVO"> 
   * </Xmp>
   * @param CartVO
   * @return 처리된 레코드 갯수
   */
  @Override
  public int create(CartVO cartVO) {
    // statement: namespace.id
    int count = sqlSessionTemplate.insert("cart.create", cartVO);
    return count;
  }

  @Override
  public List<Product_CartVO> list_by_mem_no(int mem_no) {
    List<Product_CartVO> list = sqlSessionTemplate.selectList("cart.list_by_mem_no", mem_no);
    return list;
  }
  
  @Override
  public int delete(int cart_no) {
    return sqlSessionTemplate.delete("cart.delete", cart_no);
  }
  
  @Override
  public int deleteByPr_no(int pr_no) {
    return sqlSessionTemplate.delete("cart.deleteByPr_no", pr_no);
  }
  
  @Override
  public int pr_count(HashMap hashMap) {
    return sqlSessionTemplate.selectOne("cart.pr_count", hashMap);
  }


  
  
}






