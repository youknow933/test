package dev.mvc.mileage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dev.mvc.category.Categrp_CategoryVO;

public interface MileageDAOInter {
  
  /**
   * <Xmp>
   * ���ϸ��� ���
   * <insert id="create" parameterType="MileageVO"> 
   * </Xmp>
   * @param mileageVO
   * @return ó���� ���ڵ� ����
   */
  public int create(MileageVO mileageVO);
  
  /**
   * ���
   * <xmp>
   * <select id="list" resultType="MileageVO">
   * </xmp> 
   * @return
   */
  public List<MileageVO> list();
  
  /**
   * �Ѱ��� ���ڵ� ��ȸ
   * <xmp>
   * <select id="read" resultType="MileageVO" parameterType="int">
   * </xmp> 
   * @param mileage_no
   * @return
   */
  public MileageVO read(int mileage_no);
   
  /**
   * ���ڵ带 �����մϴ�.
   * <xmp>
   * <update id="update" parameterType="MileageVO">
   * </xmp> 
   * @param mileageVO 
   * @return
   */
  public int update(MileageVO mileageVO ); 
  
  /**
   * �Ѱ��� ���ڵ� ����
   * <xmp> 
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param mileage_no
   * @return
   */
  public int delete(int mileage_no);
  
  /**
   * �����ȣ�� ���
   */
  public List<MileageVO> list_by_mem_no(int mem_no); 
   
  
  /**
   * �˻� ���
   * <xmp> 
   * <select id="list_by_mileage_search" resultType="MileageVO" parameterType="HashMap">
   * </xmp>
   * @param 
   * @return
   */
  public List<MileageVO> list_by_mileage_search(HashMap hashMap);
 
  /**
   * category�� �˻��� ���ڵ� ����
   * <xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   *  </xmp>
   * @return
   */
  public int search_count(HashMap hashMap);  
  
  /**
   * �˻� ���
   * <xmp> 
   * <select id="list_by_category_search_paging" resultType="ContentsVO" parameterType="HashMap">
   * </xmp>
   * @param categoryno
   * @return
   */
  public List<MileageVO> list_by_mileage_search_paging(HashMap hashMap);
     
}
 

