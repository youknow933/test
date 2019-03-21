package dev.mvc.shipping;

import java.util.HashMap;
import java.util.List;

import dev.mvc.deal.Member_Product_DealVO;

public interface ShippingDAOInter {

  /**
   * 등록 <Xmp> <insert id="insert" parameterType="ShippingVO"> </Xmp>
   * 
   * @param PaymentVO
   * @return
   */
  public int create(ShippingVO shippingVO);

  /**
   * 판매자 정보 목록 <Xmp>
   * <select id="pr_mem_info" resultType="Product_MemberVO" parameterType="int">
   * </Xmp>
   * 
   * @param pr_no
   * @return list
   */
  public List<Product_MemberVO> pr_mem_info(int pr_no);
  // 7/10 - 7/11
  // ---------------------------------------------------------------------------------

  /**
   * 배송 정보 목록 <Xmp> <select id="list" resultType="ShippingVO"> </Xmp>
   * 
   * @return
   */
  public List<ShippingVO> list();

  /**
   * 회원 배송정보 목록 <Xmp>
   * <select id="list_by_mem_no" resultType="ShippingVO" parameterType="int">
   * </Xmp>
   * 
   * @return
   */
  public List<ShippingVO> list_by_mem_no(int mem_no);

  /**
   * 택배거래 보기 <Xmp>
   * <select id="read" resultType="ShippingVO" parameterType="int"> </Xmp>
   * 
   * @return
   */
  public ShippingVO read(int ship_no);

  /**
   * 택배거래 수정 <Xmp> <update id="update" parameterType ="ShippingVO"> </Xmp>
   * 
   * @return
   */
  public int update(ShippingVO shippingVO);

  /**
   * 택배거래 삭제 <Xmp> <delete id="delete" parameterType="int"> </Xmp>
   * 
   * @return
   */
  public int delete(int ship_no);
  // 7/12
  // ---------------------------------------------------------------------------------

  /**
   * 전체 택배거래목록 검색 <Xmp>
   * <select id="searchList" resultType="ShippingVO" parameterType= "Hashmap">
   * </Xmp>
   * 
   * @return
   */
  public List<ShippingVO> searchList(HashMap hashMap);

  /**
   * 회원 택배거래목록 검색 <Xmp>
   * <select id="searchList_by_mem_no" resultType="ShippingVO" parameterType=
   * "Hashmap"> </Xmp>
   * 
   * @return
   */
  public List<ShippingVO> searchList_by_mem_no(HashMap hashMap);

  /**
   * 검색된 레코드 갯수 <Xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap"> </Xmp>
   * 
   * @return
   */
  public int search_count(HashMap hashMap);

  // 7/13 ~ 7/17
  // ---------------------------------------------------------------------------------

  /**
   * 회원 택배거래목록 검색 + 페이징 <Xmp>
   * <select id="searchList_by_mem_no_paging" resultType="ShippingVO" parameterType="HashMap"> </Xmp>
   * 
   * @return
   */
  public List<ShippingVO> searchList_by_mem_no_paging(HashMap hashMap);
  // 7/17
  
}
