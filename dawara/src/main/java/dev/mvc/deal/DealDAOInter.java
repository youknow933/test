package dev.mvc.deal;

import java.util.HashMap;
import java.util.List;

public interface DealDAOInter {

  /**
   * 등록 <Xmp> <insert id="create" parameterType="DealVO"> </Xmp>
   * 
   * @param dealVO
   * @return
   */
  public int create(DealVO dealVO);
  // 6/21 ---------------------------------------------------------------

  /**
   * <Xmp> <select id="list" resultType="Categrp_CategoryVO"> </Xmp>
   * 
   * @return
   */
  public List<Buy_ProductVO> BPList_by_buy_no(int buy_no);

  /**
   * <Xmp> <select id="list" resultType="Categrp_CategoryVO"> </Xmp>
   * 
   * @return
   */
  public List<Buy_MemberVO> BMList_by_mem_no(int mem_no);
  // 6/22 ---------------------------------------------------------------

  // <select id="list" resultType="Product_Buy_DealVO">
  public List<Member_Product_DealVO> list(); // ok

  // <select id="buyMemberList" resultType="BuyMember_DealVO">
  public List<BuyMember_DealVO> bm_dealList();
  // 6/25 ---------------------------------------------------------------

  // <select id="bp_list" resultType="Buy_ProductVO">
  public List<Buy_ProductVO> bp_list();

  // <select id="bm_list" resultType="Buy_MemberVO">
  public List<Buy_MemberVO> bm_list();
  // 6/22, 6/26 ---------------------------------------------------------------

  // <select id="list_by_deal_no" resultType="Member_Product_DealVO"
  // parameterType="int">
  public List<Member_Product_DealVO> list_by_deal_no(int deal_no);

  /**
   * 한 건의 레코드 조회
   * 
   * @param deal_no
   * @return
   */
  // <select id="read" resultType="DealVO" parameterType="int">
  public DealVO read(int deal_no);
  // 6/26 ---------------------------------------------------------------

  // <update id="update" parameterType="int">
  public int update(DealVO dealVO);
  // 6/27~29 ---------------------------------------------------------------

  // <delete id="delete" parameterType="int">
  public int delete(int deal_no);

  // <select id="list_by_dates_paging" resultType="DealVO"
  // parameterType="HashMap">
  public List<Member_Product_DealVO> list_by_dates_paging(HashMap hashMap);

  // <select id="search_count" resultType="int" parameterType="HashMap">
  public int search_count(HashMap hashMap);
  // 6/29 ---------------------------------------------------------------

  /**
   * 게시판 글 전체 목록입니다. <Xmp> <select id="list_all_category" resultType="DealVO">
   * </Xmp>
   * 
   * @return
   */
  // public List<Member_Product_DealVO> list_all_category();

  /**
   * 카테고리별 목록 <Xmp>
   * <select id="list_by_category" resultType="DealVO" parameterType="int">
   * </Xmp>
   * 
   * @param categoryno
   * @return
   */
  // public List<DealVO> list_by_category(int categoryno);

  // <select id="total_count" resultType="int">
  // public int total_count();

  /**
   * 검색 페이징 목록 <Xmp>
   * <select id="list_by_category_search" resultType="Member_Product_DealVO"
   * parameterType= "HashMap"> </Xmp>
   * 
   * @param hashMap
   * @return
   */
  public List<Member_Product_DealVO> searchList(HashMap hashMap);
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
  // 7/25 ---------------------------------------------------------------------

}