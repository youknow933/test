package dev.mvc.mileage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dev.mvc.category.Categrp_CategoryVO;

@Repository("dev.mvc.mileage.MileageDAO")
public class MileageDAO implements MileageDAOInter {

  @Autowired
  private SqlSessionTemplate sqlSessionTemplate;

  public MileageDAO() {
    System.out.println("--> MileageDAO created.");
  }  

  /**
   * <Xmp>
   * 마일리지 등록
   * <insert id="create" parameterType="MileageVO"> 
   * </Xmp>
   * @param mileageVO
   * @return 처리된 레코드 갯수
   */
  @Override
  public int create(MileageVO mileageVO) {
    // statement: namespace.id
    int count = sqlSessionTemplate.insert("mileage.create", mileageVO);
    return count;
  }
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="MileageVO">
   * </xmp> 
   * @return
   */
  @Override
  public List<MileageVO> list() {
    List<MileageVO> list = sqlSessionTemplate.selectList("mileage.list");
    return list;
  }
  
  
  @Override
  public MileageVO read(int mileage_no) {
    return sqlSessionTemplate.selectOne("mileage.read", mileage_no);
  }
 
  @Override 
  public int update(MileageVO mileageVO ) {
    return sqlSessionTemplate.update("mileage.update", mileageVO );
  }
  
  @Override
  public int delete(int mileage_no) {
    return sqlSessionTemplate.delete("mileage.delete", mileage_no);
  }
  
  @Override
  public List<MileageVO> list_by_mem_no(int mem_no) {
    List<MileageVO> list = null;
    list = sqlSessionTemplate.selectList("mileage.list_by_mem_no", mem_no);
 
    return list;
  }
 
  
  @Override
  public List<MileageVO> list_by_mileage_search(HashMap hashMap) {
    List<MileageVO> list = null;
    list = sqlSessionTemplate.selectList("mileage.list_by_mileage_search", hashMap);
 
    return list;
  }
  
  @Override
  public int search_count(HashMap hashMap) {
    int cnt = sqlSessionTemplate.selectOne("mileage.search_count", hashMap);
    
    return cnt;
  }
 
  @Override
  public List<MileageVO> list_by_mileage_search_paging(HashMap hashMap) {
    List<MileageVO> list = null;
    list = sqlSessionTemplate.selectList("mileage.list_by_mileage_search_paging", hashMap);
 
    return list;
  }
  
  }

 
