package dev.mvc.notice;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import nation.web.tool.Tool;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.notice.Notice;
import dev.mvc.notice.NoticeVO;


@Component("dev.mvc.notice.NoticeProc")
public class NoticeProc implements NoticeProcInter{
  @Autowired
  @Qualifier("dev.mvc.notice.NoticeDAO")
  private NoticeDAOInter noticeDAO = null;
  
  public NoticeProc() {
    System.out.println("--> NoticeProc created.");
  }  

  @Override
  public List<NoticeVO> list_all() {
    // TODO Auto-generated method stub
    
    List<NoticeVO> list_all = noticeDAO.list_all();
  
    Iterator<NoticeVO> iter = list_all.iterator();
    
    while(iter.hasNext()) {
      NoticeVO noticeVO = iter.next();
      String title = Tool.textLength(noticeVO.getNo_title(), 90);
      title = Tool.convertChar(title);
      noticeVO.setNo_title(title);

      String write = Tool.textLength(noticeVO.getNo_write(), 90);
      write = Tool.convertChar(write);
      noticeVO.setNo_write(write);
    }
    return list_all;
  }

  @Override
  public int create(NoticeVO noticeVO) {
    int count = 0;
    count = noticeDAO.create(noticeVO);
    
    return count; 
  }
  
  @Override
  public NoticeVO read(int no_no) {
    // TODO Auto-generated method stub
    NoticeVO noticeVO = noticeDAO.read(no_no);
    
    return noticeVO;
  }

  @Override
  public List<NoticeVO> read_mem_no(int mem_no) {
    // TODO Auto-generated method stub
    List<NoticeVO> noticeVO = noticeDAO.read_mem_no(mem_no);
    
    return noticeVO;
  }
 
  @Override
  public int update(NoticeVO noticeVO) {
    return noticeDAO.update(noticeVO);
  }
  
  @Override
  public NoticeVO update(int no_no) {
/*    NoticeVO noticeVO = noticeDAO.read(noticeVO.getNo_no());*/
    NoticeVO noticeVO = noticeDAO.read(no_no);
    
    String title = noticeVO.getNo_title();
    title = Tool.convertChar2(title);
    noticeVO.setNo_title(title);
    
    String content = noticeVO.getNo_contents();
    content = Tool.convertChar2(content); // Ư�� ���� ��ȯ
    noticeVO.setNo_contents(content);
    
    return noticeVO;
  }
  
  public int delete(int no_no) {
    // TODO Auto-generated method stub
    return noticeDAO.delete(no_no);
  }

  
  public int delete_img(int no_no) {
    // TODO Auto-generated method stub
    return noticeDAO.delete_img(no_no);
  }
  
  
  @Override
  public List<NoticeVO> list_by_notice(HashMap hashMap) {
    List<NoticeVO> list = noticeDAO.list_by_notice(hashMap); 
    Iterator<NoticeVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      NoticeVO noticeVO = iter.next();
      String title = Tool.textLength(noticeVO.getNo_title(), 90);
      title = Tool.convertChar(title);
      noticeVO.setNo_title(title);
      
      // noticeVO.setContent(Tool.convertChar(noticeVO.getContent()));
      
      String thumbs = noticeVO.getNo_thumbs();
      if (thumbs.length() > 0) { // preview �̹����� �ִ��� �˻�
        String thumb = (thumbs.split("/"))[0]; // ù��° ���ϸ� ����
        noticeVO.setNo_thumbs(thumb);
      }
    }
    
    return list;
  }
  
  
  
  @Override
  public int search_count(HashMap hashMap) {
    int cnt = noticeDAO.search_count(hashMap);
    
    return cnt;
  }
  
  @Override
  public int total_count() {
    int count = noticeDAO.total_count();
    return count;
  }
  
  @Override
  public List<NoticeVO> list_by_notice_search(HashMap hashMap) {
    /* 
     ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
     1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
     2 ������: nowPage = 2, (2 - 1) * 10 --> 10
     3 ������: nowPage = 3, (3 - 1) * 10 --> 20
     */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Notice.RECORD_PER_PAGE;
    
     // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
    int startNum = beginOfPage + 1; 
    //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
    int endNum = beginOfPage + Notice.RECORD_PER_PAGE;   
    /*
     1 ������: WHERE r >= 1 AND r <= 10
     2 ������: WHERE r >= 11 AND r <= 20
     3 ������: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    List<NoticeVO> list = noticeDAO.list_by_notice_search(hashMap); 
    Iterator<NoticeVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      NoticeVO noticeVO = iter.next();
      String title = Tool.textLength(noticeVO.getNo_title(), 90);
      title = Tool.convertChar(title); // �±� ó��
      noticeVO.setNo_title(title);
      
      String thumbs = noticeVO.getNo_thumbs();
      if (thumbs.length() > 0) { // preview �̹����� �ִ��� �˻�
        String thumb = (thumbs.split("/"))[0]; // ù��° ���ϸ� ����
        noticeVO.setNo_thumbs(thumb);
      }
    }
    
    return list;
  }
  
  

  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param no_no ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  public String paging(String notice_search, int mem_no, int search_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Notice.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Notice.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Notice.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Notice.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Notice.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
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
    int _nowPage = (nowGrp-1) * Notice.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_notice.do?notice_search="+notice_search+"&word="+word+"&nowPage="+_nowPage+"&mem_no="+mem_no+"'>����</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<span class='span_box_1'><A href='./list_by_notice.do?notice_search="+notice_search+"&word="+word+"&nowPage="+i+"&mem_no="+mem_no+"'>"+i+"</A></span>");   
      } 
    } 

    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� 21
    _nowPage = (nowGrp * Notice.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_notice.do?notice_search="+notice_search+"&word="+word+"&nowPage="+_nowPage+"&mem_no="+mem_no+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
/*
 *//**
   * Visible ��� ����
   * @param no_no
   * @param visible Y / N
   * @return 
   *//*
  public int show_hide(int no_no){
    NoticeVO noticeVO = noticeDAO.read(no_no);
    String visible = noticeVO.getNo_visible();
    
    if (visible.equals("Y")) {
      noticeVO.setNo_visible("N"); // Y - > N
    } else {
      noticeVO.setNo_visible("Y"); // N -> Y
    }
    int count = noticeDAO.show_hide(no_no);
    
    return count;
  }*/
/*  @Override
  public int update_seqno_up(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int update_seqno_down(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int countByCategrpno(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int deleteByCategrpno(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }
 
  @Override
  public int delete(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int increaseCnt(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int decreaseCnt(int noticeno) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public int create(NoticeVO noticeVO) {
    // TODO Auto-generated method stub
    return 0;
  }
  */
  
}



 





