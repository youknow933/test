package dev.mvc.auth;

import java.util.HashMap;
import java.util.List;

import dev.mvc.categrp.CategrpVO;

public interface AuthDAOInter {
  
  /**
   * <Xmp>
   * ī�װ� �׷� ���
   * <insert id="create" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return ó���� ���ڵ� ����
   */
  public int create(AuthVO authVO);
  
  /**
   * ���
   * <xmp>
   * <select id="list" resultType="CategrpVO">
   * </xmp> 
   * @return
   */
  public List<AuthVO> list();
  
  /**
   * ��ȸ
   * <xmp>
   *   <select id="read" resultType="CategrpVO" parameterType="int">
   * </xmp>  
   * @param categrpno
   * @return
   */
  public AuthVO read(int auth_no);
  
   
  /**
   * ���� ó��
   * <xmp>
   *   <update id="update" parameterType="CategrpVO"> 
   * </xmp>
   * @param categrpVO
   * @return
   */
  public int update(AuthVO authVO);
  
  /**
   * ���� ó��
   * <xmp>
   *   <delete id="delete" parameterType="int">
   * </xmp> 
   * @param categrpno
   * @return
   */
  public int delete(int auth_no);
  
  // <update id="update_seqno_up" parameterType="int">
  public int update_seqno_up(int auth_no);
  
  // <update id="update_seqno_down" parameterType="int">
  public int update_seqno_down(int auth_no);
  
  /**
   * <Xmp>
   * ī�װ� �׷� ���
   * <insert id="create" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return ó���� ���ڵ� ����
   */
  public int create_url(AuthVO authVO);
  
  /**
   * ���
   * <xmp>
   * <select id="list" resultType="CategrpVO">
   * </xmp> 
   * @return
   */
  public List<AuthVO> list_url();
  
  /**
   * ��ȸ
   * <xmp>
   *   <select id="read" resultType="CategrpVO" parameterType="int">
   * </xmp>  
   * @param categrpno
   * @return
   */
  public AuthVO read_url(int url_no);
  
  
  /**
   * ���� ó��
   * <xmp>
   *   <update id="update" parameterType="CategrpVO"> 
   * </xmp>
   * @param categrpVO
   * @return
   */
  public int update_url(AuthVO authVO);
  
  /**
   * ���� ó��
   * <xmp>
   *   <delete id="delete" parameterType="int">
   * </xmp> 
   * @param categrpno
   * @return
   */
  public int delete_url(int url_no);
  
  // <update id="update_seqno_up" parameterType="int">
  public int update_seqno_up_url(int url_no);
  
  // <update id="update_seqno_down" parameterType="int">
  public int update_seqno_down_url(int url_no);
  
  /**
   * <Xmp>
   * ī�װ� �׷� ���
   * <insert id="create_access_url" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return ó���� ���ڵ� ����
   */
  public int create_access_url(AuthVO authVO);
  
  /**
   * ���
   * <xmp>
   * <select id="list" resultType="CategrpVO">
   * </xmp> 
   * @return
   */
  public List<AuthVO> list_access_url();
  
  /**
   * ��ȸ
   * <xmp>
   *   <select id="read" resultType="CategrpVO" parameterType="int">
   * </xmp>  
   * @param categrpno
   * @return
   */
  public AuthVO read_access_url(int access_url_no);
  
  
  /**
   * ���� ó��
   * <xmp>
   *   <update id="update" parameterType="CategrpVO"> 
   * </xmp>
   * @param categrpVO
   * @return
   */
  public int update_access_url(AuthVO authVO);
  
  /**
   * ���� ó��
   * <xmp>
   *   <delete id="delete" parameterType="int">
   * </xmp> 
   * @param categrpno
   * @return
   */
  public int delete_access_url(int access_url_no);
  
  // <update id="update_seqno_up" parameterType="int">
  public int update_seqno_up_access_url(int access_url_no);
  
  // <update id="update_seqno_down" parameterType="int">
  public int update_seqno_down_access_url(int access_url_no);
  
  //<select id="select_count_member" resultType="int" parameterType="int">
  public int select_count_access_url(int auth_no);
  
  //<select id="delete_count_member" resultType="int" parameterType="int">
  public int delete_count_access_url(int auth_no);
  
  //<select id="select_count_member" resultType="int" parameterType="int">
  public int select_count_access_url_urltb(int url_no);
  
  //<select id="delete_count_member" resultType="int" parameterType="int">
  public int delete_count_access_url_urltb(int url_no);
  
  //<select id="delete_count_member" resultType="int" parameterType="int">
  public int access_url_check(HashMap hashMap);
  
  public int url_no_check(String url);
}


