package dev.mvc.member;

import java.util.HashMap;
import java.util.List;

public interface MemberProcInter {

  /**
   * �ߺ� ���̵� �˻� <xmp>
   * <select id="checkId" resultType="int" parameterType="String"> </xmp>
   * 
   * @param mem_id
   * @return �ߺ� ���̵� ����
   */
  public int checkId(String mem_id);

  /**
   * ȸ�� ��� <xmp> <insert id="create" parameterType="MemberVO"> MySQL insert SQL
   * ���� </xmp>
   * 
   * @param memberVO
   * @return ��ϵ� ȸ���� 1 or 0
   */
  public int create(MemberVO memberVO);

  /**
   * ȸ�� ��ü ���
   * 
   * @return
   */
  public List<MemberVO> list();

  /**
   * ��ȸ
   * 
   * @param mem_no
   * @return
   */
  public MemberVO read(int mem_no);

  /**
   * ��ȸ
   * 
   * @param mem_id
   * @return
   */
  public MemberVO readById(String mem_id);

  /**
   * ����
   * 
   * @param memberVO
   * @return
   */
  public int update(MemberVO memberVO);
  
  /**
   * ����
   * 
   * @param memberVO
   * @return
   */
  public int update_admin(MemberVO memberVO);

  /**
   * �н����� ����
   * 
   * @param mem_no
   *          ȸ�� ��ȣ
   * @param mem_pass
   *          ������ �н����� ��
   * @return
   */
  public int passwd_update(int mem_no, String new_passwd);

  /**
   * ���ڵ� 1�� ����
   * 
   * @param mem_no
   *          ������ ȸ�� ��ȣ
   * @return ������ ���ڵ� ����
   */
  public int delete(int mem_no);

  /**
   * �α��� ó��
   * @param mem_id
   * @param mem_pass
   * @return
   */
  public int login(String mem_id, String mem_pass); 
  
  /**
   * �˻� ���
   * <xmp> 
   * <select id="list_by_member_search" resultType="MemberVO" parameterType="HashMap">
   * </xmp>
   * @param categoryno
   * @return
   */
  public List<MemberVO> list_by_member_search(HashMap hashMap);
 
  /**
   * category�� �˻��� ���ڵ� ����
   * <xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   *  </xmp>
   * @return
   */
  public int search_count(HashMap hashMap);  
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @param mem_search �˻�����
   * @return ����¡ ���� ���ڿ�
   */ 
  public String paging(int search_count, int nowPage, String word, String mem_search); 
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @param mem_search �˻�����
   * @return ����¡ ���� ���ڿ�
   */ 
  public String login_paging(int search_count_login, int login_nowPage, String word, String mem_search); 
  
  /**
  �α��� ���� ���
  <xmp>
  <insert id="create_login" parameterType="MemberVO">
  MySQL insert SQL ����
  </xmp>
  @param memberVO
  @return ��ϵ� ȸ���� 1 or 0
  */
 public int create_login(HashMap hashMap); 
 
 /**
  * �α��� ��ü ���
  * @return
  */
 public List<MemberVO> list_by_login(int mem_no);
 
 /**
  * �α��� ��ü ���
  * @return
  */
 public List<MemberVO> list_by_login_admin();
 
 /**
  * ��ȸ
  * 
  * @param mem_no
  * @return
  */
 public MemberVO read_by_login(int login_no);
 
 /**
  * ��ȸ
  * 
  * @param mem_no
  * @return
  */
 public int delete_by_login(int login_no);
 
 /**
  * mem_no�� ��ġ�ϴ� login �÷� ���� ��ȸ
  * @param mem_no ��ȸ�� ȸ�� ��ȣ
  * @return ��ȸ�� ���ڵ� ����
  */
 public int select_login_member(int mem_no);
 
 /**
  * mem_no�� ��ġ�ϴ� login �÷� ���� ����
  * @param mem_no ������ ȸ�� ��ȣ
  * @return ������ ���ڵ� ����
  */
 public int delete_login_member(int mem_no);
 
 /**
  * �˻� ���
  * <xmp> 
  * <select id="list_by_member_search" resultType="MemberVO" parameterType="HashMap">
  * </xmp>
  * @param categoryno
  * @return
  */
 public List<MemberVO> list_by_login_admin_search(HashMap hashMap);

 
 /**
  * category�� �˻��� ���ڵ� ����
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