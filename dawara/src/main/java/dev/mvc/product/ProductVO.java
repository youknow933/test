package dev.mvc.product;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
/*
        pr_no          NUMBER(7)        NOT NULL        PRIMARY KEY,
        gory_no         NUMBER(7)        NULL ,
        mem_no                  NUMBER(6)        NULL ,
        pr_pr_maker                VARCHAR2(300)        NOT NULL,
        pr_title                   VARCHAR2(300)        NOT NULL,
        pr_pr_contents              VARCHAR2(4000)       NOT NULL,
        pr_thumbs              VARCHAR2(1000)                             NULL ,
        pr_pr_files                   VARCHAR2(1000)                            NULL ,
        pr_pr_sizes                  VARCHAR2(1000)                            NULL ,
        pr_cnt                    NUMBER(7)        DEFAULT 0       NOT NULL,
        pr_rdate                  DATE                                      NOT NULL,
        pr_buyyear                  DATE                                           NULL,
        pr_word                  VARCHAR2(100)                              NULL,
        pr_price                  NUMBER(10)      DEFAULT 0       NOT NULL,
        pr_visible                 CHAR(1)            DEFAULT 'Y'      NOT NULL,     
        pr_payment                 CHAR(1)            DEFAULT 'N'      NOT NULL,     --N(no), Y(yes), I(ing)
*/
  
  /** �� ��ȣ */
  private int pr_no;
  /** �Խ��� �׷� ��ȣ */
  private int gory_no;
  /** ȸ�� ��ȣ */
  private int mem_no;
  /** ���� */
  private String pr_title;
  /** ���� */
  private String pr_contents;
  /** Preview ���� �̹��� 200 X 150, �ڵ� ������ */
  private String pr_thumbs = "";
  
  /** ���� �̹����߿� ù��° Preview �̹��� ����, 200 X 150 */
  private String pr_thumb = "";
  
  /** ���ε� ���� */
  private String pr_files = "";
  /** ���ε�� ���� ũ�� */
  private String pr_sizes = "";
  /** ��ȸ�� */
  private int pr_cnt = 0;
  /** ���� ���� */
  private String pr_buyyear;
  /** ����� */
  private String pr_rdate;
  /** �˻��� */
  private String pr_word;
  /** ���� */
  private String pr_state;
  /** �ŷ� ��� */
  private String pr_transaction;
  /** ���� */
  private String pr_local;
  /** ���� ���� */
  private int pr_buyprice;
  /** ���� */
  private int pr_price;
  /** ��� ���� */
  private String pr_visible;
  /** ���� ���� */
  private String pr_payment;
  
  /** 
    Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
    DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
    �ϳ��� ���� ���ε�
  */  
  // private MultipartFile pr_filesMF;
  
  /** 
  Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
  DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
  �������� ���� ���ε�
  */  
  private List<MultipartFile> pr_filesMF;

  /** size1�� �ĸ� ���� ��¿� ����, ���� �÷��� �������� ����. */
  private String pr_sizesLabel;

  public ProductVO() {

  }

  /**
   * @return the pr_files
   */
  public String getPr_files() {
    if (this.pr_files == null) {
      return "";
    } else{
      return pr_files;
    }
  }

  /**
   * @param pr_files the pr_files to set
   */
  public void setPr_files(String pr_files) {
    this.pr_files = pr_files;
  }

  public int getPr_no() {
    return pr_no;
  }

  public void setPr_no(int pr_no) {
    this.pr_no = pr_no;
  }

  public int getGory_no() {
    return gory_no;
  }

  public void setGory_no(int gory_no) {
    this.gory_no = gory_no;
  }

  public int getMem_no() {
    return mem_no;
  }

  public void setMem_no(int mem_no) {
    this.mem_no = mem_no;
  }

  public String getPr_title() {
    return pr_title;
  }

  public void setPr_title(String pr_title) {
    this.pr_title = pr_title;
  }

  public String getPr_contents() {
    return pr_contents;
  }

  public void setPr_contents(String pr_contents) {
    this.pr_contents = pr_contents;
  }

  public String getPr_thumbs() {
    return pr_thumbs;
  }

  public void setPr_thumbs(String pr_thumbs) {
    this.pr_thumbs = pr_thumbs;
  }

  public String getPr_thumb() {
    return pr_thumb;
  }

  public void setPr_thumb(String pr_thumb) {
    this.pr_thumb = pr_thumb;
  }

  public String getPr_sizes() {
    return pr_sizes;
  }

  public void setPr_sizes(String pr_sizes) {
    this.pr_sizes = pr_sizes;
  }

  public int getPr_cnt() {
    return pr_cnt;
  }

  public void setPr_cnt(int pr_cnt) {
    this.pr_cnt = pr_cnt;
  }

  public String getPr_buyyear() {
    return pr_buyyear;
  }

  public void setPr_buyyear(String pr_buyyear) {
    this.pr_buyyear = pr_buyyear;
  }

  public String getPr_rdate() {
    return pr_rdate;
  }

  public void setPr_rdate(String pr_rdate) {
    this.pr_rdate = pr_rdate;
  }

  public String getPr_word() {
    return pr_word;
  }

  public void setPr_word(String pr_word) {
    this.pr_word = pr_word;
  }

  public int getPr_price() {
    return pr_price;
  }

  public void setPr_price(int pr_price) {
    this.pr_price = pr_price;
  }

  public String getPr_visible() {
    return pr_visible;
  }

  public void setPr_visible(String pr_visible) {
    this.pr_visible = pr_visible;
  }

  public String getPr_payment() {
    return pr_payment;
  }

  public void setPr_payment(String pr_payment) {
    this.pr_payment = pr_payment;
  }

  public List<MultipartFile> getPr_filesMF() {
    return pr_filesMF;
  }

  public void setPr_filesMF(List<MultipartFile> pr_filesMF) {
    this.pr_filesMF = pr_filesMF;
  }

  public String getPr_sizesLabel() {
    return pr_sizesLabel;
  }

  public void setPr_sizesLabel(String pr_sizesLabel) {
    this.pr_sizesLabel = pr_sizesLabel;
  }

  public String getPr_state() {
    return pr_state;
  }

  public void setPr_state(String pr_state) {
    this.pr_state = pr_state;
  }

  public String getPr_transaction() {
    return pr_transaction;
  }

  public void setPr_transaction(String pr_transaction) {
    this.pr_transaction = pr_transaction;
  }

  public String getPr_local() {
    return pr_local;
  }

  public void setPr_local(String pr_local) {
    this.pr_local = pr_local;
  }

  public int getPr_buyprice() {
    return pr_buyprice;
  }

  public void setPr_buyprice(int pr_buyprice) {
    this.pr_buyprice = pr_buyprice;
  }
  
}
 
  