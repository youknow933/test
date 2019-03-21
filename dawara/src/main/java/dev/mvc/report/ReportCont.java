package dev.mvc.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import nation.web.tool.Tool;
import nation.web.tool.Upload;

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

@Controller
public class ReportCont {
  @Autowired
  @Qualifier("dev.mvc.report.ReportProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private ReportProcInter reportProc;
  
  public ReportCont() {
  //  System.out.println("--> ReportCont created.");
  }
  
  
  /**
   * �н����带 Ȯ���մϴ�.
   * @param request
   * @param report_passwd
   * @param report_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value="/report/pwdCheck.do", method=RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  /*public ModelAndView pwdCheck(int report_no, String report_passwd){*/
/*  public int pwdCheck(HttpServletRequest request, @RequestParam(value="report_no") int report_no,
      @RequestParam(value="report_passwd") String report_passwd){ */  
  public String pwdCheck(HttpServletRequest request, @RequestParam(value="report_no") int report_no,
                                 @RequestParam(value="report_passwd") String report_passwd){
    // System.out.println("--> passwd_update() POST called.");
    //ModelAndView mav = new ModelAndView();
    System.out.println("-->Cont, report_no: " + report_no);
    System.out.println("-->Cont, report_passwd: " + report_passwd);
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("report_no", report_no); //
    hashMap.put("report_passwd", report_passwd); //
    System.out.println("-->Cont, hashMap: " + hashMap);
    
    int count = reportProc.pwdCheck(hashMap); // �Էµ� �н����� �˻�
    System.out.println("-->Cont, count: " + count);
    
    JSONObject obj = new JSONObject();
    obj.put("count", count);
    
    System.out.println(obj);
    
    if (count == 1) { // �н����� ��ġ
      System.out.println("--> �н����� ��ġ ");
      //mav.addObject("count", count);
       // mav.setViewName("redirect:/report/read.do?report_no="+report_no);      // �н����尡 ��ġ�ϸ� �ش� �Խù��� �о� ��
      
    } else {
      System.out.println("--> �н����� ����ġ ");
      //mav.addObject("count", count);
       // mav.setViewName("redirect:/report/list_by_report.jsp");
    }
    //return mav;
    return obj.toJSONString();
  } 
  
  @RequestMapping(value="/report/list_all.do", method=RequestMethod.GET)
  public ModelAndView list_all(){   
    ModelAndView mav = new ModelAndView();
   
    mav.setViewName("/report/list_by_report"); // webapp/report/list_by_report.jsp
    
    List<ReportVO> list_all = reportProc.list_all();
    mav.addObject("list_all", list_all);
     
    return mav;
  }
  
/*  *//**
   * �˻� ���
   * @param mem_no
   * @param word
   * @return
   *//*
  @RequestMapping(value = "/report/list_by_report_paging.do", method = RequestMethod.GET)
  public ModelAndView list_by_report_search(
      @RequestParam(value="mem_no") int mem_no,
      @RequestParam(value="report_search") String report_search,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) {
    // System.out.println("--> list_by_category(int report_no, String word_find) GET called.");
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/report/list_by_report_no"); // webapp/report/list_by_report_no.jsp
    
    // �˻� ��� �߰�, webapp/report/list_by_report_search.jsp
   // mav.setViewName("/report/list_by_report_search");   
     mav.setViewName("/report/list_by_report_search_paging");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{mem_no}
    hashMap.put("report_search", report_search); // #{report_search}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);                  // #{nowPage}

    // System.out.println("mem_no: " + mem_no);
    // System.out.println("word_find: " + word_find);
    
    // �˻� ���
    List<ReportVO> list_by_report_search = reportProc.list_by_report_search(hashMap);
    mav.addObject("list_by_report_search", list_by_report_search);
    
    // �˻��� ���ڵ� ����
    int search_count = reportProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    ReportVO reportVO = reportProc.read(mem_no);
    mav.addObject("reportVO", reportVO);
    
    // mav.addObject("word", word);
    
    return mav;
  }
  */
  
//  list_by_report.do���� ��� + �˻� + ����¡ ����
  @RequestMapping(value="/report/list_by_report.do", method=RequestMethod.GET)
  public ModelAndView list_by_report(   
//      @RequestParam(value="mem_no") int mem_no,
      HttpSession session,
      @RequestParam(value="report_search", defaultValue="") String report_search,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ){
    //System.out.println("--> nowPage: " + nowPage);
    ModelAndView mav = new ModelAndView();

    int mem_no = (Integer)session.getAttribute("mem_no");
//    System.out.println("mem_no: " + mem_no);
    
    //  �˻� ��� �߰�
    //mav.setViewName("/report/list_by_report");   
   
 
    //// ����¡ ��� �߰�,  /webapp/report/list_by_report_search_paging.jsp
    mav.setViewName("/report/list_by_report");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{mem_no}
    hashMap.put("report_search", report_search); // #{report_search}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);                  // #{nowPage}

    
    //list_by_report_search : �˻�, ����¡ ��� ���� �� mybatis id    
    List<ReportVO> list_by_report = reportProc.list_by_report_search(hashMap);
    mav.addObject("list_by_report", list_by_report);
   
    /*
    // �˻� ���
    List<ReportVO> list = reportProc.list_by_report_search(hashMap);
    mav.addObject("list", list);
   */
    
    // �˻��� ���ڵ� ����
    int search_count = reportProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    List<ReportVO> reportVO = reportProc.read_mem_no(mem_no);
    mav.addObject("reportVO", reportVO);
    
    
    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     *
     * @param report_no ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = reportProc.paging(report_search, mem_no, search_count, nowPage, word);
    //String paging = reportProc.paging(report_no, search_count, nowPage, word);
    mav.addObject("paging", paging);

   // mav.addObject("mem_no", mem_no);
    mav.addObject("nowPage", nowPage);
     
    return mav;
  }
  
  
  @RequestMapping(value="/report/create.do", method=RequestMethod.GET)
  public ModelAndView create(int report_no) {
    ModelAndView mav = new ModelAndView();
    
    ReportVO reportVO = reportProc.read(report_no);
    mav.addObject("reportVO", reportVO);
//    if (reportProc != null) {
//      System.out.println("--> reportProc: " + reportProc.hashCode());
//    }
    mav.setViewName("/report/create"); // /report/create.jsp
    
    return mav;
  }

  
  @RequestMapping(value="/report/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, ReportVO reportVO, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
//    if (reportProc != null) {
//      System.out.println("--> reportProc: " + reportProc.hashCode());
//    }
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    String mem_id = (String)session.getAttribute("mem_id");
    int mem_no = (Integer)session.getAttribute("mem_no"); 
    // System.out.println("reportVO.getReportno(): " + reportVO.getReportno());
    // System.out.println("reportVO.getTitle(): " + reportVO.getTitle());
    
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/report/storage");
    List<MultipartFile> filesMF = reportVO.getFilesMF(); // Spring�� File ��ü�� �����ص�.
    
    // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
    
    String report_files = ""; // �÷��� ������ ���ϸ�
    String files_item = ""; // �ϳ��� ���ϸ�
    String report_sizes = "";
    long sizes_item = 0;   // �ϳ��� ���� ������
    String report_thumbs = "";         // Thumb ���ϵ�
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
          report_files = report_files + "/" + files_item;  // file1.jpg/file2.jpg/file3.jpg
          report_sizes = report_sizes + "/" + sizes_item;   // 12546/78956/42658
          report_thumbs = report_thumbs + "/" + thumbs_item;
        } else if (multipartFile.getSize() > 0){ // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ
          report_files = files_item;         // file1.jpg
          report_sizes = "" + sizes_item; // 123456
          report_thumbs = thumbs_item;
        }
      }
    }
    reportVO.setReport_files(report_files);
    reportVO.setReport_sizes(report_sizes);
    reportVO.setReport_thumbs(report_thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    reportVO.setReport_write(mem_id);
    if (reportProc.create(reportVO) == 1) {
      // msgs.add("QnA�� ����߽��ϴ�.");
      mav.setViewName("redirect:/report//list_by_report.do?report_search=report_no&word=&mem_no=1");
      //mav.setViewName("redirect:/report/list_by_report.do?report_search=report_no&word=&mem_no=1");
//      mav.setViewName("redirect:/report/list_all.do?mem_no=" + reportVO.getMem_no());
    } else { 
      msgs.add("QnA ��Ͽ� �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� �� ����: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back();\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list_by_report.do?report_search=report_no&word=&mem_no=1\">���</button>");

      mav.addObject("msgs", msgs);
      // request.setAttribute("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/report/message"); // /report/message.jsp
    }

    return mav;
  }
  
  @RequestMapping(value = "/report/read.do", method = RequestMethod.GET)
  public ModelAndView read(int report_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/report/read"); // /webapp/report/read.jsp

    ReportVO reportVO = reportProc.read(report_no);
    reportProc.increaseCnt(report_no); // ��ȸ�� ����
    mav.addObject("reportVO", reportVO);
    
    ArrayList<Report_fileVO> file_list = new ArrayList<Report_fileVO>();
    
    String thumbs = reportVO.getReport_thumbs();
    String files = reportVO.getReport_files();
    String sizes = reportVO.getReport_sizes();
    
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
      
        Report_fileVO fileVO = new Report_fileVO(thumbs_array[index], files_array[index], sizes_array[index]);
        file_list.add(fileVO);
      }
    } 
    mav.addObject("file_list", file_list);
   
    return mav;
  }
  
 /* @RequestMapping(value = "/report/read_mem_no.do", method = RequestMethod.GET)
  public ModelAndView read_mem_no(int mem_no) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/report/list_all"); // webapp/report/list_all.jsp
    
    List<ReportVO> list_all = reportProc.list_all();
    mav.addObject("list_all", list_all);
     
    return mav;
  }*/
