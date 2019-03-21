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
  @Qualifier("dev.mvc.qna.QnaProc") // 할당되는 Class 객체의 이름
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
    qnaProc.increaseCnt(qna_no); // 조회수 증가
    mav.addObject("qnaVO", qnaVO);
    
    ArrayList<Qna_fileVO> file_list = new ArrayList<Qna_fileVO>();
    
    String thumbs = qnaVO.getQna_thumbs();
    String files = qnaVO.getQna_files();
    String sizes = qnaVO.getQna_sizes();
    
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
      
        Qna_fileVO fileVO = new Qna_fileVO(thumbs_array[index], files_array[index], sizes_array[index]);
        file_list.add(fileVO);
      }
    } 
    mav.addObject("file_list", file_list);
   
    return mav;
  }
  */
  
  /**
   * 패스워드를 확인합니다.
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
    
    int count = qnaProc.pwdCheck(hashMap); // 입력된 패스워드 검사
    System.out.println("-->Cont, count: " + count);
    
    JSONObject obj = new JSONObject();
    obj.put("count", count);
    
    System.out.println(obj);
    
    if (count == 1) { // 패스워드 일치
      System.out.println("--> 패스워드 일치 ");
      //mav.addObject("count", count);
       // mav.setViewName("redirect:/qna/read.do?qna_no="+qna_no);      // 패스워드가 일치하면 해당 게시물을 읽어 옴
      
    } else {
      System.out.println("--> 패스워드 불일치 ");
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
   * 검색 목록
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
    
    // 검색 기능 추가, webapp/qna/list_by_qna_search.jsp
   // mav.setViewName("/qna/list_by_qna_search");   
     mav.setViewName("/qna/list_by_qna_search_paging");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{mem_no}
    hashMap.put("qna_search", qna_search); // #{qna_search}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);                  // #{nowPage}

    // System.out.println("mem_no: " + mem_no);
    // System.out.println("word_find: " + word_find);
    
    // 검색 목록
    List<QnaVO> list_by_qna_search = qnaProc.list_by_qna_search(hashMap);
    mav.addObject("list_by_qna_search", list_by_qna_search);
    
    // 검색된 레코드 갯수
    int search_count = qnaProc.search_count(hashMap);
    mav.addObject("search_count", search_count);

    QnaVO qnaVO = qnaProc.read(mem_no);
    mav.addObject("qnaVO", qnaVO);
    
    // mav.addObject("word", word);
    
    return mav;
  }
  */
  
