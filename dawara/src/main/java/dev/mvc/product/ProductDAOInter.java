package dev.mvc.product;

import java.util.HashMap;
import java.util.List;

public interface ProductDAOInter {
  // <insert id="create" parameterType="CategoryVO">
  public int create(ProductVO productVO);
  
  /**
   * 검색 목록
   * <xmp> 
   * <select id="list_by_category_search" resultType="ProductVO" parameterType="HashMap">
   * </xmp>
   * @param categoryno
   * @return
   */
  public List<ProductVO> list_by_category_search(HashMap hashMap);
  
  /**
   * 멤버별 판매중인 검색 목록
   * <xmp> 
   * <select id="list_mem_no" resultType="ProductVO" parameterType="HashMap">
   * </xmp>
   * @param hashMAp
   * @return
   */
  public List<ProductVO> list_mem_no(HashMap hashMap);
  
  /**
   * 멤버별 판매한 목록
   * <xmp> 
   * <select id="list_sell_mem_no" resultType="ProductVO" parameterType="int">
   * </xmp>
   * @param mem_no
   * @return
   */
  public List<ProductVO> list_sell_mem_no(int mem_no);
  
  /**
   * category별 검색된 레코드 갯수
   * <xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   *  </xmp>
   * @return
   */
  public int search_count(HashMap hashMap);  
  
  /**
   * category별 검색된 레코드 갯수
   * <xmp>
   * <select id="search_count_mem_no" resultType="int" parameterType="HashMap">
   *  </xmp>
   * @return
   */
  public int search_count_mem_no(HashMap hashMap);  
  
  /**
   * 한건의 레코드 조회
   * <xmp>
   * <select id="read" resultType="ProductVO" parameterType="int">
   * </xmp>
   * @param pr_no 글 번호
   * @return 
   */
  public ProductVO read(int pr_no);
  
  /**
   * 수정처리
   * <xmp>
   * <update id="update" parameterType="ProductVO">
   * </xmp> 
   * @param vo
   * @return
   */
  public int update(ProductVO productVO);
  
  /**
   * 결제 완료 후 보이지 않게 함
   * <xmp>
   * <update id="update" parameterType="int">
   * </xmp> 
   * @param pr_no
   * @return
   */
  public int update_visible(int pr_no);
  
  
  /**
   * 삭제 처리
   * <xmp>
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @param pr_no
   * @return
   */
  public int delete(int pr_no);
  
  


}
