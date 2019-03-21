package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;


public interface QnaProcInter {
 
  
  /**
   * ���
   * <select id="list_all" resultType="QnaVO">
   * @return
   */
  public List<QnaVO> list_all();
  
  
  /**
   * ���
   * <select id="list_create" resultType="QnaVO" parameterType="int">
   * @return
   */
  public int create(QnaVO qnaVO);
  
  public QnaVO read(int qna_no);

  public QnaVO update(int qna_no);
  
  public int update(QnaVO qnaVO);
  
  public int delete(int qna_no);

  public int delete_img(int qna_no);


  int total_count();


  int search_count(HashMap hashMap);


  List<QnaVO> read_mem_no(int mem_no);


  List<QnaVO> list_by_qna(HashMap hashMap);

  public String paging(String qna_search, int qna_no, int search_count, int nowPage, String word);

  public List<QnaVO> list_by_qna_search(HashMap hashMap); 
  
  
  /**
   * �� �� ����
   * <xmp>
   * <update id="increaseCnt" parameterType="int"> 
   * </xmp>
   * @param qna_no
   * @return
   */
  public int increaseCnt(int qna_no);
 
  
  /**
   * �ű� �亯�� �ֿ켱���� ����ϱ����� �亯 ���� ����
   * @param qnaVO
   * @return
   */
  public int updateAnsnum(QnaVO qnaVO);
  
  /**
   * �亯
   * @param qnaVO
   * @return
   */
  public int reply(QnaVO qnaVO);


  int pwdCheck(HashMap hashMap);
  
}
