package dev.mvc.payment;

import java.util.HashMap;
import java.util.List;

public interface PaymentProcInter {

  /**
   * 등록 <Xmp> <insert id="insert" parameterType="PaymentVO"> </Xmp>
   * 
   * @param PaymentVO
   * @return
   */
  public int create(PaymentVO paymentVO);
  // 7/18
  // --------------------------------------------------------------------

  /**
   * 배송 정보 목록 <Xmp> <select id="list" resultType="PaymentVO"> </Xmp>
   * 
   * @return
   */
  public List<PaymentVO> list();

  /**
   * 회원 배송정보 목록 <Xmp>
   * <select id="list_by_mem_no" resultType="PaymentVO" parameterType="int">
   * </Xmp>
   * 
   * @return
   */
  public List<PaymentVO> list_by_mem_no(int mem_no);

  /**
   * 결제내역 보기 <Xmp>
   * <select id="read" resultType="PaymentVO" parameterType="int"> </Xmp>
   * 
   * @return
   */
  public PaymentVO read(int pay_no);

  /**
   * 결제내역 수정 <Xmp> <update id="update" parameterType ="PaymentVO"> </Xmp>
   * 
   * @return
   */
  public int update(PaymentVO paymentVO);

  /**
   * 결제내역 삭제 <Xmp> <delete id="delete" parameterType="int"> </Xmp>
   * 
   * @return
   */
  public int delete(int pay_no);

  /**
   * 전체 결제내역 목록 검색 <Xmp>
   * <select id="searchList" resultType="PaymentVO" parameterType= "Hashmap">
   * </Xmp>
   * 
   * @return
   */
  public List<PaymentVO> searchList(HashMap hashMap);
  
  /**
   * 검색된 레코드 갯수 <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap"> </Xmp>
   * 
   * @return
   */
  public int search_count(HashMap hashMap);

  /**
   * 회원 결제내역 목록 검색 <Xmp>
   * <select id="searchList_by_mem_no" resultType="PaymentVO" parameterType=
   * "Hashmap"> </Xmp>
   * 
   * @return
   */
  public List<PaymentVO> searchList_by_mem_no(HashMap hashMap);
  
  /**
   * 검색된 레코드 갯수 <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap"> </Xmp>
   * 
   * @return
   */
  public int search_count_by_mem_no(HashMap hashMap);

  /**
   * 회원 결제내역 목록 검색 + 페이징 <Xmp>
   * <select id="searchList_by_mem_no_paging" resultType="PaymentVO" parameterType="HashMap"> </Xmp>
   * 
   * @return
   */
  public List<PaymentVO> searchList_by_mem_no_paging(HashMap hashMap);

  /**
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
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
