package dev.mvc.deal;

import java.util.HashMap;
import java.util.List;

public interface DealProcInter{
 
  public int create(DealVO dealVO);
  // 6/21 ---------------------------------------------------------------
  
  public List<Buy_ProductVO> BPList_by_buy_no(int buy_no);
  
  public List<Buy_MemberVO> BMList_by_mem_no(int mem_no);
  
  public List<Member_Product_DealVO> list();
  
  public List<BuyMember_DealVO> bm_dealList();
  // 6/25 ---------------------------------------------------------------
  
  public List<Buy_ProductVO> bp_list();
  
  public List<Buy_MemberVO> bm_list();
  // 6/22, 6/26 ---------------------------------------------------------------

  public List<Member_Product_DealVO> list_by_deal_no(int deal_no);
  // 6/26 ---------------------------------------------------------------
  
  // <select id="read" resultType="DealVO" parameterType="int">
  public DealVO read(int deal_no);
  // 6/27 ---------------------------------------------------------------
  
  public int update(DealVO dealVO);
  
  public int delete(int deal_no);
  // 6/28~29 ---------------------------------------------------------------
  
  public List<Member_Product_DealVO> list_by_dates_paging(HashMap hashMap);
  
  public int search_count(HashMap hashMap);
  // 6/29 ---------------------------------------------------------------
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param deal_no      카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage      현재 페이지
   * @param startDate    검색어
   * @param endDate      검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging(int search_count, int nowPage, String startDate, String endDate); 
//  public String paging(int deal_no, int search_count, int nowPage, String startDate, String endDate); 
  // 7/4 ---------------------------------------------------------------

  /**
   * 검색 페이징 목록 <Xmp>
   * <select id="list_by_category_search" resultType="Member_Product_DealVO"
   * parameterType= "HashMap"> </Xmp>
   * 
   * @param hashMap
   * @return
   */
  public List<Member_Product_DealVO> searchList(HashMap hashMap);
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param deal_no      카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage      현재 페이지
   * @param startDate    검색어
   * @param endDate      검색어
   * @return 페이징 생성 문자열
   */ 
//  public String paging2(int search_count, int nowPage, String startDate, String endDate, String keyword); 
  // 7/20 ---------------------------------------------------------------------
  
  /**
   * 검색 페이징 목록 <Xmp>
   * <select id="searchList_paging" resultType="Member_Product_DealVO"
   * parameterType= "HashMap"> </Xmp>
   * 
   * @param hashMap
   * @return
   */
  public List<Member_Product_DealVO> searchList_paging(HashMap hashMap);
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param deal_no      카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage      현재 페이지
   * @param startDate    검색어
   * @param endDate      검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging3(int search_count, int nowPage, String startDate, String endDate, String keyword, String searchItem); 
  // 7/25 ---------------------------------------------------------------------
  
}