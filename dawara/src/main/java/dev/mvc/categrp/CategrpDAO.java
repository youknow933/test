package dev.mvc.categrp;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.categrp.CategrpDAO")
public class CategrpDAO implements CategrpDAOInter{
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public CategrpDAO() {
    System.out.println("--> CategrpDAO created.");
    
//    if (sqlSessionTemplate != null) {
//      System.out.println("--> sqlSessionTemplate 할당됨.");      
//    }
  }
  
  
  /**
   * <Xmp>
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return 처리된 레코드 갯수
   */
  @Override
  public int create(CategrpVO categrpVO) {
    // statement: namespace.id
    int count = sqlSessionTemplate.insert("categrp.create", categrpVO);
    return count;
  }
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="CategrpVO">
   * </xmp>  
   * @return
   */
  @Override
  public List<CategrpVO> list() {
    List<CategrpVO> list = sqlSessionTemplate.selectList("categrp.list");
    
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
  public int update(CategrpVO categrpVO) {
    int count = sqlSessionTemplate.update("categrp.update", categrpVO);
    return count;
  }
  
  @Override
  public CategrpVO read(int grp_no) {
    CategrpVO categrpVO = sqlSessionTemplate.selectOne("categrp.read", grp_no);
    
    return categrpVO;
  }
  
  @Override
  public int delete(int grp_no) {
    int count = sqlSessionTemplate.delete("categrp.delete",  grp_no);
    return count;
  }
  
  @Override
  public int update_seqno_up(int grp_no) {
    int count = sqlSessionTemplate.update("categrp.update_seqno_up", grp_no);
    return count;
  }
 
  @Override
  public int update_seqno_down(int grp_no) {
    int count = sqlSessionTemplate.update("categrp.update_seqno_down", grp_no);
    return count;
  }
 
  
}






