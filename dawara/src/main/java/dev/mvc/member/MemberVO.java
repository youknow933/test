package dev.mvc.member;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
  /*
  CREATE TABLE member (
  mem_no       NUMBER(6) NOT NULL     PRIMARY KEY, -- 회원 번호, 레코드를 구분하는 컬럼 
  mem_id           VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
  mem_pic       VARCHAR(100)    NULL,     -- 회원사진
  mem_size       NUMBER(10)    NULL,     -- 회원사진 크기
  mem_pass    VARCHAR(60)   NOT NULL, -- 패스워드, 영숫자 조합
  mem_name    VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
  mem_tel          VARCHAR(14)   NOT NULL, -- 전화번호
  mem_mail      VARCHAR(20)     NOT NULL, -- 이메일
  mem_auth      VARCHAR(20)     NOT NULL, -- 이메일 인증키
  mem_job         VARCHAR(20)     NOT NULL, -- 회원직업
  mem_sex         VARCHAR(10)     NOT NULL, -- 회원성별
  mem_zipcode   VARCHAR(5)        NULL, -- 우편번호, 12345
  mem_addr1  VARCHAR(100)       NULL, -- 주소 1
  mem_addr2  VARCHAR(80)       NULL, -- 주소 2    
  mem_acc   NUMBER(6)   DEFAULT 0 NOT NULL,   -- 회원의 신고당한횟수
  mem_mile   NUMBER(9)   DEFAULT 0 NOT NULL,   -- 회원 마일리지(구매용)
  mem_confirm    VARCHAR(1)         DEFAULT 'N' NOT NULL, -- 이메일 링크 클릭 여부, Y:클릭, N:클릭안함
  auth_no   NUMBER(6) DEFAULT 3 NOT NULL, -- 회원 권한 번호
  mem_date     DATE             NOT NULL, -- 가입일    
  FOREIGN KEY (AUTH_NO) REFERENCES AUTH(AUTH_NO)
);
  */

  /** 회원 번호 */
  private int mem_no;
  /** 아이디 */
  private String mem_id = "";
  /** 회원사진 */
  private String mem_pic = "";
  /** 회원사진 크기*/
  private long mem_size = 0;
  /** 패스워드 */
  private String mem_pass = "";
  /** 회원 성명 */
  private String mem_name = "";
  /** 전화 번호 */
  private String mem_tel = "";
  /** 회원 메일 */
  private String mem_mail = "";
  /** 메일 인증키 */
  private String mem_auth = "";
  /** 회원 직업 */
  private String mem_job = "";
  /** 회원 성별 */
  private String mem_sex = "";
  /** 우편 번호 */
  private String mem_zipcode = "";
  /** 주소 1 */
  private String mem_addr1 = "";
  /** 주소 2 */
  private String mem_addr2 = "";
  /** 신고횟수 */
  private int mem_acc;
  /** 마일리지 */
  private int mem_mile;
  /** 이메일 확인 */
  private String mem_confirm = "";
  /** 권한 번호 */
  private int auth_no;
  /** 가입일 */
  private String mem_date = "";
  
  /** 등록된 패스워드 */
  private String old_passwd = "";
  /** id 저장 여부 */
  private String id_save = "";
  /** passwd 저장 여부 */
  private String passwd_save = "";
  /** 이동할 주소 저장 */
  private String url_address = "";
  
  /** 로그인 테이블 번호 */
  private int login_no;
  /** 로그인 ip */
  private String login_ip = ""; 
  /** 로그인 날짜 */
  private String login_date = "";
  /** 로그인 접속경로 */
  private String login_refer = "";
  /** 로그인 브라우저 정보*/
  private String login_agent = "";


  /** 
  Spring Framework에서 자동 주입되는 업로드 파일 객체,
  DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
   */  
  private MultipartFile file1MF;
  
  public int getMem_no() {
    return mem_no;
  }

  public void setMem_no(int mem_no) {
    this.mem_no = mem_no;
  }

  public String getMem_id() {
    return mem_id;
  }

  public void setMem_id(String mem_id) {
    this.mem_id = mem_id;
  }

  public String getMem_pic() {
    return mem_pic;
  }

  public void setMem_pic(String mem_pic) {
    this.mem_pic = mem_pic;
  }

  public String getMem_pass() {
    return mem_pass;
  }

  public void setMem_pass(String mem_pass) {
    this.mem_pass = mem_pass;
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

  public String getMem_job() {
    return mem_job;
  }

  public void setMem_job(String mem_job) {
    this.mem_job = mem_job;
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

  public int getMem_acc() {
    return mem_acc;
  }

  public void setMem_acc(int mem_acc) {
    this.mem_acc = mem_acc;
  }

  public int getMem_mile() {
    return mem_mile;
  }

  public void setMem_mile(int mem_mile) {
    this.mem_mile = mem_mile;
  }

  public String getMem_confirm() {
    return mem_confirm;
  }

  public void setMem_confirm(String mem_confirm) {
    this.mem_confirm = mem_confirm;
  }

  public int getAuth_no() {
    return auth_no;
  }

  public void setAuth_no(int auth_no) {
    this.auth_no = auth_no;
  }

  public String getMem_date() {
    return mem_date;
  }

  public void setMem_date(String mem_date) {
    this.mem_date = mem_date;
  }

  public String getOld_passwd() {
    return old_passwd;
  }

  public void setOld_passwd(String old_passwd) {
    this.old_passwd = old_passwd;
  }

  public String getId_save() {
    return id_save;
  }

  public void setId_save(String id_save) {
    this.id_save = id_save;
  }

  public String getPasswd_save() {
    return passwd_save;
  }

  public void setPasswd_save(String passwd_save) {
    this.passwd_save = passwd_save;
  }

  public String getUrl_address() {
    return url_address;
  }

  public void setUrl_address(String url_address) {
    this.url_address = url_address;
  }

  public long getMem_size() {
    return mem_size;
  }

  public void setMem_size(long mem_size) {
    this.mem_size = mem_size;
  }

  public String getMem_auth() {
    return mem_auth;
  }

  public void setMem_auth(String mem_auth) {
    this.mem_auth = mem_auth;
  }

  public String getMem_sex() {
    return mem_sex;
  }

  public void setMem_sex(String mem_sex) {
    this.mem_sex = mem_sex;
  }

  public MultipartFile getFile1MF() {
    return file1MF;
  }

  public void setFile1MF(MultipartFile file1mf) {
    file1MF = file1mf;
  }

  public int getLogin_no() {
    return login_no;
  }

  public void setLogin_no(int login_no) {
    this.login_no = login_no;
  }

  public String getLogin_ip() {
    return login_ip;
  }

  public void setLogin_ip(String login_ip) {
    this.login_ip = login_ip;
  }

  public String getLogin_date() {
    return login_date;
  }

  public void setLogin_date(String login_date) {
    this.login_date = login_date;
  } 
  public String getLogin_refer() {
    return login_refer;
  }
  
  public void setLogin_refer(String login_refer) {
    this.login_refer = login_refer;
  }
  
  public String getLogin_agent() {
    return login_agent;
  }
  
  public void setLogin_agent(String login_agent) {
    this.login_agent = login_agent;
  }
}
 