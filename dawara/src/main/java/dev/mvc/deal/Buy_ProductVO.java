package dev.mvc.deal;

public class Buy_ProductVO {
  
  private int pr_no; // 구매번호
  private int buy_no; // 구매번호
  private String pr_title; // 주문자명
  private int pr_price; // 주문자 연락처
  
  public int getBuy_no() {
    return buy_no;
  }
  
  public void setBuy_no(int buy_no) {
    this.buy_no = buy_no;
  }
  
  public int getPr_no() {
    return pr_no;
  }
  
  public void setPr_no(int pr_no) {
    this.pr_no = pr_no;
  }
  
  public String getPr_title() {
    return pr_title;
  }
  
  public void setPr_title(String pr_title) {
    this.pr_title = pr_title;
  }
  
  public int getPr_price() {
    return pr_price;
  }
  
  public void setPr_price(int pr_price) {
    this.pr_price = pr_price;
  }
  
}
