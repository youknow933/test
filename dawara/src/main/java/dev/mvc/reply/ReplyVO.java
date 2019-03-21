package dev.mvc.reply;

public class ReplyVO {
  
  /** 답변 번호 */
  private int rpl_no;
  /** 상품 번호*/
  private int pr_no;
  /** 멤버 번호*/
  private int mem_no;
  /** 내용*/
  private String rpl_contents;
  /** 댓글 시간*/
  private String rpl_rdate;
  /** 댓글 visible*/
  private String rpl_visible;
  /** 댓글 그룹 번호*/
  private int rpl_grpno;
  /** 답변 차수*/
  private int rpl_indent;
  /** 답변 순서*/
  private int rpl_ansnum;
  
  public ReplyVO() {
    
  }
  
  public int getRpl_no() {
    return rpl_no;
  }
  public void setRpl_no(int rpl_no) {
    this.rpl_no = rpl_no;
  }
  public int getPr_no() {
    return pr_no;
  }
  public void setPr_no(int pr_no) {
    this.pr_no = pr_no;
  }
  public int getMem_no() {
    return mem_no;
  }
  public void setMem_no(int mem_no) {
    this.mem_no = mem_no;
  }
  public String getRpl_contents() {
    return rpl_contents;
  }
  public void setRpl_contents(String rpl_contents) {
    this.rpl_contents = rpl_contents;
  }
  public String getRpl_rdate() {
    return rpl_rdate;
  }
  public void setRpl_rdate(String rpl_rdate) {
    this.rpl_rdate = rpl_rdate;
  }
  public String getRpl_visible() {
    return rpl_visible;
  }
  public void setRpl_visible(String rpl_visible) {
    this.rpl_visible = rpl_visible;
  }
  public int getRpl_grpno() {
    return rpl_grpno;
  }
  public void setRpl_grpno(int rpl_grpno) {
    this.rpl_grpno = rpl_grpno;
  }
  public int getRpl_indent() {
    return rpl_indent;
  }
  public void setRpl_indent(int rpl_indent) {
    this.rpl_indent = rpl_indent;
  }
  public int getRpl_ansnum() {
    return rpl_ansnum;
  }
  public void setRpl_ansnum(int rpl_ansnum) {
    this.rpl_ansnum = rpl_ansnum;
  }
  
  

}
