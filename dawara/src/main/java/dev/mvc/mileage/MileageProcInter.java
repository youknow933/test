package dev.mvc.mileage;

import java.util.HashMap;
import java.util.List;

import dev.mvc.category.Categrp_CategoryVO;

public interface MileageProcInter {

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
   * 마일리지를 변경합니다.
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
   * 카테고리별 목록
   * @param categoryno
   * @return
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
   *  검색된 레코드 갯수
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
 
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param categoryno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging(int mem_no, int search_count, int nowPage, String word); 
 
}
