package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.member.MemberDAO")
public class MemberDAO implements MemberDAOInter {

  @Autowired
  private SqlSessionTemplate sqlSessionTemplate;

  public MemberDAO() {
    System.out.println("--> MemberDAO created.");
  }  

  @Override
  public int checkId(String mem_id) {
    int count = sqlSessionTemplate.selectOne("member.checkId", mem_id);
    
    return count;
  }
  
  @Override
  public int create(MemberVO memberVO) {
    int count = sqlSessionTemplate.insert("member.create", memberVO);
    return count;
  }  
 
  @Override
  public List<MemberVO> list() {
    List<MemberVO> list = sqlSessionTemplate.selectList("member.list");
    
    return list;
  } 
  
  @Override
  public MemberVO read(int mem_no) {
    MemberVO memberVO = sqlSessionTemplate.selectOne("member.read", mem_no);
    
    return memberVO;
  }

  @Override
  public MemberVO readById(String mem_id) {
    MemberVO memberVO = sqlSessionTemplate.selectOne("member.readById", mem_id);
    
    return memberVO;
  }   
 
  @Override
  public int update(MemberVO memberVO) {
    int count = sqlSessionTemplate.update("member.update", memberVO);
    return count;
  }  
  
  @Override
  public int update_admin(MemberVO memberVO) {
    int count = sqlSessionTemplate.update("member.update_admin", memberVO);
    return count;
  }  
     
  @Override
  public int passwd_update(Map<String, Object> map) {
    int count = sqlSessionTemplate.update("member.passwd_update", map);
    return count;
  }  
  
  @Override
  public int delete(int mem_no) {
    int count = sqlSessionTemplate.delete("member.delete", mem_no);
    return count;
  }
  
  @Override
  public int login(Map<String, Object> map) {
    int count = sqlSessionTemplate.selectOne("member.login", map);
    return count;
  }
  
  @Override
  public List<MemberVO> list_by_member_search(HashMap hashMap) {
    List<MemberVO> list = null;
    list = sqlSessionTemplate.selectList("member.list_by_member_search", hashMap);
 
    return list;
  }
 
  @Override
  public int search_count(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("member.search_count", hashMap);
    
    return cnt;
  }
  
  @Override
  public int create_login(HashMap hashMap){
    int count = sqlSessionTemplate.insert("member.create_login", hashMap);
    return count;
  }
  
  @Override
  public List<MemberVO> list_by_login(int mem_no) {
    List<MemberVO> list = sqlSessionTemplate.selectList("member.list_by_login", mem_no);
     
    return list;
  } 
  
  @Override
  public List<MemberVO> list_by_login_admin() {
    List<MemberVO> list = sqlSessionTemplate.selectList("member.list_by_login_admin");
    
    return list;
  } 
  
  @Override
  public MemberVO read_by_login(int login_no) {
    MemberVO memberVO = sqlSessionTemplate.selectOne("member.read_by_login", login_no);
    
    return memberVO;
  }
  
  @Override
  public int delete_by_login(int login_no) {
    int count = sqlSessionTemplate.delete("member.delete_by_login", login_no);
    return count;
  }
  
  @Override
  public int select_login_member(int mem_no) {
    int count = sqlSessionTemplate.selectOne("member.select_login_member", mem_no);
    return count;
  }
  
  @Override
  public int delete_login_member(int mem_no) {
    int count = sqlSessionTemplate.delete("member.delete_login_member", mem_no);
    return count;
  }
  
  @Override
  public List<MemberVO> list_by_login_admin_search(HashMap hashMap) {
    List<MemberVO> list = null;
    list = sqlSessionTemplate.selectList("member.list_by_login_admin_search", hashMap);
    
    return list;
  }
  
  @Override
  public int search_count_login(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("member.search_count_login", hashMap);
    
    return cnt;
  }
  
  @Override
  public int select_count_member(int auth_no) {
    int count = sqlSessionTemplate.selectOne("member.select_count_member", auth_no);
    return count;
  }
  
  @Override
  public int select_count_login(int auth_no) {
    int count = sqlSessionTemplate.selectOne("member.select_count_login", auth_no);
    return count;
  }
  
  @Override
  public int delete_count_member(int auth_no) {
    int count = sqlSessionTemplate.delete("member.delete_count_member", auth_no);
    return count;
  }
  
  @Override
  public int delete_count_login(int auth_no) {
    int count = sqlSessionTemplate.delete("member.delete_count_login", auth_no);
    return count;
  }
}
 
