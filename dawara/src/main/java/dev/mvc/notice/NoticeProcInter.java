package dev.mvc.notice;

import java.util.HashMap;
import java.util.List;


public interface NoticeProcInter {
 
  
  /**
   * ���
   * <select id="list_all" resultType="NoticeVO">
   * @return
   */
  public List<NoticeVO> list_all();
  
  
  /**
   * ���
   * <select id="list_create" resultType="NoticeVO" parameterType="int">
   * @return
   */
  public int create(NoticeVO noticeVO);
  
  public NoticeVO read(int no_no);


  public NoticeVO update(int no_no);
  
  public int update(NoticeVO noticeVO);
  
  public int delete(int no_no);

  public int delete_img(int no_no);


  int total_count();


  int search_count(HashMap hashMap);


  List<NoticeVO> read_mem_no(int mem_no);


  List<NoticeVO> list_by_notice(HashMap hashMap);

  public String paging(String notice_search, int no_no, int search_count, int nowPage, String word);

  public List<NoticeVO> list_by_notice_search(HashMap hashMap); 
  
  /*public NoticeVO show_hide(int no_no);*/

  /*List<NoticeVO> read_by_mem_no(int mem_no);*/

   
  /**
   * �� ���� ���ڵ� ��ȸ
   * <xmp>
   * <select id="read" resultType="NoticeVO" parameterType="int">
   * </xmp> 
   * @param noticeno
   * @return
   */
 /* public NoticeVO read(int noticeno);
  
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
  public int countByCategrpno(int noticeno);
  
  // <delete id="deleteByCategrpno" parameterType="int">
  public int deleteByCategrpno(int noticeno);
  
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
