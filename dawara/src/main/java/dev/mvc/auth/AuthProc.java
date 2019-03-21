package dev.mvc.auth;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.auth.AuthVO;

@Component("dev.mvc.auth.AuthProc")
public class AuthProc  implements AuthProcInter {
  @Autowired
  @Qualifier("dev.mvc.auth.AuthDAO") // 할당되는 Class 객체의 이름
  // @Qualifier("dev.mvc.categrp.CategrpDAO2016") // 할당되는 Class 객체의 이름
  // @Qualifier("dev.mvc.categrp.CategrpDAO2017") // 할당되는 Class 객체의 이름
  private AuthDAOInter authDAO = null;
  
  public AuthProc() {
  }

  @Override
  public int create(AuthVO authVO) {
    int count = authDAO.create(authVO);
    return count;
  }

  @Override
  public List<AuthVO> list() {
    List<AuthVO> list = authDAO.list();
    
    return list;
  }
  
  @Override
  public AuthVO read(int auth_no) {
    AuthVO authVO = authDAO.read(auth_no);
    
    return authVO;
  }

  
  @Override
  public int update(AuthVO authVO) {
    int count = authDAO.update(authVO);
    return count;
  }

  @Override
  public int delete(int auth_no) {
    int count = authDAO.delete(auth_no);
    return count;
  }

  @Override
  public int update_seqno_up(int auth_no) {
    int count  = authDAO.update_seqno_up(auth_no);
    
    return count;
  }

  @Override
  public int update_seqno_down(int auth_no) {
    int count  = authDAO.update_seqno_down(auth_no);
    
    return count;
  }
  
  @Override
  public int create_url(AuthVO authVO) {
    int count = authDAO.create_url(authVO);
    return count;
  }
  
  @Override
  public List<AuthVO> list_url() {
    List<AuthVO> list = authDAO.list_url();
    
    return list;
  }
  
  @Override
  public AuthVO read_url(int url_no) {
    AuthVO authVO = authDAO.read_url(url_no);
    
    return authVO;
  }
  
  
  @Override
  public int update_url(AuthVO authVO) {
    int count = authDAO.update_url(authVO);
    return count;
  }
  
  @Override
  public int delete_url(int url_no) {
    int count = authDAO.delete_url(url_no);
    return count;
  }
  
  @Override
  public int update_seqno_up_url(int url_no) {
    int count  = authDAO.update_seqno_up_url(url_no);
    
    return count;
  }
  
  @Override
  public int update_seqno_down_url(int url_no) {
    int count  = authDAO.update_seqno_down_url(url_no);
    
    return count;
  }
    
    @Override
    public int create_access_url(AuthVO authVO) {
      int count = authDAO.create_access_url(authVO);
      return count;
    }
    
    @Override
    public List<AuthVO> list_access_url() {
      List<AuthVO> list = authDAO.list_access_url();
      
      return list;
    }
    
    @Override
    public AuthVO read_access_url(int access_url_no) {
      AuthVO authVO = authDAO.read_access_url(access_url_no);
      
      return authVO;
    }
    
    
    @Override
    public int update_access_url(AuthVO authVO) {
      int count = authDAO.update_access_url(authVO);
      return count;
    }
    
    @Override
    public int delete_access_url(int access_url_no) {
      int count = authDAO.delete_access_url(access_url_no);
      return count;
    }
    
    @Override
    public int update_seqno_up_access_url(int access_url_no) {
      int count  = authDAO.update_seqno_up_access_url(access_url_no);
      
      return count;
    }
    
    @Override
    public int update_seqno_down_access_url(int access_url_no) {
      int count  = authDAO.update_seqno_down_access_url(access_url_no);
      
      return count;
  }
    
    @Override
    public int select_count_access_url(int auth_no) {
      int count  = authDAO.select_count_access_url(auth_no);
      
      return count;
    }
    
    @Override
    public int delete_count_access_url(int auth_no) {
      int count  = authDAO.delete_count_access_url(auth_no);
      
      return count;
    }
    
    @Override
    public int select_count_access_url_urltb(int url_no) {
      int count  = authDAO.select_count_access_url_urltb(url_no);
      
      return count;
    }
    
    @Override
    public int delete_count_access_url_urltb(int url_no) {
      int count  = authDAO.delete_count_access_url_urltb(url_no);
      
      return count;
    }
    
    @Override
    public int access_url_check(HashMap hashMap) {
      int count  = authDAO.access_url_check(hashMap);
      
      return count;
    }
    
    @Override
    public int url_no_check(String url) {
      int count  = authDAO.url_no_check(url);
      
      return count;
    }
}





