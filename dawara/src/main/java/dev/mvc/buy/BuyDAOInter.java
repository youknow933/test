package dev.mvc.buy;

import java.util.List;

import dev.mvc.cart.Product_CartVO;
import dev.mvc.reply.ReplyVO;

public interface BuyDAOInter{
 
  /**
   * ���
   * <Xmp>
   * <insert id="create" parameterType="BuyVO">
   * </Xmp>
   * @param buyVO
   * @return
   */
  public int create(BuyVO buyVO);
  
  /**
   * member�� buy=product ���
   * @param mem_no
   * @return
   */
  public List<BuyVO> list_by_mem_no(int mem_no); 
  
  /**
   * member�� buy=product ���
   * @param mem_no
   * @return
   */
  public List<Product_BuyVO> list_by_buyno_prno(int mem_no); 
  

  /**
   * ���� ó��
   * <xmp>
   *   <delete id="delete" parameterType="int">
   * </xmp> 
   * @param buy_no
   * @return
   */
  public int delete(int buy_no);
  
}