package dev.mvc.cart;

public class CartVO {
  
/*  CREATE TABLE CART (
      cart_no      NUMBER(6)    NOT NULL PRIMARY KEY,
      pr_no         NUMBER(7)        NULL ,
      mem_no                  NUMBER(6)        NULL ,
FOREIGN KEY (pr_no) REFERENCES product (pr_no),
FOREIGN KEY (mem_no) REFERENCES member (mem_no)
);*/
  /** ��ٱ��� ��ȣ*/
  private int cart_no;
  /** ��ǰ ��ȣ*/
  private int pr_no;
  /** ȸ�� ��ȣ*/
  private int mem_no;
  
  public CartVO() {
    super();
  }

  public int getCart_no() {
    return cart_no;
  }

  public void setCart_no(int cart_no) {
    this.cart_no = cart_no;
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


