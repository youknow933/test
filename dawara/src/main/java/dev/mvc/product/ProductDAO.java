package dev.mvc.product;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository("dev.mvc.product.ProductDAO")
public class ProductDAO implements ProductDAOInter {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public ProductDAO() {
    System.out.println("--> ProductDAO created.");
  }
  
  @Override
  public int create(ProductVO productVO) {
    // namespace.еб╠в ID
    int count = sqlSessionTemplate.insert("product.create", productVO);
    return count;
  }
  
  @Override
  public List<ProductVO> list_by_category_search(HashMap hashMap) {
    List<ProductVO> list = null;
    list = sqlSessionTemplate.selectList("product.list_by_category_search", hashMap);

    return list;
  }
  
  @Override
  public List<ProductVO> list_mem_no(HashMap hashMap) {
    List<ProductVO> list = null;
    list = sqlSessionTemplate.selectList("product.list_mem_no", hashMap);

    return list;
  }
  
  @Override
  public List<ProductVO> list_sell_mem_no(int mem_no) {
    List<ProductVO> list = null;
    list = sqlSessionTemplate.selectList("product.list_sell_mem_no", mem_no);

    return list;
  }
  
  
  @Override
  public int search_count(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("product.search_count", hashMap);
    
    return cnt;
  }
  
  @Override
  public int search_count_mem_no(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("product.search_count_mem_no", hashMap);
    
    return cnt;
  }
  
  @Override
  public ProductVO read(int pr_no) {
    return sqlSessionTemplate.selectOne("product.read", pr_no);
  }
  
  @Override
  public int update(ProductVO productVO) {
    return sqlSessionTemplate.update("product.update", productVO);
  }
  
  @Override
  public int update_visible(int pr_no) {
    return sqlSessionTemplate.update("product.update_visible", pr_no);
  }
  
  @Override
  public int delete(int pr_no) {
    return sqlSessionTemplate.delete("product.delete", pr_no);
  }

}
