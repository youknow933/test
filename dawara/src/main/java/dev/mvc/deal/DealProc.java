package dev.mvc.deal;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import nation.web.tool.Tool;

@Component("dev.mvc.deal.DealProc")
public class DealProc implements DealProcInter {
  @Autowired
  @Qualifier("dev.mvc.deal.DealDAO")
  private DealDAOInter dealDAO = null;
  
  public DealProc() {
    System.out.println("--> DealProc created.");
  }

  @Override
  public int create(DealVO dealVO) {
    return dealDAO.create(dealVO);
  }
  // 6/21 ---------------------------------------------------------------

  @Override
  public List<Member_Product_DealVO> list() {
    List<Member_Product_DealVO> list = dealDAO.list();
    return list;
  }

  @Override
  public List<BuyMember_DealVO> bm_dealList() {
    List<BuyMember_DealVO> bm_dealList = dealDAO.bm_dealList();
    return bm_dealList;
  }
  // 6/25 ---------------------------------------------------------------

  @Override
  public List<Buy_ProductVO> bp_list() {
    List<Buy_ProductVO> bp_list = dealDAO.bp_list();
    return bp_list;
  }

  @Override
  public List<Buy_MemberVO> bm_list() {
    List<Buy_MemberVO> bm_list = dealDAO.bm_list();
    return bm_list;
  }
  // 6/22, 6/26 ---------------------------------------------------------------

  @Override
  public List<Member_Product_DealVO> list_by_deal_no(int deal_no) {
    List<Member_Product_DealVO> list = dealDAO.list_by_deal_no(deal_no);
    return list;
  }

  @Override
  public List<Buy_ProductVO> BPList_by_buy_no(int buy_no) {
    List<Buy_ProductVO> BPList = dealDAO.BPList_by_buy_no(buy_no);
    return BPList;
  }

  @Override
  public List<Buy_MemberVO> BMList_by_mem_no(int mem_no) {
    List<Buy_MemberVO> BMList = dealDAO.BMList_by_mem_no(mem_no);
    return BMList;
  }
  // 6/25 ---------------------------------------------------------------
  
  @Override
  public DealVO read(int deal_no) {
    return dealDAO.read(deal_no);
  }
  // 6/26 ---------------------------------------------------------------

  @Override
  public int update(DealVO dealVO) {
    return dealDAO.update(dealVO);
  }
  // 6/27~29 ---------------------------------------------------------------

  @Override
  public int delete(int deal_no) {
    return dealDAO.delete(deal_no);
  }

//  @Override
//  public List<Product_BuyMember_DealVO> list_by_dates_paging(HashMap hashMap) {
//    return dealDAO.list_by_dates_paging(hashMap);
//  }

  @Override
  public int search_count(HashMap hashMap) {
    return dealDAO.search_count(hashMap);
  }
  // 6/29 ---------------------------------------------------------------
  
  @Override
  public List<Member_Product_DealVO> list_by_dates_paging(HashMap hashMap) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3페이지: nowPage = 3, (3 - 1) * 10 --> 20
    */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Deal.RECORD_PER_PAGE;
    
