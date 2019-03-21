package dev.mvc.product;

import java.util.HashMap;
import java.util.List;


public interface ProductProcInter {
  // <insert id="create" parameterType="CategoryVO">
  public int create(ProductVO productVO);
  
  /**
   * 검색 목록
   * <xmp> 
   * <select id="list_by_category_search" resultType="ContentsVO" parameterType="HashMap">
   * </xmp>
   * @param categoryno
   * @return
   */
  public List<ProductVO> list_by_category_search(HashMap hashMap);
  
  /**
   * 검색 목록
   * <xmp> 
   * <select id="list_mem_no" resultType="ProductVO" parameterType="HashMap">
   * </xmp>
   * @param categoryno
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
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param categoryno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging(int categoryno, int search_count, int nowPage, String word); 
  
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
   * @param contentsno
   * @return
   */
  public int delete(int pr_no);
  
  

}
