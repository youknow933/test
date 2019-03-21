package dev.mvc.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import nation.web.tool.Tool;
import nation.web.tool.Upload;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.cart.CartProcInter;
import dev.mvc.category.CategoryProcInter;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.product.Pr_fileVO;
import dev.mvc.product.ProductVO;
import dev.mvc.reply.ReplyProcInter;

@Controller
public class ProductCont {
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc") // 할당되는 Class 객체의 이름
  private ProductProcInter productProc;
  
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyProc") // 할당되는 Class 객체의 이름
  private ReplyProcInter replyProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc") // 할당되는 Class 객체의 이름
  private MemberProcInter memberProc;
  
  @Autowired
  @Qualifier("dev.mvc.cart.CartProc") // 할당되는 Class 객체의 이름
  private CartProcInter cartProc;

  @Autowired
  @Qualifier("dev.mvc.category.CategoryProc")
  private CategoryProcInter categoryProc = null;
  
  public ProductCont() {
    System.out.println("--> ProductCont created."); 
  }
   
  // http://localhost:9090/dawara/product/create.do
  @RequestMapping(value = "/product/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    System.out.println("--> create() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product/create"); // /webapp/product/create.jsp

    return mav;
  }
  
  @RequestMapping(value = "/product/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, ProductVO productVO, HttpSession session) {
    System.out.println("--> create() POST executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product/message"); // /webapp/product/message.jsp

    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();

    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/product/storage");
    List<MultipartFile> filesMF = productVO.getPr_filesMF(); // Spring이 File 객체를 저장해둠.
    
    // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
    
    String files = ""; // 컬럼에 저장할 파일명
    String files_item = ""; // 하나의 파일명
    String sizes = "";
    long sizes_item = 0;   // 하나의 파일 사이즈
    String thumbs = "";         // Thumb 파일들
    String thumbs_item = ""; // 하나의 Thumb 파일명
    
    int count = filesMF.size();
    
    // System.out.println("--> productCont count: " + count);
    
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
    int mem_no = (Integer)session.getAttribute("mem_no"); 
    System.out.println("mem_no : " + mem_no);


    productVO.setMem_no(mem_no);
    productVO.setPr_files(files);
    productVO.setPr_sizes(sizes);
    productVO.setPr_thumbs(thumbs);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------

    if (productProc.create(productVO) == 1) {
    /*  categoryProc.increaseCnt(productVO.getGory_no()); // 글수 증가
*/
      mav.setViewName("redirect:/product/list_by_category.do?gory_no=" + productVO.getGory_no());
      // mav.setViewName("redirect:/product/list_all_category.do");
    } else {
      msgs.add("[등록 실패]");
      msgs.add("글 등록에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 전산 운영팀: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back()\">다시 시도</button>");

      links.add("<button type='button' onclick=\"location.href='./list_by_gory_no.do?gory_no="
              + productVO.getGory_no() + "'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }
    return mav;
  }
  
  /**
   * 목록 + 검색 + 페이징 지원
   * @param gory_no
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/product/list_by_category.do", method = RequestMethod.GET)
  public ModelAndView list_by_category(
      @RequestParam(value="gory_no") int gory_no,
      @RequestParam(value="pr_title", defaultValue="") String pr_title,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage,
      HttpSession session
      ) { 
    // System.out.println("--> list_by_category() GET called.");
    
    ModelAndView mav = new ModelAndView();
    
    // 검색 기능 추가,  /webapp/product/list_by_category_search_paging.jsp
    mav.setViewName("/product/list_by_category_search_paging");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("gory_no", gory_no); // #{gory_no}
    hashMap.put("pr_title", pr_title);                  // #{word}
    hashMap.put("nowPage", nowPage);   
    
    System.out.println("gory_no :" + gory_no);
    System.out.println("pr_title :" + pr_title);
    System.out.println("pr_title cnt:"+ pr_title.length());
    
    // 검색 목록
    List<ProductVO> list = productProc.list_by_category_search(hashMap);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = productProc.search_count(hashMap);
    System.out.println("search_count:" + search_count);
    mav.addObject("search_count", search_count);

    /*CategoryVO categoryVO = categoryProc.read(gory_no);
    mav.addObject("categoryVO", categoryVO);*/
    
    // mav.addObject("word", word);

    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param gory_no 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    
    String paging = productProc.paging(gory_no, search_count, nowPage, pr_title); 
    System.out.println("paging : " + paging);
    mav.addObject("paging", paging);

    mav.addObject("nowPage", nowPage);
    
    // 로그인 상태 확인
    int mem_no =0; 
    if((Integer)session.getAttribute("mem_no") !=null){
      mem_no=(Integer)session.getAttribute("mem_no");
    }
    System.out.println("mem_no: " + mem_no );
    mav.addObject("mem_no", mem_no);
    
    
    return mav;
  }
  
  /**
   * 목록 + 검색 + 페이징 지원
   * @param gory_no
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/product/list_mem_no.do", method = RequestMethod.GET)
  public ModelAndView list_mem_no(
      @RequestParam(value="pr_title", defaultValue="") String pr_title,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage,
      HttpSession session
      ) { 
    // System.out.println("--> list_by_category() GET called.");
    
    ModelAndView mav = new ModelAndView();
    
    // 검색 기능 추가,  /webapp/product/list_mem_no.jsp
    mav.setViewName("/product/list_mem_no");   
    int mem_no = (Integer)session.getAttribute("mem_no");
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{gory_no}
    hashMap.put("pr_title", pr_title);                  // #{word}
    hashMap.put("nowPage", nowPage);   
    
    System.out.println("mem_no :" + mem_no);
    System.out.println("pr_title :" + pr_title);
    System.out.println("pr_title cnt:"+ pr_title.length());
    
    // 검색 목록
    List<ProductVO> list = productProc.list_mem_no(hashMap);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count_mem_no = productProc.search_count_mem_no(hashMap);
    System.out.println("search_count_mem_no:" + search_count_mem_no);
    mav.addObject("search_count_mem_no", search_count_mem_no);

    /*CategoryVO categoryVO = categoryProc.read(gory_no);
    mav.addObject("categoryVO", categoryVO);*/
    
    // mav.addObject("word", word);

    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param gory_no 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    
    String paging = productProc.paging(mem_no, search_count_mem_no, nowPage, pr_title); 
    System.out.println("paging : " + paging);
    mav.addObject("paging", paging);

    mav.addObject("nowPage", nowPage);
    
    return mav;
  }
  