    // 시작 rownum, 1페이지: 1 / 2페이지: 11 / 3페이지: 21 
    int startNum = beginOfPage + 1; 
    //  종료 rownum, 1페이지: 10 / 2페이지: 20 / 3페이지: 30
    int endNum = beginOfPage + Deal.RECORD_PER_PAGE;   
    /*
     1페이지: WHERE r >= 1 AND r <= 10
     2페이지: WHERE r >= 11 AND r <= 20
     3페이지: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    return dealDAO.list_by_dates_paging(hashMap); 
  }
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param deal_no      거래번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage      현재 페이지
   * @param startDate    검색어
   * @param endDate      검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String paging(int search_count, int nowPage, String startDate, String endDate) {
    int totalPage = (int)(Math.ceil((double)search_count/Deal.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Deal.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Deal.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Deal.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Deal.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
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
    str.append("    padding:1px 6px 1px 6px; "); 
    str.append("    margin:1px 2px 1px 2px; "); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; "); 
    str.append("    margin:1px 2px 1px 2px; "); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
    
//    System.out.println("proc startDate: "+ startDate);
//    System.out.println("proc endDate: "+endDate);
    
//    str.append("<div><span style='float:left; left: 30%;'>현재 페이지: "+ nowPage+" / 전체 페이지: " + totalPage + "</span></div>");
    
 // 이전 페이지 그룹으로 이동
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // 현재 2그룹일 경우: ( 2 - 1 ) * 10 = 1그룹의 10페이지
    // 현재 3그룹일 경우: ( 3 - 1 ) * 10 = 2그룹의 10페이지
    // 현재 n그룹일 경우: ( n - 1 ) * 10 = n-1그룹의 10페이지
    int _nowPage = (nowGrp-1) * Deal.PAGE_PER_BLOCK; // _nowPage: 상황에 따라서 좀 다르게 쓰일 때 _를 붙임
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 
 
    for(int i = startPage; i <= endPage; i++){ 
      if (i > totalPage){ 
        break; // ex) 11페이지에서 짤림
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지-강조 
      }else{
        // 현재 페이지가 아닌 나머지 페이지
        str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+i+"'>"+i+"</A></span>"); 
        // "&deal_no="+deal_no+": 많이 바뀌는 부분 ex) adminno, ...   
      } 
    } 
     
    // 다음 페이지 그룹으로 이동 
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // 현재 1그룹일 경우: ( 2 * 10 ) + 1 = 2그룹의 첫 페이지(11)
    // 현재 2그룹일 경우: ( 3 * 10 ) + 1 = 3그룹의 첫 페이지(21)
    // 현재 n그룹일 경우: ( n * 10 ) + 1 = n+1그룹의 첫 페이지((n+1) * 10 + 1)
    _nowPage = (nowGrp * Deal.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  // 7/4 ~ 7/5 ---------------------------------------------------------------
  
  @Override
  public List<Member_Product_DealVO> searchList(HashMap hashMap) {
    List<Member_Product_DealVO> list = dealDAO.searchList(hashMap);
    Iterator<Member_Product_DealVO> iter = list.iterator();
    
    while(iter.hasNext()){
      Member_Product_DealVO member_Product_DealVO = iter.next();
      String pr_title = Tool.textLength(member_Product_DealVO.getPr_title(), 90); // 90자까지만 씀; 로직 처리
      pr_title = Tool.convertChar(pr_title);
      member_Product_DealVO.setPr_title(pr_title);
    }
    
    return list;
  }
  // 7/20 ---------------------------------------------------------------------

  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param deal_no      거래번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage      현재 페이지
   * @param startDate    검색어
   * @param endDate      검색어
   * @return 페이징 생성 문자열
   */ 
  /*
  @Override
  public String paging2(int search_count, int nowPage, String startDate, String endDate, String keyword) {
    int totalPage = (int)(Math.ceil((double)search_count/Deal.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Deal.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Deal.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Deal.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Deal.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
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
    str.append("    padding:1px 6px 1px 6px; "); 
    str.append("    margin:1px 2px 1px 2px; "); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; "); 
    str.append("    margin:1px 2px 1px 2px; "); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
    */
//    System.out.println("proc startDate: "+ startDate);
//    System.out.println("proc endDate: "+endDate);
    
//    str.append("<div><span style='float:left; left: 30%;'>현재 페이지: "+ nowPage+" / 전체 페이지: " + totalPage + "</span></div>");
    /*
 // 이전 페이지 그룹으로 이동
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // 현재 2그룹일 경우: ( 2 - 1 ) * 10 = 1그룹의 10페이지
    // 현재 3그룹일 경우: ( 3 - 1 ) * 10 = 2그룹의 10페이지
    // 현재 n그룹일 경우: ( n - 1 ) * 10 = n-1그룹의 10페이지
    int _nowPage = (nowGrp-1) * Deal.PAGE_PER_BLOCK; // _nowPage: 상황에 따라서 좀 다르게 쓰일 때 _를 붙임
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 
 
    for(int i = startPage; i <= endPage; i++){ 
      if (i > totalPage){ 
        break; // ex) 11페이지에서 짤림
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지-강조 
      }else{
        // 현재 페이지가 아닌 나머지 페이지
        str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+i+"'>"+i+"</A></span>"); 
        // "&deal_no="+deal_no+": 많이 바뀌는 부분 ex) adminno, ...   
      } 
    } 
     
    // 다음 페이지 그룹으로 이동 
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // 현재 1그룹일 경우: ( 2 * 10 ) + 1 = 2그룹의 첫 페이지(11)
    // 현재 2그룹일 경우: ( 3 * 10 ) + 1 = 3그룹의 첫 페이지(21)
    // 현재 n그룹일 경우: ( n * 10 ) + 1 = n+1그룹의 첫 페이지((n+1) * 10 + 1)
    _nowPage = (nowGrp * Deal.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  */
  
