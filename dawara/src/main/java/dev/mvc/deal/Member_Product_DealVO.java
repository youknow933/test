package dev.mvc.deal;

public class Member_Product_DealVO {
  private int deal_no; // �ŷ� ��ȣ
  private int pr_no; // ��ǰ ��ȣ

  private int buyer_no; // ������ ��ȣ
  private String buyer; // ������
  private int seller_no; // �Ǹ��� ��ȣ
  private String seller; // �Ǹ���

  private String pr_title; // ����
  private String pr_word; // �˻���
  private int pr_price; // ��ǰ ����
  private String pr_rdate; // ��ǰ�����

  private String d_state; // �ŷ�����
  private String d_way; // �ŷ� ���
  private String d_check; // �ŷ� Ȯ��
  private String d_date; // �ŷ������

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
