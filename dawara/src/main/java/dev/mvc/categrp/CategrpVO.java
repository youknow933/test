package dev.mvc.categrp;

public class CategrpVO {
  /** 카테고리 이름 */
  private String grp_title;
  /** 카테고리 번호 */
  private int grp_no;
  /** 카테고리 그룹 분류 */
  private int grp_classification;
  /** 출력 순서 */
  private int grp_seqno;
  /** 출력 모드 */
  private String grp_visible;
  /** 등록일 */
  private String grp_rdate;
  
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
  
  public int getGrp_classification() {
    return grp_classification;
  }
  
  public void setGrp_classification(int grp_classification) {
    this.grp_classification = grp_classification;
  }
  
  public int getGrp_seqno() {
    return grp_seqno;
  }
  
  public void setGrp_seqno(int grp_seqno) {
    this.grp_seqno = grp_seqno;
  }
  
  public String getGrp_visible() {
    return grp_visible;
  }
  
  public void setGrp_visible(String grp_visible) {
    this.grp_visible = grp_visible;
  }
  
  public String getGrp_rdate() {
    return grp_rdate;
  }
  
  public void setGrp_rdate(String grp_rdate) {
    this.grp_rdate = grp_rdate;
  }
  
}
