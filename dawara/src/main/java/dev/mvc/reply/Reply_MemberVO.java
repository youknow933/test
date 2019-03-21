package dev.mvc.reply;

public class Reply_MemberVO {
/*  SELECT r.rpl_no, r.pr_no, r.mem_no, r.rpl_contents, r.rpl_rdate, r.rpl_visible,  
  r.rpl_grpno, r.rpl_indent, r.rpl_ansnum, m.mem_id
 FROM reply r, member m
  WHERE r.mem_no= m.mem_no AND pr_no=#{pr_no}
    ORDER BY rpl_grpno DESC, rpl_ansnum*/
  
  //Reply table
  private String rpl_no;
  private int pr_no;
  private int rpl_mem_no;
  private String rpl_contents;
  private String rpl_rdate;
  private String rpl_visible;
  private String rpl_grpno;
  private String rpl_indent;
  private String rpl_ansnum;
  
  // member table
  private int mem_no;
  private String mem_id;
  
  public String getRpl_no() {
    return rpl_no;
  }
  public void setRpl_no(String rpl_no) {
    this.rpl_no = rpl_no;
  }

  public int getPr_no() {
    return pr_no;
  }
  public void setPr_no(int pr_no) {
    this.pr_no = pr_no;
  }
  public int getRpl_mem_no() {
    return rpl_mem_no;
  }
  public void setRpl_mem_no(int rpl_mem_no) {
    this.rpl_mem_no = rpl_mem_no;
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
  public String getRpl_grpno() {
    return rpl_grpno;
  }
  public void setRpl_grpno(String rpl_grpno) {
    this.rpl_grpno = rpl_grpno;
  }
  public String getRpl_indent() {
    return rpl_indent;
  }
  public void setRpl_indent(String rpl_indent) {
    this.rpl_indent = rpl_indent;
  }
  public String getRpl_ansnum() {
    return rpl_ansnum;
  }
  public void setRpl_ansnum(String rpl_ansnum) {
    this.rpl_ansnum = rpl_ansnum;
  }
  public int getMem_no() {
    return mem_no;
  }
  public void setMem_no(int mem_no) {
    this.mem_no = mem_no;
  }
  public String getMem_id() {
    return mem_id;
  }
  public void setMem_id(String mem_id) {
    this.mem_id = mem_id;
  }

}
