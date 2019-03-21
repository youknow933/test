package dev.mvc.shipping;

public class ShippingVO {

  /** 배송번호 */
  private int ship_no;
  /** 받는사람 */
  private String ship_rname;
  /** 받는사람 휴대폰 */
  private String ship_rtel;
  /** 우편번호 */
  private String ship_zipcode;
  /** 배송지1 */
  private String ship_addr1;
  /** 배송지2 */
  private String ship_addr2;
  /** 배송시 요청사항 */
  private String ship_memo;
  /** 배송날짜 */
  private String ship_date;
  /** 배송확인 */
  private String ship_check;
  /** 상품번호 */
  private int pr_no;
  /** 회원번호 */
  private int mem_no;

  public int getShip_no() {
    return ship_no;
  }

  public void setShip_no(int ship_no) {
    this.ship_no = ship_no;
  }

  public String getShip_zipcode() {
    return ship_zipcode;
  }

  public void setShip_zipcode(String ship_zipcode) {
    this.ship_zipcode = ship_zipcode;
  }

  public String getShip_addr1() {
    return ship_addr1;
  }

  public void setShip_addr1(String ship_addr1) {
    this.ship_addr1 = ship_addr1;
  }

  public String getShip_addr2() {
    return ship_addr2;
  }

  public void setShip_addr2(String ship_addr2) {
    this.ship_addr2 = ship_addr2;
  }

  public String getShip_rname() {
    return ship_rname;
  }

  public void setShip_rname(String ship_rname) {
    this.ship_rname = ship_rname;
  }

  public String getShip_rtel() {
    return ship_rtel;
  }

  public void setShip_rtel(String ship_rtel) {
    this.ship_rtel = ship_rtel;
  }

  public String getShip_memo() {
    return ship_memo;
  }

  public void setShip_memo(String ship_memo) {
    this.ship_memo = ship_memo;
  }

  public String getShip_date() {
    return ship_date;
  }

  public void setShip_date(String ship_date) {
    this.ship_date = ship_date;
  }

  public String getShip_check() {
    return ship_check;
  }

  public void setShip_check(String ship_check) {
    this.ship_check = ship_check;
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

}
