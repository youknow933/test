package dev.mvc.categrp;

import java.util.List;

public interface CategrpProcInter {

  /**
   * <Xmp>
   * ī�װ� �׷� ���
   * <insert id="create" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return ó���� ���ڵ� ����
   */
  public int create(CategrpVO categrpVO);
  
  /**
   * ���
   * <xmp>
   * <select id="list" resultType="CategrpVO">
   * </xmp> 
   * @return 
   */
  public List<CategrpVO> list();
 
  
  /**
   * ���� ó��
   * <xmp>
   *   <update id="update" parameterType="CategrpVO"> 
   * </xmp>
   * @param categrpVO
   * @return
   */
  public int update(CategrpVO categrpVO);
 
  
  /**
   * ��ȸ
   * <xmp>
   *   <select id="read" resultType="CategrpVO" parameterType="int">
   * </xmp>  
   * @param categrpno
   * @return
   */
  public CategrpVO read(int grp_no);
  
  /**
   * ���� ó��
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





