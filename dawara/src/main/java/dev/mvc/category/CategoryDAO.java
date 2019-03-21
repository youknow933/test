package dev.mvc.category;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.category.CategoryDAO")
public class CategoryDAO implements CategoryDAOInter {
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public CategoryDAO() {
    System.out.println("--> CategoryDAO created.");
  }

  @Override
  public int create(CategoryVO categoryVO) {
    // namespace.еб╠в ID
    int count = sqlSessionTemplate.insert("category.create", categoryVO);
    return count;
  }
   
  @Override
  public List<Categrp_CategoryVO> list() {
    List<Categrp_CategoryVO> list = sqlSessionTemplate.selectList("category.list");
    return list;
  }

  @Override
  public List<Categrp_CategoryVO> list_by_grp_no(int grp_no) {
    List<Categrp_CategoryVO> list = sqlSessionTemplate.selectList("category.list_by_grp_no", grp_no);
    return list;
  }

  @Override
  public CategoryVO read(int gory_no) {
    return sqlSessionTemplate.selectOne("category.read", gory_no);
  }

  @Override
  public int update(CategoryVO categoryVO ) {
    return sqlSessionTemplate.update("category.update", categoryVO );
  }

  @Override
  public int delete(int gory_no) {
    return sqlSessionTemplate.delete("category.delete", gory_no);
  }
  
  @Override
  public int update_seqno_up(int gory_no) {
    int count = sqlSessionTemplate.update("category.update_seqno_up", gory_no);
    return count;
  }

  @Override
  public int update_seqno_down(int gory_no) {
    int count = sqlSessionTemplate.update("category.update_seqno_down", gory_no);
    return count;
  }
  
  @Override
  public int countBygrp_no(int grp_no) {
    int count = sqlSessionTemplate.selectOne("category.countBygrp_no", grp_no);
    return count;
  }
 
  @Override
  public int deleteBygrp_no(int grp_no) {
    int count = sqlSessionTemplate.delete("category.deleteBygrp_no", grp_no);
    return count;
  }
  
  @Override
  public int increaseCnt(int gory_no) {
    return sqlSessionTemplate.update("category.increaseCnt", gory_no);
  }
  
  @Override
  public int decreaseCnt(int gory_no) {
    return sqlSessionTemplate.update("category.decreaseCnt", gory_no);
  }

  
  
}





  