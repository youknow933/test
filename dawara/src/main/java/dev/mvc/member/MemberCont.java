package dev.mvc.member;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import nation.web.tool.Messages;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class MemberCont {
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  @Autowired
  @Qualifier("dev.mvc.tool.Messages")
  private Messages messages = null;
  
  public MemberCont(){
    System.out.println("--> MemberCont created.");
  }
  
  // http://localhost:9090/blog/member/create.do
  @RequestMapping(value = "/member/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    System.out.println("--> create() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/create"); // /webapp/member/create.jsp

    return mav;
  }
  
  /**
   * �ߺ� ID �˻�
   * http://localhost:9090/blog/member/checkId.do?id=user1
   * ���: {"cnt":1}
   * @param id
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/member/checkId.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String checkId(String mem_id) {
    System.out.println("--> checkId() GET executed");
    
    JSONObject obj = new JSONObject();
    
    int cnt = memberProc.checkId(mem_id);
    // System.out.println("--> id: " + id);
    // System.out.println("--> cnt: " + cnt);
    
    obj.put("cnt", cnt);

    return obj.toJSONString();
  }
  
  @RequestMapping(value="/member/create.do", method=RequestMethod.POST)
  public ModelAndView create(RedirectAttributes redirectAttributes,
                                        HttpServletRequest request, MemberVO memberVO){
    // System.out.println("--> update() POST called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("redirect:/member/message_create.jsp");
    
    int count = memberProc.checkId(memberVO.getMem_id());
    
    if (count == 1) { // ID �ߺ��� �޽��� ���
      redirectAttributes.addAttribute("sw", "mem_id");
      redirectAttributes.addAttribute("count", count); // 1 or 0
      
    } else {   
        // -------------------------------------------------------------------
        // ���� ���� �ڵ� ����
        // -------------------------------------------------------------------
        String upDir = Tool.getRealPath(request, "/member/storage");
        MultipartFile file1MF = memberVO.getFile1MF();
        
        String mem_pic = ""; // �÷��� ������ ���ϸ�
        long mem_size = file1MF.getSize();
        
        if (mem_size > 0 && mem_size < 10485760) {
          mem_pic = Upload.saveFileSpring(file1MF, upDir);
          System.out.println("mem_pic:" + mem_pic);
            
          memberVO.setMem_pic(mem_pic);
          memberVO.setMem_size(mem_size);
       }
        // -------------------------------------------------------------------
        // ���� ���� �ڵ� ����
        // -------------------------------------------------------------------
      
        count = memberProc.create(memberVO); // ���
      
        redirectAttributes.addAttribute("sw", "create");
        redirectAttributes.addAttribute("count", count); // 1 or 0
    }
      
    return mav;
  }
  
  @RequestMapping(value="/member/list.do", method=RequestMethod.GET)
  public ModelAndView list(){
    // System.out.println("--> create() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/list"); // webapp/member/list.jsp
      
    List<MemberVO> list = memberProc.list();
    mav.addObject("list", list);
    
    return mav;
  }  
  
  @RequestMapping(value="/member/read.do", method=RequestMethod.GET)
  public ModelAndView read(int mem_no){
    // System.out.println("--> read(int mno) GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/read"); // webapp/member/read.jsp
    
    MemberVO memberVO = memberProc.read(mem_no);
    mav.addObject("memberVO", memberVO);
    
    return mav;
  }  
  
  @RequestMapping(value="/member/read_admin.do", method=RequestMethod.GET)
  public ModelAndView read_admin(int mem_no){
    // System.out.println("--> read(int mno) GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/read_admin"); // webapp/member/read.jsp
    
    MemberVO memberVO = memberProc.read(mem_no);
    mav.addObject("memberVO", memberVO);
    
    return mav;
  } 
  
  @RequestMapping(value="/member/update.do", method=RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes,
                                        HttpServletRequest request, MemberVO memberVO){
    // System.out.println("--> update() POST called.");
    ModelAndView mav = new ModelAndView();
    
    // ---------------------------------------------------------------------------
    // ���� ����
    // ---------------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/member/storage");
    /*
    <input type="file" class="form-control input-lg" name='file1MF' id='file1MF' size='40' >
    ��
     name='file1MF'�� �ش��ϴ� �ʵ带 ã�Ƽ� File ��ü�� �ڵ����� �Ҵ�
    ��
    BlogVO.java: private MultipartFile file1MF;
    ��
     ���� ��ü ���: MultipartFile file1MF = blogVO.getFile1MF();          
     */
    MultipartFile file1MF = memberVO.getFile1MF();
    String mem_pic = "";                    // DBMS file1 �÷��� ��
    long mem_size = file1MF.getSize(); // ���� ũ��
    
    // ������ ��ϵ� �� ���� �ε�
    MemberVO memberVO_old = memberProc.read(memberVO.getMem_no());
    
    if (mem_size > 0) { // ��ϵ� ������ �ִٸ�
      Tool.deleteFile(upDir, memberVO_old.getMem_pic());    // ���� ���� ����
      
        if (mem_size > 0 && mem_size < 10485760) {
          mem_pic = Upload.saveFileSpring(file1MF, upDir); // �ű� ���� ���ε�
        }
    } else {
      // ������ �������� �ʴ� ��� ���� ���� ���� ���
      mem_pic = memberVO_old.getMem_pic();
      mem_size = memberVO_old.getMem_size();
    }
    memberVO.setMem_pic(mem_pic);
    memberVO.setMem_size(mem_size);
    // ---------------------------------------------------------------------------
    
    int count = memberProc.update(memberVO); // ����

    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("mem_no", memberVO.getMem_no()); // ȸ�� ��ȣ
    
    mav.setViewName("redirect:/member/message_update.jsp");
   
    return mav;
  }
  
  @RequestMapping(value="/member/passwd_update.do", method=RequestMethod.GET)
  public ModelAndView passwd_update(){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/passwd_update"); // webapp/member/passwd_update.jsp
    
    // mav.addObject("mno", mno);
    
    return mav;
  }  
  
  @RequestMapping(value="/member/update_admin.do", method=RequestMethod.POST)
  public ModelAndView update_admin(RedirectAttributes redirectAttributes,
                                                   HttpServletRequest request, MemberVO memberVO){
    // System.out.println("--> update() POST called.");
    ModelAndView mav = new ModelAndView();
    
    // ---------------------------------------------------------------------------
    // ���� ����
    // ---------------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/member/storage");
    /*
    <input type="file" class="form-control input-lg" name='file1MF' id='file1MF' size='40' >
    ��
     name='file1MF'�� �ش��ϴ� �ʵ带 ã�Ƽ� File ��ü�� �ڵ����� �Ҵ�
    ��
    BlogVO.java: private MultipartFile file1MF;
    ��
     ���� ��ü ���: MultipartFile file1MF = blogVO.getFile1MF();          
     */
    MultipartFile file1MF = memberVO.getFile1MF();
    String mem_pic = "";                    // DBMS file1 �÷��� ��
    long mem_size = file1MF.getSize(); // ���� ũ��
    
    // ������ ��ϵ� �� ���� �ε�
    MemberVO memberVO_old = memberProc.read(memberVO.getMem_no());
    
    if (mem_size > 0) { // ��ϵ� ������ �ִٸ�
      Tool.deleteFile(upDir, memberVO_old.getMem_pic());    // ���� ���� ����
      
      if (mem_size > 0 && mem_size < 10485760) {
        mem_pic = Upload.saveFileSpring(file1MF, upDir); // �ű� ���� ���ε�
      }
    } else {
      // ������ �������� �ʴ� ��� ���� ���� ���� ���
      mem_pic = memberVO_old.getMem_pic();
      mem_size = memberVO_old.getMem_size();
    }
    memberVO.setMem_pic(mem_pic);
    memberVO.setMem_size(mem_size);
    // ---------------------------------------------------------------------------
    
    int count = memberProc.update_admin(memberVO); // ����
    
    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("mem_no", memberVO.getMem_no()); // ȸ�� ��ȣ
    
    mav.setViewName("redirect:/member/message_update_admin.jsp");
    
    return mav;
  }
  
  
  /**
   * �н����带 �����մϴ�.
   * @param request
   * @param passwd
   * @param new_passwd
   * @return
   */
  @RequestMapping(value="/member/passwd_update.do", method=RequestMethod.POST)
  public ModelAndView passwd_update(HttpServletRequest request,
                                                    HttpSession session,
                                                    String mem_pass,
                                                    String new_passwd){
    // System.out.println("--> passwd_update() POST called.");
    ModelAndView mav = new ModelAndView();
    
    String mem_id = (String)session.getAttribute("mem_id"); // session
    int mem_no = (Integer)session.getAttribute("mem_no"); // session
    
    // �α��� ���� �߰� ���� 
    int count = memberProc.login(mem_id, mem_pass); // ���� �н����� �˻�
    System.out.println("--> count: " + count);
    if (count == 1) { // �α����� ȸ���� �н����� �˻�
      int count_update = memberProc.passwd_update(mem_no, new_passwd);
      System.out.println("--> count_update: " + count_update);
      mav.setViewName("redirect:/member/message_passwd.jsp?count=" + count_update + "&mem_no=" + mem_no);
    } else {
      mav.setViewName("redirect:/member/message_passwd.jsp?count=0");      
    }
    
    return mav;
  } 
  
  @RequestMapping(value="/member/delete.do", method=RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, Locale locale,
                                        HttpServletRequest request, int mem_no){
    ModelAndView mav = new ModelAndView();
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
        
    MemberVO memberVO = memberProc.read(mem_no);
    int login_count = memberProc.delete_login_member(mem_no);
    
    if (login_count > 0) {
      msgs.add(messages.getMessage("member.delete.count", memberVO.getMem_id()+"/"+login_count, locale));
    }
    
    // ī�װ� �׷� ����
    if (memberProc.delete(mem_no) == 1) {
      // mav.setViewName("redirect:/categrp/list.do");
 
      msgs.add(messages.getMessage("member.delete.success", memberVO.getMem_id(), locale));

      links.add("<button type='button' onclick=\"location.href='./list_by_member.do'\">���</button>");
    } else {
      msgs.add(messages.getMessage("member.delete.fail", memberVO.getMem_id(), locale));
      msgs.add(messages.getMessage("member.delete.retry", locale));
      links.add("<button type='button' onclick=\"history.back();\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list_by_member.do'\">���</button>");
    }

    mav.addObject("msgs", msgs);
    mav.addObject("links", links);
    
    mav.setViewName("/member/message"); // /categrp/message.jsp
    
    return mav;
  }
  
  /**
   * �α��� ��
   * @return
   */
  // http://localhost:9090/member/member/login.do 
  @RequestMapping(value = "/member/login.do", 
                             method = RequestMethod.GET)
  public ModelAndView login(HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/login_ck_form"); // /webapp/member/login_ck_form.jsp
    
    Cookie[] cookies = request.getCookies();
    Cookie cookie = null;

    String ck_id = ""; // id ���� ����
    String ck_id_save = ""; // id ���� ���θ� üũ�ϴ� ����
    String ck_passwd = ""; // passwd ���� ����
    String ck_passwd_save = ""; // passwd ���� ���θ� üũ�ϴ� ����

    if (cookies != null) {
      for (int i=0; i < cookies.length; i++){
        cookie = cookies[i]; // ��Ű ��ü ����
        
        if (cookie.getName().equals("ck_id")){
          ck_id = cookie.getValue(); 
        }else if(cookie.getName().equals("ck_id_save")){
          ck_id_save = cookie.getValue();  // Y, N
        }else if (cookie.getName().equals("ck_passwd")){
          ck_passwd = cookie.getValue();         // 1234
        }else if(cookie.getName().equals("ck_passwd_save")){
          ck_passwd_save = cookie.getValue();  // Y, N
        }
      }
    }
    
    mav.addObject("ck_id", ck_id);
    mav.addObject("ck_id_save", ck_id_save);
    mav.addObject("ck_passwd", ck_passwd);
    mav.addObject("ck_passwd_save", ck_passwd_save);
    
    return mav;
  }
  
  /**
   * �α��� ó��
   * @param request
   * @param response
   * @param session
   * @param memberVO
   * @return
   */
  @RequestMapping(value="/member/login.do", method=RequestMethod.POST)
  public ModelAndView login(HttpServletRequest request, 
                                       HttpServletResponse response,
                                       HttpSession session,
                                       MemberVO memberVO){
//     System.out.println("--> login() POST called.");
    ModelAndView mav = new ModelAndView();
    
    String mem_id = memberVO.getMem_id();
    String mem_pass = memberVO.getMem_pass();
    
    if (memberProc.login(mem_id, mem_pass) != 1) { // �α��� ���н�
      mav.setViewName("redirect:/member/message_login.jsp");
      
    } else { // �н����� ��ġ�ϴ� ���
      MemberVO old_memberVO = memberProc.readById(mem_id);

      session.setAttribute("mem_no",  old_memberVO.getMem_no()); // session ���� ��ü
      session.setAttribute("mem_id", mem_id);
      session.setAttribute("mem_pass", mem_pass);
      session.setAttribute("mem_name", old_memberVO.getMem_name());
      session.setAttribute("auth_no", old_memberVO.getAuth_no());
      
      // -------------------------------------------------------------------
      // id ���� ��� ����
      // -------------------------------------------------------------------
      String id_save = Tool.checkNull(memberVO.getId_save());
      if (id_save.equals("Y")) { // id�� ������ ���
        Cookie ck_id = new Cookie("ck_id", mem_id); 
        ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, �ʴ���
        response.addCookie(ck_id);
      } else { // N, id�� �������� �ʴ� ���
        Cookie ck_id = new Cookie("ck_id", "");
        ck_id.setMaxAge(0);
        response.addCookie(ck_id);
      }
      // id�� �������� �����ϴ�  CheckBox üũ ����
      Cookie ck_id_save = new Cookie("ck_id_save", id_save);
      ck_id_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_id_save);
      // -------------------------------------------------------------------

      // -------------------------------------------------------------------
      // Password ���� ��� ����
      // -------------------------------------------------------------------
      String passwd_save = Tool.checkNull(memberVO.getPasswd_save());
      if (passwd_save.equals("Y")) { // �н����� ������ ���
        Cookie ck_passwd = new Cookie("ck_passwd", mem_pass);
        ck_passwd.setMaxAge(60 * 60 * 72 * 10); // 30 day
        response.addCookie(ck_passwd);
      } else { // N, �н����带 �������� ���� ���
        Cookie ck_passwd = new Cookie("ck_passwd", "");
        ck_passwd.setMaxAge(0);
        response.addCookie(ck_passwd);
      }
      // passwd�� �������� �����ϴ�  CheckBox üũ ����
      Cookie ck_passwd_save = new Cookie("ck_passwd_save", passwd_save);
      ck_passwd_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_passwd_save);
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/create_login.do"); // Ȯ���� ��� 
      
    }
    
    return mav;
  }
  
  
  /**
   * �α׾ƿ� ó��
   * @param request
   * @param session
   * @return
   */
  @RequestMapping(value="/member/logout.do", method=RequestMethod.GET)
  public ModelAndView logout(HttpServletRequest request, 
                                         HttpSession session){
    // System.out.println("--> logout() GET called.");
    ModelAndView mav = new ModelAndView();

    session.invalidate(); // session ���� ��ü�� ��ϵ� ��� session ���� ����
    
    // webapp/member/message_logout.jsp
    mav.setViewName("redirect:/member/message_logout.jsp"); 
    
    return mav;
  }
  
  /**
   * �˻� ���
   * @param word
   * @return
   */
  /*
  @RequestMapping(value = "/member/list_by_member.do", method = RequestMethod.GET)
  public ModelAndView list_by_member_search(String word, String mem_search) {
    // System.out.println("--> list_by_category(int categoryno, String word_find) GET called.");
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/contents/list_by_categoryno"); // webapp/contents/list_by_categoryno.jsp
    
    // �˻� ��� �߰�, webapp/contents/list_by_category_search.jsp
    mav.setViewName("/member/list_by_member");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("word", word);    // #{word}
    hashMap.put("mem_search", mem_search);     // #{mem_search}, �˻� �� �Ķ���� ���� ���⿡ �������־����
    
    // �˻� ���
    List<MemberVO> list = memberProc.list_by_member_search(hashMap);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = memberProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    return mav;
  } 
  */
  
  /**
   * ��� + �˻� + ����¡ ����
   * @param categoryno
   * @param word
   * @param nowPage
   * @return
   */
  
  @RequestMapping(value = "/member/list_by_member.do", method = RequestMethod.GET)
  public ModelAndView list_by_member_search(
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="mem_serach", defaultValue="mem_search_all") String mem_search,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    //System.out.println("--> list_by_categoryno() GET called.");
    System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/contents/list_by_categoryno"); // webapp/contents/list_by_categoryno.jsp
    
    // �˻� ��� �߰�, webapp/contents/list_by_category_search.jsp
    mav.setViewName("/member/list_by_member");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("word", word);    // #{word}
    hashMap.put("mem_search", mem_search);     // #{mem_search}, �˻� �� �Ķ���� ���� ���⿡ �������־����
    hashMap.put("nowPage", nowPage);             // #{nowpage}, ����¡ �� �Ķ���� ���� ���⿡ �������־����, proc���� ���� hashmap.get���� �����پ�
    
    // �˻� ���
    List<MemberVO> list = memberProc.list_by_member_search(hashMap);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = memberProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    // mav.addObject("word", word);
 
    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     *
     * @param categoryno ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = memberProc.paging(search_count, nowPage, word, mem_search);
    
    mav.addObject("paging", paging);
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
    
  /**
   * �α��� ���� ����
   * @return
   */
  // http://localhost:9090/member/member/login.do 
  @RequestMapping(value = "create_login.do", method = RequestMethod.GET)
  public ModelAndView create_login(RedirectAttributes redirectAttributes, HttpSession session,
                                                HttpServletRequest request, MemberVO memberVO) {
    System.out.println("--> create() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("create_login"); // /webapp/member/create.jsp
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    Calendar date = Calendar.getInstance();

    int mem_no = (Integer)session.getAttribute("mem_no");    
    String login_ip = request.getRemoteAddr(); // �α��� ip �����ϴ� ����(ipv6)
    String login_date = sdf.format(date.getTime()); // �α��� ��¥ �����ϴ� ����
    String login_agent = request.getHeader("User-Agent"); // �α��� ������ ����
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();    
    hashMap.put("mem_no", mem_no);    // #{word}
    hashMap.put("login_ip", login_ip);    // #{word}
    hashMap.put("login_date", login_date);     // #{mem_search}, �˻� �� �Ķ���� ���� ���⿡ �������־����
    hashMap.put("login_agent", login_agent);             // #{nowpage}, ����¡ �� �Ķ���� ���� ���⿡ �������־����, proc���� ���� hashmap.get���� �����پ�
    
    if(mem_no != 0){
      memberVO.setMem_no(mem_no);
      memberVO.setLogin_ip(login_ip);
      memberVO.setLogin_date(login_date);
      memberVO.setLogin_agent(login_agent);
    }else{
      memberVO.setLogin_ip(login_ip);
      memberVO.setLogin_date(login_date);
      memberVO.setLogin_agent(login_agent);
    }
    
    int count = memberProc.create_login(hashMap); // ���

    return mav;
  }
  
  
  @RequestMapping(value="/member/read_by_login.do", method=RequestMethod.GET)
  public ModelAndView read_by_login(int login_no){
    // System.out.println("--> read(int mno) GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/read_by_login"); // webapp/member/read.jsp
    
    MemberVO memberVO = memberProc.read_by_login(login_no);
    mav.addObject("memberVO", memberVO);
    
    return mav;
  }  
  
  @RequestMapping(value="/member/delete_by_login.do", method=RequestMethod.GET)
  public ModelAndView delete_by_login(int login_no){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/delete_by_login"); // webapp/member/delete.jsp
    
    MemberVO memberVO = memberProc.read_by_login(login_no);
    mav.addObject("memberVO", memberVO);
    
    return mav;
  }  
  
  @RequestMapping(value="/member/delete_by_login.do", method=RequestMethod.POST)
  public ModelAndView delete_by_login(RedirectAttributes redirectAttributes,
                                                    HttpServletRequest request, int login_no){
    ModelAndView mav = new ModelAndView();
    
    int count = memberProc.delete_by_login(login_no);

    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("login_no", login_no); // �α��� ��ȣ
    
    mav.setViewName("redirect:/member/message_login_delete.jsp");
   
    return mav;
  }
  
  /**
   * ��� + �˻� + ����¡ ����
   * @param categoryno
   * @param word
   * @param nowPage
   * @return
   */
  
  @RequestMapping(value="/member/list_by_login.do", method = RequestMethod.GET)
  public ModelAndView list_by_login(int mem_no){ 
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/contents/list_by_categoryno"); // webapp/contents/list_by_categoryno.jsp
    
    // �˻� ��� �߰�, webapp/contents/list_by_category_search.jsp
    mav.setViewName("/member/list_by_login");   
    
    // �˻� ���
    List<MemberVO> list = memberProc.list_by_login(mem_no);
    mav.addObject("list", list);
   
    return mav;
  }
  
  /**
   * ��� + �˻� + ����¡ ����
   * @param categoryno
   * @param word
   * @param nowPage
   * @return
   */
  
  @RequestMapping(value = "/member/list_by_login_admin.do", method = RequestMethod.GET)
  public ModelAndView list_by_login_admin_search(
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="mem_serach", defaultValue="mem_search_all") String mem_search,
      @RequestParam(value="login_nowPage", defaultValue="1") int login_nowPage
      ) { 
    //System.out.println("--> list_by_categoryno() GET called.");
    System.out.println("--> login_nowPage: " + login_nowPage);
    
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/contents/list_by_categoryno"); // webapp/contents/list_by_categoryno.jsp
    
    // �˻� ��� �߰�, webapp/contents/list_by_category_search.jsp
    mav.setViewName("/member/list_by_login_admin");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("word", word);    // #{word}
    hashMap.put("mem_search", mem_search);     // #{mem_search}, �˻� �� �Ķ���� ���� ���⿡ �������־����
    hashMap.put("login_nowPage", login_nowPage);             // #{nowpage}, ����¡ �� �Ķ���� ���� ���⿡ �������־����, proc���� ���� hashmap.get���� �����پ�
    
    // �˻� ���
    List<MemberVO> list = memberProc.list_by_login_admin_search(hashMap);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count_login = memberProc.search_count_login(hashMap);
    mav.addObject("search_count_login", search_count_login);
    
    // mav.addObject("word", word);
    
    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     *
     * @param categoryno ī�װ���ȣ 
     * @param search_count_login �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String login_paging = memberProc.login_paging(search_count_login, login_nowPage, word, mem_search);
     
    mav.addObject("login_paging", login_paging);
    mav.addObject("login_nowPage", login_nowPage);
    
    return mav;
  }
  
  @RequestMapping(value="/member/delete_user.do", method=RequestMethod.POST)
  public ModelAndView delete_user(RedirectAttributes redirectAttributes, HttpSession session,
                                              HttpServletRequest request, int mem_no){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("redirect:/member/message_delete_user.jsp");
    
    int login_count = memberProc.delete_login_member(mem_no);   // �α��� ��� ����
    int count = memberProc.delete(mem_no); // ����
    
    session.invalidate(); // session ���� ��ü�� ��ϵ� ��� session ���� ����
    
    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("login_count", login_count);
      
    return mav;
  }
}
 
