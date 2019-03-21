package dev.mvc.categrp;

import java.util.List;

public interface CategrpProcInter {

  /**
   * <Xmp>
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int create(CategrpVO categrpVO);
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="CategrpVO">
   * </xmp> 
   * @return 
   */
  public List<CategrpVO> list();
 
  
  /**
   * 수정 처리
   * <xmp>
   *   <update id="update" parameterType="CategrpVO"> 
   * </xmp>
   * @param categrpVO
   * @return
   */
  public int update(CategrpVO categrpVO);
 
  
  /**
   * 조회
   * <xmp>
   *   <select id="read" resultType="CategrpVO" parameterType="int">
   * </xmp>  
   * @param categrpno
   * @return
   */
  public CategrpVO read(int grp_no);
  
  /**
   * 삭제 처리
   * <xmp>
   *   <delete id="delete" parameterType="int">
   * </xmp> 
   * @param categrpno
   * @return
   */
  public int delete(int grp_no);
  
  // <update id="update_seqno_up" parameterType="int">
  public int update_seqno_up(int grp_no);
  
  // <update id="update_seqno_down" parameterType="int">
  public int update_seqno_down(int grp_no);
 
 
 
}





