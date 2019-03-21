package dev.mvc.shipping;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.deal.Deal;
import dev.mvc.shipping.Shipping;

@Component("dev.mvc.shipping.ShippingProc")
public class ShippingProc implements ShippingProcInter {
  @Autowired
  @Qualifier("dev.mvc.shipping.ShippingDAO")
  private ShippingDAOInter shippingDAO = null;

  public ShippingProc() {
    System.out.println("--> ShippingProc created.");
  }

  @Override
  public int create(ShippingVO shippingVO) {
    return shippingDAO.create(shippingVO);
  }

  @Override
  public List<Product_MemberVO> pr_mem_info(int pr_no) {
    List<Product_MemberVO> pmList = shippingDAO.pr_mem_info(pr_no);
    return pmList;
  }
  // 7/10 - 7/11
  // --------------------------------------------------------------------

  @Override
  public List<ShippingVO> list() {
    return shippingDAO.list();
  }

  @Override
  public List<ShippingVO> list_by_mem_no(int mem_no) {
    return shippingDAO.list_by_mem_no(mem_no);
  }

  @Override
  public ShippingVO read(int ship_no) {
    return shippingDAO.read(ship_no);
  }

  @Override
  public int update(ShippingVO shippingVO) {
    return shippingDAO.update(shippingVO);
  }

  @Override
  public int delete(int ship_no) {
    return shippingDAO.delete(ship_no);
  }
  // 7/12
  // ---------------------------------------------------------------------------------
  
  @Override
  public List<ShippingVO> searchList(HashMap hashMap) {
    return shippingDAO.searchList(hashMap);
  }

  @Override
  public List<ShippingVO> searchList_by_mem_no(HashMap hashMap) {
    return shippingDAO.searchList_by_mem_no(hashMap);
  }

  @Override
  public int search_count(HashMap hashMap) {
    return shippingDAO.search_count(hashMap);
  }
  // 7/13 ~
  // ---------------------------------------------------------------------------------

  @Override
  public List<ShippingVO> searchList_by_mem_no_paging(HashMap hashMap) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3페이지: nowPage = 3, (3 - 1) * 10 --> 20
    */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Shipping.RECORD_PER_PAGE;
    
    // 시작 rownum, 1페이지: 1 / 2페이지: 11 / 3페이지: 21 
    int startNum = beginOfPage + 1; 
    //  종료 rownum, 1페이지: 10 / 2페이지: 20 / 3페이지: 30
    int endNum = beginOfPage + Shipping.RECORD_PER_PAGE;   
    /*
     1페이지: WHERE r >= 1 AND r <= 10
     2페이지: WHERE r >= 11 AND r <= 20
     3페이지: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    return shippingDAO.searchList_by_mem_no_paging(hashMap);
  }
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param Shipping_no      거래번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage      현재 페이지
   * @param keyword    검색어
   * @param endDate      검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String paging(int mem_no, int search_count, int nowPage, String keyword) {
    int totalPage = (int)(Math.ceil((double)search_count/Shipping.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Shipping.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Shipping.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Shipping.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Shipping.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
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
    
 // 이전 페이지 그룹으로 이동
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // 현재 2그룹일 경우: ( 2 - 1 ) * 10 = 1그룹의 10페이지
    // 현재 3그룹일 경우: ( 3 - 1 ) * 10 = 2그룹의 10페이지
    // 현재 n그룹일 경우: ( n - 1 ) * 10 = n-1그룹의 10페이지
    int _nowPage = (nowGrp-1) * Shipping.PAGE_PER_BLOCK; // _nowPage: 상황에 따라서 좀 다르게 쓰일 때 _를 붙임
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./searchList_by_mem_no_paging.do?mem_no="+mem_no+"&keyword="+keyword+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 
 
    for(int i = startPage; i <= endPage; i++){ 
      if (i > totalPage){ 
        break; // ex) 11페이지에서 짤림
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지-강조 
      }else{
        // 현재 페이지가 아닌 나머지 페이지
        str.append("<span class='span_box_1'><A href='./searchList_by_mem_no_paging.do?mem_no="+mem_no+"&keyword="+keyword+"&nowPage="+i+"'>"+i+"</A></span>"); 
        // "&Shipping_no="+Shipping_no+": 많이 바뀌는 부분 ex) adminno, ...   
      } 
    } 
     
    // 다음 페이지 그룹으로 이동 
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // 현재 1그룹일 경우: ( 2 * 10 ) + 1 = 2그룹의 첫 페이지(11)
    // 현재 2그룹일 경우: ( 3 * 10 ) + 1 = 3그룹의 첫 페이지(21)
    // 현재 n그룹일 경우: ( n * 10 ) + 1 = n+1그룹의 첫 페이지((n+1) * 10 + 1)
    _nowPage = (nowGrp * Shipping.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./searchList_by_mem_no_paging.do?mem_no="+mem_no+"&keyword="+keyword+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  // 7/17

}
