package dev.mvc.qna;

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

import dev.mvc.qna.QnaVO;
import dev.mvc.qna.QnaProcInter;

@Controller
public class QnaCont {
  @Autowired
  @Qualifier("dev.mvc.qna.QnaProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private QnaProcInter qnaProc;
  
  public QnaCont() {
  //  System.out.println("--> QnaCont created.");
  }
  
  
  /*
  @RequestMapping(value="/qna/pwdCheck.do", method=RequestMethod.GET)
  public ModelAndView pwdCheck(int qna_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/qna/read"); // /webapp/qna/read.jsp

    
    QnaVO qnaVO = qnaProc.read(qna_no);
    qnaProc.increaseCnt(qna_no); // ��ȸ�� ����
    mav.addObject("qnaVO", qnaVO);
    
    ArrayList<Qna_fileVO> file_list = new ArrayList<Qna_fileVO>();
    
    String thumbs = qnaVO.getQna_thumbs();
    String files = qnaVO.getQna_files();
    String sizes = qnaVO.getQna_sizes();
    
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
      
        Qna_fileVO fileVO = new Qna_fileVO(thumbs_array[index], files_array[index], sizes_array[index]);
        file_list.add(fileVO);
      }
    } 
    mav.addObject("file_list", file_list);
   
    return mav;
  }
  */
  
  /**
   * �н����带 Ȯ���մϴ�.
   * @param request
   * @param qna_passwd
   * @param qna_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value="/qna/pwdCheck.do", method=RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  /*public ModelAndView pwdCheck(int qna_no, String qna_passwd){*/
/*  public int pwdCheck(HttpServletRequest request, @RequestParam(value="qna_no") int qna_no,
      @RequestParam(value="qna_passwd") String qna_passwd){ */  
  public String pwdCheck(HttpServletRequest request, @RequestParam(value="qna_no") int qna_no,
                                 @RequestParam(value="qna_passwd") String qna_passwd){
    // System.out.println("--> passwd_update() POST called.");
    //ModelAndView mav = new ModelAndView();
    System.out.println("-->Cont, qna_no: " + qna_no);
    System.out.println("-->Cont, qna_passwd: " + qna_passwd);
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("qna_no", qna_no); //
    hashMap.put("qna_passwd", qna_passwd); //
    System.out.println("-->Cont, hashMap: " + hashMap);
    
    int count = qnaProc.pwdCheck(hashMap); // �Էµ� �н����� �˻�
    System.out.println("-->Cont, count: " + count);
    
    JSONObject obj = new JSONObject();
    obj.put("count", count);
    
    System.out.println(obj);
    
    if (count == 1) { // �н����� ��ġ
      System.out.println("--> �н����� ��ġ ");
      //mav.addObject("count", count);
       // mav.setViewName("redirect:/qna/read.do?qna_no="+qna_no);      // �н����尡 ��ġ�ϸ� �ش� �Խù��� �о� ��
      
    } else {
      System.out.println("--> �н����� ����ġ ");
      //mav.addObject("count", count);
       // mav.setViewName("redirect:/qna/list_by_qna.jsp");
    }
    //return mav;
    return obj.toJSONString();
  } 
  
  @RequestMapping(value="/qna/list_all.do", method=RequestMethod.GET)
  public ModelAndView list_all(){   
    System.out.println("qna list_all.do called!");
    ModelAndView mav = new ModelAndView();
   
    mav.setViewName("/qna/list_by_qna"); // webapp/qna/list_by_qna.jsp
    
    List<QnaVO> list_all = qnaProc.list_all();
    mav.addObject("list_all", list_all);
     
    return mav;
  }
  
/*  *//**
   * �˻� ���
   * @param mem_no
   * @param word
   * @return
   *//*
  @RequestMapping(value = "/qna/list_by_qna_paging.do", method = RequestMethod.GET)
  public ModelAndView list_by_qna_search(
      @RequestParam(value="mem_no") int mem_no,
      @RequestParam(value="qna_search") String qna_search,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) {
    // System.out.println("--> list_by_category(int qna_no, String word_find) GET called.");
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/qna/list_by_qna_no"); // webapp/qna/list_by_qna_no.jsp
    
    // �˻� ��� �߰�, webapp/qna/list_by_qna_search.jsp
   // mav.setViewName("/qna/list_by_qna_search");   
     mav.setViewName("/qna/list_by_qna_search_paging");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{mem_no}
    hashMap.put("qna_search", qna_search); // #{qna_search}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);                  // #{nowPage}

    // System.out.println("mem_no: " + mem_no);
    // System.out.println("word_find: " + word_find);
    
    // �˻� ���
    List<QnaVO> list_by_qna_search = qnaProc.list_by_qna_search(hashMap);
    mav.addObject("list_by_qna_search", list_by_qna_search);
    
    // �˻��� ���ڵ� ����
    int search_count = qnaProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    QnaVO qnaVO = qnaProc.read(mem_no);
    mav.addObject("qnaVO", qnaVO);
    
    // mav.addObject("word", word);
    
    return mav;
  }
  */
  
//  list_by_qna.do���� ��� + �˻� + ����¡ ����
  @RequestMapping(value="/qna/list_by_qna.do", method=RequestMethod.GET)
  public ModelAndView list_by_qna(   
//      @RequestParam(value="mem_no") int mem_no,
      HttpSession session,
      @RequestParam(value="qna_search", defaultValue="") String qna_search,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ){
//    System.out.println("--> nowPage: " + nowPage);
    ModelAndView mav = new ModelAndView();
    
    int mem_no = (Integer)session.getAttribute("mem_no");
//    System.out.println("mem_no: " + mem_no);
    
    //  �˻� ��� �߰�
    //mav.setViewName("/qna/list_by_qna");   
 
    //// ����¡ ��� �߰�,  /webapp/qna/list_by_qna_search_paging.jsp
    mav.setViewName("/qna/list_by_qna");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{mem_no}
    hashMap.put("qna_search", qna_search); // #{qna_search}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);                  // #{nowPage}

    
    //list_by_qna_search : �˻�, ����¡ ��� ���� �� mybatis id    
    List<QnaVO> list_by_qna = qnaProc.list_by_qna_search(hashMap);
    mav.addObject("list_by_qna", list_by_qna);
   
    /*
    // �˻� ���
    List<QnaVO> list = qnaProc.list_by_qna_search(hashMap);
    mav.addObject("list", list);
   */
    
    // �˻��� ���ڵ� ����
    int search_count = qnaProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    List<QnaVO> qnaVO = qnaProc.read_mem_no(mem_no);
    mav.addObject("qnaVO", qnaVO);
    
    
    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     *
     * @param qna_no ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = qnaProc.paging(qna_search, mem_no, search_count, nowPage, word);
    //String paging = qnaProc.paging(qna_no, search_count, nowPage, word);
    mav.addObject("paging", paging);

   // mav.addObject("mem_no", mem_no);
    mav.addObject("nowPage", nowPage);
     
    return mav;
  }
  
  @RequestMapping(value="/qna/create.do", method=RequestMethod.GET)
  public ModelAndView create(int qna_no) {
    ModelAndView mav = new ModelAndView();
    
    QnaVO qnaVO = qnaProc.read(qna_no);
    mav.addObject("qnaVO", qnaVO);
//    if (qnaProc != null) {
//      System.out.println("--> qnaProc: " + qnaProc.hashCode());
//    }
    mav.setViewName("/qna/create"); // /qna/create.jsp
    
    return mav;
  }

  @RequestMapping(value="/qna/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, QnaVO qnaVO, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    System.out.println("QnA create.do POST called.");
//    if (qnaProc != null) {
//      System.out.println("--> qnaProc: " + qnaProc.hashCode());
//    }
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    String mem_id = (String)session.getAttribute("mem_id");
    int mem_no = (Integer)session.getAttribute("mem_no"); 
    
    // System.out.println("qnaVO.getQnano(): " + qnaVO.getQnano());
    // System.out.println("qnaVO.getTitle(): " + qnaVO.getTitle());
    
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/qna/storage");
    List<MultipartFile> filesMF = qnaVO.getFilesMF(); // Spring�� File ��ü�� �����ص�.
    
    // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
    
    String qna_files = ""; // �÷��� ������ ���ϸ�
    String files_item = ""; // �ϳ��� ���ϸ�
    String qna_sizes = "";
    long sizes_item = 0;   // �ϳ��� ���� ������
    String qna_thumbs = "";         // Thumb ���ϵ�
    String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�
    
    int count = filesMF.size();
    
     System.out.println("--> ContentsCont count: " + count);
    
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
          qna_files = qna_files + "/" + files_item;  // file1.jpg/file2.jpg/file3.jpg
          qna_sizes = qna_sizes + "/" + sizes_item;   // 12546/78956/42658
          qna_thumbs = qna_thumbs + "/" + thumbs_item;
        } else if (multipartFile.getSize() > 0){ // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ
          qna_files = files_item;         // file1.jpg
          qna_sizes = "" + sizes_item; // 123456
          qna_thumbs = thumbs_item;
        }
      }
    }
    qnaVO.setQna_files(qna_files);
    qnaVO.setQna_sizes(qna_sizes);
    qnaVO.setQna_thumbs(qna_thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    
    qnaVO.setQna_write(mem_id);
    
    if (qnaProc.create(qnaVO) == 1) {
      // msgs.add("QnA�� ����߽��ϴ�.");
      mav.setViewName("redirect:/qna//list_by_qna.do?qna_search=qna_no&mem_no=1");
      //mav.setViewName("redirect:/qna/list_by_qna.do?qna_search=qna_no&word=&mem_no=1");
//      mav.setViewName("redirect:/qna/list_all.do?mem_no=" + qnaVO.getMem_no());
    } else { 
      msgs.add("QnA ��Ͽ� �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� �� ����: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back();\">�ٽ� �õ�</button>");
      links.add("<button type='button' onclick=\"location.href='./list_by_qna.do?qna_search=qna_no&word=&mem_no=1\">���</button>");

      mav.addObject("msgs", msgs);
      // request.setAttribute("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/qna/message"); // /qna/message.jsp
    }

    return mav;
  }
  
  @RequestMapping(value = "/qna/read.do", method = RequestMethod.GET)
  public ModelAndView read(int qna_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/qna/read"); // /webapp/qna/read.jsp

    
    QnaVO qnaVO = qnaProc.read(qna_no);
    qnaProc.increaseCnt(qna_no); // ��ȸ�� ����
    mav.addObject("qnaVO", qnaVO);
    
    ArrayList<Qna_fileVO> file_list = new ArrayList<Qna_fileVO>();
    
    String thumbs = qnaVO.getQna_thumbs();
    String files = qnaVO.getQna_files();
    String sizes = qnaVO.getQna_sizes();
    
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
      
        Qna_fileVO fileVO = new Qna_fileVO(thumbs_array[index], files_array[index], sizes_array[index]);
        file_list.add(fileVO);
      }
    } 
    mav.addObject("file_list", file_list);
   
    return mav;
  }
  
 /* @RequestMapping(value = "/qna/read_mem_no.do", method = RequestMethod.GET)
  public ModelAndView read_mem_no(int mem_no) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/qna/list_all"); // webapp/qna/list_all.jsp
    
    List<QnaVO> list_all = qnaProc.list_all();
    mav.addObject("list_all", list_all);
     
    return mav;
  }*/
