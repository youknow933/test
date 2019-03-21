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
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1������: nowPage = 1, (1 - 1) * 10 --> 0 
    2������: nowPage = 2, (2 - 1) * 10 --> 10
    3������: nowPage = 3, (3 - 1) * 10 --> 20
    */
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Shipping.RECORD_PER_PAGE;
    
    // ���� rownum, 1������: 1 / 2������: 11 / 3������: 21 
    int startNum = beginOfPage + 1; 
    //  ���� rownum, 1������: 10 / 2������: 20 / 3������: 30
    int endNum = beginOfPage + Shipping.RECORD_PER_PAGE;   
    /*
     1������: WHERE r >= 1 AND r <= 10
     2������: WHERE r >= 11 AND r <= 20
     3������: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    return shippingDAO.searchList_by_mem_no_paging(hashMap);
  }
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param Shipping_no      �ŷ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage      ���� ������
   * @param keyword    �˻���
   * @param endDate      �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  @Override
  public String paging(int mem_no, int search_count, int nowPage, String keyword) {
    int totalPage = (int)(Math.ceil((double)search_count/Shipping.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Shipping.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Shipping.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Shipping.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Shipping.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
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
    
 // ���� ������ �׷����� �̵�
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // ���� 2�׷��� ���: ( 2 - 1 ) * 10 = 1�׷��� 10������
    // ���� 3�׷��� ���: ( 3 - 1 ) * 10 = 2�׷��� 10������
    // ���� n�׷��� ���: ( n - 1 ) * 10 = n-1�׷��� 10������
    int _nowPage = (nowGrp-1) * Shipping.PAGE_PER_BLOCK; // _nowPage: ��Ȳ�� ���� �� �ٸ��� ���� �� _�� ����
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./searchList_by_mem_no_paging.do?mem_no="+mem_no+"&keyword="+keyword+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 
 
    for(int i = startPage; i <= endPage; i++){ 
      if (i > totalPage){ 
        break; // ex) 11���������� ©��
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������-���� 
      }else{
        // ���� �������� �ƴ� ������ ������
        str.append("<span class='span_box_1'><A href='./searchList_by_mem_no_paging.do?mem_no="+mem_no+"&keyword="+keyword+"&nowPage="+i+"'>"+i+"</A></span>"); 
        // "&Shipping_no="+Shipping_no+": ���� �ٲ�� �κ� ex) adminno, ...   
      } 
    } 
     
    // ���� ������ �׷����� �̵� 
    // nowGrp = 1 -> (1 ~ 10 page)
    // nowGrp = 2 -> (11 ~ 20 page)
    // nowGrp = 3 -> (21 ~ 30 page)
    // ���� 1�׷��� ���: ( 2 * 10 ) + 1 = 2�׷��� ù ������(11)
    // ���� 2�׷��� ���: ( 3 * 10 ) + 1 = 3�׷��� ù ������(21)
    // ���� n�׷��� ���: ( n * 10 ) + 1 = n+1�׷��� ù ������((n+1) * 10 + 1)
    _nowPage = (nowGrp * Shipping.PAGE_PER_BLOCK)+1; 
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./searchList_by_mem_no_paging.do?mem_no="+mem_no+"&keyword="+keyword+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  // 7/17

}