  @Override
  public List<Member_Product_DealVO> searchList_paging(HashMap hashMap) {
//    List<Member_Product_DealVO> list = dealDAO.searchList_paging(hashMap);
//    Iterator<Member_Product_DealVO> iter = list.iterator();
//    
//    while(iter.hasNext()){
//      Member_Product_DealVO member_Product_DealVO = iter.next();
//      String pr_title = Tool.textLength(member_Product_DealVO.getPr_title(), 90); // 90자까지만 씀; 로직 처리
//      pr_title = Tool.convertChar(pr_title);
//      member_Product_DealVO.setPr_title(pr_title);
//    }
    
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Deal.RECORD_PER_PAGE;
    
    // 시작 rownum, 1페이지: 1 / 2페이지: 11 / 3페이지: 21 
    int startNum = beginOfPage + 1; 
    //  종료 rownum, 1페이지: 10 / 2페이지: 20 / 3페이지: 30
    int endNum = beginOfPage + Deal.RECORD_PER_PAGE;   
    
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
//    return list;
    return dealDAO.searchList_paging(hashMap);
  }
  
  @Override
  public String paging3(int search_count, int nowPage, String startDate, String endDate, String keyword, String searchItem) {
    int totalPage = (int)(Math.ceil((double)search_count/Deal.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Deal.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Deal.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Deal.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Deal.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
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
    str.append("    padding:1px 6px 1px 6px; "); 
    str.append("    margin:1px 2px 1px 2px; "); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; "); 
    str.append("    margin:1px 2px 1px 2px; "); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
    
//    str.append("<div><span style='float:left; left: 30%;'>현재 페이지: "+ nowPage+" / 전체 페이지: " + totalPage + "</span></div>");
    
 // 이전 페이지 그룹으로 이동
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // 현재 2그룹일 경우: ( 2 - 1 ) * 10 = 1그룹의 10페이지
    // 현재 3그룹일 경우: ( 3 - 1 ) * 10 = 2그룹의 10페이지
    // 현재 n그룹일 경우: ( n - 1 ) * 10 = n-1그룹의 10페이지
    int _nowPage = (nowGrp-1) * Deal.PAGE_PER_BLOCK; // _nowPage: 상황에 따라서 좀 다르게 쓰일 때 _를 붙임
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./searchList_paging.do?searchItem="+searchItem+"&keyword="+keyword+"&startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 
 
    for(int i = startPage; i <= endPage; i++){ 
      if (i > totalPage){ 
        break; // ex) 11페이지에서 짤림
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지-강조 
      }else{
        // 현재 페이지가 아닌 나머지 페이지
        str.append("<span class='span_box_1'><A href='./searchList_paging.do?searchItem="+searchItem+"&keyword="+keyword+"&startDate="+startDate+"&endDate="+endDate+"&nowPage="+i+"'>"+i+"</A></span>"); 
        // "&deal_no="+deal_no+": 많이 바뀌는 부분 ex) adminno, ...   
      } 
    } 
     
    // 다음 페이지 그룹으로 이동 
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // 현재 1그룹일 경우: ( 2 * 10 ) + 1 = 2그룹의 첫 페이지(11)
    // 현재 2그룹일 경우: ( 3 * 10 ) + 1 = 3그룹의 첫 페이지(21)
    // 현재 n그룹일 경우: ( n * 10 ) + 1 = n+1그룹의 첫 페이지((n+1) * 10 + 1)
    _nowPage = (nowGrp * Deal.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./searchList_paging.do?searchItem="+searchItem+"&keyword="+keyword+"&startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  // 7/25 ---------------------------------------------------------------------

}