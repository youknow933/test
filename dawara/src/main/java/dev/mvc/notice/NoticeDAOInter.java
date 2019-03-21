package dev.mvc.notice;

import java.util.HashMap;
import java.util.List;


public interface NoticeDAOInter {
  /**
   * ���
   * <xmp>
   * <select id="list_all" resultType="NoticeVO">
   * </xmp>
   * @return
   */

  public List<NoticeVO> list_all();
  
  public NoticeVO read(int no_no);
  /**
   * ���
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
   * �� ���� ���ڵ� ��ȸ
   * <xmp>
   * <select id="read" resultType="NoticeVO" parameterType="int">
   * </xmp> 
   * @param noticeno
   * @return
   *//*
  public NoticeVO read(int noticeno);
  
  *//**
   * ���ڵ带 �����մϴ�.
   * <xmp>
   * <update id="update" parameterType="NoticeVO">
   * </xmp> 
   * @param noticeVO 
   * @return
   *//*
  public int update(NoticeVO noticeVO); 
  
  *//**
   * �Ѱ��� ���ڵ� ����
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
   * �� �� ����
   * <xmp>
   * <update id="increaseCnt" parameterType="int">
   * </xmp> 
   * @param noticeno
   * @return
   *//*
  public int increaseCnt(int noticeno);
 
  *//**
   * �� �� ����
   * <xmp>
   * <update id="decreaseCnt" parameterType="int">
   * </xmp> 
   * @param noticeno
   * @return
   *//*
  public int decreaseCnt(int noticeno);
 
  */
}






