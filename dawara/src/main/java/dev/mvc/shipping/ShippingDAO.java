package dev.mvc.shipping;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.shipping.ShippingDAO")
public class ShippingDAO implements ShippingDAOInter {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;

  public ShippingDAO() {
    System.out.println("--> ShippingDAO created.");
  }

  @Override
  public List<Product_MemberVO> pr_mem_info(int pr_no) {
    List<Product_MemberVO> pmList = sqlSessionTemplate.selectList("shipping.pr_mem_info", pr_no);
    return pmList;
  }

  @Override
  public int create(ShippingVO shippingVO) {
    return sqlSessionTemplate.insert("shipping.create", shippingVO);
  }
  // 7/10 - 7/11
  // ---------------------------------------------------------------------------------

  @Override
  public List<ShippingVO> list() {
    return sqlSessionTemplate.selectList("shipping.list");
  }

  @Override
  public List<ShippingVO> list_by_mem_no(int mem_no) {
    return sqlSessionTemplate.selectList("shipping.list_by_mem_no", mem_no);
  }

  @Override
  public ShippingVO read(int ship_no) {
    return sqlSessionTemplate.selectOne("shipping.read", ship_no);
  }

  @Override
  public int update(ShippingVO shippingVO) {
    return sqlSessionTemplate.update("shipping.update", shippingVO);
  }

  @Override
  public int delete(int ship_no) {
    return sqlSessionTemplate.delete("shipping.delete", ship_no);
  }
  // 7/12
  // ---------------------------------------------------------------------------------
  
  @Override
  public List<ShippingVO> searchList(HashMap hashMap) {
    return sqlSessionTemplate.selectList("shipping.searchList", hashMap);
  }

  @Override
  public List<ShippingVO> searchList_by_mem_no(HashMap hashMap) {
    return sqlSessionTemplate.selectList("shipping.searchList_by_mem_no", hashMap);
  }

  @Override
  public int search_count(HashMap hashMap) {
    return sqlSessionTemplate.selectOne("shipping.search_count", hashMap);
  }
  // 7/13 ~ 7/17
  // ---------------------------------------------------------------------------------

  @Override
  public List<ShippingVO> searchList_by_mem_no_paging(HashMap hashMap) {
    return sqlSessionTemplate.selectList("shipping.searchList_by_mem_no_paging", hashMap);
  }
  // 7/17

}
