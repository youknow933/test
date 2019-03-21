package dev.mvc.deal;

public class Member_Product_DealVO {
  private int deal_no; // 거래 번호
  private int pr_no; // 상품 번호

  private int buyer_no; // 구매자 번호
  private String buyer; // 구매자
  private int seller_no; // 판매자 번호
  private String seller; // 판매자

  private String pr_title; // 제목
  private String pr_word; // 검색어
  private int pr_price; // 상품 가격
  private String pr_rdate; // 상품등록일

  private String d_state; // 거래상태
  private String d_way; // 거래 방법
  private String d_check; // 거래 확인
  private String d_date; // 거래등록일

  public int getDeal_no() {
    return deal_no;
  }

  public void setDeal_no(int deal_no) {
    this.deal_no = deal_no;
  }

  public int getPr_no() {
    return pr_no;
  }

  public void setPr_no(int pr_no) {
    this.pr_no = pr_no;
  }

  public String getBuyer() {
    return buyer;
  }

  public void setBuyer(String buyer) {
    this.buyer = buyer;
  }

  public String getSeller() {
    return seller;
  }

  public void setSeller(String seller) {
    this.seller = seller;
  }

  public int getBuyer_no() {
    return buyer_no;
  }

  public void setBuyer_no(int buyer_no) {
    this.buyer_no = buyer_no;
  }

  public int getSeller_no() {
    return seller_no;
  }

  public void setSeller_no(int seller_no) {
    this.seller_no = seller_no;
  }

  public String getPr_title() {
    return pr_title;
  }

  public void setPr_title(String pr_title) {
    this.pr_title = pr_title;
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

  public String getPr_rdate() {
    return pr_rdate;
  }

  public void setPr_rdate(String pr_rdate) {
    this.pr_rdate = pr_rdate;
  }

  public String getD_state() {
    return d_state;
  }

  public void setD_state(String d_state) {
    this.d_state = d_state;
  }

  public String getD_way() {
    return d_way;
  }

  public void setD_way(String d_way) {
    this.d_way = d_way;
  }

  public String getD_check() {
    return d_check;
  }

  public void setD_check(String d_check) {
    this.d_check = d_check;
  }

  public String getD_date() {
    return d_date;
  }

  public void setD_date(String d_date) {
    this.d_date = d_date;
  }

}
