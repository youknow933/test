package dev.mvc.auth;

import java.util.HashMap;
import java.util.List;

import dev.mvc.categrp.CategrpVO;

public interface AuthDAOInter {
  
  /**
   * <Xmp>
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int create(AuthVO authVO);
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="CategrpVO">
   * </xmp> 
   * @return
   */
  public List<AuthVO> list();
  
  /**
   * 조회
   * <xmp>
   *   <select id="read" resultType="CategrpVO" parameterType="int">
   * </xmp>  
   * @param categrpno
   * @return
   */
  public AuthVO read(int auth_no);
  
   
  /**
   * 수정 처리
   * <xmp>
   *   <update id="update" parameterType="CategrpVO"> 
   * </xmp>
   * @param categrpVO
   * @return
   */
  public int update(AuthVO authVO);
  
  /**
   * 삭제 처리
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
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int create_url(AuthVO authVO);
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="CategrpVO">
   * </xmp> 
   * @return
   */
  public List<AuthVO> list_url();
  
  /**
   * 조회
   * <xmp>
   *   <select id="read" resultType="CategrpVO" parameterType="int">
   * </xmp>  
   * @param categrpno
   * @return
   */
  public AuthVO read_url(int url_no);
  
  
  /**
   * 수정 처리
   * <xmp>
   *   <update id="update" parameterType="CategrpVO"> 
   * </xmp>
   * @param categrpVO
   * @return
   */
  public int update_url(AuthVO authVO);
  
  /**
   * 삭제 처리
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
   * 카테고리 그룹 등록
   * <insert id="create_access_url" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int create_access_url(AuthVO authVO);
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="CategrpVO">
   * </xmp> 
   * @return
   */
  public List<AuthVO> list_access_url();
  
  /**
   * 조회
   * <xmp>
   *   <select id="read" resultType="CategrpVO" parameterType="int">
   * </xmp>  
   * @param categrpno
   * @return
   */
  public AuthVO read_access_url(int access_url_no);
  
  
  /**
   * 수정 처리
   * <xmp>
   *   <update id="update" parameterType="CategrpVO"> 
   * </xmp>
   * @param categrpVO
   * @return
   */
  public int update_access_url(AuthVO authVO);
  
  /**
   * 삭제 처리
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


