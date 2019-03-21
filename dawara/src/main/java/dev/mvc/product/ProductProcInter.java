package dev.mvc.product;

import java.util.HashMap;
import java.util.List;


public interface ProductProcInter {
  // <insert id="create" parameterType="CategoryVO">
  public int create(ProductVO productVO);
  
  /**
   * �˻� ���
   * <xmp> 
   * <select id="list_by_category_search" resultType="ContentsVO" parameterType="HashMap">
   * </xmp>
   * @param categoryno
   * @return
   */
  public List<ProductVO> list_by_category_search(HashMap hashMap);
  
  /**
   * �˻� ���
   * <xmp> 
   * <select id="list_mem_no" resultType="ProductVO" parameterType="HashMap">
   * </xmp>
   * @param categoryno
   * @return
   */
  public List<ProductVO> list_mem_no(HashMap hashMap);
  
  /**
   * ����� �Ǹ��� ���
   * <xmp> 
   * <select id="list_sell_mem_no" resultType="ProductVO" parameterType="int">
   * </xmp>
   * @param mem_no
   * @return
   */
  public List<ProductVO> list_sell_mem_no(int mem_no);
  
  /**
   * category�� �˻��� ���ڵ� ����
   * <xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   *  </xmp>
   * @return
   */
  public int search_count(HashMap hashMap);  
  
  /**
   * category�� �˻��� ���ڵ� ����
   * <xmp>
   * <select id="search_count_mem_no" resultType="int" parameterType="HashMap">
   *  </xmp>
   * @return
   */
  public int search_count_mem_no(HashMap hashMap);  
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param categoryno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  public String paging(int categoryno, int search_count, int nowPage, String word); 
  
  /**
   * �Ѱ��� ���ڵ� ��ȸ
   * <xmp>
   * <select id="read" resultType="ProductVO" parameterType="int">
   * </xmp>
   * @param pr_no �� ��ȣ
   * @return
   */
  public ProductVO read(int pr_no);
  
  /**
   * ����ó��
   * <xmp>
   * <update id="update" parameterType="ProductVO">
   * </xmp> 
   * @param vo
   * @return
   */
  public int update(ProductVO productVO);
  
  /**
   * ���� �Ϸ� �� ������ �ʰ� ��
   * <xmp>
   * <update id="update" parameterType="int">
   * </xmp> 
   * @param pr_no
   * @return
   */
  public int update_visible(int pr_no);
  
  
  
  /**
   * ���� ó��
   * <xmp>
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @param contentsno
   * @return
   */
  public int delete(int pr_no);
  
  

}
