package dev.mvc.category;

/* 
  gory_no      NUMBER(7)                                 NOT NULL,
  grp_no        NUMBER(10)                               NOT NULL ,
  gory_title                 VARCHAR2(50)                            NOT NULL,
  gory_seqno              NUMBER(3)        DEFAULT 1         NOT NULL,
  gory_visible              CHAR(1)            DEFAULT 'Y'        NOT NULL,
  gory_ids                   VARCHAR2(100) DEFAULT 'admin' NOT NULL,
  cnt                   NUMBER(6)       DEFAULT 0          NOT NULL, 
  gory_rdate               DATE                 NOT NULL,
 */

public class CategoryVO {
  private int gory_no;
  private int grp_no;
  private String gory_title;
  private int gory_seqno;
  private String gory_visible;
  private String gory_ids;
  private int cnt;
  private String gory_rdate;
  private int mem_no;
  
  public int getGory_no() {
    return gory_no;
  }
  
  public void setGory_no(int gory_no) {
    this.gory_no = gory_no;
  }
  
  public int getGrp_no() {
    return grp_no;
  }
  
  public void setGrp_no(int grp_no) {
    this.grp_no = grp_no;
  }
  
  public String getGory_title() {
    return gory_title;
  }
  
  public void setGory_title(String gory_title) {
    this.gory_title = gory_title;
  }
  
  public int getGory_seqno() {
    return gory_seqno;
  }
  
  public void setGory_seqno(int gory_seqno) {
    this.gory_seqno = gory_seqno;
  }
  
  public String getGory_visible() {
    return gory_visible;
  }
  
  public void setGory_visible(String gory_visible) {
    this.gory_visible = gory_visible;
  }
  
  public String getGory_ids() {
    return gory_ids;
  }
  
  public void setGory_ids(String gory_ids) {
    this.gory_ids = gory_ids;
  }
  
  public int getCnt() {
    return cnt;
  }
  
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  
  public String getGory_rdate() {
    return gory_rdate;
  }
  
  public void setGory_rdate(String gory_rdate) {
    this.gory_rdate = gory_rdate;
  }
  
  public int getMem_no() {
    return mem_no;
  }
  
  public void setMem_no(int mem_no) {
    this.mem_no = mem_no;
  }
  
}