package dev.mvc.payment;

public class PaymentVO {

  /** ���� ��ȣ */
  private int pay_no;
  /** �ù�ŷ� ��ȣ */
  private int ship_no;
  /** ȸ����ȣ */
  private int mem_no;
  /** �����ݾ� */
  private String pay_amount;
  /** �������� */
  private String pay_way;
  /** ������ */
  private String pay_date;
  /** �����޸� */
  private String pay_memo;

  public int getPay_no() {
    return pay_no;
  }

  public void setPay_no(int pay_no) {
    this.pay_no = pay_no;
  }

  public int getShip_no() {
    return ship_no;
  }

  public void setShip_no(int ship_no) {
    this.ship_no = ship_no;
  }

  public int getMem_no() {
    return mem_no;
  }

  public void setMem_no(int mem_no) {
    this.mem_no = mem_no;
  }

  public String getPay_amount() {
    return pay_amount;
  }

  public void setPay_amount(String pay_amount) {
    this.pay_amount = pay_amount;
  }

  public String getPay_way() {
    return pay_way;
  }

  public void setPay_way(String pay_way) {
    this.pay_way = pay_way;
  }

  public String getPay_date() {
    return pay_date;
  }

  public void setPay_date(String pay_date) {
    this.pay_date = pay_date;
  }

  public String getPay_memo() {
    return pay_memo;
  }

  public void setPay_memo(String pay_memo) {
    this.pay_memo = pay_memo;
  }

}
