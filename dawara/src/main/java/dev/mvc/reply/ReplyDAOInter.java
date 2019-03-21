package dev.mvc.reply;

import java.util.List;

import dev.mvc.categrp.CategrpVO;


public interface ReplyDAOInter {
  
  /**
   * <Xmp>
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  public int create(ReplyVO replyVO);
  
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="ReplyVO">
   * </xmp> 
   * @return
   */
  public List<ReplyVO> list();
  
  /**
   * 카테고리별 목록
   * @param pr_no
   * @return
   */
  public List<ReplyVO> list_by_pr_no(int pr_no); 
  
  /**
   * memno=prno 목록
   * @param pr_no
   * @return
   */
  public List<Reply_MemberVO> list_memno_prno(int pr_no); 
 
  
  /**
   * 조회
   * <xmp>
   *   <select id="read" resultType="ReplyVO" parameterType="int">
   * </xmp>  
   * @param rpl_no
   * @return
   */
  public ReplyVO read(int rpl_no);
  
  
 /**
  * 수정 처리
  * <xmp>
  *   <update id="update" parameterType="CategrpVO"> 
  * </xmp>
  * @param categrpVO
  * @return
  */
 public int update(ReplyVO replyVO);
 
 /**
  * 삭제 처리
  * <xmp>
  *   <delete id="delete" parameterType="int">
  * </xmp> 
  * @param rpl_no
  * @return
  */
 public int delete(int rpl_no);
 
 /**
  * 삭제 처리
  * <xmp>
  *   <delete id="deleteByPr_no" parameterType="int">
  * </xmp> 
  * @param pr_no
  * @return
  */
 public int deleteByPr_no(int pr_no);
 
 
 /**
  * 신규 답변을 최우선으로 출력하기위한 답변 순서 조절
  * @param contentsVO
  * @return
  */
 public int updateAnsnum(ReplyVO replyVO);
 
 
 /**
  * 답변
  * @param replyVO
  * @return
  */
 public int answer(ReplyVO replyVO);
 

}
