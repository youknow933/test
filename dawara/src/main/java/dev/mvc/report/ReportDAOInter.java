package dev.mvc.report;

import java.util.HashMap;
import java.util.List;


public interface ReportDAOInter {
  /**
   * 목록
   * <xmp>
   * <select id="list_all" resultType="ReportVO">
   * </xmp>
   * @return
   */
  public List<ReportVO> list_all();
  
  public ReportVO read(int report_no);
  
  /**
   * 등록
   * <select id="list_create" resultType="ReportVO" parameterType="int">
   * @return
   */
  public int create(ReportVO reportVO);

  public int update(ReportVO reportVO);
  
  public int delete(int report_no);
  
  public int delete_img(int report_no);

  public List<ReportVO> list_by_report(HashMap hashMap);

  public List<ReportVO> list_by_report_search(HashMap hashMap);

  int search_count(HashMap hashMap);

  int total_count();

  public List<ReportVO> read_mem_no(int mem_no);
  
  /**
   * 글 수 증가
   * <xmp>
   * <update id="increaseCnt" parameterType="int">
   * </xmp> 
   * @param categoryno
   * @return
   */
  public int increaseCnt(int report_no);
  
  /**
   * 신규 답변을 최우선으로 출력하기위한 답변 순서 조절
   * @param reportVO
   * @return
   */
  public int updateAnsnum(ReportVO reportVO);
  
  /**
   * 답변
   * @param reportVO
   * @return
   */
  public int reply(ReportVO reportVO);
  
  int pwdCheck(HashMap hashMap);
}






