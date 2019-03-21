package dev.mvc.cart;

import java.util.HashMap;
import java.util.List;

import dev.mvc.category.Categrp_CategoryVO;

public interface CartDAOInter {
  
  /**
   * <Xmp>
   * ī�װ� �׷� ���
   * <insert id="create" parameterType="cartVO"> 
   * </Xmp>
   * @param cartVO
   * @return ó���� ���ڵ� ����
   */
  public int create(CartVO cartVO);
  
  /**
   * ���
   * <xmp>
   * <select id="list" resultType="Categrp_CategoryVO">
   * </xmp>
   * @return
   */
  public List<Product_CartVO> list_by_mem_no(int mem_no);
  
  /**
   * ���� ó��
   * <xmp>
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @param cart_no
   * @return
   */
  public int delete(int cart_no);
  
  /**
   * ���� ó��
   * <xmp>
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @param cart_no
   * @return
   */
  public int deleteByPr_no(int pr_no);
  
  /**
   * pr_no, mem_no ����
   * <xmp>
   * <select id="pr_count" resultType="CartVO" parameterType="HashMap">
   * </xmp> 
   * @return
   */
  public int pr_count(HashMap hashMap);  
}







