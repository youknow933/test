package dev.mvc.category;

public class Categrp_CategoryVO {
  // categrp table
  private String grp_title;
  private int grp_no;
  private int grp_seqno;
  
  // category table
  private int gory_no;
  private String gory_title;
  private int gory_seqno; // JOIN 시만 사용, seqno 컬럼과 대응
  private String gory_visible;
  private String gory_ids;
  private int cnt;
  private String gory_rdate;
  
  
  public String getGrp_title() {
    return grp_title;
  }
  public void setGrp_title(String grp_title) {
    this.grp_title = grp_title;
  }
  public int getGrp_no() {
    return grp_no;
  }
  public void setGrp_no(int grp_no) {
    this.grp_no = grp_no;
  }
  public int getGrp_seqno() {
    return grp_seqno;
  }
  public void setGrp_seqno(int grp_seqno) {
    this.grp_seqno = grp_seqno;
  }
  public int getGory_no() {
    return gory_no;
  }
  public void setGory_no(int gory_no) {
    this.gory_no = gory_no;
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
  
  
  
  
}
