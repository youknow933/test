package dev.mvc.categrp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.categrp.CategrpProc")
public class CategrpProc  implements CategrpProcInter {
  @Autowired
  @Qualifier("dev.mvc.categrp.CategrpDAO") // 할당되는 Class 객체의 이름
  // @Qualifier("dev.mvc.categrp.CategrpDAO2016") // 할당되는 Class 객체의 이름
  // @Qualifier("dev.mvc.categrp.CategrpDAO2017") // 할당되는 Class 객체의 이름
  private CategrpDAOInter categrpDAO = null;
  
  public CategrpProc() {
    System.out.println("--> CategrpProc created.");
  }

  @Override
  public int create(CategrpVO categrpVO) {
    int count = categrpDAO.create(categrpVO);
    return count;
  }
  
  @Override
  public List<CategrpVO> list() {
    List<CategrpVO> list = categrpDAO.list();
     
    return list;
  }
 
  @Override
  public int update(CategrpVO categrpVO) {
    int count = categrpDAO.update(categrpVO);
    return count;
  }
  
  @Override
  public CategrpVO read(int grp_no) {
    CategrpVO categrpVO = categrpDAO.read(grp_no);
    
    return categrpVO;
  }
  
  @Override
  public int delete(int grp_no) {
    int count = categrpDAO.delete(grp_no);
    return count;
  }
  
  @Override
  public int update_seqno_up(int grp_no) {
    int count  = categrpDAO.update_seqno_up(grp_no);
    
    return count;
  }
 
  @Override
  public int update_seqno_down(int grp_no) {
    int count  = categrpDAO.update_seqno_down(grp_no);
    
    return count;
  }
   
}





