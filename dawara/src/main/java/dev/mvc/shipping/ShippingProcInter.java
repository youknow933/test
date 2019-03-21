package dev.mvc.shipping;

import java.util.HashMap;
import java.util.List;

public interface ShippingProcInter {

  /**
   * ��� <Xmp> <insert id="insert" parameterType="ShippingVO"> </Xmp>
   * 
   * @param PaymentVO
   * @return
   */
  public int create(ShippingVO shippingVO);

  /**
   * �Ǹ��� ���� ��� <Xmp>
   * <select id="pr_mem_info" resultType="Product_MemberVO" parameterType="int">
   * </Xmp>
   * 
   * @param pr_no
   * @return list
   */
  public List<Product_MemberVO> pr_mem_info(int pr_no);
  // 7/10 - 7/11
  // --------------------------------------------------------------------

  /**
   * ��� ���� ��� <Xmp> <select id="list" resultType="ShippingVO"> </Xmp>
   * 
   * @return
   */
  public List<ShippingVO> list();

  /**
   * ȸ�� ������� ��� <Xmp>
   * <select id="list_by_mem_no" resultType="ShippingVO" parameterType="int">
   * </Xmp>
   * 
   * @return
   */
  public List<ShippingVO> list_by_mem_no(int mem_no);

  /**
   * ��� ���� ��� <Xmp>
   * <select id="read" resultType="ShippingVO" parameterType="int"> </Xmp>
   * 
   * @return
   */
  public ShippingVO read(int ship_no);

  /**
   * �ù�ŷ� ���� <Xmp> <update id="update" parameterType ="ShippingVO"> </Xmp>
   * 
   * @return
   */
  public int update(ShippingVO shippingVO);

  /**
   * �ù�ŷ� ���� <Xmp> <delete id="delete" parameterType="int"> </Xmp>
   * 
   * @return
   */
  public int delete(int ship_no);
  // 7/12
  // ---------------------------------------------------------------------------------

  /**
   * ��ü �ù�ŷ���� �˻� <Xmp>
   * <select id="searchList" resultType="ShippingVO" parameterType= "Hashmap">
   * </Xmp>
   * 
   * @return
   */
  public List<ShippingVO> searchList(HashMap hashMap);

  /**
   * ȸ�� �ù�ŷ���� �˻� <Xmp>
   * <select id="searchList_by_mem_no" resultType="ShippingVO" parameterType=
   * "Hashmap"> </Xmp>
   * 
   * @return
   */
  public List<ShippingVO> searchList_by_mem_no(HashMap hashMap);

  /**
   * �˻��� ���ڵ� ���� <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap"> </Xmp>
   * 
   * @return
   */
  public int search_count(HashMap hashMap);

  // 7/13 ~ 7/17
  // ---------------------------------------------------------------------------------

  /**
   * ȸ�� �ù�ŷ���� �˻� + ����¡ <Xmp>
   * <select id="searchList_by_mem_no_paging" resultType="ShippingVO" parameterType="HashMap"> </Xmp>
   * 
   * @return
   */
  public List<ShippingVO> searchList_by_mem_no_paging(HashMap hashMap);

  /**
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   * 
   * @param mem_no
   * @param search_count
   * @param nowPage
   * @param keyword
   * @return
   */
  public String paging(int mem_no, int search_count, int nowPage, String keyword); 
  // 7/17
}
