package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MemberDAOInter {
  /**
   * 중복 아이디 검사
   * <xmp>
   * <select id="checkId" resultType="int" parameterType="String">
   * </xmp> 
   * @param mem_id
   * @return 중복 아이디 갯수
   */
  public int checkId(String mem_id);
  
  /**
  회원 등록
  <xmp>
  <insert id="create" parameterType="MemberVO">
  MySQL insert SQL 실행
  </xmp>
  @param memberVO
  @return 등록된 회원수 1 or 0
  */
 public int create(MemberVO memberVO);   
 
 /**
  * 회원 전체 목록
  * @return
  */
 public List<MemberVO> list();
 
 /**
  * 조회
  * @param mem_no
  * @return
  */
 public MemberVO read(int mem_no);
 
 /**
  * 조회
  * @param mem_id
  * @return
  */
 public MemberVO readById(String mem_id);
 
 /**
  * 변경
  * @param memberVO
  * @return
  */
 public int update(MemberVO memberVO);
 
 /**
  * 변경
  * @param memberVO
  * @return
  */
 public int update_admin(MemberVO memberVO);

 /**
  * 패스워드 변경 
  * @param map
  * @return
  */
 public int passwd_update(Map<String, Object> map);
 
 /**
  * 레코드 1건 삭제
  * @param mno 삭제할 회원 번호
  * @return 삭제된 레코드 갯수
  */
 public int delete(int mem_no);
 
 /**
  * 로그인
  * 
  * @param map
  * @return
  */
 public int login(Map<String, Object> map);
 
 /**
  * 검색 목록
  * <xmp> 
  * <select id="list_by_member_search" resultType="ContentsVO" parameterType="HashMap">
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
 로그인 정보 등록
 <xmp>
 <insert id="create_login" parameterType="MemberVO">
 MySQL insert SQL 실행
 </xmp>
 @param map
 @return 등록된 회원수 1 or 0
 */
 public int create_login(HashMap hashMap); 
 
 /**
  * 나의 로그인 목록
  * @return
  */
 public List<MemberVO> list_by_login(int mem_no); 
 
 /**
  * 로그인 전체 목록
  * @return
  */
 public List<MemberVO> list_by_login_admin();
 
 /**
  * 읽기
  * @param login_no
  * @return
  */
 public MemberVO read_by_login(int login_no);
 
 /**
  * 레코드 1건 삭제
  * @param login_no 삭제할 회원 번호
  * @return 삭제된 레코드 갯수
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
  * <select id="list_by_member_search" resultType="ContentsVO" parameterType="HashMap">
  * </xmp>
  * @param categoryno
  * @return
  */
 public List<MemberVO> list_by_login_admin_search(HashMap hashMap);
 
 /**
  * category별 검색된 레코드 갯수
  * <xmp>
  * <select id="search_count_login" resultType="int" parameterType="HashMap">
  *  </xmp>
  * @return
  */
 public int search_count_login(HashMap hashMap); 
 
 //<select id="select_count_member" resultType="int" parameterType="int">
 public int select_count_member(int auth_no);
 
 //<select id="select_count_member" resultType="int" parameterType="int">
 public int select_count_login(int auth_no);
 
 //<select id="delete_count_member" resultType="int" parameterType="int">
 public int delete_count_member(int auth_no);
 
 //<select id="delete_count_login" resultType="int" parameterType="int">
 public int delete_count_login(int auth_no);
}




