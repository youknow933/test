package dev.mvc.reply;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dev.mvc.categrp.CategrpVO;


@Repository("dev.mvc.reply.ReplyDAO")
public class ReplyDAO implements ReplyDAOInter{
  @Autowired
  private SqlSessionTemplate sqlSessionTemplate = null;
  
  public ReplyDAO() {
    System.out.println("--> ReplyDAO created.");
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
  public int create(ReplyVO replyVO) {
    // statement: namespace.id
    int count = sqlSessionTemplate.insert("reply.create", replyVO);
    return count;
  }
  
  @Override
  public List<ReplyVO> list() {
    List<ReplyVO> list = sqlSessionTemplate.selectList("reply.list");
    
    return list;
  }
  
  @Override
  public List<ReplyVO> list_by_pr_no(int pr_no) {
    List<ReplyVO> list = null;
    list = sqlSessionTemplate.selectList("reply.list_by_pr_no", pr_no);

    return list;
  }
  
  @Override
  public List<Reply_MemberVO> list_memno_prno(int pr_no) {
    List<Reply_MemberVO> list = null;
    list = sqlSessionTemplate.selectList("reply.list_memno_prno", pr_no);

    return list;
  }
  
  
  
  @Override
  public ReplyVO read(int rpl_no) {
    ReplyVO replyVO = sqlSessionTemplate.selectOne("reply.read", rpl_no);
    
    return replyVO;
  }
  
  @Override
  public int update(ReplyVO replyVO) {
    int count = sqlSessionTemplate.update("reply.update", replyVO);
    return count;
  }
  
  @Override
  public int delete(int rpl_no) {
    int count = sqlSessionTemplate.delete("reply.delete",  rpl_no);
    return count;
  }
  
  @Override
  public int deleteByPr_no(int pr_no) {
    int count = sqlSessionTemplate.delete("reply.deleteByPr_no",  pr_no);
    return count;
  }
  
  @Override
  public int updateAnsnum(ReplyVO replyVO) {
    return sqlSessionTemplate.update("reply.updateAnsnum", replyVO); 
  }

  

  @Override
  public int answer(ReplyVO replyVO) {
    return sqlSessionTemplate.insert("reply.answer", replyVO);
  }
  

}