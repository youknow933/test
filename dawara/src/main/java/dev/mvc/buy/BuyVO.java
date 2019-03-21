package dev.mvc.buy;

public class BuyVO {
  
 /* CREATE TABLE buy (
      buy_no      NUMBER(6)    NOT NULL PRIMARY KEY,
      pr_no         NUMBER(7)        NULL ,
      mem_no                  NUMBER(6)        NULL ,
      payment_no                  NUMBER(6)        NULL ,
      buy_rdate       DATE        NOT NULL, 
      buy_visible                 CHAR(1)            DEFAULT 'Y'      NOT NULL,     
      FOREIGN KEY (pr_no) REFERENCES product (pr_no),
      FOREIGN KEY (mem_no) REFERENCES member (mem_no),
      FOREIGN KEY (payment_no) REFERENCES payment (payment_no)
);
*/
  
  private int buy_no; // 구매 번호
  private int pr_no; // 상품 번호
  private int mem_no; // 회원 번호
  private int pay_no; // 결재 번호
  private String buy_rdate; // 거래 날짜
  private String buy_visible; // VISIBLE
  
  public BuyVO() {
  }

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

  public int getMem_no() {
    return mem_no;
  }

  public void setMem_no(int mem_no) {
    this.mem_no = mem_no;
  }

  public int getPay_no() {
    return pay_no;
  }

  public void setPay_no(int pay_no) {
    this.pay_no = pay_no;
  }

  public String getBuy_rdate() {
    return buy_rdate;
  }

  public void setBuy_rdate(String buy_rdate) {
    this.buy_rdate = buy_rdate;
  }

  public String getBuy_visible() {
    return buy_visible;
  }

  public void setBuy_visible(String buy_visible) {
    this.buy_visible = buy_visible;
  }
 
}
