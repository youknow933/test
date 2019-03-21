package dev.mvc.deal;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.deal.DealDAO")
public class DealDAO implements DealDAOInter {
  @Autowired 
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public DealDAO() {
    System.out.println("--> DealDAO created.");
  }

  @Override
  public int create(DealVO dealVO) {
    return sqlSessionTemplate.insert("deal.create", dealVO);
  }
  // 6/21 ---------------------------------------------------------------
  
  @Override
  public List<Member_Product_DealVO> list() {
    List<Member_Product_DealVO> list = sqlSessionTemplate.selectList("deal.list");
    return list;
  }

  @Override
  public List<BuyMember_DealVO> bm_dealList() {
    List<BuyMember_DealVO> bm_dealList = sqlSessionTemplate.selectList("deal.bm_dealList");
    return bm_dealList;
  }
  // 6/25 ---------------------------------------------------------------

  @Override
  public List<Buy_ProductVO> bp_list() {
    List<Buy_ProductVO> bp_list = sqlSessionTemplate.selectList("deal.bp_list");
    return bp_list;
  }
  
  @Override
  public List<Buy_MemberVO> bm_list() {
    List<Buy_MemberVO> bm_list = sqlSessionTemplate.selectList("deal.bm_list");
    return bm_list;
  }
  // 6/22, 6/26 ---------------------------------------------------------------

  @Override
  public List<Member_Product_DealVO> list_by_deal_no(int deal_no) {
    List<Member_Product_DealVO> list = sqlSessionTemplate.selectList("deal.list_by_deal_no", deal_no);
    return list;
  }
  // 6/26 ---------------------------------------------------------------------

  @Override
  public List<Buy_ProductVO> BPList_by_buy_no(int buy_no) {
    List<Buy_ProductVO> BPList = sqlSessionTemplate.selectList("deal.BPList_by_buy_no", buy_no);
    return BPList;
  }

  @Override
  public List<Buy_MemberVO> BMList_by_mem_no(int mem_no) {
    List<Buy_MemberVO> BMList = sqlSessionTemplate.selectList("deal.BMList_by_mem_no", mem_no);
    return BMList; 
  }
  // 6/26, 6/25 ---------------------------------------------------------------
  
  @Override
  public DealVO read(int deal_no) {
    return sqlSessionTemplate.selectOne("deal.read", deal_no);
  }
  // 6/27 ---------------------------------------------------------------------

  @Override
  public int update(DealVO dealVO) {
    int count = sqlSessionTemplate.update("deal.update", dealVO);
//    System.out.println("DAO update() count: " + count);
    return count;
  }
  // 6/28~29 ---------------------------------------------------------------------

  @Override
  public int delete(int deal_no) {
    return sqlSessionTemplate.delete("deal.delete", deal_no);
  }

  @Override
  public List<Member_Product_DealVO> list_by_dates_paging(HashMap hashMap) {
    return sqlSessionTemplate.selectList("deal.list_by_dates_paging", hashMap);
  }

  @Override
  public int search_count(HashMap hashMap) {
    return sqlSessionTemplate.selectOne("deal.search_count", hashMap);
  }
  // 6/29 ---------------------------------------------------------------------
  
  @Override
  public List<Member_Product_DealVO> searchList(HashMap hashMap) {
    return sqlSessionTemplate.selectList("deal.searchList", hashMap);
  }
  // 7/20 ---------------------------------------------------------------------
  
  @Override
  public List<Member_Product_DealVO> searchList_paging(HashMap hashMap) {
    return sqlSessionTemplate.selectList("deal.searchList_paging", hashMap);
  }
  // 7/25 ---------------------------------------------------------------------

}