/*
  @RequestMapping(value = "/report/read_by_mem_no.do", method = RequestMethod.GET)
  public ModelAndView read_by_mem_no(int mem_no) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/report/list_all"); // webapp/report/list_all.jsp
    
    List<ReportVO> read_by_mem_no = reportProc.read_by_mem_no(mem_no);
    mav.addObject("read_by_mem_no", read_by_mem_no);
     
    return mav;
  }*/
  
 /* @RequestMapping(value="/report/list_index.do", method=RequestMethod.GET)
  public ModelAndView list_index(HttpServletRequest request){
    // System.out.println("--> list_index() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/report/list_index"); // webapp/report/list_index.jsp
    
    List<ReportVO> report_list = reportProc.list(); // ī�װ� �׷� ���
    
    // Categrp: name, Category: title ���� ���
    ArrayList<String> name_title_list = new ArrayList<String>();   
    
    StringBuffer url = new StringBuffer(); // ī�װ� ���� ��ũ ����

    // ī�װ� �׷� ������ŭ ��ȯ
    for (int index = 0; index < report_list.size(); index++) {
      ReportVO reportVO = report_list.get(index);

      name_title_list.add("<LI class='categrp_name'>"+ reportVO.get() + "</LI>");

      List<Categrp_ReportVO> report_list = reportProc.list_by_report_no(reportVO.getReportno()); // ī�װ� Join ���
      
      // ī�װ� ������ŭ ��ȯ
      for (int j=0; j < report_list.size(); j++) {
        Categrp_ReportVO categrp_ReportVO = report_list.get(j);
        String title = categrp_ReportVO.getTitle(); // ī�װ� �̸�
        int cnt = categrp_ReportVO.getCnt();
        
        url.append("<LI class='report_title'>");
        url.append("  <A href='" + request.getContextPath()+ "/content/list_by_report.do?report_no"+categrp_ReportVO.getReport_no()+"'>");
        url.append(title);
        url.append("  </A>");
        url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
        url.append("</LI>");
        name_title_list.add(url.toString()); // ��� ��Ͽ� �ϳ��� report �߰� 
        
        url.delete(0, url.toString().length()); // StringBuffer ���ڿ� ����
        
      }
    }
    
    mav.addObject("name_title_list", name_title_list);
    mav.addObject("total_count", reportProc.total_count());
    
    return mav;
  }*/
  
  
  /**
  <Xmp>
    ���� �� 
    SELECT report_no, mem_no, report_title, report_write, report_rdate, report_cnt, report_report, report_visible, report_seqno
    FROM report 
    WHERE report_no=#{report_no} 
  </Xmp>
  * 
  * @param report_no
  * @return
  */
 @ResponseBody
 @RequestMapping(value = "/report/update.do", method = RequestMethod.GET, 
                           produces = "text/plain;charset=UTF-8")
 public ModelAndView update(int report_no) {
// System.out.println("--> update() GET executed");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/report/update"); // /webapp/report/update.jsp

   ReportVO reportVO = reportProc.read(report_no);
   mav.addObject("reportVO", reportVO);
   
   ArrayList<Report_fileVO> file_list = new ArrayList<Report_fileVO>();
   
   String thumbs = reportVO.getReport_thumbs();
   String files = reportVO.getReport_files();
   String sizes = reportVO.getReport_sizes();
   
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
     
       Report_fileVO fileVO = new Report_fileVO(thumbs_array[index], files_array[index], sizes_array[index]);
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
  * @param reportVO
  * @return
  */
 @RequestMapping(value = "/report/update.do", 
                            method = RequestMethod.POST)
 public ModelAndView update(RedirectAttributes redirectAttributes,
                            HttpServletRequest request, ReportVO reportVO) {
// System.out.println("--> update() POST executed");
   ModelAndView mav = new ModelAndView();

   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/report/storage");
   List<MultipartFile> filesMF = reportVO.getFilesMF(); // Spring�� File ��ü�� �����ص�.
   
   // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
   
   String files = ""; // �÷��� ������ ���ϸ�
   String files_item = ""; // �ϳ��� ���ϸ�
   String sizes = "";
   long sizes_item = 0;   // �ϳ��� ���� ������
   String thumbs = "";         // Thumb ���ϵ�
   String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�
   
   int count = filesMF.size();

   // ���� ��� ���� �о��.
   ReportVO reportVO_old = reportProc.read(reportVO.getReport_no());
   
   if (filesMF.get(0).getSize() > 0) { // ���� ������ �����Ѵٸ�
     // System.out.println("3) ���ο� ������ ����մϴ�.");
     // ���� ���� ����
     
     String thumbs_old = reportVO_old.getReport_thumbs();
     String files_old = reportVO_old.getReport_files();
     
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
     files = reportVO_old.getReport_files();
     sizes = reportVO_old.getReport_sizes();
     thumbs = reportVO_old.getReport_thumbs();
   } 
   reportVO.setReport_files(files);
   reportVO.setReport_sizes(sizes);
   reportVO.setReport_thumbs(thumbs);
   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   
   /*
    // ȸ�� ���� �� session ���κ���
   reportVO.setMno(1);*/
   
   count = reportProc.update(reportVO);
   
   redirectAttributes.addAttribute("count", count); // 1 or 0
   redirectAttributes.addAttribute("report_no", reportVO.getReport_no());
   redirectAttributes.addAttribute("mem_no", reportVO.getMem_no());

   mav.setViewName("redirect:/report/message_update.jsp");
   
   return mav;
 }
 
 @RequestMapping(value = "/report/delete_img.do", method = RequestMethod.GET)
 public ModelAndView delete_img(int report_no) {
   // System.out.println("--> delete() GET executed");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/report/update"); // /webapp/report/delete.jsp

   ReportVO reportVO = reportProc.read(report_no);
   mav.addObject("reportVO", reportVO);
   
   return mav;
 }
 

 /**
  * �̹��� ���� ó��
  * @param report_no ī�װ� �׷� ��ȣ
  * @param report_no ������ ���ڵ� ��ȣ
  * @return
  */
 @RequestMapping(value = "/report/delete_img.do", method = RequestMethod.POST)
 public ModelAndView delete_img(RedirectAttributes redirectAttributes,
               HttpServletRequest request, int report_no) { 

   ModelAndView mav = new ModelAndView();

   ArrayList<String> msgs = new ArrayList<String>();
   ArrayList<String> links = new ArrayList<String>();

   ReportVO reportVO = reportProc.read(report_no);
   String report_files = reportVO.getReport_files();
   String report_thumbs = reportVO.getReport_thumbs();
   // System.out.println("--> report_files: " + report_files); //  sw35.jpg/sw36.jpg/sw37.jpg
   String upDir = Tool.getRealPath(request, "/report/storage");
   
   StringTokenizer st = new StringTokenizer(report_files, "/");  // Thumbs

   while(st.hasMoreTokens()) { // �ܾ �ִ��� �˻�
     String fname = upDir + st.nextToken(); // �ܾ� ����
     Tool.deleteFile(fname);
   }
   
   StringTokenizer st2 = new StringTokenizer(report_thumbs, "/");  // Thumbs

   while(st2.hasMoreTokens()) { // �ܾ �ִ��� �˻�
     String fname = upDir + st2.nextToken(); // �ܾ� ����
     Tool.deleteFile(fname);
   }
   
   int count = reportProc.delete_img(report_no);

   if (count == 1) {
     
     msgs.add("÷�� ������ �����߽��ϴ�.");
     mav.setViewName("redirect:/report/list_all.do");     
   } else {
     msgs.add("QnA ������ �����߽��ϴ�.");
     msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");
     links.add("<button type='button' onclick=\"location.href='./list_all.do?report_no=" + report_no + "'\">���</button>");

     mav.addObject("msgs", msgs);
     mav.addObject("links", links);

     mav.setViewName("/report/message"); // /webapp/report/message.jsp
   }

   return mav;
 }
 
 
 /**
  * 
  * ����
  * @param report_no
  * @return
  */
 
 @RequestMapping(value = "/report/delete.do", method = RequestMethod.GET)
 public ModelAndView delete(int report_no) {
   // System.out.println("--> delete() GET executed");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/report/delete"); // /webapp/report/delete.jsp

   ReportVO reportVO = reportProc.read(report_no);
   mav.addObject("reportVO", reportVO);
   
   /*ReportVO reportVO = reportProc.read(reportno);
   mav.addObject("reportVO", reportVO);*/
   
   return mav;
 }
 

 /**
  * ���� ó��
  * @param report_no ī�װ� �׷� ��ȣ
  * @param report_no ������ ���ڵ� ��ȣ
  * @return
  */
 @RequestMapping(value = "/report/delete.do", method = RequestMethod.POST)
 public ModelAndView delete(RedirectAttributes redirectAttributes,
               HttpServletRequest request, int report_no) { 

   ModelAndView mav = new ModelAndView();

   ArrayList<String> msgs = new ArrayList<String>();
   ArrayList<String> links = new ArrayList<String>();

   int count = reportProc.delete(report_no);
// System.out.println("report_no: " + report_no);
// System.out.println("count: " + count);

   if (count == 1) {
     // msgs.add("QnA�� �����߽��ϴ�.");
     mav.setViewName("redirect:/report//list_by_report.do?report_search=report_no&word=&mem_no=1");     
     //mav.setViewName("redirect:/report/list_by_report.do?report_search=report_no&word=&mem_no=1");     
   } else {
     msgs.add("QnA ������ �����߽��ϴ�.");
     msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");
     //links.add("<button type='button' onclick=\"location.href='./list_all.do?report_no=" + report_no + "'\">���</button>");
     links.add("<button type='button' onclick=\"location.href='./list_by_report.do?report_search=report_no&word=&mem_no=1'\">���</button>");

     mav.addObject("msgs", msgs);
     mav.addObject("links", links);

     mav.setViewName("/report/message"); // /webapp/report/message.jsp
   }

   return mav;
 }
 
 @RequestMapping(value="/report/reply.do", method=RequestMethod.GET)
 public ModelAndView reply(ReportVO reportVO){
   // System.out.println("--> reply() GET called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/report/reply"); // webapp/report/reply.jsp
   
   reportVO = reportProc.read(reportVO.getReport_no());
   mav.addObject("reportVO", reportVO);  // FK column
   
   return mav;
 }

 
 // �亯
 @RequestMapping(value="/report/reply.do", method=RequestMethod.POST)
 public ModelAndView reply(RedirectAttributes redirectAttributes, 
                                      HttpServletRequest request, 
                                      ReportVO reportVO,
                                     
                                      String word){
   // System.out.println("--> create() POST called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/report/reply"); // webapp/report/reply.jsp
   
   ArrayList<String> msgs = new ArrayList<String>();
   ArrayList<String> links = new ArrayList<String>();
   
   int report_no = reportVO.getReport_no();

   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/report/storage");
   List<MultipartFile> filesMF = reportVO.getFilesMF(); // Spring�� File ��ü�� �����ص�.
   
   // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
   
   String files = ""; // �÷��� ������ ���ϸ�
   String files_item = ""; // �ϳ��� ���ϸ�
   String sizes = "";
   long sizes_item = 0;   // �ϳ��� ���� ������
   String thumbs = "";         // Thumb ���ϵ�
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
         files = files + "/" + files_item;  // file1.jpg/file2.jpg/file3.jpg
         sizes = sizes + "/" + sizes_item;   // 12546/78956/42658
         thumbs = thumbs + "/" + thumbs_item;
       } else if (multipartFile.getSize() > 0){ // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ
         files = files_item;         // file1.jpg
         sizes = "" + sizes_item; // 123456
         thumbs = thumbs_item;
       }
     }
   }
   reportVO.setReport_files(files);
   reportVO.setReport_sizes(sizes);
   reportVO.setReport_thumbs(thumbs);
   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   
   // ȸ�� ���� �� session ���κ���
   // int mno = (Integer)session.getAttribute("mno");
  // reportVO.setMno(1);
   
   String root = request.getContextPath();
   
   // --------------------------- �亯 ���� �ڵ� ���� --------------------------
   ReportVO parentVO = reportProc.read(reportVO.getReport_no()); // �θ�� ���� ����
   reportVO.setReport_grpno(parentVO.getReport_grpno()); // �׷� ��ȣ
   reportVO.setReport_ansnum(parentVO.getReport_ansnum()); // �亯 ����

   reportProc.updateAnsnum(reportVO); // ���� ��ϵ� �亯 �ڷ� +1 ó����.

   reportVO.setReport_indent(parentVO.getReport_indent() + 1); // �亯 ���� ����
   reportVO.setReport_ansnum(parentVO.getReport_ansnum() + 1); // �θ� �ٷ� �Ʒ� ���
   // --------------------------- �亯 ���� �ڵ� ���� --------------------------
   
   count = reportProc.reply(reportVO); // DBMS �亯 ó��
