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
//      System.out.println("--> sqlSessionTemplate �Ҵ��.");      
//    }
  }
  
  
  /**
   * <Xmp>
   * ī�װ� �׷� ���
   * <insert id="create" parameterType="CategrpVO"> 
   * </Xmp>
   * @param categrpVO
   * @return ó���� ���ڵ� ����
   */
  @Override
  public int create(CategrpVO categrpVO) {
    // statement: namespace.id
    int count = sqlSessionTemplate.insert("categrp.create", categrpVO);
    return count;
  }
  
  /**
   * ���
   * <xmp>
   * <select id="list" resultType="CategrpVO">
   * </xmp>  
   * @return
   */
  @Override
  public List<CategrpVO> list() {
    List<CategrpVO> list = sqlSessionTemplate.selectList("categrp.list");
    
/*    if (list instanceof List) {
      System.out.println("--> List Ÿ���Դϴ�.");
    }
 
    if (list instanceof ArrayList) {
      System.out.println("--> ArrayList Ÿ���Դϴ�.");
    }
 
    if (list instanceof HashMap) {
      System.out.println("--> HashMap Ÿ���Դϴ�.");
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