//  list_by_qna.do에서 목록 + 검색 + 페이징 지원
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
    
    //  검색 기능 추가
    //mav.setViewName("/qna/list_by_qna");   
 
    //// 페이징 기능 추가,  /webapp/qna/list_by_qna_search_paging.jsp
    mav.setViewName("/qna/list_by_qna");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{mem_no}
    hashMap.put("qna_search", qna_search); // #{qna_search}
    hashMap.put("word", word);                  // #{word}
    hashMap.put("nowPage", nowPage);                  // #{nowPage}

    
    //list_by_qna_search : 검색, 페이징 모두 구현 된 mybatis id    
    List<QnaVO> list_by_qna = qnaProc.list_by_qna_search(hashMap);
    mav.addObject("list_by_qna", list_by_qna);
   
    /*
    // 검색 목록
    List<QnaVO> list = qnaProc.list_by_qna_search(hashMap);
    mav.addObject("list", list);
   */
    
    // 검색된 레코드 갯수
    int search_count = qnaProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    List<QnaVO> qnaVO = qnaProc.read_mem_no(mem_no);
    mav.addObject("qnaVO", qnaVO);
    
    
    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param qna_no 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
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
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/qna/storage");
    List<MultipartFile> filesMF = qnaVO.getFilesMF(); // Spring이 File 객체를 저장해둠.
    
    // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
    
    String qna_files = ""; // 컬럼에 저장할 파일명
    String files_item = ""; // 하나의 파일명
    String qna_sizes = "";
    long sizes_item = 0;   // 하나의 파일 사이즈
    String qna_thumbs = "";         // Thumb 파일들
    String thumbs_item = ""; // 하나의 Thumb 파일명
    
    int count = filesMF.size();
    
     System.out.println("--> ContentsCont count: " + count);
    
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
          qna_files = qna_files + "/" + files_item;  // file1.jpg/file2.jpg/file3.jpg
          qna_sizes = qna_sizes + "/" + sizes_item;   // 12546/78956/42658
          qna_thumbs = qna_thumbs + "/" + thumbs_item;
        } else if (multipartFile.getSize() > 0){ // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크
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
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    qnaVO.setQna_write(mem_id);
    
    if (qnaProc.create(qnaVO) == 1) {
      // msgs.add("QnA을 등록했습니다.");
      mav.setViewName("redirect:/qna//list_by_qna.do?qna_search=qna_no&mem_no=1");
      //mav.setViewName("redirect:/qna/list_by_qna.do?qna_search=qna_no&word=&mem_no=1");
//      mav.setViewName("redirect:/qna/list_all.do?mem_no=" + qnaVO.getMem_no());
    } else { 
      msgs.add("QnA 등록에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list_by_qna.do?qna_search=qna_no&word=&mem_no=1\">목록</button>");

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
    qnaProc.increaseCnt(qna_no); // 조회수 증가
    mav.addObject("qnaVO", qnaVO);
    
    ArrayList<Qna_fileVO> file_list = new ArrayList<Qna_fileVO>();
    
    String thumbs = qnaVO.getQna_thumbs();
    String files = qnaVO.getQna_files();
    String sizes = qnaVO.getQna_sizes();
    
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
    
    List<QnaVO> qna_list = qnaProc.list(); // 카테고리 그룹 목록
    
    // Categrp: name, Category: title 결합 목록
    ArrayList<String> name_title_list = new ArrayList<String>();   
    
    StringBuffer url = new StringBuffer(); // 카테고리 제목 링크 조합

    // 카테고리 그룹 갯수만큼 순환
    for (int index = 0; index < qna_list.size(); index++) {
      QnaVO qnaVO = qna_list.get(index);

      name_title_list.add("<LI class='categrp_name'>"+ qnaVO.get() + "</LI>");

      List<Categrp_QnaVO> qna_list = qnaProc.list_by_qna_no(qnaVO.getQnano()); // 카테고리 Join 목록
      
      // 카테고리 갯수만큼 순환
      for (int j=0; j < qna_list.size(); j++) {
        Categrp_QnaVO categrp_QnaVO = qna_list.get(j);
        String title = categrp_QnaVO.getTitle(); // 카테고리 이름
        int cnt = categrp_QnaVO.getCnt();
        
        url.append("<LI class='qna_title'>");
        url.append("  <A href='" + request.getContextPath()+ "/content/list_by_qna.do?qna_no"+categrp_QnaVO.getQna_no()+"'>");
        url.append(title);
        url.append("  </A>");
        url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
        url.append("</LI>");
        name_title_list.add(url.toString()); // 출력 목록에 하나의 qna 추가 
        
        url.delete(0, url.toString().length()); // StringBuffer 문자열 삭제
        
      }
    }
    
    mav.addObject("name_title_list", name_title_list);
    mav.addObject("total_count", qnaProc.total_count());
    
    return mav;
  }*/
  
  
  /**
  <Xmp>
    수정 폼 
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
   String[] files_array = files.split("/");   // 파일명 추출
   String[] sizes_array = sizes.split("/"); // 파일 사이즈

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
 - 글만 수정하는 경우의 구현
 - 파일만 수정하는 경우의 구현
 - 글과 파일을 동시에 수정하는 경우의 구현
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
   // 파일 전송 코드 시작
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/qna/storage");
   List<MultipartFile> filesMF = qnaVO.getFilesMF(); // Spring이 File 객체를 저장해둠.
   
   // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
   
   String files = ""; // 컬럼에 저장할 파일명
   String files_item = ""; // 하나의 파일명
   String sizes = "";
   long sizes_item = 0;   // 하나의 파일 사이즈
   String thumbs = "";         // Thumb 파일들
   String thumbs_item = ""; // 하나의 Thumb 파일명
   
   int count = filesMF.size();

   // 기존 등록 정보 읽어옴.
   QnaVO qnaVO_old = qnaProc.read(qnaVO.getQna_no());
   
   if (filesMF.get(0).getSize() > 0) { // 전송 파일이 존재한다면
     // System.out.println("3) 새로운 파일을 등록합니다.");
     // 기존 파일 삭제
     
     String thumbs_old = qnaVO_old.getQna_thumbs();
     String files_old = qnaVO_old.getQna_files();
     
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
     files = qnaVO_old.getQna_files();
     sizes = qnaVO_old.getQna_sizes();
     thumbs = qnaVO_old.getQna_thumbs();
   } 
   qnaVO.setQna_files(files);
   qnaVO.setQna_sizes(sizes);
   qnaVO.setQna_thumbs(thumbs);
   // -------------------------------------------------------------------
   // 파일 전송 코드 종료
   // -------------------------------------------------------------------
   
   /*
    // 회원 개발 후 session 으로변경
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
  * 이미지 삭제 처리
  * @param qna_no 카테고리 그룹 번호
  * @param qna_no 삭제할 레코드 번호
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

   while(st.hasMoreTokens()) { // 단어가 있는지 검사
     String fname = upDir + st.nextToken(); // 단어 추출
     Tool.deleteFile(fname);
   }
   
   StringTokenizer st2 = new StringTokenizer(qna_thumbs, "/");  // Thumbs

   while(st2.hasMoreTokens()) { // 단어가 있는지 검사
     String fname = upDir + st2.nextToken(); // 단어 추출
     Tool.deleteFile(fname);
   }
   
   int count = qnaProc.delete_img(qna_no);

   if (count == 1) {
     
     msgs.add("첨부 파일을 삭제했습니다.");
     mav.setViewName("redirect:/qna/list_all.do");     
   } else {
     msgs.add("QnA 삭제에 실패했습니다.");
     msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
     links.add("<button type='button' onclick=\"location.href='./list_all.do?qna_no=" + qna_no + "'\">목록</button>");

     mav.addObject("msgs", msgs);
     mav.addObject("links", links);

     mav.setViewName("/qna/message"); // /webapp/qna/message.jsp
   }

   return mav;
 }
 
 
 /**
  * 
  * 삭제
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
  * 삭제 처리
  * @param qna_no 카테고리 그룹 번호
  * @param qna_no 삭제할 레코드 번호
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
     // msgs.add("QnA을 삭제했습니다.");
     mav.setViewName("redirect:/qna//list_by_qna.do?qna_search=qna_no&word=&mem_no=1");     
     //mav.setViewName("redirect:/qna/list_by_qna.do?qna_search=qna_no&word=&mem_no=1");     
   } else {
     msgs.add("QnA 삭제에 실패했습니다.");
     msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
     links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");
     //links.add("<button type='button' onclick=\"location.href='./list_all.do?qna_no=" + qna_no + "'\">목록</button>");
     links.add("<button type='button' onclick=\"location.href='./list_by_qna.do?qna_search=qna_no&word=&mem_no=1'\">목록</button>");

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

 
 // 답변
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
   // 파일 전송 코드 시작
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/qna/storage");
   List<MultipartFile> filesMF = qnaVO.getFilesMF(); // Spring이 File 객체를 저장해둠.
   
   // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
   
   String files = ""; // 컬럼에 저장할 파일명
   String files_item = ""; // 하나의 파일명
   String sizes = "";
   long sizes_item = 0;   // 하나의 파일 사이즈
   String thumbs = "";         // Thumb 파일들
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
         files = files + "/" + files_item;  // file1.jpg/file2.jpg/file3.jpg
         sizes = sizes + "/" + sizes_item;   // 12546/78956/42658
         thumbs = thumbs + "/" + thumbs_item;
       } else if (multipartFile.getSize() > 0){ // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크
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
   // 파일 전송 코드 종료
   // -------------------------------------------------------------------
   
   // 회원 개발 후 session 으로변경
   // int mno = (Integer)session.getAttribute("mno");
  // qnaVO.setMno(1);
   
   String root = request.getContextPath();
   
   // --------------------------- 답변 관련 코드 시작 --------------------------
   QnaVO parentVO = qnaProc.read(qnaVO.getQna_no()); // 부모글 정보 추출
   qnaVO.setQna_grpno(parentVO.getQna_grpno()); // 그룹 번호
   qnaVO.setQna_ansnum(parentVO.getQna_ansnum()); // 답변 순서

   qnaProc.updateAnsnum(qnaVO); // 현재 등록된 답변 뒤로 +1 처리함.

   qnaVO.setQna_indent(parentVO.getQna_indent() + 1); // 답변 차수 증가
   qnaVO.setQna_ansnum(parentVO.getQna_ansnum() + 1); // 부모 바로 아래 등록
   // --------------------------- 답변 관련 코드 종료 --------------------------
   
   count = qnaProc.reply(qnaVO); // DBMS 답변 처리
/*   
   if (count == 1) {
     qnaProc.increaseCnt(qna_no); // 글 수 증가
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
   
   List<QnaVO> qna_list = qnaProc.list(); // 카테고리 그룹 목록
   
   // Categrp: name, Category: title 결합 목록
   ArrayList<String> name_title_list = new ArrayList<String>();   
   
   StringBuffer url = new StringBuffer(); // 카테고리 제목 링크 조합

   // 카테고리 그룹 갯수만큼 순환
   for (int index = 0; index < qna_list.size(); index++) {
     QnaVO qnaVO = qna_list.get(index);

     name_title_list.add("<LI class='categrp_name'>"+ qnaVO.getName() + "</LI>");

     List<Categrp_QnaVO> qna_list = qnaProc.list_by_qna_no(qnaVO.getQnano()); // 카테고리 Join 목록
     
     // 카테고리 갯수만큼 순환
     for (int j=0; j < qna_list.size(); j++) {
       Categrp_QnaVO categrp_QnaVO = qna_list.get(j);
       String title = categrp_QnaVO.getTitle(); // 카테고리 이름
       int cnt = categrp_QnaVO.getCnt();
       
       url.append("<LI class='qna_title'>");
       url.append("  <A href='" + request.getContextPath()+ "/qna/list_by_qna.do?qna_no="+categrp_QnaVO.getQna_no()+"'>");
       url.append(title);
       url.append("  </A>");
       url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
       url.append("</LI>");
       name_title_list.add(url.toString()); // 출력 목록에 하나의 qna 추가 
       
       url.delete(0, url.toString().length()); // StringBuffer 문자열 삭제
       
     }
   }
   
   mav.addObject("name_title_list", name_title_list);
   mav.addObject("total_count", qnaProc.total_count());
   
   return mav;
 }
 
 */
}
