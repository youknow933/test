package dev.mvc.report;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ReportVO {
  private int report_no;
  private int mem_no;
  private String report_title;
  private String report_write;
  private String report_passwd;
  private String report_rdate;
  private String report_grpno;
  private String report_cnt;
  private String report_contents;
  private String report_web;
  private String report_files = "";
  private String report_sizes = "";
  private String report_thumbs = "";
  private String report_visible;
  private int report_indent;
  private int report_ansnum;
  
  private List<MultipartFile> filesMF;
  
  public ReportVO() {
  }

  /**
   * @return the report_no
   */
  public int getReport_no() {
    return report_no;
  }

  /**
   * @param report_no the report_no to set
   */
  public void setReport_no(int report_no) {
    this.report_no = report_no;
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
   * @return the report_title
   */
  public String getReport_title() {
    return report_title;
  }

  /**
   * @param report_title the report_title to set
   */
  public void setReport_title(String report_title) {
    this.report_title = report_title;
  }

  /**
   * @return the report_write
   */
  public String getReport_write() {
    return report_write;
  }

  /**
   * @param report_write the report_write to set
   */
  public void setReport_write(String report_write) {
    this.report_write = report_write;
  }

  /**
   * @return the report_passwd
   */
  public String getReport_passwd() {
    return report_passwd;
  }

  /**
   * @param report_passwd the report_passwd to set
   */
  public void setReport_passwd(String report_passwd) {
    this.report_passwd = report_passwd;
  }

  /**
   * @return the report_rdate
   */
  public String getReport_rdate() {
    return report_rdate;
  }

  /**
   * @param report_rdate the report_rdate to set
   */
  public void setReport_rdate(String report_rdate) {
    this.report_rdate = report_rdate;
  }

  /**
   * @return the report_grpno
   */
  public String getReport_grpno() {
    return report_grpno;
  }

  /**
   * @param report_grpno the report_grpno to set
   */
  public void setReport_grpno(String report_grpno) {
    this.report_grpno = report_grpno;
  }

  /**
   * @return the report_cnt
   */
  public String getReport_cnt() {
    return report_cnt;
  }

  /**
   * @param report_cnt the report_cnt to set
   */
  public void setReport_cnt(String report_cnt) {
    this.report_cnt = report_cnt;
  }

  /**
   * @return the report_contents
   */
  public String getReport_contents() {
    return report_contents;
  }

  /**
   * @param report_contents the report_contents to set
   */
  public void setReport_contents(String report_contents) {
    this.report_contents = report_contents;
  }

  /**
   * @return the report_web
   */
  public String getReport_web() {
    return report_web;
  }

  /**
   * @param report_web the report_web to set
   */
  public void setReport_web(String report_web) {
    this.report_web = report_web;
  }

  /**
   * @return the report_files
   */
  public String getReport_files() {
    return report_files;
  }

  /**
   * @param report_files the report_files to set
   */
  public void setReport_files(String report_files) {
    this.report_files = report_files;
  }

  /**
   * @return the report_sizes
   */
  public String getReport_sizes() {
    return report_sizes;
  }

  /**
   * @param report_sizes the report_sizes to set
   */
  public void setReport_sizes(String report_sizes) {
    this.report_sizes = report_sizes;
  }

  /**
   * @return the report_thumbs
   */
  public String getReport_thumbs() {
    return report_thumbs;
  }

  /**
   * @param report_thumbs the report_thumbs to set
   */
  public void setReport_thumbs(String report_thumbs) {
    this.report_thumbs = report_thumbs;
  }

  /**
   * @return the report_visible
   */
  public String getReport_visible() {
    return report_visible;
  }

  /**
   * @param report_visible the report_visible to set
   */
  public void setReport_visible(String report_visible) {
    this.report_visible = report_visible;
  }

  /**
   * @return the indent
   */
  public int getReport_indent() {
    return report_indent;
  }

  /**
   * @param indent the indent to set
   */
  public void setReport_indent(int report_indent) {
    this.report_indent = report_indent;
  }

  /**
   * @return the ansnum
   */
  public int getReport_ansnum() {
    return report_ansnum;
  }

  /**
   * @param ansnum the ansnum to set
   */
  public void setReport_ansnum(int report_ansnum) {
    this.report_ansnum = report_ansnum;
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
 
 
