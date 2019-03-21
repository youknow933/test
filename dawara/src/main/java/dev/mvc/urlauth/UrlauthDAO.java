package dev.mvc.urlauth;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dev.mvc.auth.AuthVO;

@Repository("dev.mvc.urlauth.UrlauthDAO")
public class UrlauthDAO implements UrlauthDAOInter {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public UrlauthDAO() {
    System.out.println("--> UrlauthDAO created.");
  }

  @Override
  public int create(UrlauthVO urlauthVO) {
    return sqlSessionTemplate.insert("urlauth.create", urlauthVO);
  }

  @Override
  public UrlauthVO read(int urlauth_no) {
    return sqlSessionTemplate.selectOne("urlauth.read", urlauth_no);
  }

  @Override
  public int update(UrlauthVO urlauthVO) {
    return sqlSessionTemplate.update("urlauth.update", urlauthVO);
  }

  @Override
  public int delete(int urlauth_no) {
    return sqlSessionTemplate.delete("urlauth.delete", urlauth_no);
  }
  
  @Override
  public List<UrlauthVO> list() {
    return sqlSessionTemplate.selectList("urlauth.list");
  }
  
  @Override
  public int urlauth_search_cnt(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("urlauth.urlauth_search_cnt", hashMap);
    
    return cnt;
  }
  
  @Override
  public List<UrlauthVO> list_search_paging(HashMap hashMap) {
    List<UrlauthVO> list = null;
    list = sqlSessionTemplate.selectList("urlauth.list_search_paging", hashMap);
 
    return list;
  }
}
