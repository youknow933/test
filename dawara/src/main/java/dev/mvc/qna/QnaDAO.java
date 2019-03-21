package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;

import nation.web.tool.Tool;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.qna.QnaDAO")
public class QnaDAO implements QnaDAOInter{
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public QnaDAO() {
  //  System.out.println("--> QnaDAO created.");
  }  
  
  @Override
  public int pwdCheck(HashMap hashMap) {
    int count = sqlSessionTemplate.selectOne("qna.pwdCheck", hashMap);
    
    return count;
  }
  
  @Override
  public List<QnaVO> list_all() {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.selectList("qna.list_all");
  }

  @Override
  public int create(QnaVO qnaVO) {  
    // TODO Auto-generated method stub 
    return sqlSessionTemplate.insert("qna.create", qnaVO);
  }

  @Override
  public QnaVO read(int qna_no) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.selectOne("qna.read", qna_no);
  }
  
  @Override
  public int update(QnaVO qnaVO) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.update("qna.update", qnaVO);
  }
  
  @Override
  public int delete(int qna_no) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.delete("qna.delete", qna_no);
  }
  
  public int delete_img(int qna_no) {
    // TODO Auto-generated method stub
    return sqlSessionTemplate.update("qna.delete_img", qna_no);
  }
  

  @Override
  public List<QnaVO> list_by_qna(HashMap hashMap) {
    List<QnaVO> list = null;
    list = sqlSessionTemplate.selectList("qna.list_by_qna", hashMap);

    return list;
  }

  @Override
  public int search_count(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("qna.search_count", hashMap);
    
    return cnt;
  }
  
  @Override
  public int total_count() {
    return sqlSessionTemplate.selectOne("qna.total_count");
  }
  
  @Override
  public List<QnaVO> list_by_qna_search(HashMap hashMap) {
    List<QnaVO> list = null;
    list = sqlSessionTemplate.selectList("qna.list_by_qna_search", hashMap);
    
    return list;
  }


  @Override
  public List<QnaVO> read_mem_no(int mem_no) {
    // TODO Auto-generated method stub
    List<QnaVO> list = null;
    list = sqlSessionTemplate.selectList("qna.read_mem_no", mem_no);
    
    return list;
  }
  
  @Override
  public int increaseCnt(int qna_no) {
    return sqlSessionTemplate.update("qna.increaseCnt", qna_no);
  }
  
  @Override
  public int updateAnsnum(QnaVO qnaVO) {
    return sqlSessionTemplate.update("qna.updateAnsnum", qnaVO); 
  }
 
  @Override
  public int reply(QnaVO qnaVO) {
    return sqlSessionTemplate.insert("qna.reply", qnaVO);
  }
}

