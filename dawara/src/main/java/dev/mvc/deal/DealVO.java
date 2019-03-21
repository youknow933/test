package dev.mvc.deal;

public class DealVO {

  private int deal_no; // 거래번호
  private String d_state; // 거래 상태
  private String d_way; // 거래 방법
  private String d_check; // 거래 확인
  private String d_date; // 거래등록일
  private String d_memo; // 거래등록일
  private int mem_no; // 구매번호
  private int pr_no; // 상품번호

  public int getDeal_no() {
    return deal_no;
  }

  public void setDeal_no(int deal_no) {
    this.deal_no = deal_no;
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

  public String getD_memo() {
    return d_memo;
  }

  public void setD_memo(String d_memo) {
    this.d_memo = d_memo;
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

}
