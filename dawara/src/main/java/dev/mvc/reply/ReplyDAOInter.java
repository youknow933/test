package dev.mvc.reply;

import java.util.List;

import dev.mvc.categrp.CategrpVO;


public interface ReplyDAOInter {
  
  /**
   * <Xmp>
   * ī�װ� �׷� ���
   * <insert id="create" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return ó���� ���ڵ� ����
   */
  public int create(ReplyVO replyVO);
  
  
  /**
   * ���
   * <xmp>
   * <select id="list" resultType="ReplyVO">
   * </xmp> 
   * @return
   */
  public List<ReplyVO> list();
  
  /**
   * ī�װ��� ���
   * @param pr_no
   * @return
   */
  public List<ReplyVO> list_by_pr_no(int pr_no); 
  
  /**
   * memno=prno ���
   * @param pr_no
   * @return
   */
  public List<Reply_MemberVO> list_memno_prno(int pr_no); 
 
  
  /**
   * ��ȸ
   * <xmp>
   *   <select id="read" resultType="ReplyVO" parameterType="int">
   * </xmp>  
   * @param rpl_no
   * @return
   */
  public ReplyVO read(int rpl_no);
  
  
 /**
  * ���� ó��
  * <xmp>
  *   <update id="update" parameterType="CategrpVO"> 
  * </xmp>
  * @param categrpVO
  * @return
  */
 public int update(ReplyVO replyVO);
 
 /**
  * ���� ó��
  * <xmp>
  *   <delete id="delete" parameterType="int">
  * </xmp> 
  * @param rpl_no
  * @return
  */
 public int delete(int rpl_no);
 
 /**
  * ���� ó��
  * <xmp>
  *   <delete id="deleteByPr_no" parameterType="int">
  * </xmp> 
  * @param pr_no
  * @return
  */
 public int deleteByPr_no(int pr_no);
 
 
 /**
  * �ű� �亯�� �ֿ켱���� ����ϱ����� �亯 ���� ����
  * @param contentsVO
  * @return
  */
 public int updateAnsnum(ReplyVO replyVO);
 
 
 /**
  * �亯
  * @param replyVO
  * @return
  */
 public int answer(ReplyVO replyVO);
 

}
