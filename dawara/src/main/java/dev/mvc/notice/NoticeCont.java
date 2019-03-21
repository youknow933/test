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
  @Qualifier("dev.mvc.notice.NoticeProc") // 할당되는 Class 객체의 이름
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
   * 검색 목록
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
    
    // 검색 기능 추가, webapp/notice/list_by_notice_search.jsp
   // mav.setViewName("/notice/list_by_notice_search");   
     mav.setViewName("/notice/list_by_notice_search_paging");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{mem_no}
    hashMap.put("notice_search", notice_search); // #{notice_search}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);                  // #{nowPage}

    // System.out.println("mem_no: " + mem_no);
    // System.out.println("word_find: " + word_find);
    
    // 검색 목록
    List<NoticeVO> list_by_notice_search = noticeProc.list_by_notice_search(hashMap);
    mav.addObject("list_by_notice_search", list_by_notice_search);
    
    // 검색된 레코드 갯수
    int search_count = noticeProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    NoticeVO noticeVO = noticeProc.read(mem_no);
    mav.addObject("noticeVO", noticeVO);
    
    // mav.addObject("word", word);
    
    return mav;
  }
  
  
//  list_by_notice.do에서 목록 + 검색 + 페이징 지원
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


    //  검색 기능 추가
    //mav.setViewName("/notice/list_by_notice");   
   
    int mem_no = (Integer)session.getAttribute("mem_no");
    System.out.println("mem_no: " + mem_no);
 
    //// 페이징 기능 추가,  /webapp/notice/list_by_notice_search_paging.jsp
    mav.setViewName("/notice/list_by_notice");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{mem_no}
    hashMap.put("notice_search", notice_search); // #{notice_search}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);                  // #{nowPage}

    
    List<NoticeVO> list_by_notice = noticeProc.list_by_notice_search(hashMap);
    mav.addObject("list_by_notice", list_by_notice);
   
    /*
    // 검색 목록
    List<NoticeVO> list = noticeProc.list_by_notice_search(hashMap);
    mav.addObject("list", list);
   */
    
    // 검색된 레코드 갯수
    int search_count = noticeProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    List<NoticeVO> noticeVO = noticeProc.read_mem_no(mem_no);
    mav.addObject("noticeVO", noticeVO);
    
    
    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param no_no 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
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
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/notice/storage");
    List<MultipartFile> filesMF = noticeVO.getFilesMF(); // Spring이 File 객체를 저장해둠.
    
    // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
    
    String no_files = ""; // 컬럼에 저장할 파일명
    String files_item = ""; // 하나의 파일명
    String no_sizes = "";
    long sizes_item = 0;   // 하나의 파일 사이즈
    String no_thumbs = "";         // Thumb 파일들
    String thumbs_item = ""; // 하나의 Thumb 파일명
    
    int count = filesMF.size();
    
    // System.out.println("--> ContentsCont count: " + count);
    
    if (count > 0) { // 전송 파일이 존재한다면
      // for (MultipartFile multipartFile: filesMF) {
      for (int i=0; i < count; i++) {
        MultipartFile multipartFile = filesMF.get(i);
        files_item = Upload.saveFileSpring(multipartFile, upDir);
        sizes_item = multipartFile.getSize();
        
        if (Tool.isImage(files_item)) {
          thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb 이미지 생성
        }
        
        if ( i != 0 &&  i < count ) {
          no_files = no_files + "/" + files_item;  // file1.jpg/file2.jpg/file3.jpg
          no_sizes = no_sizes + "/" + sizes_item;   // 12546/78956/42658
          no_thumbs = no_thumbs + "/" + thumbs_item;
        } else if (multipartFile.getSize() > 0){ // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크
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
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    
    if (noticeProc.create(noticeVO) == 1) {
      // msgs.add("공지사항을 등록했습니다.");
      mav.setViewName("redirect:/notice/list_by_notice.do?notice_search=notice_no&word=&mem_no=1");
//      mav.setViewName("redirect:/notice/list_all.do?mem_no=" + noticeVO.getMem_no());
    } else { 
      msgs.add("공지사항 등록에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list_by_notice.do?notice_search=notice_no&word=&mem_no=1\">목록</button>");

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
    String[] files_array = files.split("/");   // 파일명 추출
    String[] sizes_array = sizes.split("/"); // 파일 사이즈

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
    
    List<NoticeVO> notice_list = noticeProc.list(); // 카테고리 그룹 목록
    
    // Categrp: name, Category: title 결합 목록
    ArrayList<String> name_title_list = new ArrayList<String>();   
    
    StringBuffer url = new StringBuffer(); // 카테고리 제목 링크 조합

    // 카테고리 그룹 갯수만큼 순환
    for (int index = 0; index < notice_list.size(); index++) {
      NoticeVO noticeVO = notice_list.get(index);

      name_title_list.add("<LI class='categrp_name'>"+ noticeVO.get() + "</LI>");

      List<Categrp_NoticeVO> notice_list = noticeProc.list_by_no_no(noticeVO.getNoticeno()); // 카테고리 Join 목록
      
      // 카테고리 갯수만큼 순환
      for (int j=0; j < notice_list.size(); j++) {
        Categrp_NoticeVO categrp_NoticeVO = notice_list.get(j);
        String title = categrp_NoticeVO.getTitle(); // 카테고리 이름
        int cnt = categrp_NoticeVO.getCnt();
        
        url.append("<LI class='notice_title'>");
        url.append("  <A href='" + request.getContextPath()+ "/content/list_by_notice.do?no_no"+categrp_NoticeVO.getCategoryno()+"'>");
        url.append(title);
        url.append("  </A>");
        url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
        url.append("</LI>");
        name_title_list.add(url.toString()); // 출력 목록에 하나의 notice 추가 
        
        url.delete(0, url.toString().length()); // StringBuffer 문자열 삭제
        
      }
    }
    
    mav.addObject("name_title_list", name_title_list);
    mav.addObject("total_count", noticeProc.total_count());
    
    return mav;
  }*/
  
  
  /**
  <Xmp>
    수정 폼 
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
   String[] files_array = files.split("/");   // 파일명 추출
   String[] sizes_array = sizes.split("/"); // 파일 사이즈

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
 - 글만 수정하는 경우의 구현
 - 파일만 수정하는 경우의 구현
 - 글과 파일을 동시에 수정하는 경우의 구현
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
   // 파일 전송 코드 시작
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/notice/storage");
   List<MultipartFile> filesMF = noticeVO.getFilesMF(); // Spring이 File 객체를 저장해둠.
   
   // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
   
   String files = ""; // 컬럼에 저장할 파일명
   String files_item = ""; // 하나의 파일명
   String sizes = "";
   long sizes_item = 0;   // 하나의 파일 사이즈
   String thumbs = "";         // Thumb 파일들
   String thumbs_item = ""; // 하나의 Thumb 파일명
   
   int count = filesMF.size();

   // 기존 등록 정보 읽어옴.
   NoticeVO noticeVO_old = noticeProc.read(noticeVO.getNo_no());
   
   if (filesMF.get(0).getSize() > 0) { // 전송 파일이 존재한다면
     // System.out.println("3) 새로운 파일을 등록합니다.");
     // 기존 파일 삭제
     
     String thumbs_old = noticeVO_old.getNo_thumbs();
     String files_old = noticeVO_old.getNo_files();
     
     StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");  // Thumbs
     while(thumbs_st.hasMoreTokens()) { // 단어가 있는지 검사
       String fname = upDir + thumbs_st.nextToken(); // 단어 추출
       Tool.deleteFile(fname);
     }
     
     StringTokenizer files_st = new StringTokenizer(files_old, "/");           // files
     while(files_st.hasMoreTokens()) { // 단어가 있는지 검사
       String fname = upDir + files_st.nextToken(); // 단어 추출
       Tool.deleteFile(fname);
     }
     
     // for (MultipartFile multipartFile: filesMF) {
     for (int i=0; i < count; i++) {
       MultipartFile multipartFile = filesMF.get(i);
       files_item = Upload.saveFileSpring(multipartFile, upDir);
       sizes_item = multipartFile.getSize();
       
       if (Tool.isImage(files_item)) {
         thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb 이미지 생성
       }
       
       if ( i != 0 &&  i < count ) {
         files = files + "/" + files_item;  // file1.jpg/file2.jpg/file3.jpg
         sizes = sizes + "/" + sizes_item;   // 12546/78956/42658
         thumbs = thumbs + "/" + thumbs_item;
       } else if (multipartFile.getSize() > 0){ // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크
         files = files_item;         // file1.jpg
         sizes = "" + sizes_item; // 123456
         thumbs = thumbs_item;
       }
     }
   } else { // 글만 수정하는 경우 
     files = noticeVO_old.getNo_files();
     sizes = noticeVO_old.getNo_sizes();
     thumbs = noticeVO_old.getNo_thumbs();
   } 
   noticeVO.setNo_files(files);
   noticeVO.setNo_sizes(sizes);
   noticeVO.setNo_thumbs(thumbs);
   // -------------------------------------------------------------------
   // 파일 전송 코드 종료
   // -------------------------------------------------------------------
   
   /*
    // 회원 개발 후 session 으로변경
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
  * 이미지 삭제 처리
  * @param no_no 카테고리 그룹 번호
  * @param no_no 삭제할 레코드 번호
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

   while(st.hasMoreTokens()) { // 단어가 있는지 검사
     String fname = upDir + st.nextToken(); // 단어 추출
     Tool.deleteFile(fname);
   }
   
   StringTokenizer st2 = new StringTokenizer(no_thumbs, "/");  // Thumbs

   while(st2.hasMoreTokens()) { // 단어가 있는지 검사
     String fname = upDir + st2.nextToken(); // 단어 추출
     Tool.deleteFile(fname);
   }
   
   int count = noticeProc.delete_img(no_no);

   if (count == 1) {
     
     msgs.add("첨부 파일을 삭제했습니다.");
     mav.setViewName("redirect:/notice/list_all.do");     
   } else {
     msgs.add("공지사항 삭제에 실패했습니다.");
     msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
     links.add("<button type='button' onclick=\"location.href='./list_all.do?no_no=" + no_no + "'\">목록</button>");

     mav.addObject("msgs", msgs);
     mav.addObject("links", links);

     mav.setViewName("/notice/message"); // /webapp/notice/message.jsp
   }

   return mav;
 }
 
 
 /**
  * 
  * 삭제
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
  * 삭제 처리
  * @param no_no 카테고리 그룹 번호
  * @param no_no 삭제할 레코드 번호
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
     // msgs.add("공지사항을 삭제했습니다.");
     //mav.setViewName("redirect:/notice/list_all.do");     
     mav.setViewName("redirect:/notice/list_by_notice.do?notice_search=notice_no&word=&mem_no=1");     
   } else {
     msgs.add("공지사항 삭제에 실패했습니다.");
     msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
     //links.add("<button type='button' onclick=\"location.href='./list_all.do?no_no=" + no_no + "'\">목록</button>");
     links.add("<button type='button' onclick=\"location.href='./list_by_notice.do?notice_search=notice_no&word=&mem_no=1'\">목록</button>");

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
   
   List<NoticeVO> notice_list = noticeProc.list(); // 카테고리 그룹 목록
   
   // Categrp: name, Category: title 결합 목록
   ArrayList<String> name_title_list = new ArrayList<String>();   
   
   StringBuffer url = new StringBuffer(); // 카테고리 제목 링크 조합

   // 카테고리 그룹 갯수만큼 순환
   for (int index = 0; index < notice_list.size(); index++) {
     NoticeVO noticeVO = notice_list.get(index);

     name_title_list.add("<LI class='categrp_name'>"+ noticeVO.getName() + "</LI>");

     List<Categrp_NoticeVO> notice_list = noticeProc.list_by_no_no(noticeVO.getNoticeno()); // 카테고리 Join 목록
     
     // 카테고리 갯수만큼 순환
     for (int j=0; j < notice_list.size(); j++) {
       Categrp_NoticeVO categrp_NoticeVO = notice_list.get(j);
       String title = categrp_NoticeVO.getTitle(); // 카테고리 이름
       int cnt = categrp_NoticeVO.getCnt();
       
       url.append("<LI class='notice_title'>");
       url.append("  <A href='" + request.getContextPath()+ "/notice/list_by_notice.do?no_no="+categrp_NoticeVO.getCategoryno()+"'>");
       url.append(title);
       url.append("  </A>");
       url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
       url.append("</LI>");
       name_title_list.add(url.toString()); // 출력 목록에 하나의 notice 추가 
       
       url.delete(0, url.toString().length()); // StringBuffer 문자열 삭제
       
     }
   }
   
   mav.addObject("name_title_list", name_title_list);
   mav.addObject("total_count", noticeProc.total_count());
   
   return mav;
 }
 
    
 */
}


