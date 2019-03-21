package dev.mvc.cart;

import java.util.HashMap;
import java.util.List;

import dev.mvc.category.Categrp_CategoryVO;

public interface CartDAOInter {
  
  /**
   * <Xmp>
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="cartVO"> 
   * </Xmp>
   * @param cartVO
   * @return 처리된 레코드 갯수
   */
  public int create(CartVO cartVO);
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="Categrp_CategoryVO">
   * </xmp>
   * @return
   */
  public List<Product_CartVO> list_by_mem_no(int mem_no);
  
  /**
   * 삭제 처리
   * <xmp>
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @param cart_no
   * @return
   */
  public int delete(int cart_no);
  
  /**
   * 삭제 처리
   * <xmp>
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @param cart_no
   * @return
   */
  public int deleteByPr_no(int pr_no);
  
  /**
   * pr_no, mem_no 갯수
   * <xmp>
   * <select id="pr_count" resultType="CartVO" parameterType="HashMap">
   * </xmp> 
   * @return
   */
  public int pr_count(HashMap hashMap);  
}







