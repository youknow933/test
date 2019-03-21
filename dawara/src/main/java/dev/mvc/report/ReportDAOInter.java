package dev.mvc.report;

import java.util.HashMap;
import java.util.List;


public interface ReportDAOInter {
  /**
   * ���
   * <xmp>
   * <select id="list_all" resultType="ReportVO">
   * </xmp>
   * @return
   */
  public List<ReportVO> list_all();
  
  public ReportVO read(int report_no);
  
  /**
   * ���
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
   * �� �� ����
   * <xmp>
   * <update id="increaseCnt" parameterType="int">
   * </xmp> 
   * @param categoryno
   * @return
   */
  public int increaseCnt(int report_no);
  
  /**
   * �ű� �亯�� �ֿ켱���� ����ϱ����� �亯 ���� ����
   * @param reportVO
   * @return
   */
  public int updateAnsnum(ReportVO reportVO);
  
  /**
   * �亯
   * @param reportVO
   * @return
   */
  public int reply(ReportVO reportVO);
  
  int pwdCheck(HashMap hashMap);
}






