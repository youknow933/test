package dev.mvc.notice;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class NoticeVO {
  private int no_no;
  private int mem_no;
  private String no_title;
  private String no_write;
  private String no_rdate;
  private String no_cnt;
  private String no_contents;
  private String no_visible;
  private String no_seqno;
  private String no_files = "";
  private String no_sizes = "";
  private String no_thumbs = "";
  private int indent;
  private int ansnum;
  private String word = "";
  
  private List<MultipartFile> filesMF;
  
  public NoticeVO() {
    
  }

  /**
   * @return the no_no
   */
  public int getNo_no() {
    return no_no;
  }

  /**
   * @param no_no the no_no to set
   */
  public void setNo_no(int no_no) {
    this.no_no = no_no;
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
   * @return the no_title
   */
  public String getNo_title() {
    return no_title;
  }

  /**
   * @param no_title the no_title to set
   */
  public void setNo_title(String no_title) {
    this.no_title = no_title;
  }

  /**
   * @return the no_write
   */
  public String getNo_write() {
    return no_write;
  }

  /**
   * @param no_write the no_write to set
   */
  public void setNo_write(String no_write) {
    this.no_write = no_write;
  }

  /**
   * @return the no_rdate
   */
  public String getNo_rdate() {
    return no_rdate;
  }

  /**
   * @param no_rdate the no_rdate to set
   */
  public void setNo_rdate(String no_rdate) {
    this.no_rdate = no_rdate;
  }

  /**
   * @return the no_cnt
   */
  public String getNo_cnt() {
    return no_cnt;
  }

  /**
   * @param no_cnt the no_cnt to set
   */
  public void setNo_cnt(String no_cnt) {
    this.no_cnt = no_cnt;
  }

  /**
   * @return the no_contents
   */
  public String getNo_contents() {
    return no_contents;
  }

  /**
   * @param no_contents the no_contents to set
   */
  public void setNo_contents(String no_contents) {
    this.no_contents = no_contents;
  }

  /**
   * @return the no_visible
   */
  public String getNo_visible() {
    return no_visible;
  }

  /**
   * @param no_visible the no_visible to set
   */
  public void setNo_visible(String no_visible) {
    this.no_visible = no_visible;
  }

  /**
   * @return the no_seqno
   */
  public String getNo_seqno() {
    return no_seqno;
  }

  /**
   * @param no_seqno the no_seqno to set
   */
  public void setNo_seqno(String no_seqno) {
    this.no_seqno = no_seqno;
  }

  /**
   * @return the files
   */
  public String getNo_files() {
    if (this.no_files == null) {
      return "";
    } else{
      return no_files;
    }
  }

  /**
   * @param files the files to set
   */
  public void setNo_files(String no_files) {
    this.no_files = no_files;
  }

  /**
   * @return the no_sizes
   */
  public String getNo_sizes() {
    return no_sizes;
  }

  /**
   * @param no_sizes the no_sizes to set
   */
  public void setNo_sizes(String no_sizes) {
    this.no_sizes = no_sizes;
  }
  
  /**
   * @return the no_thumbs
   */
  public String getNo_thumbs() {
    return no_thumbs;
  }

  /**
   * @param no_thumbs the no_thumbs to set
   */
  public void setNo_thumbs(String no_thumbs) {
    this.no_thumbs = no_thumbs;
  }

  /**
   * @return the indent
   */
  public int getIndent() {
    return indent;
  }

  /**
   * @param indent the indent to set
   */
  public void setIndent(int indent) {
    this.indent = indent;
  }

  /**
   * @return the ansnum
   */
  public int getAnsnum() {
    return ansnum;
  }

  /**
   * @param ansnum the ansnum to set
   */
  public void setAnsnum(int ansnum) {
    this.ansnum = ansnum;
  }

  /**
   * @return the word
   */
  public String getWord() {
    return word;
  }

  /**
   * @param word the word to set
   */
  public void setWord(String word) {
    this.word = word;
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
 
 