/*
  @RequestMapping(value = "/qna/read_by_mem_no.do", method = RequestMethod.GET)
  public ModelAndView read_by_mem_no(int mem_no) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/qna/list_all"); // webapp/qna/list_all.jsp
    
    List<QnaVO> read_by_mem_no = qnaProc.read_by_mem_no(mem_no);
    mav.addObject("read_by_mem_no", read_by_mem_no);
     
    return mav;
  }*/
  
 /* @RequestMapping(value="/qna/list_index.do", method=RequestMethod.GET)
  public ModelAndView list_index(HttpServletRequest request){
    // System.out.println("--> list_index() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/qna/list_index"); // webapp/qna/list_index.jsp
    
    List<QnaVO> qna_list = qnaProc.list(); // ī�װ� �׷� ���
    
    // Categrp: name, Category: title ���� ���
    ArrayList<String> name_title_list = new ArrayList<String>();   
    
    StringBuffer url = new StringBuffer(); // ī�װ� ���� ��ũ ����

    // ī�װ� �׷� ������ŭ ��ȯ
    for (int index = 0; index < qna_list.size(); index++) {
      QnaVO qnaVO = qna_list.get(index);

      name_title_list.add("<LI class='categrp_name'>"+ qnaVO.get() + "</LI>");

      List<Categrp_QnaVO> qna_list = qnaProc.list_by_qna_no(qnaVO.getQnano()); // ī�װ� Join ���
      
      // ī�װ� ������ŭ ��ȯ
      for (int j=0; j < qna_list.size(); j++) {
        Categrp_QnaVO categrp_QnaVO = qna_list.get(j);
        String title = categrp_QnaVO.getTitle(); // ī�װ� �̸�
        int cnt = categrp_QnaVO.getCnt();
        
        url.append("<LI class='qna_title'>");
        url.append("  <A href='" + request.getContextPath()+ "/content/list_by_qna.do?qna_no"+categrp_QnaVO.getQna_no()+"'>");
        url.append(title);
        url.append("  </A>");
        url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
        url.append("</LI>");
        name_title_list.add(url.toString()); // ��� ��Ͽ� �ϳ��� qna �߰� 
        
        url.delete(0, url.toString().length()); // StringBuffer ���ڿ� ����
        
      }
    }
    
    mav.addObject("name_title_list", name_title_list);
    mav.addObject("total_count", qnaProc.total_count());
    
    return mav;
  }*/
  
  
  /**
  <Xmp>
    ���� �� 
    SELECT qna_no, mem_no, qna_title, qna_write, qna_rdate, qna_cnt, qna_qna, qna_visible, qna_seqno
    FROM qna 
    WHERE qna_no=#{qna_no} 
  </Xmp>
  * 
  * @param qna_no
  * @return
  */
 @ResponseBody
 @RequestMapping(value = "/qna/update.do", method = RequestMethod.GET, 
                           produces = "text/plain;charset=UTF-8")
 public ModelAndView update(int qna_no) {
// System.out.println("--> update() GET executed");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/qna/update"); // /webapp/qna/update.jsp

   QnaVO qnaVO = qnaProc.read(qna_no);
   mav.addObject("qnaVO", qnaVO);
   
   ArrayList<Qna_fileVO> file_list = new ArrayList<Qna_fileVO>();
   
   String thumbs = qnaVO.getQna_thumbs();
   String files = qnaVO.getQna_files();
   String sizes = qnaVO.getQna_sizes();
   
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
     
       Qna_fileVO fileVO = new Qna_fileVO(thumbs_array[index], files_array[index], sizes_array[index]);
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
  * @param qnaVO
  * @return
  */
 @RequestMapping(value = "/qna/update.do", 
                            method = RequestMethod.POST)
 public ModelAndView update(RedirectAttributes redirectAttributes,
                            HttpServletRequest request, QnaVO qnaVO) {
// System.out.println("--> update() POST executed");
   ModelAndView mav = new ModelAndView();

   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/qna/storage");
   List<MultipartFile> filesMF = qnaVO.getFilesMF(); // Spring�� File ��ü�� �����ص�.
   
   // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
   
   String files = ""; // �÷��� ������ ���ϸ�
   String files_item = ""; // �ϳ��� ���ϸ�
   String sizes = "";
   long sizes_item = 0;   // �ϳ��� ���� ������
   String thumbs = "";         // Thumb ���ϵ�
   String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�
   
   int count = filesMF.size();

   // ���� ��� ���� �о��.
   QnaVO qnaVO_old = qnaProc.read(qnaVO.getQna_no());
   
   if (filesMF.get(0).getSize() > 0) { // ���� ������ �����Ѵٸ�
     // System.out.println("3) ���ο� ������ ����մϴ�.");
     // ���� ���� ����
     
     String thumbs_old = qnaVO_old.getQna_thumbs();
     String files_old = qnaVO_old.getQna_files();
     
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
     files = qnaVO_old.getQna_files();
     sizes = qnaVO_old.getQna_sizes();
     thumbs = qnaVO_old.getQna_thumbs();
   } 
   qnaVO.setQna_files(files);
   qnaVO.setQna_sizes(sizes);
   qnaVO.setQna_thumbs(thumbs);
   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   
   /*
    // ȸ�� ���� �� session ���κ���
   qnaVO.setMno(1);*/
   
   count = qnaProc.update(qnaVO);
   
   redirectAttributes.addAttribute("count", count); // 1 or 0
   redirectAttributes.addAttribute("qna_no", qnaVO.getQna_no());
   redirectAttributes.addAttribute("mem_no", qnaVO.getMem_no());

   mav.setViewName("redirect:/qna/message_update.jsp");
   
   return mav;
 }
 
 @RequestMapping(value = "/qna/delete_img.do", method = RequestMethod.GET)
 public ModelAndView delete_img(int qna_no) {
   // System.out.println("--> delete() GET executed");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/qna/update"); // /webapp/qna/delete.jsp

   QnaVO qnaVO = qnaProc.read(qna_no);
   mav.addObject("qnaVO", qnaVO);
   
   return mav;
 }
 

 /**
  * �̹��� ���� ó��
  * @param qna_no ī�װ� �׷� ��ȣ
  * @param qna_no ������ ���ڵ� ��ȣ
  * @return
  */
 @RequestMapping(value = "/qna/delete_img.do", method = RequestMethod.POST)
 public ModelAndView delete_img(RedirectAttributes redirectAttributes,
               HttpServletRequest request, int qna_no) { 

   ModelAndView mav = new ModelAndView();

   ArrayList<String> msgs = new ArrayList<String>();
   ArrayList<String> links = new ArrayList<String>();

   QnaVO qnaVO = qnaProc.read(qna_no);
   String qna_files = qnaVO.getQna_files();
   String qna_thumbs = qnaVO.getQna_thumbs();
   // System.out.println("--> qna_files: " + qna_files); //  sw35.jpg/sw36.jpg/sw37.jpg
   String upDir = Tool.getRealPath(request, "/qna/storage");
   
   StringTokenizer st = new StringTokenizer(qna_files, "/");  // Thumbs

   while(st.hasMoreTokens()) { // �ܾ �ִ��� �˻�
     String fname = upDir + st.nextToken(); // �ܾ� ����
     Tool.deleteFile(fname);
   }
   
   StringTokenizer st2 = new StringTokenizer(qna_thumbs, "/");  // Thumbs

   while(st2.hasMoreTokens()) { // �ܾ �ִ��� �˻�
     String fname = upDir + st2.nextToken(); // �ܾ� ����
     Tool.deleteFile(fname);
   }
   
   int count = qnaProc.delete_img(qna_no);

   if (count == 1) {
     
     msgs.add("÷�� ������ �����߽��ϴ�.");
     mav.setViewName("redirect:/qna/list_all.do");     
   } else {
     msgs.add("QnA ������ �����߽��ϴ�.");
     msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");
     links.add("<button type='button' onclick=\"location.href='./list_all.do?qna_no=" + qna_no + "'\">���</button>");

     mav.addObject("msgs", msgs);
     mav.addObject("links", links);

     mav.setViewName("/qna/message"); // /webapp/qna/message.jsp
   }

   return mav;
 }
 
 
 /**
  * 
  * ����
  * @param qna_no
  * @return
  */
 
 @RequestMapping(value = "/qna/delete.do", method = RequestMethod.GET)
 public ModelAndView delete(int qna_no) {
   // System.out.println("--> delete() GET executed");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/qna/delete"); // /webapp/qna/delete.jsp

   QnaVO qnaVO = qnaProc.read(qna_no);
   mav.addObject("qnaVO", qnaVO);
   
   /*QnaVO qnaVO = qnaProc.read(qnano);
   mav.addObject("qnaVO", qnaVO);*/
   
   return mav;
 }
 

 /**
  * ���� ó��
  * @param qna_no ī�װ� �׷� ��ȣ
  * @param qna_no ������ ���ڵ� ��ȣ
  * @return
  */
 @RequestMapping(value = "/qna/delete.do", method = RequestMethod.POST)
 public ModelAndView delete(RedirectAttributes redirectAttributes,
               HttpServletRequest request, int qna_no) { 

   
   ModelAndView mav = new ModelAndView();

   ArrayList<String> msgs = new ArrayList<String>();
   ArrayList<String> links = new ArrayList<String>();

   int count = qnaProc.delete(qna_no);
// System.out.println("qna_no: " + qna_no);
// System.out.println("count: " + count);

   if (count == 1) {
     // msgs.add("QnA�� �����߽��ϴ�.");
     mav.setViewName("redirect:/qna//list_by_qna.do?qna_search=qna_no&word=&mem_no=1");     
     //mav.setViewName("redirect:/qna/list_by_qna.do?qna_search=qna_no&word=&mem_no=1");     
   } else {
     msgs.add("QnA ������ �����߽��ϴ�.");
     msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");
     //links.add("<button type='button' onclick=\"location.href='./list_all.do?qna_no=" + qna_no + "'\">���</button>");
     links.add("<button type='button' onclick=\"location.href='./list_by_qna.do?qna_search=qna_no&word=&mem_no=1'\">���</button>");

     mav.addObject("msgs", msgs);
     mav.addObject("links", links);

     mav.setViewName("/qna/message"); // /webapp/qna/message.jsp
   }

   return mav;
 }
 
 @RequestMapping(value="/qna/reply.do", method=RequestMethod.GET)
 public ModelAndView reply(QnaVO qnaVO){
   // System.out.println("--> reply() GET called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/qna/reply"); // webapp/qna/reply.jsp
   
   qnaVO = qnaProc.read(qnaVO.getQna_no());
   mav.addObject("qnaVO", qnaVO);  // FK column
   
   return mav;
 }

 
 // �亯
 @RequestMapping(value="/qna/reply.do", method=RequestMethod.POST)
 public ModelAndView reply(RedirectAttributes redirectAttributes, 
                                      HttpServletRequest request, 
                                      QnaVO qnaVO,
                                     
                                      String word){
   // System.out.println("--> create() POST called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/qna/reply"); // webapp/qna/reply.jsp
   
   ArrayList<String> msgs = new ArrayList<String>();
   ArrayList<String> links = new ArrayList<String>();
   
   int qna_no = qnaVO.getQna_no();

   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/qna/storage");
   List<MultipartFile> filesMF = qnaVO.getFilesMF(); // Spring�� File ��ü�� �����ص�.
   
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
   qnaVO.setQna_files(files);
   qnaVO.setQna_sizes(sizes);
   qnaVO.setQna_thumbs(thumbs);
   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   
   // ȸ�� ���� �� session ���κ���
   // int mno = (Integer)session.getAttribute("mno");
  // qnaVO.setMno(1);
   
   String root = request.getContextPath();
   
   // --------------------------- �亯 ���� �ڵ� ���� --------------------------
   QnaVO parentVO = qnaProc.read(qnaVO.getQna_no()); // �θ�� ���� ����
   qnaVO.setQna_grpno(parentVO.getQna_grpno()); // �׷� ��ȣ
   qnaVO.setQna_ansnum(parentVO.getQna_ansnum()); // �亯 ����

   qnaProc.updateAnsnum(qnaVO); // ���� ��ϵ� �亯 �ڷ� +1 ó����.

   qnaVO.setQna_indent(parentVO.getQna_indent() + 1); // �亯 ���� ����
   qnaVO.setQna_ansnum(parentVO.getQna_ansnum() + 1); // �θ� �ٷ� �Ʒ� ���
   // --------------------------- �亯 ���� �ڵ� ���� --------------------------
   
   count = qnaProc.reply(qnaVO); // DBMS �亯 ó��
/*   
   if (count == 1) {
     qnaProc.increaseCnt(qna_no); // �� �� ����
   }
   */
   redirectAttributes.addAttribute("count", count); // 1 or 0
   redirectAttributes.addAttribute("qna_no", qnaVO.getQna_no());
   /*redirectAttributes.addAttribute("nowPage", nowPage);*/
   redirectAttributes.addAttribute("word", word);
   
   mav.setViewName("redirect:/qna/message_reply.jsp");
   
   return mav;
 }
 
 
 
 
 /*@RequestMapping(value = "/qna/show_hide.do", method = RequestMethod.GET)
 public ModelAndView show_hide(int qna_no) {
   ModelAndView mav = new ModelAndView();

   mav.setViewName("/qna/list_by_qna");   
   
   QnaVO show_hide = qnaProc.show_hide(qna_no);
   mav.addObject("show_hide", show_hide);

   return mav;
 }
 */
 
/*
 @RequestMapping(value = "/qna/update_seqqna_up.do", method = RequestMethod.POST)
 public ModelAndView update_seqqna_up(int qna_no) {
   ModelAndView mav = new ModelAndView();

   if (qnaProc.update_seqqna_up(qna_no) == 1) {
     mav.setViewName("redirect:/qna/list.do?qna_no=" + qna_no);
   }

   return mav;
 }

 @RequestMapping(value = "/qna/update_seqqna_down.do", method = RequestMethod.POST)
 public ModelAndView update_seqqna_down(int qna_no) {
   ModelAndView mav = new ModelAndView();

   if (qnaProc.update_seqqna_down(qna_no) == 1) {
     mav.setViewName("redirect:/qna/list.do?qna_no=" + qna_no);
   }

   return mav;
 }*/
/*
 @RequestMapping(value="/qna/list_index_left.do", method=RequestMethod.GET)
 public ModelAndView list_index_left(HttpServletRequest request){
   // System.out.println("--> list_index() GET called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/qna/list_index_left"); // webapp/qna/list_index_left.jsp
   
   List<QnaVO> qna_list = qnaProc.list(); // ī�װ� �׷� ���
   
   // Categrp: name, Category: title ���� ���
   ArrayList<String> name_title_list = new ArrayList<String>();   
   
   StringBuffer url = new StringBuffer(); // ī�װ� ���� ��ũ ����

   // ī�װ� �׷� ������ŭ ��ȯ
   for (int index = 0; index < qna_list.size(); index++) {
     QnaVO qnaVO = qna_list.get(index);

     name_title_list.add("<LI class='categrp_name'>"+ qnaVO.getName() + "</LI>");

     List<Categrp_QnaVO> qna_list = qnaProc.list_by_qna_no(qnaVO.getQnano()); // ī�װ� Join ���
     
     // ī�װ� ������ŭ ��ȯ
     for (int j=0; j < qna_list.size(); j++) {
       Categrp_QnaVO categrp_QnaVO = qna_list.get(j);
       String title = categrp_QnaVO.getTitle(); // ī�װ� �̸�
       int cnt = categrp_QnaVO.getCnt();
       
       url.append("<LI class='qna_title'>");
       url.append("  <A href='" + request.getContextPath()+ "/qna/list_by_qna.do?qna_no="+categrp_QnaVO.getQna_no()+"'>");
       url.append(title);
       url.append("  </A>");
       url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
       url.append("</LI>");
       name_title_list.add(url.toString()); // ��� ��Ͽ� �ϳ��� qna �߰� 
       
       url.delete(0, url.toString().length()); // StringBuffer ���ڿ� ����
       
     }
   }
   
   mav.addObject("name_title_list", name_title_list);
   mav.addObject("total_count", qnaProc.total_count());
   
   return mav;
 }
 
 */
}
