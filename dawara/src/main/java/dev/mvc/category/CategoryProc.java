package dev.mvc.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.category.CategoryProc")
public class CategoryProc implements CategoryProcInter {
  @Autowired
  @Qualifier("dev.mvc.category.CategoryDAO")
  private CategoryDAOInter categoryDAO = null;
  
  public CategoryProc() {
    System.out.println("--> CategoryProc created."); 
  }
  
  @Override
  public int create(CategoryVO categoryVO) {
    int count = categoryDAO.create(categoryVO);
    
    return count;
  }
  
  @Override
  public List<Categrp_CategoryVO> list() {
    List<Categrp_CategoryVO> list = categoryDAO.list();
    
    return list;
  }

  @Override
  public List<Categrp_CategoryVO> list_by_grp_no(int grp_no) {
    List<Categrp_CategoryVO> list = categoryDAO.list_by_grp_no(grp_no);
    
    return list;
  }
  
  @Override
  public CategoryVO read(int gory_no) {
    return categoryDAO.read(gory_no);
  }

  @Override
  public int update(CategoryVO categoryVO) {
    return categoryDAO.update(categoryVO);
  }
  
  @Override
  public int delete(int gory_no) {
    return categoryDAO.delete(gory_no);
  }
   
  @Override
  public int update_seqno_up(int gory_no) {
    int count  = categoryDAO.update_seqno_up(gory_no);
    
    return count;
  }

  @Override
  public int update_seqno_down(int gory_no) {
    int count  = categoryDAO.update_seqno_down(gory_no);
    
    return count;
  }
 
  @Override
  public int countBygrp_no(int grp_no) {
    int count  = categoryDAO.countBygrp_no(grp_no);
    
    return count;
  }
   
  @Override
  public int deleteBygrp_no(int grp_no) {
    int count  = categoryDAO.deleteBygrp_no(grp_no);
    
    return count;
  } 
 
  @Override
  public int increaseCnt(int gory_no) {
    int count = categoryDAO.increaseCnt(gory_no);
    
    return count;
  }
  
  @Override
  public int decreaseCnt(int gory_no) {
    return categoryDAO.decreaseCnt(gory_no);
  }
 

  
}



 