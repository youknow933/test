package dev.mvc.notice;

import java.util.HashMap;
import java.util.List;


public interface NoticeDAOInter {
  /**
   * 목록
   * <xmp>
   * <select id="list_all" resultType="NoticeVO">
   * </xmp>
   * @return
   */

  public List<NoticeVO> list_all();
  
  public NoticeVO read(int no_no);
  /**
   * 등록
   * <select id="list_create" resultType="NoticeVO" parameterType="int">
   * @return
   */
  public int create(NoticeVO noticeVO);

  public int update(NoticeVO noticeVO);
  
  public int delete(int no_no);
  
  public int delete_img(int no_no);

  
  public List<NoticeVO> list_by_notice(HashMap hashMap);

  public List<NoticeVO> list_by_notice_search(HashMap hashMap);

  int search_count(HashMap hashMap);

  int total_count();

  public List<NoticeVO> read_mem_no(int mem_no);

/*  public int show_hide(int no_no);*/
  
  /*List<NoticeVO> read_by_mem_no(int mem_no);*/


  
  
  /**
   * 한 건의 레코드 조회
   * <xmp>
   * <select id="read" resultType="NoticeVO" parameterType="int">
   * </xmp> 
   * @param noticeno
   * @return
   *//*
  public NoticeVO read(int noticeno);
  
  *//**
   * 레코드를 수정합니다.
   * <xmp>
   * <update id="update" parameterType="NoticeVO">
   * </xmp> 
   * @param noticeVO 
   * @return
   *//*
  public int update(NoticeVO noticeVO); 
  
  *//**
   * 한건의 레코드 삭제
   * <xmp> 
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param noticeno
   * @return
   *//*
  public int delete(int noticeno);
  
  // <update id="update_seqno_up" parameterType="int">
  public int update_seqno_up(int noticeno);
  
  // <update id="update_seqno_down" parameterType="int">
  public int update_seqno_down(int noticeno);
  
  // <select id="countByCategrpno" resultType="int" parameterType="int">
  public int countByNoticeno(int noticeno);
 
  // <delete id="deleteByNoticeno" parameterType="int">
  public int deleteByNoticeno(int noticeno);
  
  *//**
   * 글 수 증가
   * <xmp>
   * <update id="increaseCnt" parameterType="int">
   * </xmp> 
   * @param noticeno
   * @return
   *//*
  public int increaseCnt(int noticeno);
 
  *//**
   * 글 수 감소
   * <xmp>
   * <update id="decreaseCnt" parameterType="int">
   * </xmp> 
   * @param noticeno
   * @return
   *//*
  public int decreaseCnt(int noticeno);
 
  */
}






