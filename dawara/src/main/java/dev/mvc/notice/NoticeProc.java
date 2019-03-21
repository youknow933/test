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
    content = Tool.convertChar2(content); // 특수 문자 변환
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
      if (thumbs.length() > 0) { // preview 이미지가 있는지 검사
        String thumb = (thumbs.split("/"))[0]; // 첫번째 파일명 추출
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
     페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
     1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
     2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
     3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
     */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Notice.RECORD_PER_PAGE;
    
     // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
    int startNum = beginOfPage + 1; 
    //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
    int endNum = beginOfPage + Notice.RECORD_PER_PAGE;   
    /*
     1 페이지: WHERE r >= 1 AND r <= 10
     2 페이지: WHERE r >= 11 AND r <= 20
     3 페이지: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    List<NoticeVO> list = noticeDAO.list_by_notice_search(hashMap); 
    Iterator<NoticeVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      NoticeVO noticeVO = iter.next();
      String title = Tool.textLength(noticeVO.getNo_title(), 90);
      title = Tool.convertChar(title); // 태그 처리
      noticeVO.setNo_title(title);
      
      String thumbs = noticeVO.getNo_thumbs();
      if (thumbs.length() > 0) { // preview 이미지가 있는지 검사
        String thumb = (thumbs.split("/"))[0]; // 첫번째 파일명 추출
        noticeVO.setNo_thumbs(thumb);
      }
    }
    
    return list;
  }
  
  

  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param no_no 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging(String notice_search, int mem_no, int search_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Notice.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Notice.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Notice.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Notice.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Notice.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
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
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

    // 이전 10개 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 20
    int _nowPage = (nowGrp-1) * Notice.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_notice.do?notice_search="+notice_search+"&word="+word+"&nowPage="+_nowPage+"&mem_no="+mem_no+"'>이전</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='./list_by_notice.do?notice_search="+notice_search+"&word="+word+"&nowPage="+i+"&mem_no="+mem_no+"'>"+i+"</A></span>");   
      } 
    } 

    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 11
    // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 21
    _nowPage = (nowGrp * Notice.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_notice.do?notice_search="+notice_search+"&word="+word+"&nowPage="+_nowPage+"&mem_no="+mem_no+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
/*
 *//**
   * Visible 모드 변경
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



 