/*   
   if (count == 1) {
     reportProc.increaseCnt(report_no); // �� �� ����
   }
   */
   redirectAttributes.addAttribute("count", count); // 1 or 0
   redirectAttributes.addAttribute("report_no", reportVO.getReport_no());
   /*redirectAttributes.addAttribute("nowPage", nowPage);*/
   redirectAttributes.addAttribute("word", word);
   
   mav.setViewName("redirect:/report/message_reply.jsp");
   
   return mav;
 }
 
 
 
 
 /*@RequestMapping(value = "/report/show_hide.do", method = RequestMethod.GET)
 public ModelAndView show_hide(int report_no) {
   ModelAndView mav = new ModelAndView();

   mav.setViewName("/report/list_by_report");   
   
   ReportVO show_hide = reportProc.show_hide(report_no);
   mav.addObject("show_hide", show_hide);

   return mav;
 }
 */
 
/*
 @RequestMapping(value = "/report/update_seqreport_up.do", method = RequestMethod.POST)
 public ModelAndView update_seqreport_up(int report_no) {
   ModelAndView mav = new ModelAndView();

   if (reportProc.update_seqreport_up(report_no) == 1) {
     mav.setViewName("redirect:/report/list.do?report_no=" + report_no);
   }

   return mav;
 }

 @RequestMapping(value = "/report/update_seqreport_down.do", method = RequestMethod.POST)
 public ModelAndView update_seqreport_down(int report_no) {
   ModelAndView mav = new ModelAndView();

   if (reportProc.update_seqreport_down(report_no) == 1) {
     mav.setViewName("redirect:/report/list.do?report_no=" + report_no);
   }

   return mav;
 }*/
