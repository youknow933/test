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
  @Qualifier("dev.mvc.product.ProductProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private ProductProcInter productProc;
  
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private ReplyProcInter replyProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
  private MemberProcInter memberProc;
  
  @Autowired
  @Qualifier("dev.mvc.cart.CartProc") // �Ҵ�Ǵ� Class ��ü�� �̸�
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/product/storage");
    List<MultipartFile> filesMF = productVO.getPr_filesMF(); // Spring�� File ��ü�� �����ص�.
    
    // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
    
    String files = ""; // �÷��� ������ ���ϸ�
    String files_item = ""; // �ϳ��� ���ϸ�
    String sizes = "";
    long sizes_item = 0;   // �ϳ��� ���� ������
    String thumbs = "";         // Thumb ���ϵ�
    String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�
    
    int count = filesMF.size();
    
    // System.out.println("--> productCont count: " + count);
    
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
    int mem_no = (Integer)session.getAttribute("mem_no"); 
    System.out.println("mem_no : " + mem_no);


    productVO.setMem_no(mem_no);
    productVO.setPr_files(files);
    productVO.setPr_sizes(sizes);
    productVO.setPr_thumbs(thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------

    if (productProc.create(productVO) == 1) {
    /*  categoryProc.increaseCnt(productVO.getGory_no()); // �ۼ� ����
*/
      mav.setViewName("redirect:/product/list_by_category.do?gory_no=" + productVO.getGory_no());
      // mav.setViewName("redirect:/product/list_all_category.do");
    } else {
      msgs.add("[��� ����]");
      msgs.add("�� ��Ͽ� �����߽��ϴ�.");
      msgs.add("�˼������� �ٽ��ѹ� �õ����ּ���. �� ���� ���: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back()\">�ٽ� �õ�</button>");

      links.add("<button type='button' onclick=\"location.href='./list_by_gory_no.do?gory_no="
              + productVO.getGory_no() + "'\">���</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
    }
    return mav;
  }
  
  /**
   * ��� + �˻� + ����¡ ����
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
    
    // �˻� ��� �߰�,  /webapp/product/list_by_category_search_paging.jsp
    mav.setViewName("/product/list_by_category_search_paging");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("gory_no", gory_no); // #{gory_no}
    hashMap.put("pr_title", pr_title);                  // #{word}
    hashMap.put("nowPage", nowPage);   
    
    System.out.println("gory_no :" + gory_no);
    System.out.println("pr_title :" + pr_title);
    System.out.println("pr_title cnt:"+ pr_title.length());
    
    // �˻� ���
    List<ProductVO> list = productProc.list_by_category_search(hashMap);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = productProc.search_count(hashMap);
    System.out.println("search_count:" + search_count);
    mav.addObject("search_count", search_count);

    /*CategoryVO categoryVO = categoryProc.read(gory_no);
    mav.addObject("categoryVO", categoryVO);*/
    
    // mav.addObject("word", word);

    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     *
     * @param gory_no ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    
    String paging = productProc.paging(gory_no, search_count, nowPage, pr_title); 
    System.out.println("paging : " + paging);
    mav.addObject("paging", paging);

    mav.addObject("nowPage", nowPage);
    
    // �α��� ���� Ȯ��
    int mem_no =0; 
    if((Integer)session.getAttribute("mem_no") !=null){
      mem_no=(Integer)session.getAttribute("mem_no");
    }
    System.out.println("mem_no: " + mem_no );
    mav.addObject("mem_no", mem_no);
    
    
    return mav;
  }
  
  /**
   * ��� + �˻� + ����¡ ����
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
    
    // �˻� ��� �߰�,  /webapp/product/list_mem_no.jsp
    mav.setViewName("/product/list_mem_no");   
    int mem_no = (Integer)session.getAttribute("mem_no");
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("mem_no", mem_no); // #{gory_no}
    hashMap.put("pr_title", pr_title);                  // #{word}
    hashMap.put("nowPage", nowPage);   
    
    System.out.println("mem_no :" + mem_no);
    System.out.println("pr_title :" + pr_title);
    System.out.println("pr_title cnt:"+ pr_title.length());
    
    // �˻� ���
    List<ProductVO> list = productProc.list_mem_no(hashMap);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count_mem_no = productProc.search_count_mem_no(hashMap);
    System.out.println("search_count_mem_no:" + search_count_mem_no);
    mav.addObject("search_count_mem_no", search_count_mem_no);

    /*CategoryVO categoryVO = categoryProc.read(gory_no);
    mav.addObject("categoryVO", categoryVO);*/
    
    // mav.addObject("word", word);

    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     *
     * @param gory_no ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
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
    
    /*CategoryVO categoryVO = categoryProc.read(productVO.getGory_no()); // ī�װ� ���� ����
    mav.addObject("categoryVO", categoryVO);*/ //CategoryVO

    ArrayList<Pr_fileVO> file_list = new ArrayList<Pr_fileVO>();
    
    String thumbs = productVO.getPr_thumbs(); 
    String files = productVO.getPr_files();
    String sizes = productVO.getPr_sizes();
    
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
      
        Pr_fileVO fileVO = new Pr_fileVO(thumbs_array[index], files_array[index], sizes_array[index]);
        file_list.add(fileVO);
      }
    } 
    mav.addObject("file_list", file_list);
    
    // �α��� ���� Ȯ��
    int mem_no =0; 
    if((Integer)session.getAttribute("mem_no") !=null){
      mem_no=(Integer)session.getAttribute("mem_no");
    }
    System.out.println("mem_no: " + mem_no );
    mav.addObject("mem_no", mem_no);
    
    return mav;
  }
  
  /**
   * ���� ��
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
    String[] files_array = files.split("/");   // ���ϸ� ����
    String[] sizes_array = sizes.split("/"); // ���� ������

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
   - �۸� �����ϴ� ����� ����
   - ���ϸ� �����ϴ� ����� ����
   - �۰� ������ ���ÿ� �����ϴ� ����� ����
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/product/storage");
    List<MultipartFile> filesMF = productVO.getPr_filesMF(); // Spring�� File ��ü�� �����ص�.
    
    // System.out.println("--> filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
    
    String files = ""; // �÷��� ������ ���ϸ�
    String files_item = ""; // �ϳ��� ���ϸ�
    String sizes = "";
    long sizes_item = 0;   // �ϳ��� ���� ������
    String thumbs = "";         // Thumb ���ϵ�
    String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�
    
    int count = filesMF.size();

    // ���� ��� ���� �о��.
    ProductVO productVO_old = productProc.read(productVO.getPr_no());
    
    // System.out.println("--> productCont count: " + count);
    // System.out.println("1) filesMF.get(0).getName(): " + filesMF.get(0).getName());
    // System.out.println("1) filesMF.get(0).getSize(): " + filesMF.get(0).getSize());
    // System.out.println("2) filesMF.get(0).getName().length(): " + filesMF.get(0).getName().length());
    if (filesMF.get(0).getSize() > 0) { // ���� ������ �����Ѵٸ�
      // System.out.println("3) ���ο� ������ ����մϴ�.");
      // ���� ���� ����
      
      String thumbs_old = productVO_old.getPr_thumbs();
      String files_old = productVO_old.getPr_files();
      
      System.out.println( "productVO_old.getPr_files() : "+ productVO_old.getPr_files());
      
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
      files = productVO_old.getPr_files();
      sizes = productVO_old.getPr_sizes();
      thumbs = productVO_old.getPr_thumbs();
    }
    productVO.setPr_files(files);
    productVO.setPr_sizes(sizes);
    productVO.setPr_thumbs(thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    
    // ȸ�� ���� �� session ���κ���
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

    String upDir = Tool.getRealPath(request, "/product/storage"); // ���� ���� ���� ���

    ProductVO productVO = productProc.read(pr_no); // ������ ���� ������ �б� ���� ����
    
    String thumbs_old = productVO.getPr_thumbs();
    String files_old = productVO.getPr_files();
    
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
    // ���� ��ǰ�� �޸� ��� ����.
    replyProc.deleteByPr_no(pr_no);
    // ��ٱ��� ����
    cartProc.deleteByPr_no(pr_no);
    
    int count = productProc.delete(pr_no); // ���ڵ� ����
    
    if (count == 1) {
     /* categoryProc.decreaseCnt(gory_no); // ��ϵ� �ۼ��� ����
*/      
      // 4���� ���ڵ尡 �ϳ��� �������ΰ�� 5��° ���ڵ尡 �����Ǹ� ����������
      // 2���������� 1 �������� �ٿ����մϴ�. 
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
