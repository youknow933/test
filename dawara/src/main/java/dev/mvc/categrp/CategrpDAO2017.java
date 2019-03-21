package dev.mvc.categrp;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("dev.mvc.categrp.CategrpDAO2017")
public class CategrpDAO2017 implements CategrpDAOInter{
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public CategrpDAO2017() {
    System.out.println("--> CategrpDAO2017 created.");
  }

  @Override
  public int create(CategrpVO categrpVO) {

    return 0;
  }

  @Override
  public List<CategrpVO> list() {
    return null;
  }

  @Override
  public CategrpVO read(int categrpno) {
    // TODO Auto-generated method stub
    return null;
  }

  @Override
  public int update(CategrpVO categrpVO) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int delete(int categrpno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int update_seqno_up(int categrpno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int update_seqno_down(int categrpno) {
    // TODO Auto-generated method stub
    return 0;
  }


}






