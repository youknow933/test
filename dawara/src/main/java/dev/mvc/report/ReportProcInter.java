package dev.mvc.report;

import java.util.HashMap;
import java.util.List;


public interface ReportProcInter {
 
  
  /**
   * 목록
   * <select id="list_all" resultType="ReportVO">
   * @return
   */
  public List<ReportVO> list_all();
  
  
  /**
   * 등록
   * <select id="list_create" resultType="ReportVO" parameterType="int">
   * @return
   */
  public int create(ReportVO reportVO);
  
  public ReportVO read(int report_no);

  public ReportVO update(int report_no);
  
  public int update(ReportVO reportVO);
  
  public int delete(int report_no);

  public int delete_img(int report_no);


  int total_count();


  int search_count(HashMap hashMap);


  List<ReportVO> read_mem_no(int mem_no);


  List<ReportVO> list_by_report(HashMap hashMap);

  public String paging(String report_search, int report_no, int search_count, int nowPage, String word);

  public List<ReportVO> list_by_report_search(HashMap hashMap); 
  
  
  /**
   * 글 수 증가
   * <xmp>
   * <update id="increaseCnt" parameterType="int"> 
   * </xmp>
   * @param report_no
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
