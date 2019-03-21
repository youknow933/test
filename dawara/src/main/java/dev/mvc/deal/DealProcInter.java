package dev.mvc.deal;

import java.util.HashMap;
import java.util.List;

public interface DealProcInter{
 
  public int create(DealVO dealVO);
  // 6/21 ---------------------------------------------------------------
  
  public List<Buy_ProductVO> BPList_by_buy_no(int buy_no);
  
  public List<Buy_MemberVO> BMList_by_mem_no(int mem_no);
  
  public List<Member_Product_DealVO> list();
  
  public List<BuyMember_DealVO> bm_dealList();
  // 6/25 ---------------------------------------------------------------
  
  public List<Buy_ProductVO> bp_list();
  
  public List<Buy_MemberVO> bm_list();
  // 6/22, 6/26 ---------------------------------------------------------------

  public List<Member_Product_DealVO> list_by_deal_no(int deal_no);
  // 6/26 ---------------------------------------------------------------
  
  // <select id="read" resultType="DealVO" parameterType="int">
  public DealVO read(int deal_no);
  // 6/27 ---------------------------------------------------------------
  
  public int update(DealVO dealVO);
  
  public int delete(int deal_no);
  // 6/28~29 ---------------------------------------------------------------
  
  public List<Member_Product_DealVO> list_by_dates_paging(HashMap hashMap);
  
  public int search_count(HashMap hashMap);
  // 6/29 ---------------------------------------------------------------
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param deal_no      ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage      ���� ������
   * @param startDate    �˻���
   * @param endDate      �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  public String paging(int search_count, int nowPage, String startDate, String endDate); 
//  public String paging(int deal_no, int search_count, int nowPage, String startDate, String endDate); 
  // 7/4 ---------------------------------------------------------------

  /**
   * �˻� ����¡ ��� <Xmp>
   * <select id="list_by_category_search" resultType="Member_Product_DealVO"
   * parameterType= "HashMap"> </Xmp>
   * 
   * @param hashMap
   * @return
   */
  public List<Member_Product_DealVO> searchList(HashMap hashMap);
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param deal_no      ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage      ���� ������
   * @param startDate    �˻���
   * @param endDate      �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
//  public String paging2(int search_count, int nowPage, String startDate, String endDate, String keyword); 
  // 7/20 ---------------------------------------------------------------------
  
  /**
   * �˻� ����¡ ��� <Xmp>
   * <select id="searchList_paging" resultType="Member_Product_DealVO"
   * parameterType= "HashMap"> </Xmp>
   * 
   * @param hashMap
   * @return
   */
  public List<Member_Product_DealVO> searchList_paging(HashMap hashMap);
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param deal_no      ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage      ���� ������
   * @param startDate    �˻���
   * @param endDate      �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  public String paging3(int search_count, int nowPage, String startDate, String endDate, String keyword, String searchItem); 
  // 7/25 ---------------------------------------------------------------------
  
}