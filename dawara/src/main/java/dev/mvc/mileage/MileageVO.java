package dev.mvc.mileage;

public class MileageVO {
    /**  ���ϸ��� ��ȣ */
    private int mileage_no;
    
    /**  ��� ��ȣ */
    private int mem_no;
    
    /** ���� ��� */
    private String cway; 
    
    /** ���� ��ȣ */
    private int cway_no; 
    
    /** ���� �ݾ� */
    private int char_m;
    
    /** �� ���ϸ��� */
    private int mymileage;
    
    /** ����� */
    private String cmileage_date;

public int getMileage_no() {
  return mileage_no;
}

public void setMileage_no(int mileage_no) {
  this.mileage_no = mileage_no;
}

public int getMem_no() {
  return mem_no;
}

public void setMem_no(int mem_no) {
  this.mem_no = mem_no;
}

public String getCway() {
  return cway;
}

public void setCway(String cway) {
  this.cway = cway;
}

public int getCway_no() {
  return cway_no;
}

public void setCway_no(int cway_no) {
  this.cway_no = cway_no;
}

public int getChar_m() {
  return char_m;
}

public void setChar_m(int char_m) {
  this.char_m = char_m;
}

public int getMymileage() {
  return mymileage;
}

public void setMymileage(int mymileage) {
  this.mymileage = mymileage;
}

public String getCmileage_date() {
  return cmileage_date;
}

public void setCmileage_date(String cmileage_date) {
  this.cmileage_date = cmileage_date;
  }
}