package dev.mvc.category;

import java.util.List;

public interface CategoryDAOInter {
  // <insert id="create" parameterType="CategoryVO">
  public int create(CategoryVO categoryVO);
  
  /**
   * ���
   * <xmp>
   * <select id="list" resultType="Categrp_CategoryVO">
   * </xmp>
   * @return
   */
  public List<Categrp_CategoryVO> list();
  
  // <select id="list_by_categrpno" resultType="Categrp_CategoryVO" parameterType="int">
  public List<Categrp_CategoryVO> list_by_grp_no(int grp_no);
  
  /**
   * �Ѱ��� ���ڵ� ��ȸ
   * <xmp>
   * <select id="read" resultType="CategoryVO" parameterType="int">
   * </xmp> 
   * @param categrpno
   * @return
   */
  public CategoryVO read(int gory_no);
  
  /**
   * ���ڵ带 �����մϴ�.
   * <xmp>
   * <update id="update" parameterType="CategoryVO">
   * </xmp> 
   * @param categoryVO 
   * @return
   */
  public int update(CategoryVO categoryVO ); 
  
  /**
   * �Ѱ��� ���ڵ� ����
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
   * �� �� ����
   * <xmp>
   * <update id="increaseCnt" parameterType="int">
   * </xmp> 
   * @param categoryno
   * @return
   */
  public int increaseCnt(int gory_no);
 
  /**
   * �� �� ����
   * <xmp>
   * <update id="decreaseCnt" parameterType="int">
   * </xmp> 
   * @param categoryno 
   * @return
   */
  public int decreaseCnt(int gory_no);
 
  
}






