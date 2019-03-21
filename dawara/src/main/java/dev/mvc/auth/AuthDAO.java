package dev.mvc.auth;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dev.mvc.categrp.CategrpVO;

@Repository("dev.mvc.auth.AuthDAO")
public class AuthDAO implements AuthDAOInter{
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public AuthDAO() {
    //System.out.println("--> CategrpDAO created.");
    //    if (sqlSessionTemplate != null) {
    //      System.out.println("--> sqlSessionTemplate 할당됨.");    
    //    }
  }

  /**
   * <Xmp>
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="AuthVO"> 
   * </Xmp>
   * @param AuthVO
   * @return 처리된 레코드 갯수
   */
  @Override
  public int create(AuthVO authVO) {
    // statement: namespace.id
    int count = sqlSessionTemplate.insert("auth.create", authVO);
    return count;
  }

  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="AuthVO">
   * </xmp> 
   * @return
   */
  @Override
  public List<AuthVO> list() {
    List<AuthVO> list = sqlSessionTemplate.selectList("auth.list");
    
/*    if (list instanceof List) {
      System.out.println("--> List 타입입니다.");
    }

    if (list instanceof ArrayList) {
      System.out.println("--> ArrayList 타입입니다.");
    }

    if (list instanceof HashMap) {
      System.out.println("--> HashMap 타입입니다.");
    }*/
    
    return list;
  }
  
  @Override
  public AuthVO read(int auth_no) {
    AuthVO authVO = sqlSessionTemplate.selectOne("auth.read", auth_no);
    
    return authVO;
  }


  @Override
  public int update(AuthVO authVO) {
    int count = sqlSessionTemplate.update("auth.update", authVO);
    return count;
  }

  @Override
  public int delete(int auth_no) {
    int count = sqlSessionTemplate.delete("auth.delete",  auth_no);
    return count;
  }
  
  @Override
  public int update_seqno_up(int auth_no) {
    int count = sqlSessionTemplate.update("auth.update_seqno_up", auth_no);
    return count;
  }

  @Override
  public int update_seqno_down(int auth_no) {
    int count = sqlSessionTemplate.update("auth.update_seqno_down", auth_no);
    return count;
  }
  
  /**
   * <Xmp>
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="AuthVO"> 
   * </Xmp>
   * @param AuthVO
   * @return 처리된 레코드 갯수
   */
  @Override
  public int create_url(AuthVO authVO) {
    // statement: namespace.id
    int count = sqlSessionTemplate.insert("auth.create_url", authVO);
    return count;
  }
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="AuthVO">
   * </xmp> 
   * @return
   */
  @Override
  public List<AuthVO> list_url() {
    List<AuthVO> list = sqlSessionTemplate.selectList("auth.list_url");
    
    /*    if (list instanceof List) {
      System.out.println("--> List 타입입니다.");
    }

    if (list instanceof ArrayList) {
      System.out.println("--> ArrayList 타입입니다.");
    }

    if (list instanceof HashMap) {
      System.out.println("--> HashMap 타입입니다.");
    }*/
    
    return list;
  }
  
  @Override
  public AuthVO read_url(int url_no) {
    AuthVO authVO = sqlSessionTemplate.selectOne("auth.read_url", url_no);
    
    return authVO;
  }
  
  
  @Override
  public int update_url(AuthVO authVO) {
    int count = sqlSessionTemplate.update("auth.update_url", authVO);
    return count;
  }
  
  @Override
  public int delete_url(int url_no) {
    int count = sqlSessionTemplate.delete("auth.delete_url",  url_no);
    return count;
  }
  
  @Override
  public int update_seqno_up_url(int url_no) {
    int count = sqlSessionTemplate.update("auth.update_seqno_up_url", url_no);
    return count;
  }
  
  @Override
  public int update_seqno_down_url(int url_no) {
    int count = sqlSessionTemplate.update("auth.update_seqno_down_url", url_no);
    return count;
  }
  
  /**
   * <Xmp>
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="AuthVO"> 
   * </Xmp>
   * @param AuthVO
   * @return 처리된 레코드 갯수
   */
  @Override
  public int create_access_url(AuthVO authVO) {
    // statement: namespace.id
    int count = sqlSessionTemplate.insert("auth.create_access_url", authVO);
    return count;
  }
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="AuthVO">
   * </xmp> 
   * @return
   */
  @Override
  public List<AuthVO> list_access_url() {
    List<AuthVO> list = sqlSessionTemplate.selectList("auth.list_access_url");
    
    /*    if (list instanceof List) {
      System.out.println("--> List 타입입니다.");
    }

    if (list instanceof ArrayList) {
      System.out.println("--> ArrayList 타입입니다.");
    }

    if (list instanceof HashMap) {
      System.out.println("--> HashMap 타입입니다.");
    }*/
    
    return list;
  }
  
  @Override
  public AuthVO read_access_url(int access_url_no) {
    AuthVO authVO = sqlSessionTemplate.selectOne("auth.read_access_url", access_url_no);
    
    return authVO;
  }
  
  
  @Override
  public int update_access_url(AuthVO authVO) {
    int count = sqlSessionTemplate.update("auth.update_access_url", authVO);
    return count;
  }
  
  @Override
  public int delete_access_url(int access_url_no) {
    int count = sqlSessionTemplate.delete("auth.delete_access_url",  access_url_no);
    return count;
  }
  
  @Override
  public int update_seqno_up_access_url(int access_url_no) {
    int count = sqlSessionTemplate.update("auth.update_seqno_up_access_url", access_url_no);
    return count;
  }
  
  @Override
  public int update_seqno_down_access_url(int access_url_no) {
    int count = sqlSessionTemplate.update("auth.update_seqno_down_access_url", access_url_no);
    return count;
  }
  
  @Override
  public int select_count_access_url(int auth_no) {
    int count = sqlSessionTemplate.selectOne("auth.select_count_access_url", auth_no);
    return count;
  }
  
  @Override
  public int delete_count_access_url(int auth_no) {
    int count = sqlSessionTemplate.delete("auth.delete_count_access_url", auth_no);
    return count;
  }
  
  @Override
  public int select_count_access_url_urltb(int url_no) {
    int count = sqlSessionTemplate.selectOne("auth.select_count_access_url_urltb", url_no);
    return count;
  }
  
  @Override
  public int delete_count_access_url_urltb(int url_no) {
    int count = sqlSessionTemplate.delete("auth.delete_count_access_url_urltb", url_no);
    return count;
  }
  
  @Override
  public int access_url_check(HashMap hashMap) {
    int count = sqlSessionTemplate.selectOne("auth.access_url_check", hashMap);
    return count;
  }
  
  @Override
  public int url_no_check(String url) {
    int count = sqlSessionTemplate.selectOne("auth.url_no_check", url);
    return count;
  }
}






