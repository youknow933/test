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
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1������: nowPage = 1, (1 - 1) * 10 --> 0 
    2������: nowPage = 2, (2 - 1) * 10 --> 10
    3������: nowPage = 3, (3 - 1) * 10 --> 20
    */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Deal.RECORD_PER_PAGE;
    
    // ���� rownum, 1������: 1 / 2������: 11 / 3������: 21 
    int startNum = beginOfPage + 1; 
    //  ���� rownum, 1������: 10 / 2������: 20 / 3������: 30
    int endNum = beginOfPage + Deal.RECORD_PER_PAGE;   
    /*
     1������: WHERE r >= 1 AND r <= 10
     2������: WHERE r >= 11 AND r <= 20
     3������: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    return dealDAO.list_by_dates_paging(hashMap); 
  }
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param deal_no      �ŷ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage      ���� ������
   * @param startDate    �˻���
   * @param endDate      �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  @Override
  public String paging(int search_count, int nowPage, String startDate, String endDate) {
    int totalPage = (int)(Math.ceil((double)search_count/Deal.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Deal.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Deal.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Deal.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Deal.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
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
    
//    str.append("<div><span style='float:left; left: 30%;'>���� ������: "+ nowPage+" / ��ü ������: " + totalPage + "</span></div>");
    
 // ���� ������ �׷����� �̵�
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // ���� 2�׷��� ���: ( 2 - 1 ) * 10 = 1�׷��� 10������
    // ���� 3�׷��� ���: ( 3 - 1 ) * 10 = 2�׷��� 10������
    // ���� n�׷��� ���: ( n - 1 ) * 10 = n-1�׷��� 10������
    int _nowPage = (nowGrp-1) * Deal.PAGE_PER_BLOCK; // _nowPage: ��Ȳ�� ���� �� �ٸ��� ���� �� _�� ����
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 
 
    for(int i = startPage; i <= endPage; i++){ 
      if (i > totalPage){ 
        break; // ex) 11���������� ©��
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������-���� 
      }else{
        // ���� �������� �ƴ� ������ ������
        str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+i+"'>"+i+"</A></span>"); 
        // "&deal_no="+deal_no+": ���� �ٲ�� �κ� ex) adminno, ...   
      } 
    } 
     
    // ���� ������ �׷����� �̵� 
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // ���� 1�׷��� ���: ( 2 * 10 ) + 1 = 2�׷��� ù ������(11)
    // ���� 2�׷��� ���: ( 3 * 10 ) + 1 = 3�׷��� ù ������(21)
    // ���� n�׷��� ���: ( n * 10 ) + 1 = n+1�׷��� ù ������((n+1) * 10 + 1)
    _nowPage = (nowGrp * Deal.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>����</A></span>"); 
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
      String pr_title = Tool.textLength(member_Product_DealVO.getPr_title(), 90); // 90�ڱ����� ��; ���� ó��
      pr_title = Tool.convertChar(pr_title);
      member_Product_DealVO.setPr_title(pr_title);
    }
    
    return list;
  }
  // 7/20 ---------------------------------------------------------------------

  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param deal_no      �ŷ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage      ���� ������
   * @param startDate    �˻���
   * @param endDate      �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  /*
  @Override
  public String paging2(int search_count, int nowPage, String startDate, String endDate, String keyword) {
    int totalPage = (int)(Math.ceil((double)search_count/Deal.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Deal.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Deal.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Deal.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Deal.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
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
    
//    str.append("<div><span style='float:left; left: 30%;'>���� ������: "+ nowPage+" / ��ü ������: " + totalPage + "</span></div>");
    /*
 // ���� ������ �׷����� �̵�
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // ���� 2�׷��� ���: ( 2 - 1 ) * 10 = 1�׷��� 10������
    // ���� 3�׷��� ���: ( 3 - 1 ) * 10 = 2�׷��� 10������
    // ���� n�׷��� ���: ( n - 1 ) * 10 = n-1�׷��� 10������
    int _nowPage = (nowGrp-1) * Deal.PAGE_PER_BLOCK; // _nowPage: ��Ȳ�� ���� �� �ٸ��� ���� �� _�� ����
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 
 
    for(int i = startPage; i <= endPage; i++){ 
      if (i > totalPage){ 
        break; // ex) 11���������� ©��
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������-���� 
      }else{
        // ���� �������� �ƴ� ������ ������
        str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+i+"'>"+i+"</A></span>"); 
        // "&deal_no="+deal_no+": ���� �ٲ�� �κ� ex) adminno, ...   
      } 
    } 
     
    // ���� ������ �׷����� �̵� 
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // ���� 1�׷��� ���: ( 2 * 10 ) + 1 = 2�׷��� ù ������(11)
    // ���� 2�׷��� ���: ( 3 * 10 ) + 1 = 3�׷��� ù ������(21)
    // ���� n�׷��� ���: ( n * 10 ) + 1 = n+1�׷��� ù ������((n+1) * 10 + 1)
    _nowPage = (nowGrp * Deal.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_dates_paging.do?startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>����</A></span>"); 
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
//      String pr_title = Tool.textLength(member_Product_DealVO.getPr_title(), 90); // 90�ڱ����� ��; ���� ó��
//      pr_title = Tool.convertChar(pr_title);
//      member_Product_DealVO.setPr_title(pr_title);
//    }
    
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Deal.RECORD_PER_PAGE;
    
    // ���� rownum, 1������: 1 / 2������: 11 / 3������: 21 
    int startNum = beginOfPage + 1; 
    //  ���� rownum, 1������: 10 / 2������: 20 / 3������: 30
    int endNum = beginOfPage + Deal.RECORD_PER_PAGE;   
    
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
//    return list;
    return dealDAO.searchList_paging(hashMap);
  }
  
  @Override
  public String paging3(int search_count, int nowPage, String startDate, String endDate, String keyword, String searchItem) {
    int totalPage = (int)(Math.ceil((double)search_count/Deal.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Deal.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Deal.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Deal.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Deal.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
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
    
//    str.append("<div><span style='float:left; left: 30%;'>���� ������: "+ nowPage+" / ��ü ������: " + totalPage + "</span></div>");
    
 // ���� ������ �׷����� �̵�
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // ���� 2�׷��� ���: ( 2 - 1 ) * 10 = 1�׷��� 10������
    // ���� 3�׷��� ���: ( 3 - 1 ) * 10 = 2�׷��� 10������
    // ���� n�׷��� ���: ( n - 1 ) * 10 = n-1�׷��� 10������
    int _nowPage = (nowGrp-1) * Deal.PAGE_PER_BLOCK; // _nowPage: ��Ȳ�� ���� �� �ٸ��� ���� �� _�� ����
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./searchList_paging.do?searchItem="+searchItem+"&keyword="+keyword+"&startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 
 
    for(int i = startPage; i <= endPage; i++){ 
      if (i > totalPage){ 
        break; // ex) 11���������� ©��
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������-���� 
      }else{
        // ���� �������� �ƴ� ������ ������
        str.append("<span class='span_box_1'><A href='./searchList_paging.do?searchItem="+searchItem+"&keyword="+keyword+"&startDate="+startDate+"&endDate="+endDate+"&nowPage="+i+"'>"+i+"</A></span>"); 
        // "&deal_no="+deal_no+": ���� �ٲ�� �κ� ex) adminno, ...   
      } 
    } 
     
    // ���� ������ �׷����� �̵� 
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // ���� 1�׷��� ���: ( 2 * 10 ) + 1 = 2�׷��� ù ������(11)
    // ���� 2�׷��� ���: ( 3 * 10 ) + 1 = 3�׷��� ù ������(21)
    // ���� n�׷��� ���: ( n * 10 ) + 1 = n+1�׷��� ù ������((n+1) * 10 + 1)
    _nowPage = (nowGrp * Deal.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./searchList_paging.do?searchItem="+searchItem+"&keyword="+keyword+"&startDate="+startDate+"&endDate="+endDate+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  // 7/25 ---------------------------------------------------------------------

}