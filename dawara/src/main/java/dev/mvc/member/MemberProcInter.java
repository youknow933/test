package dev.mvc.member;

import java.util.HashMap;
import java.util.List;

public interface MemberProcInter {

  /**
   * 중복 아이디 검사 <xmp>
   * <select id="checkId" resultType="int" parameterType="String"> </xmp>
   * 
   * @param mem_id
   * @return 중복 아이디 갯수
   */
  public int checkId(String mem_id);

  /**
   * 회원 등록 <xmp> <insert id="create" parameterType="MemberVO"> MySQL insert SQL
   * 실행 </xmp>
   * 
   * @param memberVO
   * @return 등록된 회원수 1 or 0
   */
  public int create(MemberVO memberVO);

  /**
   * 회원 전체 목록
   * 
   * @return
   */
  public List<MemberVO> list();

  /**
   * 조회
   * 
   * @param mem_no
   * @return
   */
  public MemberVO read(int mem_no);

  /**
   * 조회
   * 
   * @param mem_id
   * @return
   */
  public MemberVO readById(String mem_id);

  /**
   * 변경
   * 
   * @param memberVO
   * @return
   */
  public int update(MemberVO memberVO);
  
  /**
   * 변경
   * 
   * @param memberVO
   * @return
   */
  public int update_admin(MemberVO memberVO);

  /**
   * 패스워드 변경
   * 
   * @param mem_no
   *          회원 번호
   * @param mem_pass
   *          변경할 패스워드 값
   * @return
   */
  public int passwd_update(int mem_no, String new_passwd);

  /**
   * 레코드 1건 삭제
   * 
   * @param mem_no
   *          삭제할 회원 번호
   * @return 삭제된 레코드 갯수
   */
  public int delete(int mem_no);

  /**
   * 로그인 처리
   * @param mem_id
   * @param mem_pass
   * @return
   */
  public int login(String mem_id, String mem_pass); 
  
  /**
   * 검색 목록
   * <xmp> 
   * <select id="list_by_member_search" resultType="MemberVO" parameterType="HashMap">
   * </xmp>
   * @param categoryno
   * @return
   */
  public List<MemberVO> list_by_member_search(HashMap hashMap);
 
  /**
   * category별 검색된 레코드 갯수
   * <xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   *  </xmp>
   * @return
   */
  public int search_count(HashMap hashMap);  
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @param mem_search 검색조건
   * @return 페이징 생성 문자열
   */ 
  public String paging(int search_count, int nowPage, String word, String mem_search); 
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @param mem_search 검색조건
   * @return 페이징 생성 문자열
   */ 
  public String login_paging(int search_count_login, int login_nowPage, String word, String mem_search); 
  
  /**
  로그인 정보 등록
  <xmp>
  <insert id="create_login" parameterType="MemberVO">
  MySQL insert SQL 실행
  </xmp>
  @param memberVO
  @return 등록된 회원수 1 or 0
  */
 public int create_login(HashMap hashMap); 
 
 /**
  * 로그인 전체 목록
  * @return
  */
 public List<MemberVO> list_by_login(int mem_no);
 
 /**
  * 로그인 전체 목록
  * @return
  */
 public List<MemberVO> list_by_login_admin();
 
 /**
  * 조회
  * 
  * @param mem_no
  * @return
  */
 public MemberVO read_by_login(int login_no);
 
 /**
  * 조회
  * 
  * @param mem_no
  * @return
  */
 public int delete_by_login(int login_no);
 
 /**
  * mem_no와 일치하는 login 컬럼 갯수 조회
  * @param mem_no 조회할 회원 번호
  * @return 조회된 레코드 갯수
  */
 public int select_login_member(int mem_no);
 
 /**
  * mem_no와 일치하는 login 컬럼 갯수 삭제
  * @param mem_no 삭제할 회원 번호
  * @return 삭제된 레코드 갯수
  */
 public int delete_login_member(int mem_no);
 
 /**
  * 검색 목록
  * <xmp> 
  * <select id="list_by_member_search" resultType="MemberVO" parameterType="HashMap">
  * </xmp>
  * @param categoryno
  * @return
  */
 public List<MemberVO> list_by_login_admin_search(HashMap hashMap);

 
 /**
  * category별 검색된 레코드 갯수
  * <xmp>
  * <select id="search_count" resultType="int" parameterType="HashMap">
  *  </xmp>
  * @return
  */
 public int search_count_login(HashMap hashMap);  
 
 //<select id="select_count_member" resultType="int" parameterType="int">
 public int select_count_member(int auth_no);

 //<select id="select_count_member" resultType="int" parameterType="int">
 public int select_count_login(int auth_no);
 
 //<select id="select_count_member" resultType="int" parameterType="int">
 public int delete_count_member(int auth_no);
 
 //<select id="select_count_member" resultType="int" parameterType="int">
 public int delete_count_login(int auth_no);
}
