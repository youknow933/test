package dev.mvc.mileage;

import java.util.HashMap;
import java.util.List;

import dev.mvc.category.Categrp_CategoryVO;

public interface MileageProcInter {

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
   * ���ϸ����� �����մϴ�.
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
   * ī�װ��� ���
   * @param categoryno
   * @return
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
   *  �˻��� ���ڵ� ����
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
  public String paging(int mem_no, int search_count, int nowPage, String word); 
 
}
