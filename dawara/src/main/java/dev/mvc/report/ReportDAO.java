package dev.mvc.report;

import java.util.HashMap;
import java.util.List;

import nation.web.tool.Tool;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.report.ReportDAO")
public class ReportDAO implements ReportDAOInter{
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public ReportDAO() {
  //  System.out.println("--> ReportDAO created.");
  }  
  
  @Override
  public int pwdCheck(HashMap hashMap) {
    int count = sqlSessionTemplate.selectOne("report.pwdCheck", hashMap);
    
    return count;
  }
  
  
  @Override
  public List<ReportVO> list_all() {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.selectList("report.list_all");
  }

  @Override
  public int create(ReportVO reportVO) {  
    // TODO Auto-generated method stub 
    return sqlSessionTemplate.insert("report.create", reportVO);
  }

  @Override
  public ReportVO read(int report_no) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.selectOne("report.read", report_no);
  }
  
  @Override
  public int update(ReportVO reportVO) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.update("report.update", reportVO);
  }
  
  @Override
  public int delete(int report_no) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.delete("report.delete", report_no);
  }
  
  public int delete_img(int report_no) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.update("report.delete_img", report_no);
  }
  

  @Override
  public List<ReportVO> list_by_report(HashMap hashMap) {
    List<ReportVO> list = null;
    list = sqlSessionTemplate.selectList("report.list_by_report", hashMap);

    return list;
  }

  @Override
  public int search_count(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("report.search_count", hashMap);
    
    return cnt;
  }
  
  @Override
  public int total_count() {
    return sqlSessionTemplate.selectOne("report.total_count");
  }
  
  @Override
  public List<ReportVO> list_by_report_search(HashMap hashMap) {
    List<ReportVO> list = null;
    list = sqlSessionTemplate.selectList("report.list_by_report_search", hashMap);
    
    return list;
  }


  @Override
  public List<ReportVO> read_mem_no(int mem_no) {
    // TODO Auto-generated method stub
    List<ReportVO> list = null;
    list = sqlSessionTemplate.selectList("report.read_mem_no", mem_no);
    
    return list;
  }
  
  @Override
  public int increaseCnt(int report_no) {
    return sqlSessionTemplate.update("report.increaseCnt", report_no);
  }
  
  @Override
  public int updateAnsnum(ReportVO reportVO) {
    return sqlSessionTemplate.update("report.updateAnsnum", reportVO); 
  }
 
  @Override
  public int reply(ReportVO reportVO) {
    return sqlSessionTemplate.insert("report.reply", reportVO);
  }
}

