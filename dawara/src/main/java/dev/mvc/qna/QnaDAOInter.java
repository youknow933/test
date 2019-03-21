package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;


public interface QnaDAOInter {
  /**
   * 목록
   * <xmp>
   * <select id="list_all" resultType="QnaVO">
   * </xmp>
   * @return
   */
  public List<QnaVO> list_all();
  
  public QnaVO read(int qna_no);
  
  /**
   * 등록
   * <select id="list_create" resultType="QnaVO" parameterType="int">
   * @return
   */
  public int create(QnaVO qnaVO);

  public int update(QnaVO qnaVO);
  
  public int delete(int qna_no);
  
  public int delete_img(int qna_no);

  public List<QnaVO> list_by_qna(HashMap hashMap);

  public List<QnaVO> list_by_qna_search(HashMap hashMap);

  int search_count(HashMap hashMap);

  int total_count();

  public List<QnaVO> read_mem_no(int mem_no);
  
  /**
   * 글 수 증가
   * <xmp>
   * <update id="increaseCnt" parameterType="int">
   * </xmp> 
   * @param categoryno
   * @return
   */
  public int increaseCnt(int qna_no);
  
  /**
   * 신규 답변을 최우선으로 출력하기위한 답변 순서 조절
   * @param qnaVO
   * @return
   */
  public int updateAnsnum(QnaVO qnaVO);
  
  /**
   * 답변
   * @param qnaVO
   * @return
   */
  public int reply(QnaVO qnaVO);
  
  int pwdCheck(HashMap hashMap);
}






