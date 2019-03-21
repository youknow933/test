package dev.mvc.mileage;

public class MileageVO {
    /**  마일리지 번호 */
    private int mileage_no;
    
    /**  멤버 번호 */
    private int mem_no;
    
    /** 충전 방법 */
    private String cway; 
    
    /** 충전 번호 */
    private int cway_no; 
    
    /** 충전 금액 */
    private int char_m;
    
    /** 내 마일리지 */
    private int mymileage;
    
    /** 등록일 */
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