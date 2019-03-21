package dev.mvc.deal;

public class Deal_MemberVO {
  
  private int pr_no; // 상품번호
  private int gory_no; // 카테고리번호
  private int mem_no; // 회원번호
  private String pr_title; // 상품
  private String pr_price; // 판매가격
  
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
  
  public String getPr_price() {
    return pr_price;
  }
  
  public void setPr_price(String pr_price) {
    this.pr_price = pr_price;
  }
  
}
