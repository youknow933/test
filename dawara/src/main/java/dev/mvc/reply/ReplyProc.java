package dev.mvc.reply;

import java.util.Iterator;
import java.util.List;

import nation.web.tool.Tool;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.categrp.CategrpVO;



@Component("dev.mvc.reply.ReplyProc")
public class ReplyProc  implements ReplyProcInter {
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyDAO") // 할당되는 Class 객체의 이름
  private ReplyDAOInter replyDAO = null;
  
  public ReplyProc() {
    System.out.println("--> ReplyProc created.");
  }
  
  @Override
  public int create(ReplyVO replyVO) {
    int count = replyDAO.create(replyVO);
    return count;
  }
  
  @Override
  public List<ReplyVO> list() {
    List<ReplyVO> list = replyDAO.list();
    
    return list;
  }
  
  @Override
  public List<ReplyVO> list_by_pr_no(int pr_no) {
    List<ReplyVO> list = replyDAO.list_by_pr_no(pr_no); 
    
    return list;
  }
  
  @Override
  public List<Reply_MemberVO> list_memno_prno(int pr_no) {
    List<Reply_MemberVO> list = replyDAO.list_memno_prno(pr_no); 
    
    return list;
  }
  
  
  @Override
  public ReplyVO read(int rpl_no) {
    ReplyVO replyVO = replyDAO.read(rpl_no);
    
    return replyVO;
  }
  
  @Override
  public int update(ReplyVO replyVO) {
    int count = replyDAO.update(replyVO);
    return count;
  }
  

  @Override
  public int delete(int rpl_no) {
    int count = replyDAO.delete(rpl_no);
    return count;
  }
  
  @Override
  public int deleteByPr_no(int pr_no) {
    int count = replyDAO.deleteByPr_no(pr_no);
    return count;
  }
  
  
  
  @Override
  public int updateAnsnum(ReplyVO replyVO) {
    int count = 0;
    count = replyDAO.updateAnsnum(replyVO);
    
    return count;
  }
  
  @Override
  public int answer(ReplyVO replyVO) {
    int count = 0;
    count = replyDAO.answer(replyVO);
    
    return count;
  }

}
