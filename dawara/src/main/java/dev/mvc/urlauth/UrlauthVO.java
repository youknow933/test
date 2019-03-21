package dev.mvc.urlauth;

public class UrlauthVO {
  /*CREATE TABLE urlauth(
    urlauth_no                         NUMBER(10)     NOT NULL    PRIMARY KEY,
    urlauth_address                 VARCHAR2(200)    NOT NULL,
    urlauth_seqno                    NUMBER(10)         NOT NULL,
    urlauth_etc                        VARCHAR2(100)     NULL, 
    auth_no                            NUMBER(10)     NOT NULL,
    FOREIGN KEY (auth_no) REFERENCES AUTH (auth_no)
  );

  COMMENT ON TABLE urlauth is '권한별 접근 URL';
  COMMENT ON COLUMN urlauth.urlauth_no is '권한별 접근 URL 번호';
  COMMENT ON COLUMN urlauth.urlauth_address is '권한별 접근 URL 주소';
  COMMENT ON COLUMN urlauth.auth_no is '권한 번호';*/
  
  /** 권한별 접근 URL 번호 **/
  private int urlauth_no = 0;
  /** 권한별 접근 URL 주소 **/
  private String urlauth_address = "";
  /** 권한 번호 **/
  private int auth_no = 0;
  
  public UrlauthVO() {
    
  }

  public UrlauthVO(int urlauth_no, int auth_no, String urlauth_address) {
    this.urlauth_no = urlauth_no;
    this.urlauth_address = urlauth_address;
    this.auth_no = auth_no;
  }

  /**
   * @return the urlauth_no
   */
  public int getUrlauth_no() {
    return urlauth_no;
  }

  /**
   * @param urlauth_no the urlauth_no to set
   */
  public void setUrlauth_no(int urlauth_no) {
    this.urlauth_no = urlauth_no;
  }

  /**
   * @return the auth_no
   */
  public int getAuth_no() {
    return auth_no;
  }

  /**
   * @param auth_no the auth_no to set
   */
  public void setAuth_no(int auth_no) {
    this.auth_no = auth_no;
  }

  /**
   * @return the urlauth_address
   */
  public String getUrlauth_address() {
    return urlauth_address;
  }

  /**
   * @param urlauth_address the urlauth_address to set
   */
  public void setUrlauth_address(String urlauth_address) {
    this.urlauth_address = urlauth_address;
  }
  
  
}
