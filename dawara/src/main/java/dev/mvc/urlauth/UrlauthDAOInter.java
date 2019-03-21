package dev.mvc.urlauth;

import java.util.HashMap;
import java.util.List;

import dev.mvc.auth.AuthVO;

public interface UrlauthDAOInter {
  /**
   * 등록
   * <xmp>
   * <insert id="create" parameterType="UrlauthVO">
   * </xmp>
   * @return
   */
  public int create(UrlauthVO urlauthVO);
  
  /**
   * 조회
   * <xmp>
   * <select id="read" resultType="UrlauthVO" parameterType="int">
   * </xmp>
   * @return
   */
  public UrlauthVO read(int urlauth_no);
  
  /**
   * 수정
   * <xmp>
   * <update id="update" parameterType="UrlauthVO">
   * </xmp>
   * @return
   */
  public int update(UrlauthVO urlauthVO);
  
  /**
   * 삭제
   * <xmp>
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @return
   */
  public int delete(int urlauth_no);
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="UrlauthVO">
   * </xmp>
   * @return
   */
  public List<UrlauthVO> list(); 
  
  /**
   * 검색된 레코드 갯수
   * <xmp>
   * <select id="urlauth_search_cnt" resultType="int" parameterType="HashMap">
   * </xmp>
   * @return
   */
  public int urlauth_search_cnt(HashMap hashMap); 
  
  /**
   * 검색 목록 페이징
   * <xmp>
   * <select id="list_search_paging" resultType="UrlauthVO" parameterType="HashMap">
   * </xmp>
   * @return
   */
  public List<UrlauthVO> list_search_paging(HashMap hashMap);
}
