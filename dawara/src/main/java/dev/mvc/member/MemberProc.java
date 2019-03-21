package dev.mvc.member;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import nation.web.tool.Tool;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.member.MemberProc")
public class MemberProc implements MemberProcInter {
  @Autowired
  @Qualifier("dev.mvc.member.MemberDAO")
  private MemberDAOInter memberDAO;
  
  public MemberProc(){
    System.out.println("--> MemberProc created.");
  }
  
  @Override
  public int checkId(String mem_id) {
    int count = memberDAO.checkId(mem_id); 
    return count;
  }

  @Override
  public int create(MemberVO memberVO) {
    int count = 0;
    count = memberDAO.create(memberVO);
    return count;
  }
  
  @Override
  public List<MemberVO> list() {
    List<MemberVO> list = memberDAO.list();
      
    return list;
  }
  
  @Override
  public MemberVO read(int mem_no) {
    MemberVO memberVO = memberDAO.read(mem_no);
    
    return memberVO;
  }

  @Override
  public MemberVO readById(String mem_id) {
    MemberVO memberVO = memberDAO.readById(mem_id);
    
    return memberVO;
  }
 
  @Override
  public int update(MemberVO memberVO) {
    int count = memberDAO.update(memberVO);
    return count;
  }
  
  @Override
  public int update_admin(MemberVO memberVO) {
    int count = memberDAO.update_admin(memberVO);
    return count;
  }
 
  /**
   * 패스워드 변경
   * @param mno 회원 번호
   * @param passwd 변경할 패스워드 값
   * @return
   */
  @Override
  public int passwd_update(int mem_no, String new_passwd) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("mem_no", mem_no);
    map.put("new_passwd", new_passwd);
    
    int count = memberDAO .passwd_update(map);
    
