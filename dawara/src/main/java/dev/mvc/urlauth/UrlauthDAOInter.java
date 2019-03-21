package dev.mvc.urlauth;

import java.util.HashMap;
import java.util.List;

import dev.mvc.auth.AuthVO;

public interface UrlauthDAOInter {
  /**
   * ���
   * <xmp>
   * <insert id="create" parameterType="UrlauthVO">
   * </xmp>
   * @return
   */
  public int create(UrlauthVO urlauthVO);
  
  /**
   * ��ȸ
   * <xmp>
   * <select id="read" resultType="UrlauthVO" parameterType="int">
   * </xmp>
   * @return
   */
  public UrlauthVO read(int urlauth_no);
  
  /**
   * ����
   * <xmp>
   * <update id="update" parameterType="UrlauthVO">
   * </xmp>
   * @return
   */
  public int update(UrlauthVO urlauthVO);
  
  /**
   * ����
   * <xmp>
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @return
   */
  public int delete(int urlauth_no);
  
  /**
   * ���
   * <xmp>
   * <select id="list" resultType="UrlauthVO">
   * </xmp>
   * @return
   */
  public List<UrlauthVO> list(); 
  
  /**
   * �˻��� ���ڵ� ����
   * <xmp>
   * <select id="urlauth_search_cnt" resultType="int" parameterType="HashMap">
   * </xmp>
   * @return
   */
  public int urlauth_search_cnt(HashMap hashMap); 
  
  /**
   * �˻� ��� ����¡
   * <xmp>
   * <select id="list_search_paging" resultType="UrlauthVO" parameterType="HashMap">
   * </xmp>
   * @return
   */
  public List<UrlauthVO> list_search_paging(HashMap hashMap);
}
