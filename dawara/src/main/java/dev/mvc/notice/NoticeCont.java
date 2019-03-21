package dev.mvc.notice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class NoticeCont {
  @Autowired
  @Qualifier("dev.mvc.notice.NoticeProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private NoticeProcInter noticeProc;
  
  public NoticeCont() {
    System.out.println("--> NoticeCont created.");
  }
  
  
  @RequestMapping(value="/notice/list_all.do", method=RequestMethod.GET)
  public ModelAndView list_all(){   
    ModelAndView mav = new ModelAndView();
   
    mav.setViewName("/notice/list_all"); // webapp/notice/list_all.jsp
    
    List<NoticeVO> list_all = noticeProc.list_all();
    mav.addObject("list_all", list_all);
     
    return mav;
  }
  
  /**
   * �˻� ���
   * @param mem_no
   * @param word
   * @return
   */
  @RequestMapping(value = "/notice/list_by_notice_paging.do", method = RequestMethod.GET)
  public ModelAndView list_by_notice_search(
      HttpSession session,
      @RequestParam(value="notice_search", defaultValue="") String notice_search,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) {
    // System.out.println("--> list_by_category(int no_no, String word_find) GET called.");
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/notice/list_by_no_no"); // webapp/notice/list_by_no_no.jsp
    
    int mem_no = (Integer)session.getAttribute("mem_no");
    System.out.println("mem_no: " + mem_no);
    
    // �˻� ��� �߰�, webapp/notice/list_by_notice_search.jsp
   // mav.setViewName("/notice/list_by_notice_search");   
     mav.setViewName("/notice/list_by_notice_search_paging");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{mem_no}
    hashMap.put("notice_search", notice_search); // #{notice_search}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);                  // #{nowPage}

    // System.out.println("mem_no: " + mem_no);
    // System.out.println("word_find: " + word_find);
    
    // �˻� ���
    List<NoticeVO> list_by_notice_search = noticeProc.list_by_notice_search(hashMap);
    mav.addObject("list_by_notice_search", list_by_notice_search);
    
    // �˻��� ���ڵ� ����
    int search_count = noticeProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    NoticeVO noticeVO = noticeProc.read(mem_no);
    mav.addObject("noticeVO", noticeVO);
    
    // mav.addObject("word", word);
    
    return mav;
  }
  
  
//  list_by_notice.do���� ��� + �˻� + ����¡ ����
  @RequestMapping(value="/notice/list_by_notice.do", method=RequestMethod.GET)
  public ModelAndView list_by_notice(   
//      @RequestParam(value="mem_no") int mem_no,
      HttpSession session,
      @RequestParam(value="notice_search", defaultValue="") String notice_search,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ){
    //System.out.println("--> nowPage: " + nowPage);
    ModelAndView mav = new ModelAndView();


    //  �˻� ��� �߰�
    //mav.setViewName("/notice/list_by_notice");   
   
    int mem_no = (Integer)session.getAttribute("mem_no");
    System.out.println("mem_no: " + mem_no);
 
    //// ����¡ ��� �߰�,  /webapp/notice/list_by_notice_search_paging.jsp
    mav.setViewName("/notice/list_by_notice");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{mem_no}
    hashMap.put("notice_search", notice_search); // #{notice_search}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);                  // #{nowPage}

    
    List<NoticeVO> list_by_notice = noticeProc.list_by_notice_search(hashMap);
    mav.addObject("list_by_notice", list_by_notice);
   
    /*
    // �˻� ���
    List<NoticeVO> list = noticeProc.list_by_notice_search(hashMap);
    mav.addObject("list", list);
   */
    
    // �˻��� ���ڵ� ����
    int search_count = noticeProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    List<NoticeVO> noticeVO = noticeProc.read_mem_no(mem_no);
    mav.addObject("noticeVO", noticeVO);
    
    
    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     *
     * @param no_no ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = noticeProc.paging(notice_search, mem_no, search_count, nowPage, word);
    //String paging = noticeProc.paging(no_no, search_count, nowPage, word);
    mav.addObject("paging", paging);

   // mav.addObject("mem_no", mem_no);
    mav.addObject("nowPage", nowPage);
     
    return mav;
  }
  
  
  @RequestMapping(value="/notice/create.do", method=RequestMethod.GET)
  public ModelAndView create(int mem_no) {
    ModelAndView mav = new ModelAndView();
    
    NoticeVO noticeVO = noticeProc.read(mem_no);
    mav.addObject("noticeVO", noticeVO);
//    if (noticeProc != null) {
//      System.out.println("--> noticeProc: " + noticeProc.hashCode());
//    }
    mav.setViewName("/notice/create"); // /notice/create.jsp
    
    return mav;
  }

  
  @RequestMapping(value="/notice/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, NoticeVO noticeVO) {
    ModelAndView mav = new ModelAndView();
    
//    if (noticeProc != null) {
//      System.out.println("--> noticeProc: " + noticeProc.hashCode());
//    }
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    // System.out.println("noticeVO.getNoticeno(): " + noticeVO.getNoticeno());
    // System.out.println("noticeVO.getTitle(): " + noticeVO.getTitle());
    
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/notice/storage");
    List<MultipartFile> filesMF = noticeVO.getFilesMF(); // Spring�� File ��ü�� �����ص�.
    
    // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
    
    String no_files = ""; // �÷��� ������ ���ϸ�
    String files_item = ""; // �ϳ��� ���ϸ�
    String no_sizes = "";
    long sizes_item = 0;   // �ϳ��� ���� ������
    String no_thumbs = "";         // Thumb ���ϵ�
    String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�
    
    int count = filesMF.size();
    
    // System.out.println("--> ContentsCont count: " + count);
    
    if (count > 0) { // ���� ������ �����Ѵٸ�
      // for (MultipartFile multipartFile: filesMF) {
      for (int i=0; i < count; i++) {
        MultipartFile multipartFile = filesMF.get(i);
        files_item = Upload.saveFileSpring(multipartFile, upDir);
        sizes_item = multipartFile.getSize();
        
        if (Tool.isImage(files_item)) {
          thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb �̹��� ����
        }
        
        if ( i != 0 &&  i < count ) {
          no_files = no_files + "/" + files_item;  // file1.jpg/file2.jpg/file3.jpg
          no_sizes = no_sizes + "/" + sizes_item;   // 12546/78956/42658
          no_thumbs = no_thumbs + "/" + thumbs_item;
        } else if (multipartFile.getSize() > 0){ // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ
          no_files = files_item;         // file1.jpg
          no_sizes = "" + sizes_item; // 123456
          no_thumbs = thumbs_item;
        }
      }
    }
    noticeVO.setNo_files(no_files);
    noticeVO.setNo_sizes(no_sizes);
    noticeVO.setNo_thumbs(no_thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    
    
    if (noticeProc.create(noticeVO) == 1) {
      // msgs.add("���������� ����߽��ϴ�.");
      mav.setViewName("redirect:/notice/list_by_notice.do?notice_search=notice_no&word=&mem_no=1");
//      mav.setViewName("redirect:/notice/list_all.do?mem_no=" + noticeVO.getMem_no());
    } else { 
      msgs.add("�������� ��Ͽ� �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� �� ����: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back();\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list_by_notice.do?notice_search=notice_no&word=&mem_no=1\">���</button>");

      mav.addObject("msgs", msgs);
      // request.setAttribute("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/notice/message"); // /notice/message.jsp
    }

    return mav;
  }
  
  @RequestMapping(value = "/notice/read.do", method = RequestMethod.GET)
  public ModelAndView read(int no_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/notice/read"); // /webapp/notice/read.jsp

    NoticeVO noticeVO = noticeProc.read(no_no);
    mav.addObject("noticeVO", noticeVO);
    
    ArrayList<No_fileVO> file_list = new ArrayList<No_fileVO>();
    
    String thumbs = noticeVO.getNo_thumbs();
    String files = noticeVO.getNo_files();
    String sizes = noticeVO.getNo_sizes();
    
    String[] thumbs_array = thumbs.split("/");  // Thumbs
    String[] files_array = files.split("/");   // ���ϸ� ����
    String[] sizes_array = sizes.split("/"); // ���� ������

    int count = sizes_array.length;
    // System.out.println("sizes_array.length: " + sizes_array.length);
    // System.out.println("sizes: " + sizes);
    // System.out.println("files: " + files);

    if (files.length() > 0) {
      for (int index = 0; index < count; index++) {
        sizes_array[index] = Tool.unit(new Integer(sizes_array[index]));  // 1024 -> 1KB
      
        No_fileVO fileVO = new No_fileVO(thumbs_array[index], files_array[index], sizes_array[index]);
        file_list.add(fileVO);
      }
    } 
    mav.addObject("file_list", file_list);
   
    return mav;
  }
  
 /* @RequestMapping(value = "/notice/read_mem_no.do", method = RequestMethod.GET)
  public ModelAndView read_mem_no(int mem_no) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/notice/list_all"); // webapp/notice/list_all.jsp
    
    List<NoticeVO> list_all = noticeProc.list_all();
    mav.addObject("list_all", list_all);
     
    return mav;
  }*/
/*
  @RequestMapping(value = "/notice/read_by_mem_no.do", method = RequestMethod.GET)
  public ModelAndView read_by_mem_no(int mem_no) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/notice/list_all"); // webapp/notice/list_all.jsp
    
    List<NoticeVO> read_by_mem_no = noticeProc.read_by_mem_no(mem_no);
    mav.addObject("read_by_mem_no", read_by_mem_no);
     
    return mav;
  }*/
  
 /* @RequestMapping(value="/notice/list_index.do", method=RequestMethod.GET)
  public ModelAndView list_index(HttpServletRequest request){
    // System.out.println("--> list_index() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/notice/list_index"); // webapp/notice/list_index.jsp
    
    List<NoticeVO> notice_list = noticeProc.list(); // ī�װ� �׷� ���
    
    // Categrp: name, Category: title ���� ���
    ArrayList<String> name_title_list = new ArrayList<String>();   
    
    StringBuffer url = new StringBuffer(); // ī�װ� ���� ��ũ ����

    // ī�װ� �׷� ������ŭ ��ȯ
    for (int index = 0; index < notice_list.size(); index++) {
      NoticeVO noticeVO = notice_list.get(index);

      name_title_list.add("<LI class='categrp_name'>"+ noticeVO.get() + "</LI>");

      List<Categrp_NoticeVO> notice_list = noticeProc.list_by_no_no(noticeVO.getNoticeno()); // ī�װ� Join ���
      
      // ī�װ� ������ŭ ��ȯ
      for (int j=0; j < notice_list.size(); j++) {
        Categrp_NoticeVO categrp_NoticeVO = notice_list.get(j);
        String title = categrp_NoticeVO.getTitle(); // ī�װ� �̸�
        int cnt = categrp_NoticeVO.getCnt();
        
        url.append("<LI class='notice_title'>");
        url.append("  <A href='" + request.getContextPath()+ "/content/list_by_notice.do?no_no"+categrp_NoticeVO.getCategoryno()+"'>");
        url.append(title);
        url.append("  </A>");
        url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
        url.append("</LI>");
        name_title_list.add(url.toString()); // ��� ��Ͽ� �ϳ��� notice �߰� 
        
        url.delete(0, url.toString().length()); // StringBuffer ���ڿ� ����
        
      }
    }
    
    mav.addObject("name_title_list", name_title_list);
    mav.addObject("total_count", noticeProc.total_count());
    
    return mav;
  }*/
  
  
  /**
  <Xmp>
    ���� �� 
    SELECT no_no, mem_no, no_title, no_write, no_rdate, no_cnt, no_notice, no_visible, no_seqno
    FROM notice 
    WHERE no_no=#{no_no} 
  </Xmp>
  * 
  * @param no_no
  * @return
  */
 @ResponseBody
 @RequestMapping(value = "/notice/update.do", method = RequestMethod.GET, 
                           produces = "text/plain;charset=UTF-8")
 public ModelAndView update(int no_no) {
// System.out.println("--> update() GET executed");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/notice/update"); // /webapp/notice/update.jsp

   NoticeVO noticeVO = noticeProc.read(no_no);
   mav.addObject("noticeVO", noticeVO);
   
   ArrayList<No_fileVO> file_list = new ArrayList<No_fileVO>();
   
   String thumbs = noticeVO.getNo_thumbs();
   String files = noticeVO.getNo_files();
   String sizes = noticeVO.getNo_sizes();
   
   String[] thumbs_array = thumbs.split("/");  // Thumbs
   String[] files_array = files.split("/");   // ���ϸ� ����
   String[] sizes_array = sizes.split("/"); // ���� ������

   int count = sizes_array.length;
   // System.out.println("sizes_array.length: " + sizes_array.length);
   // System.out.println("sizes: " + sizes);
   // System.out.println("files: " + files);

   if (files.length() > 0) {
     for (int index = 0; index < count; index++) {
       sizes_array[index] = Tool.unit(new Integer(sizes_array[index]));  // 1024 -> 1KB
     
       No_fileVO fileVO = new No_fileVO(thumbs_array[index], files_array[index], sizes_array[index]);
       file_list.add(fileVO);
     }
   } 
   mav.addObject("file_list", file_list);
   
 
   return mav;
 }

 /**
 - �۸� �����ϴ� ����� ����
 - ���ϸ� �����ϴ� ����� ����
 - �۰� ������ ���ÿ� �����ϴ� ����� ����
  * @param noticeVO
  * @return
  */
 @RequestMapping(value = "/notice/update.do", 
                            method = RequestMethod.POST)
 public ModelAndView update(RedirectAttributes redirectAttributes,
                            HttpServletRequest request, NoticeVO noticeVO) {
// System.out.println("--> update() POST executed");
   ModelAndView mav = new ModelAndView();

   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/notice/storage");
   List<MultipartFile> filesMF = noticeVO.getFilesMF(); // Spring�� File ��ü�� �����ص�.
   
   // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
   
   String files = ""; // �÷��� ������ ���ϸ�
   String files_item = ""; // �ϳ��� ���ϸ�
   String sizes = "";
   long sizes_item = 0;   // �ϳ��� ���� ������
   String thumbs = "";         // Thumb ���ϵ�
   String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�
   
   int count = filesMF.size();

   // ���� ��� ���� �о��.
   NoticeVO noticeVO_old = noticeProc.read(noticeVO.getNo_no());
   
   if (filesMF.get(0).getSize() > 0) { // ���� ������ �����Ѵٸ�
     // System.out.println("3) ���ο� ������ ����մϴ�.");
     // ���� ���� ����
     
     String thumbs_old = noticeVO_old.getNo_thumbs();
     String files_old = noticeVO_old.getNo_files();
     
     StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");  // Thumbs
     while(thumbs_st.hasMoreTokens()) { // �ܾ �ִ��� �˻�
       String fname = upDir + thumbs_st.nextToken(); // �ܾ� ����
       Tool.deleteFile(fname);
     }
     
     StringTokenizer files_st = new StringTokenizer(files_old, "/");           // files
     while(files_st.hasMoreTokens()) { // �ܾ �ִ��� �˻�
       String fname = upDir + files_st.nextToken(); // �ܾ� ����
       Tool.deleteFile(fname);
     }
     
     // for (MultipartFile multipartFile: filesMF) {
     for (int i=0; i < count; i++) {
       MultipartFile multipartFile = filesMF.get(i);
       files_item = Upload.saveFileSpring(multipartFile, upDir);
       sizes_item = multipartFile.getSize();
       
       if (Tool.isImage(files_item)) {
         thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb �̹��� ����
       }
       
       if ( i != 0 &&  i < count ) {
         files = files + "/" + files_item;  // file1.jpg/file2.jpg/file3.jpg
         sizes = sizes + "/" + sizes_item;   // 12546/78956/42658
         thumbs = thumbs + "/" + thumbs_item;
       } else if (multipartFile.getSize() > 0){ // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ
         files = files_item;         // file1.jpg
         sizes = "" + sizes_item; // 123456
         thumbs = thumbs_item;
       }
     }
   } else { // �۸� �����ϴ� ��� 
     files = noticeVO_old.getNo_files();
     sizes = noticeVO_old.getNo_sizes();
     thumbs = noticeVO_old.getNo_thumbs();
   } 
   noticeVO.setNo_files(files);
   noticeVO.setNo_sizes(sizes);
   noticeVO.setNo_thumbs(thumbs);
   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   
   /*
    // ȸ�� ���� �� session ���κ���
   noticeVO.setMno(1);*/
   
   count = noticeProc.update(noticeVO);
   
   redirectAttributes.addAttribute("count", count); // 1 or 0
   redirectAttributes.addAttribute("no_no", noticeVO.getNo_no());
   redirectAttributes.addAttribute("mem_no", noticeVO.getMem_no());

   mav.setViewName("redirect:/notice/message_update.jsp");
   
   return mav;
 }
 
 @RequestMapping(value = "/notice/delete_img.do", method = RequestMethod.GET)
 public ModelAndView delete_img(int no_no) {
   // System.out.println("--> delete() GET executed");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/notice/update"); // /webapp/notice/delete.jsp

   NoticeVO noticeVO = noticeProc.read(no_no);
   mav.addObject("noticeVO", noticeVO);
   
   return mav;
 }
 

 /**
  * �̹��� ���� ó��
  * @param no_no ī�װ� �׷� ��ȣ
  * @param no_no ������ ���ڵ� ��ȣ
  * @return
  */
 @RequestMapping(value = "/notice/delete_img.do", method = RequestMethod.POST)
 public ModelAndView delete_img(RedirectAttributes redirectAttributes,
               HttpServletRequest request, int no_no) { 

   ModelAndView mav = new ModelAndView();

   ArrayList<String> msgs = new ArrayList<String>();
   ArrayList<String> links = new ArrayList<String>();

   NoticeVO noticeVO = noticeProc.read(no_no);
   String no_files = noticeVO.getNo_files();
   String no_thumbs = noticeVO.getNo_thumbs();
   // System.out.println("--> no_files: " + no_files); //  sw35.jpg/sw36.jpg/sw37.jpg
   String upDir = Tool.getRealPath(request, "/notice/storage");
   
   StringTokenizer st = new StringTokenizer(no_files, "/");  // Thumbs

   while(st.hasMoreTokens()) { // �ܾ �ִ��� �˻�
     String fname = upDir + st.nextToken(); // �ܾ� ����
     Tool.deleteFile(fname);
   }
   
   StringTokenizer st2 = new StringTokenizer(no_thumbs, "/");  // Thumbs

   while(st2.hasMoreTokens()) { // �ܾ �ִ��� �˻�
     String fname = upDir + st2.nextToken(); // �ܾ� ����
     Tool.deleteFile(fname);
   }
   
   int count = noticeProc.delete_img(no_no);

   if (count == 1) {
     
     msgs.add("÷�� ������ �����߽��ϴ�.");
     mav.setViewName("redirect:/notice/list_all.do");     
   } else {
     msgs.add("�������� ������ �����߽��ϴ�.");
     msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");
     links.add("<button type='button' onclick=\"location.href='./list_all.do?no_no=" + no_no + "'\">���</button>");

     mav.addObject("msgs", msgs);
     mav.addObject("links", links);

     mav.setViewName("/notice/message"); // /webapp/notice/message.jsp
   }

   return mav;
 }
 
 
 /**
  * 
  * ����
  * @param no_no
  * @return
  */
 
 @RequestMapping(value = "/notice/delete.do", method = RequestMethod.GET)
 public ModelAndView delete(int no_no) {
   // System.out.println("--> delete() GET executed");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/notice/delete"); // /webapp/notice/delete.jsp

   NoticeVO noticeVO = noticeProc.read(no_no);
   mav.addObject("noticeVO", noticeVO);
   
   /*NoticeVO noticeVO = noticeProc.read(noticeno);
   mav.addObject("noticeVO", noticeVO);*/
   
   return mav;
 }
 

 /**
  * ���� ó��
  * @param no_no ī�װ� �׷� ��ȣ
  * @param no_no ������ ���ڵ� ��ȣ
  * @return
  */
 @RequestMapping(value = "/notice/delete.do", method = RequestMethod.POST)
 public ModelAndView delete(RedirectAttributes redirectAttributes,
               HttpServletRequest request, int no_no) { 

   ModelAndView mav = new ModelAndView();

   ArrayList<String> msgs = new ArrayList<String>();
   ArrayList<String> links = new ArrayList<String>();

   int count = noticeProc.delete(no_no);
// System.out.println("no_no: " + no_no);
// System.out.println("count: " + count);

   if (count == 1) {
     // msgs.add("���������� �����߽��ϴ�.");
     //mav.setViewName("redirect:/notice/list_all.do");     
     mav.setViewName("redirect:/notice/list_by_notice.do?notice_search=notice_no&word=&mem_no=1");     
   } else {
     msgs.add("�������� ������ �����߽��ϴ�.");
     msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");
     //links.add("<button type='button' onclick=\"location.href='./list_all.do?no_no=" + no_no + "'\">���</button>");
     links.add("<button type='button' onclick=\"location.href='./list_by_notice.do?notice_search=notice_no&word=&mem_no=1'\">���</button>");

     mav.addObject("msgs", msgs);
     mav.addObject("links", links);

     mav.setViewName("/notice/message"); // /webapp/notice/message.jsp
   }

   return mav;
 }
 /*@RequestMapping(value = "/notice/show_hide.do", method = RequestMethod.GET)
 public ModelAndView show_hide(int no_no) {
   ModelAndView mav = new ModelAndView();

   mav.setViewName("/notice/list_by_notice");   
   
   NoticeVO show_hide = noticeProc.show_hide(no_no);
   mav.addObject("show_hide", show_hide);

   return mav;
 }
 */
 
/*
 @RequestMapping(value = "/notice/update_seqno_up.do", method = RequestMethod.POST)
 public ModelAndView update_seqno_up(int no_no) {
   ModelAndView mav = new ModelAndView();

   if (noticeProc.update_seqno_up(no_no) == 1) {
     mav.setViewName("redirect:/notice/list.do?no_no=" + no_no);
   }

   return mav;
 }

 @RequestMapping(value = "/notice/update_seqno_down.do", method = RequestMethod.POST)
 public ModelAndView update_seqno_down(int no_no) {
   ModelAndView mav = new ModelAndView();

   if (noticeProc.update_seqno_down(no_no) == 1) {
     mav.setViewName("redirect:/notice/list.do?no_no=" + no_no);
   }

   return mav;
 }*/
/*
 @RequestMapping(value="/notice/list_index_left.do", method=RequestMethod.GET)
 public ModelAndView list_index_left(HttpServletRequest request){
   // System.out.println("--> list_index() GET called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/notice/list_index_left"); // webapp/notice/list_index_left.jsp
   
   List<NoticeVO> notice_list = noticeProc.list(); // ī�װ� �׷� ���
   
   // Categrp: name, Category: title ���� ���
   ArrayList<String> name_title_list = new ArrayList<String>();   
   
   StringBuffer url = new StringBuffer(); // ī�װ� ���� ��ũ ����

   // ī�װ� �׷� ������ŭ ��ȯ
   for (int index = 0; index < notice_list.size(); index++) {
     NoticeVO noticeVO = notice_list.get(index);

     name_title_list.add("<LI class='categrp_name'>"+ noticeVO.getName() + "</LI>");

     List<Categrp_NoticeVO> notice_list = noticeProc.list_by_no_no(noticeVO.getNoticeno()); // ī�װ� Join ���
     
     // ī�װ� ������ŭ ��ȯ
     for (int j=0; j < notice_list.size(); j++) {
       Categrp_NoticeVO categrp_NoticeVO = notice_list.get(j);
       String title = categrp_NoticeVO.getTitle(); // ī�װ� �̸�
       int cnt = categrp_NoticeVO.getCnt();
       
       url.append("<LI class='notice_title'>");
       url.append("  <A href='" + request.getContextPath()+ "/notice/list_by_notice.do?no_no="+categrp_NoticeVO.getCategoryno()+"'>");
       url.append(title);
       url.append("  </A>");
       url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
       url.append("</LI>");
       name_title_list.add(url.toString()); // ��� ��Ͽ� �ϳ��� notice �߰� 
       
       url.delete(0, url.toString().length()); // StringBuffer ���ڿ� ����
       
     }
   }
   
   mav.addObject("name_title_list", name_title_list);
   mav.addObject("total_count", noticeProc.total_count());
   
   return mav;
 }
 
    
 */
}


