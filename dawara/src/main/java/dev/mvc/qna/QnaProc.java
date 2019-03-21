package dev.mvc.qna;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import nation.web.tool.Tool;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.qna.Qna;
import dev.mvc.qna.QnaVO;


@Component("dev.mvc.qna.QnaProc")
public class QnaProc implements QnaProcInter{
  @Autowired
  @Qualifier("dev.mvc.qna.QnaDAO")
  private QnaDAOInter qnaDAO = null;
  
  public QnaProc() {
   // System.out.println("--> QnaProc created.");
  }  
  
  @Override
  public int pwdCheck(HashMap hashMap) {
    int count = qnaDAO.pwdCheck(hashMap); 
    return count;
  }

  @Override
  public List<QnaVO> list_all() {
    // TODO Auto-generated method stub
    
    List<QnaVO> list_all = qnaDAO.list_all();
  
    Iterator<QnaVO> iter = list_all.iterator();
    
    while(iter.hasNext()) {
      QnaVO qnaVO = iter.next();
      String title = Tool.textLength(qnaVO.getQna_title(), 90);
      title = Tool.convertChar(title);
      qnaVO.setQna_title(title);

      String write = Tool.textLength(qnaVO.getQna_write(), 90);
      write = Tool.convertChar(write);
      qnaVO.setQna_write(write);
    }
    return list_all;
  }

  @Override
  public int create(QnaVO qnaVO) {
    int count = 0;
    count = qnaDAO.create(qnaVO);
    
    return count; 
  }
  
  @Override
  public QnaVO read(int qna_no) {
    // TODO Auto-generated method stub
    QnaVO qnaVO = qnaDAO.read(qna_no);
    
    return qnaVO;
  }

  @Override
  public List<QnaVO> read_mem_no(int mem_no) {
    // TODO Auto-generated method stub
    List<QnaVO> qnaVO = qnaDAO.read_mem_no(mem_no);
    
    return qnaVO;
  }
 
  @Override
  public int update(QnaVO qnaVO) {
    return qnaDAO.update(qnaVO);
  }
  
  @Override
  public QnaVO update(int qna_no) {
/*    QnaVO qnaVO = qnaDAO.read(qnaVO.getQna_no());*/
    QnaVO qnaVO = qnaDAO.read(qna_no);
    
    String title = qnaVO.getQna_title();
    title = Tool.convertChar2(title);
    qnaVO.setQna_title(title);
    
    String content = qnaVO.getQna_contents();
    content = Tool.convertChar2(content); // Ư�� ���� ��ȯ
    qnaVO.setQna_contents(content);
    
    return qnaVO;
  }
  
  public int delete(int qna_no) {
    // TODO Auto-generated method stub
    return qnaDAO.delete(qna_no);
  }

  
  public int delete_img(int qna_no) {
    // TODO Auto-generated method stub
    return qnaDAO.delete_img(qna_no);
  }
  
  
  @Override
  public List<QnaVO> list_by_qna(HashMap hashMap) {
    List<QnaVO> list = qnaDAO.list_by_qna(hashMap); 
    Iterator<QnaVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      QnaVO qnaVO = iter.next();
      String title = Tool.textLength(qnaVO.getQna_title(), 90);
      title = Tool.convertChar(title);
      qnaVO.setQna_title(title);
      
      // qnaVO.setContent(Tool.convertChar(qnaVO.getContent()));
      
      String thumbs = qnaVO.getQna_thumbs();
      if (thumbs.length() > 0) { // preview �̹����� �ִ��� �˻�
        String thumb = (thumbs.split("/"))[0]; // ù��° ���ϸ� ����
        qnaVO.setQna_thumbs(thumb);
      }
    }
    
    return list;
  }
  
  
  
  @Override
  public int search_count(HashMap hashMap) {
    int cnt = qnaDAO.search_count(hashMap);
    
    return cnt;
  }
  
  @Override
  public int total_count() {
    int count = qnaDAO.total_count();
    return count;
  }
  
  @Override
  public List<QnaVO> list_by_qna_search(HashMap hashMap) {
    /* 
     ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
     1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
     2 ������: nowPage = 2, (2 - 1) * 10 --> 10
     3 ������: nowPage = 3, (3 - 1) * 10 --> 20
     */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Qna.RECORD_PER_PAGE;
    
     // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
    int startNum = beginOfPage + 1; 
    //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
    int endNum = beginOfPage + Qna.RECORD_PER_PAGE;   
    /*
     1 ������: WHERE r >= 1 AND r <= 10
     2 ������: WHERE r >= 11 AND r <= 20
     3 ������: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    List<QnaVO> list = qnaDAO.list_by_qna_search(hashMap); 
    Iterator<QnaVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      QnaVO qnaVO = iter.next();
      String title = Tool.textLength(qnaVO.getQna_title(), 90);
      title = Tool.convertChar(title); // �±� ó��
      qnaVO.setQna_title(title);
      
      String thumbs = qnaVO.getQna_thumbs();
      if (thumbs.length() > 0) { // preview �̹����� �ִ��� �˻�
        String thumb = (thumbs.split("/"))[0]; // ù��° ���ϸ� ����
        qnaVO.setQna_thumbs(thumb);
      }
    }
    
    return list;
  }
  
  

  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param qna_no ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  public String paging(String qna_search, int mem_no, int search_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Qna.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Qna.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Qna.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Qna.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Qna.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 

    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� 20
    int _nowPage = (nowGrp-1) * Qna.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_qna.do?qna_search="+qna_search+"&word="+word+"&nowPage="+_nowPage+"&mem_no="+mem_no+"'>����</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<span class='span_box_1'><A href='./list_by_qna.do?qna_search="+qna_search+"&word="+word+"&nowPage="+i+"&mem_no="+mem_no+"'>"+i+"</A></span>");   
      } 
    } 

    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� 21
    _nowPage = (nowGrp * Qna.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_qna.do?qna_search="+qna_search+"&word="+word+"&nowPage="+_nowPage+"&mem_no="+mem_no+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
  
  @Override
  public int increaseCnt(int qna_no) {
    int count = qnaDAO.increaseCnt(qna_no);
    
    return count;
  }
  
  @Override
  public int updateAnsnum(QnaVO qnaVO) {
    int count = 0;
    count = qnaDAO.updateAnsnum(qnaVO);
    
    return count;
  }
 
  @Override
  public int reply(QnaVO qnaVO) {
    int count = 0;
    count = qnaDAO.reply(qnaVO);
    
    return count;
  }
}



 