  @RequestMapping(value = "/product/list_sell_mem_no.do", method = RequestMethod.GET)
  public ModelAndView list_mem_no(HttpSession session) { 
    // System.out.println("--> list_sell_mem_no GET called.");
    int mem_no = (Integer)session.getAttribute("mem_no");
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/product/list_sell_mem_no");   //webapp/product/list_sell_mem_no.jsp
    
    List<ProductVO> list = productProc.list_sell_mem_no(mem_no);
    mav.addObject("list", list);
    
    return mav;
  }
  
  
  @RequestMapping(value = "/product/read.do", method = RequestMethod.GET)
  public ModelAndView read(int pr_no, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product/read"); // /webapp/product/read.jsp

    ProductVO productVO = productProc.read(pr_no);
    mav.addObject("productVO", productVO);
    System.out.println("productVO.getMem_no : " + productVO.getMem_no() );
    MemberVO memberVO = memberProc.read(productVO.getMem_no());
    mav.addObject("memberVO", memberVO);
    
    /*CategoryVO categoryVO = categoryProc.read(productVO.getGory_no()); // 카테고리 정보 추출
    mav.addObject("categoryVO", categoryVO);*/ //CategoryVO

    ArrayList<Pr_fileVO> file_list = new ArrayList<Pr_fileVO>();
    
    String thumbs = productVO.getPr_thumbs(); 
    String files = productVO.getPr_files();
    String sizes = productVO.getPr_sizes();
    
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
      
        Pr_fileVO fileVO = new Pr_fileVO(thumbs_array[index], files_array[index], sizes_array[index]);
        file_list.add(fileVO);
      }
    } 
    mav.addObject("file_list", file_list);
    
    // 로그인 상태 확인
    int mem_no =0; 
    if((Integer)session.getAttribute("mem_no") !=null){
      mem_no=(Integer)session.getAttribute("mem_no");
    }
    System.out.println("mem_no: " + mem_no );
    mav.addObject("mem_no", mem_no);
    
    return mav;
  }
  
  /**
   * 수정 폼
   * http://localhost:9090/contents/contents/update.do
   * @param pr_no
   * @return
   */
  @RequestMapping(value = "/product/update.do", method = RequestMethod.GET)
  public ModelAndView update(int pr_no) {
    // System.out.println("--> update() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product/update"); // /webapp/product/update.jsp

    ProductVO productVO = productProc.read(pr_no);
    mav.addObject("productVO", productVO);

  /*  CategoryVO categoryVO = categoryProc.read(productVO.getGory_no());
    mav.addObject("categoryVO", categoryVO);*/

    ArrayList<Pr_fileVO> file_list = new ArrayList<Pr_fileVO>();
    
    String thumbs = productVO.getPr_thumbs();
    String files = productVO.getPr_files();
    String sizes = productVO.getPr_sizes();
    
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
      
        Pr_fileVO fileVO = new Pr_fileVO(thumbs_array[index], files_array[index], sizes_array[index]);
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
   @param request
   @param productVO
   @return
   */
  @RequestMapping(value="/product/update.do", method=RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes,
                                         HttpServletRequest request, ProductVO productVO,  HttpSession session){
    // System.out.println("--> update() POST called.");
    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/product/storage");
    List<MultipartFile> filesMF = productVO.getPr_filesMF(); // Spring이 File 객체를 저장해둠.
    
    // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
    
    String files = ""; // 컬럼에 저장할 파일명
    String files_item = ""; // 하나의 파일명
    String sizes = "";
    long sizes_item = 0;   // 하나의 파일 사이즈
    String thumbs = "";         // Thumb 파일들
    String thumbs_item = ""; // 하나의 Thumb 파일명
    
    int count = filesMF.size();

    // 기존 등록 정보 읽어옴.
    ProductVO productVO_old = productProc.read(productVO.getPr_no());
    
    // System.out.println("--> productCont count: " + count);
    // System.out.println("1) filesMF.get(0).getName(): " + filesMF.get(0).getName());
    // System.out.println("1) filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
    // System.out.println("2) filesMF.get(0).getName().length(): " + filesMF.get(0).getName().length());
    if (filesMF.get(0).getSize() > 0) { // 전송 파일이 존재한다면
      // System.out.println("3) 새로운 파일을 등록합니다.");
      // 기존 파일 삭제
      
      String thumbs_old = productVO_old.getPr_thumbs();
      String files_old = productVO_old.getPr_files();
      
      System.out.println( "productVO_old.getPr_files() : "+ productVO_old.getPr_files());
      
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
      files = productVO_old.getPr_files();
      sizes = productVO_old.getPr_sizes();
      thumbs = productVO_old.getPr_thumbs();
    }
    productVO.setPr_files(files);
    productVO.setPr_sizes(sizes);
    productVO.setPr_thumbs(thumbs);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    // 회원 개발 후 session 으로변경
    int mem_no = (Integer)session.getAttribute("mem_no"); 
    productVO.setMem_no(mem_no);
    
    count = productProc.update(productVO);
    
    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("pr_no", productVO.getPr_no());
    redirectAttributes.addAttribute("gory_no", productVO.getGory_no());
    System.out.println("productVO.getGory_no(): " + productVO.getGory_no()); // 1

    mav.setViewName("redirect:/product/message_update.jsp");
    
    return mav;
  }
  
  // http://localhost:9090/contents/contents/delete.do
  @RequestMapping(value = "/product/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int pr_no, int gory_no) {
    // System.out.println("--> delete() GET executed");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product/delete"); // /webapp/product/delete.jsp

  /*  CategoryVO categoryVO = categoryProc.read(categoryno);
    mav.addObject("categoryVO", categoryVO);*/
    
    ProductVO productVO = productProc.read(pr_no);
    mav.addObject("productVO", productVO);
    
    return mav;
  }
  
  
  
  @RequestMapping(value = "/product/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes,
                                        HttpServletRequest request, int gory_no, int pr_no,
                                        String word, int nowPage) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product/message"); // /webapp/product/message.jsp

    String upDir = Tool.getRealPath(request, "/product/storage"); // 저장 폴더 절대 경로

    ProductVO productVO = productProc.read(pr_no); // 삭제할 파일 정보를 읽기 위한 목적
    
    String thumbs_old = productVO.getPr_thumbs();
    String files_old = productVO.getPr_files();
    
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
    // 현재 상품에 달린 댓글 삭제.
    replyProc.deleteByPr_no(pr_no);
    // 장바구니 삭제
    cartProc.deleteByPr_no(pr_no);
    
    int count = productProc.delete(pr_no); // 레코드 삭제
    
    if (count == 1) {
     /* categoryProc.decreaseCnt(gory_no); // 등록된 글수의 감소
*/      
      // 4개의 레코드가 하나의 페이지인경우 5번째 레코드가 삭제되면 페이지수도
      // 2페이지에서 1 페이지로 줄여야합니다. 
      HashMap<String, Object> hashMap = new HashMap<String, Object>();
      hashMap.put("gory_no", gory_no); // #{categoryno}
      hashMap.put("word", word);                  // #{word}
      if (productProc.search_count(hashMap) % Product.RECORD_PER_PAGE == 0){ 
        nowPage = nowPage - 1;
        if (nowPage < 1){
          nowPage = 1;
        }
      }
    }

    redirectAttributes.addAttribute("count", count); // 1 or 0
    redirectAttributes.addAttribute("pr_no", productVO.getPr_no());
    redirectAttributes.addAttribute("gory_no", productVO.getGory_no());
    redirectAttributes.addAttribute("word", word);
    redirectAttributes.addAttribute("nowPage", nowPage);

    mav.setViewName("redirect:/product/message_delete.jsp");

    return mav;
  }

     
}
