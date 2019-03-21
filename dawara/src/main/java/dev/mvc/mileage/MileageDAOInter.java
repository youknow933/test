package dev.mvc.mileage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dev.mvc.category.Categrp_CategoryVO;

public interface MileageDAOInter {
  
  /**
   * <Xmp>
   * 마일리지 등록
   * <insert id="create" parameterType="MileageVO"> 
   * </Xmp>
   * @param mileageVO
   * @return 처리된 레코드 갯수
   */
  public int create(MileageVO mileageVO);
  
  /**
   * 목록
   * <xmp>
   * <select id="list" resultType="MileageVO">
   * </xmp> 
   * @return
   */
  public List<MileageVO> list();
  
  /**
   * 한건의 레코드 조회
   * <xmp>
   * <select id="read" resultType="MileageVO" parameterType="int">
   * </xmp> 
   * @param mileage_no
   * @return
   */
  public MileageVO read(int mileage_no);
   
  /**
   * 레코드를 수정합니다.
   * <xmp>
   * <update id="update" parameterType="MileageVO">
   * </xmp> 
   * @param mileageVO 
   * @return
   */
  public int update(MileageVO mileageVO ); 
  
  /**
   * 한건의 레코드 삭제
   * <xmp> 
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param mileage_no
   * @return
   */
  public int delete(int mileage_no);
  
  /**
   * 멤버번호별 목록
   */
  public List<MileageVO> list_by_mem_no(int mem_no); 
   
  
  /**
   * 검색 목록
   * <xmp> 
   * <select id="list_by_mileage_search" resultType="MileageVO" parameterType="HashMap">
   * </xmp>
   * @param 
   * @return
   */
  public List<MileageVO> list_by_mileage_search(HashMap hashMap);
 
  /**
   * category별 검색된 레코드 갯수
   * <xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   *  </xmp>
   * @return
   */
  public int search_count(HashMap hashMap);  
  
  /**
   * 검색 목록
   * <xmp> 
   * <select id="list_by_category_search_paging" resultType="ContentsVO" parameterType="HashMap">
   * </xmp>
   * @param categoryno
   * @return
   */
  public List<MileageVO> list_by_mileage_search_paging(HashMap hashMap);
     
}
 

