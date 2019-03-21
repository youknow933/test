package dev.mvc.qna;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class QnaVO {
  private int qna_no;
  private int mem_no;
  private String qna_title;
  private String qna_write;
  private String qna_passwd;
  private String qna_rdate;
  private String qna_grpno;
  private String qna_cnt;
  private String qna_contents;
  private String qna_web;
  private String qna_files = "";
  private String qna_sizes = "";
  private String qna_thumbs = "";
  private String qna_visible;
  private int qna_indent;
  private int qna_ansnum;
  
  private List<MultipartFile> filesMF;
  
  public QnaVO() {
  }

  /**
   * @return the qna_no
   */
  public int getQna_no() {
    return qna_no;
  }

  /**
   * @param qna_no the qna_no to set
   */
  public void setQna_no(int qna_no) {
    this.qna_no = qna_no;
  }

  /**
   * @return the mem_no
   */
  public int getMem_no() {
    return mem_no;
  }

  /**
   * @param mem_no the mem_no to set
   */
  public void setMem_no(int mem_no) {
    this.mem_no = mem_no;
  }

  /**
   * @return the qna_title
   */
  public String getQna_title() {
    return qna_title;
  }

  /**
   * @param qna_title the qna_title to set
   */
  public void setQna_title(String qna_title) {
    this.qna_title = qna_title;
  }

  /**
   * @return the qna_write
   */
  public String getQna_write() {
    return qna_write;
  }

  /**
   * @param qna_write the qna_write to set
   */
  public void setQna_write(String qna_write) {
    this.qna_write = qna_write;
  }

  /**
   * @return the qna_passwd
   */
  public String getQna_passwd() {
    return qna_passwd;
  }

  /**
   * @param qna_passwd the qna_passwd to set
   */
  public void setQna_passwd(String qna_passwd) {
    this.qna_passwd = qna_passwd;
  }

  /**
   * @return the qna_rdate
   */
  public String getQna_rdate() {
    return qna_rdate;
  }

  /**
   * @param qna_rdate the qna_rdate to set
   */
  public void setQna_rdate(String qna_rdate) {
    this.qna_rdate = qna_rdate;
  }

  /**
   * @return the qna_grpno
   */
  public String getQna_grpno() {
    return qna_grpno;
  }

  /**
   * @param qna_grpno the qna_grpno to set
   */
  public void setQna_grpno(String qna_grpno) {
    this.qna_grpno = qna_grpno;
  }

  /**
   * @return the qna_cnt
   */
  public String getQna_cnt() {
    return qna_cnt;
  }

  /**
   * @param qna_cnt the qna_cnt to set
   */
  public void setQna_cnt(String qna_cnt) {
    this.qna_cnt = qna_cnt;
  }

  /**
   * @return the qna_contents
   */
  public String getQna_contents() {
    return qna_contents;
  }

  /**
   * @param qna_contents the qna_contents to set
   */
  public void setQna_contents(String qna_contents) {
    this.qna_contents = qna_contents;
  }

  /**
   * @return the qna_web
   */
  public String getQna_web() {
    return qna_web;
  }

  /**
   * @param qna_web the qna_web to set
   */
  public void setQna_web(String qna_web) {
    this.qna_web = qna_web;
  }

  /**
   * @return the qna_files
   */
  public String getQna_files() {
    return qna_files;
  }

  /**
   * @param qna_files the qna_files to set
   */
  public void setQna_files(String qna_files) {
    this.qna_files = qna_files;
  }

  /**
   * @return the qna_sizes
   */
  public String getQna_sizes() {
    return qna_sizes;
  }

  /**
   * @param qna_sizes the qna_sizes to set
   */
  public void setQna_sizes(String qna_sizes) {
    this.qna_sizes = qna_sizes;
  }

  /**
   * @return the qna_thumbs
   */
  public String getQna_thumbs() {
    return qna_thumbs;
  }

  /**
   * @param qna_thumbs the qna_thumbs to set
   */
  public void setQna_thumbs(String qna_thumbs) {
    this.qna_thumbs = qna_thumbs;
  }

  /**
   * @return the qna_visible
   */
  public String getQna_visible() {
    return qna_visible;
  }

  /**
   * @param qna_visible the qna_visible to set
   */
  public void setQna_visible(String qna_visible) {
    this.qna_visible = qna_visible;
  }

  /**
   * @return the indent
   */
  public int getQna_indent() {
    return qna_indent;
  }

  /**
   * @param indent the indent to set
   */
  public void setQna_indent(int qna_indent) {
    this.qna_indent = qna_indent;
  }

  /**
   * @return the ansnum
   */
  public int getQna_ansnum() {
    return qna_ansnum;
  }

  /**
   * @param ansnum the ansnum to set
   */
  public void setQna_ansnum(int qna_ansnum) {
    this.qna_ansnum = qna_ansnum;
  }


  /**
   * @return the filesMF
   */
  public List<MultipartFile> getFilesMF() {
    return filesMF;
  }

  /**
   * @param filesMF the filesMF to set
   */
  public void setFilesMF(List<MultipartFile> filesMF) {
    this.filesMF = filesMF;
  }
  
}
 
 
