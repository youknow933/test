package dev.mvc.payment;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.payment.PaymentDAO")
public class PaymentDAO implements PaymentDAOInter {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;

  public PaymentDAO() {
    System.out.println("--> PaymentDAO created.");
  }

  @Override
  public int create(PaymentVO paymentVO) {
    return sqlSessionTemplate.insert("payment.create", paymentVO);
  }
  // 7/18
  // ---------------------------------------------------------------------------------

  @Override
  public List<PaymentVO> list() {
    return sqlSessionTemplate.selectList("payment.list");
  }

  @Override
  public List<PaymentVO> list_by_mem_no(int mem_no) {
    return sqlSessionTemplate.selectList("payment.list_by_mem_no", mem_no);
  }

  @Override
  public PaymentVO read(int pay_no) {
    return sqlSessionTemplate.selectOne("payment.read", pay_no);
  }
  
  @Override
  public int update(PaymentVO paymentVO) {
    return sqlSessionTemplate.update("payment.update", paymentVO);
  }

  @Override
  public int delete(int pay_no) {
    return sqlSessionTemplate.delete("payment.delete", pay_no);
  }
  // ---------------------------------------------------------------------------------
  
  @Override
  public List<PaymentVO> searchList(HashMap hashMap) {
    return sqlSessionTemplate.selectList("payment.searchList", hashMap);
  }

  @Override
  public int search_count(HashMap hashMap) {
    return sqlSessionTemplate.selectOne("payment.search_count", hashMap);
  }
  
  @Override
  public List<PaymentVO> searchList_by_mem_no(HashMap hashMap) {
    return sqlSessionTemplate.selectList("payment.searchList_by_mem_no", hashMap);
  }
  
  @Override
  public int search_count_by_mem_no(HashMap hashMap) {
    return sqlSessionTemplate.selectOne("payment.search_count_by_mem_no", hashMap);
  }

  @Override
  public List<PaymentVO> searchList_by_mem_no_paging(HashMap hashMap) {
    return sqlSessionTemplate.selectList("payment.searchList_by_mem_no_paging", hashMap);
  }
  // 7/19
  // ---------------------------------------------------------------------------------
}