    return count;
  }
  
  @Override
  public int delete(int mem_no) {
    int count = memberDAO.delete(mem_no);
    return count;
  }
  
  @Override
  public int login(String mem_id, String mem_pass) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("mem_id", mem_id);
    map.put("mem_pass", mem_pass);
    
    int count = memberDAO.login(map);
    
    return count;
  }
  
  /*
  @Override
  public List<MemberVO> list_by_member_search(HashMap hashMap) {
    List<MemberVO> list = memberDAO.list_by_member_search(hashMap); 
    Iterator<MemberVO> iter = list.iterator(); 
    
    while(iter.hasNext() == true) { // 객체가 있는지 검사
      MemberVO memberVO = iter.next(); // 객체 가져옴
      }
    return list;
    }
    */
 
  @Override
  public int search_count(HashMap hashMap) {
    int cnt = memberDAO.search_count(hashMap);
    
    return cnt;
  }
  
  @Override
  public List<MemberVO> list_by_member_search(HashMap hashMap) {
    /* 
     페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
     1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
     2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
     3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
     */
    
    int beginOfPage = ((Integer)hashMap.get("nowPage") - 1) * Member.RECORD_PER_PAGE;
    
     // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
    int startNum = beginOfPage + 1; 
    //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
    int endNum = beginOfPage + Member.RECORD_PER_PAGE;   
    /*
     1 페이지: WHERE r >= 1 AND r <= 10
     2 페이지: WHERE r >= 11 AND r <= 20
     3 페이지: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    List<MemberVO> list = memberDAO.list_by_member_search(hashMap); 
    Iterator<MemberVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      MemberVO memberVO = iter.next();
      }
    return list;
  }
 
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param categoryno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  public String paging(int search_count, int nowPage, String word, String mem_search){ 
    int totalPage = (int)(Math.ceil((double)search_count/Member.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Member.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Member.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Member.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Member.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
 
    // 이전 10개 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 20
    int _nowPage = (nowGrp-1) * Member.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_member.do?&word="+word+"&nowPage="+_nowPage+"&mem_search="+mem_search+"'>이전</A></span>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='./list_by_member.do?word="+word+"&nowPage="+i+"&mem_search="+mem_search+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 11
    // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 21
    _nowPage = (nowGrp * Member.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_member.do?&word="+word+"&nowPage="+_nowPage+"&mem_search="+mem_search+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
  @Override
  public int create_login(HashMap hashMap) {
    int cnt = memberDAO.create_login(hashMap);
    
    return cnt;
  }
  
  @Override
  public List<MemberVO> list_by_login(int mem_no) {
    List<MemberVO> list = memberDAO.list_by_login(mem_no); 
      
    return list;
  }
  
  @Override
  public List<MemberVO> list_by_login_admin() {
    List<MemberVO> list = memberDAO.list_by_login_admin();
    
    return list;
  }
  
  @Override
  public MemberVO read_by_login(int login_no) {
    MemberVO memberVO = memberDAO.read_by_login(login_no);
    
    return memberVO;
  }
  
  @Override
  public int delete_by_login(int login_no) {
    int count = memberDAO.delete_by_login(login_no);
    return count;
  }
  
  @Override
  public int select_login_member(int mem_no) {
    int count = memberDAO.select_login_member(mem_no);
    return count;
  }
  
  @Override
  public int delete_login_member(int mem_no) {
    int count = memberDAO.delete_login_member(mem_no);
    return count;
  }
  
  @Override
  public int search_count_login(HashMap hashMap) {
    int cnt = memberDAO.search_count_login(hashMap);
    
    return cnt;
  }

  @Override
  public List<MemberVO> list_by_login_admin_search(HashMap hashMap) {
    /* 
     페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
     1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
     2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
     3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
     */
    
    int beginOfPage = ((Integer)hashMap.get("login_nowPage") - 1) * Member.RECORD_PER_PAGE;
    
    // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
    int startNum = beginOfPage + 1; 
    //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
    int endNum = beginOfPage + Member.RECORD_PER_PAGE;   
    /*
     1 페이지: WHERE r >= 1 AND r <= 10
     2 페이지: WHERE r >= 11 AND r <= 20
     3 페이지: WHERE r >= 21 AND r <= 30
     */
    hashMap.put("startNum", startNum);
    hashMap.put("endNum", endNum);
    
    List<MemberVO> list = memberDAO.list_by_login_admin_search(hashMap); 
    Iterator<MemberVO> iter = list.iterator();
    
    while(iter.hasNext() == true) {
      MemberVO memberVO = iter.next();
    }
    return list;
  }
  
  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param categoryno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  public String login_paging(int search_count_login, int login_nowPage, String word, String mem_search){ 
    int totalPage = (int)(Math.ceil((double)search_count_login/Member.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Member.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)login_nowPage/Member.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Member.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Member.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='login_paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
 
    // 이전 10개 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 20
    int _nowPage = (nowGrp-1) * Member.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./list_by_login_admin.do?&word="+word+"&login_nowPage="+_nowPage+"&mem_search="+mem_search+"'>이전</A></span>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (login_nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='./list_by_login_admin.do?word="+word+"&login_nowPage="+i+"&mem_search="+mem_search+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 11
    // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 21
    _nowPage = (nowGrp * Member.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./list_by_login_admin.do?&word="+word+"&login_nowPage="+_nowPage+"&mem_search="+mem_search+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
  @Override
  public int select_count_member(int auth_no) {
    int count  = memberDAO.select_count_member(auth_no);
    
    return count;
  }
  
  @Override
  public int select_count_login(int auth_no) {
    int count  = memberDAO.select_count_login(auth_no);
    
    return count;
  }
  
  @Override
  public int delete_count_member(int auth_no) {
    int count  = memberDAO.delete_count_member(auth_no);
    
    return count;
  }
  
  @Override
  public int delete_count_login(int auth_no) {
    int count  = memberDAO.delete_count_login(auth_no);
    
    return count;
  }
}