/*
 @RequestMapping(value="/report/list_index_left.do", method=RequestMethod.GET)
 public ModelAndView list_index_left(HttpServletRequest request){
   // System.out.println("--> list_index() GET called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/report/list_index_left"); // webapp/report/list_index_left.jsp
   
   List<ReportVO> report_list = reportProc.list(); // ī�װ� �׷� ���
   
   // Categrp: name, Category: title ���� ���
   ArrayList<String> name_title_list = new ArrayList<String>();   
   
   StringBuffer url = new StringBuffer(); // ī�װ� ���� ��ũ ����

   // ī�װ� �׷� ������ŭ ��ȯ
   for (int index = 0; index < report_list.size(); index++) {
     ReportVO reportVO = report_list.get(index);

     name_title_list.add("<LI class='categrp_name'>"+ reportVO.getName() + "</LI>");

     List<Categrp_ReportVO> report_list = reportProc.list_by_report_no(reportVO.getReportno()); // ī�װ� Join ���
     
     // ī�װ� ������ŭ ��ȯ
     for (int j=0; j < report_list.size(); j++) {
       Categrp_ReportVO categrp_ReportVO = report_list.get(j);
       String title = categrp_ReportVO.getTitle(); // ī�װ� �̸�
       int cnt = categrp_ReportVO.getCnt();
       
       url.append("<LI class='report_title'>");
       url.append("  <A href='" + request.getContextPath()+ "/report/list_by_report.do?report_no="+categrp_ReportVO.getReport_no()+"'>");
       url.append(title);
       url.append("  </A>");
       url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
       url.append("</LI>");
       name_title_list.add(url.toString()); // ��� ��Ͽ� �ϳ��� report �߰� 
       
       url.delete(0, url.toString().length()); // StringBuffer ���ڿ� ����
       
     }
   }
   
   mav.addObject("name_title_list", name_title_list);
   mav.addObject("total_count", reportProc.total_count());
   
   return mav;
 }
 
    
 */
}


