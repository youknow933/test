package dev.mvc.payment;

import java.util.HashMap;
import java.util.List;

public interface PaymentProcInter {

  /**
   * ��� <Xmp> <insert id="insert" parameterType="PaymentVO"> </Xmp>
   * 
   * @param PaymentVO
   * @return
   */
  public int create(PaymentVO paymentVO);
  // 7/18
  // --------------------------------------------------------------------

  /**
   * ��� ���� ��� <Xmp> <select id="list" resultType="PaymentVO"> </Xmp>
   * 
   * @return
   */
  public List<PaymentVO> list();

  /**
   * ȸ�� ������� ��� <Xmp>
   * <select id="list_by_mem_no" resultType="PaymentVO" parameterType="int">
   * </Xmp>
   * 
   * @return
   */
  public List<PaymentVO> list_by_mem_no(int mem_no);

  /**
   * �������� ���� <Xmp>
   * <select id="read" resultType="PaymentVO" parameterType="int"> </Xmp>
   * 
   * @return
   */
  public PaymentVO read(int pay_no);

  /**
   * �������� ���� <Xmp> <update id="update" parameterType ="PaymentVO"> </Xmp>
   * 
   * @return
   */
  public int update(PaymentVO paymentVO);

  /**
   * �������� ���� <Xmp> <delete id="delete" parameterType="int"> </Xmp>
   * 
   * @return
   */
  public int delete(int pay_no);

  /**
   * ��ü �������� ��� �˻� <Xmp>
   * <select id="searchList" resultType="PaymentVO" parameterType= "Hashmap">
   * </Xmp>
   * 
   * @return
   */
  public List<PaymentVO> searchList(HashMap hashMap);
  
  /**
   * �˻��� ���ڵ� ���� <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap"> </Xmp>
   * 
   * @return
   */
  public int search_count(HashMap hashMap);

  /**
   * ȸ�� �������� ��� �˻� <Xmp>
   * <select id="searchList_by_mem_no" resultType="PaymentVO" parameterType=
   * "Hashmap"> </Xmp>
   * 
   * @return
   */
  public List<PaymentVO> searchList_by_mem_no(HashMap hashMap);
  
  /**
   * �˻��� ���ڵ� ���� <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap"> </Xmp>
   * 
   * @return
   */
  public int search_count_by_mem_no(HashMap hashMap);

  /**
   * ȸ�� �������� ��� �˻� + ����¡ <Xmp>
   * <select id="searchList_by_mem_no_paging" resultType="PaymentVO" parameterType="HashMap"> </Xmp>
   * 
   * @return
   */
  public List<PaymentVO> searchList_by_mem_no_paging(HashMap hashMap);

  /**
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   * 
   * @param mem_no
   * @param search_count
   * @param nowPage
   * @param keyword
   * @param searchItem
   * @return
   */
  public String paging(int mem_no, int search_count, int nowPage, String keyword, String searchItem); 
  // 7/19
  // ---------------------------------------------------------------------------------
}
