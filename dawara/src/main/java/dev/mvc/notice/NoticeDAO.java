package dev.mvc.notice;

import java.util.HashMap;
import java.util.List;

import nation.web.tool.Tool;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;


@Repository("dev.mvc.notice.NoticeDAO")
public class NoticeDAO implements NoticeDAOInter{
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public NoticeDAO() {
    System.out.println("--> NoticeDAO created.");
  }  
  
  
  @Override
  public List<NoticeVO> list_all() {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.selectList("notice.list_all");
  }

  @Override
  public int create(NoticeVO noticeVO) {  
    // TODO Auto-generated method stub 
    return sqlSessionTemplate.insert("notice.create", noticeVO);
  }

  @Override
  public NoticeVO read(int no_no) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.selectOne("notice.read", no_no);
  }
  
 /* 
  * public NoticeVO read_mem(int mem_no) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.selectOne("notice.read_mem_no", mem_no);
  }*/
 /* 
  @Override
  public List<NoticeVO> read_by_mem_no(int mem_no) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.selectList("notice.read_by_mem_no");
  }*/
  
  @Override
  public int update(NoticeVO noticeVO) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.update("notice.update", noticeVO);
  }
  
  @Override
  public int delete(int no_no) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.delete("notice.delete", no_no);
  }
  
  public int delete_img(int no_no) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.update("notice.delete_img", no_no);
  }
  

  @Override
  public List<NoticeVO> list_by_notice(HashMap hashMap) {
    List<NoticeVO> list = null;
    list = sqlSessionTemplate.selectList("notice.list_by_notice", hashMap);

    return list;
  }

  @Override
  public int search_count(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("notice.search_count", hashMap);
    
    return cnt;
  }
  
  @Override
  public int total_count() {
    return sqlSessionTemplate.selectOne("notice.total_count");
  }
  
  @Override
  public List<NoticeVO> list_by_notice_search(HashMap hashMap) {
    List<NoticeVO> list = null;
    list = sqlSessionTemplate.selectList("notice.list_by_notice_search", hashMap);
    
    return list;
  }


  @Override
  public List<NoticeVO> read_mem_no(int mem_no) {
    // TODO Auto-generated method stub
    List<NoticeVO> list = null;
    list = sqlSessionTemplate.selectList("notice.read_mem_no", mem_no);
    
    return list;
  }
  
/*  public int show_hide(int no_no){
    
    return sqlSessionTemplate.update("notice.show_hide", no_no);
  }*/
  
  /*
  @Override
  public int update_seqno_up(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int update_seqno_down(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int countByNoticeno(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int deleteByNoticeno(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  

  @Override
  public int update(NoticeVO noticeVO) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int delete(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int increaseCnt(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int decreaseCnt(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }
  */
}

