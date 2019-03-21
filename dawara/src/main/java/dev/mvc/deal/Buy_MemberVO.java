package dev.mvc.deal;

public class Buy_MemberVO {
  
  private int buy_no; // 구매번호
  private int mem_no; // 구매번호
  private String mem_name; // 주문자명
  private String mem_tel; // 주문자 연락처
  private String mem_mail; // 주문자 이메일
  private String mem_zipcode; // 주문자 우편번호
  private String mem_addr1; // 주문자 주소
  private String mem_addr2; // 주문자 상세주소
  
  public int getBuy_no() {
    return buy_no;
  }
  
  public void setBuy_no(int buy_no) {
    this.buy_no = buy_no;
  }
  
  public int getMem_no() {
    return mem_no;
  }
  
  public void setMem_no(int mem_no) {
    this.mem_no = mem_no;
  }
  
  public String getMem_name() {
    return mem_name;
  }
  
  public void setMem_name(String mem_name) {
    this.mem_name = mem_name;
  }
  
  public String getMem_tel() {
    return mem_tel;
  }
  
  public void setMem_tel(String mem_tel) {
    this.mem_tel = mem_tel;
  }
  
  public String getMem_mail() {
    return mem_mail;
  }
  
  public void setMem_mail(String mem_mail) {
    this.mem_mail = mem_mail;
  }
  
  public String getMem_zipcode() {
    return mem_zipcode;
  }
  
  public void setMem_zipcode(String mem_zipcode) {
    this.mem_zipcode = mem_zipcode;
  }
  
  public String getMem_addr1() {
    return mem_addr1;
  }
  
  public void setMem_addr1(String mem_addr1) {
    this.mem_addr1 = mem_addr1;
  }
  
  public String getMem_addr2() {
    return mem_addr2;
  }
  
  public void setMem_addr2(String mem_addr2) {
    this.mem_addr2 = mem_addr2;
  }
  
}
