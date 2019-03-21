package dev.mvc.buy;

public class Product_BuyVO {
  
/*  SELECT b.buy_no, b.pr_no as buy_pr_no, b.mem_no, p.pr_title, p.pr_thumbs, p.pr_state, p.pr_price, p.pr_rdate,pr_transaction
  FROM buy b, product p
  WHERE  b.pr_no = p.pr_no and b.mem_no =#{mem_no}
  ORDER BY b.buy_no DESC*/
  
  //buy table
  private int buy_no;
  private int buy_pr_no;
  private int mem_no;
  
  //cart table
  private int pr_no;
  private String pr_title;
  private String pr_thumbs;
  private String pr_price;
  private String pr_rdate;
  private String pr_transaction;
  private String pr_state;
  public int getBuy_no() {
    return buy_no;
  }
  public void setBuy_no(int buy_no) {
    this.buy_no = buy_no;
  }
  public int getBuy_pr_no() {
    return buy_pr_no;
  }
  public void setBuy_pr_no(int buy_pr_no) {
    this.buy_pr_no = buy_pr_no;
  }
  public int getMem_no() {
    return mem_no;
  }
  public void setMem_no(int mem_no) {
    this.mem_no = mem_no;
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
  public String getPr_thumbs() {
    return pr_thumbs;
  }
  public void setPr_thumbs(String pr_thumbs) {
    this.pr_thumbs = pr_thumbs;
  }
  public String getPr_price() {
    return pr_price;
  }
  public void setPr_price(String pr_price) {
    this.pr_price = pr_price;
  }
  public String getPr_rdate() {
    return pr_rdate;
  }
  public void setPr_rdate(String pr_rdate) {
    this.pr_rdate = pr_rdate;
  }
  public String getPr_transaction() {
    return pr_transaction;
  }
  public void setPr_transaction(String pr_transaction) {
    this.pr_transaction = pr_transaction;
  }
  public String getPr_state() {
    return pr_state;
  }
  public void setPr_state(String pr_state) {
    this.pr_state = pr_state;
  }

}
