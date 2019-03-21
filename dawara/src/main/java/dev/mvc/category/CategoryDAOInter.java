package dev.mvc.category;

import java.util.List;

public interface CategoryDAOInter {
  // <insert id="create" parameterType="CategoryVO">
  public int create(CategoryVO categoryVO);
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="Categrp_CategoryVO">
   * </xmp>
   * @return
   */
  public List<Categrp_CategoryVO> list();
  
  // <select id="list_by_categrpno" resultType="Categrp_CategoryVO" parameterType="int">
  public List<Categrp_CategoryVO> list_by_grp_no(int grp_no);
  
  /**
   * 한건의 레코드 조회
   * <xmp>
   * <select id="read" resultType="CategoryVO" parameterType="int">
   * </xmp> 
   * @param categrpno
   * @return
   */
  public CategoryVO read(int gory_no);
  
  /**
   * 레코드를 수정합니다.
   * <xmp>
   * <update id="update" parameterType="CategoryVO">
   * </xmp> 
   * @param categoryVO 
   * @return
   */
  public int update(CategoryVO categoryVO ); 
  
  /**
   * 한건의 레코드 삭제
   * <xmp> 
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param categoryno
   * @return
   */
  public int delete(int gory_no);
  
  // <update id="update_seqno_up" parameterType="int">
  public int update_seqno_up(int gory_no);
  
  // <update id="update_seqno_down" parameterType="int">
  public int update_seqno_down(int gory_no);
  
  // <select id="countByCategrpno" resultType="int" parameterType="int">
  public int countBygrp_no(int grp_no);
 
  // <delete id="deleteByCategrpno" parameterType="int">
  public int deleteBygrp_no(int grp_no);
  
  /**
   * 글 수 증가
   * <xmp>
   * <update id="increaseCnt" parameterType="int">
   * </xmp> 
   * @param categoryno
   * @return
   */
  public int increaseCnt(int gory_no);
 
  /**
   * 글 수 감소
   * <xmp>
   * <update id="decreaseCnt" parameterType="int">
   * </xmp> 
   * @param categoryno 
   * @return
   */
  public int decreaseCnt(int gory_no);
 
  
}






