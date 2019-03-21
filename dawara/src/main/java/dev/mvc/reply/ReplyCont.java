package dev.mvc.reply;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import nation.web.tool.Messages;

import org.json.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.category.CategoryVO;
import dev.mvc.category.Categrp_CategoryVO;
import dev.mvc.categrp.CategrpVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.product.ProductProcInter;
import dev.mvc.product.ProductVO;
import dev.mvc.reply.ReplyVO;

@Controller
public class ReplyCont {
  @Autowired
  @Qualifier("dev.mvc.tool.Messages")
  private Messages messages = null;
  
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyProc") // 할당되는 Class 객체의 이름
  private ReplyProcInter replyProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc") // 할당되는 Class 객체의 이름
  private MemberProcInter memberProc;
  
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc = null;
  
  public ReplyCont() {
    System.out.println("ReplyCont created.");    
  }

  @ResponseBody
  @RequestMapping(value = "/reply/create.do", method = RequestMethod.POST, 
                            produces = "text/json;charset=UTF-8")
  public String create(ReplyVO replyVO) {
 
    JSONObject obj = new JSONObject();
    JSONArray msgs = new JSONArray();
    
    if (replyProc.create(replyVO) == 1) {
      msgs.put("댓글을 등록했습니다.");
    } else {
      msgs.put("댓글 등록에 실패했습니다.");
      msgs.put("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
    }
    
    obj.put("msgs", msgs);
    return obj.toString();
  }

  @RequestMapping(value="/reply/list.do", method=RequestMethod.GET)
  public ModelAndView list_by_pr_no(int pr_no) {
    ModelAndView mav = new ModelAndView();
    
    List<ReplyVO> list = replyProc.list_by_pr_no(pr_no);
    mav.addObject("list", list);
    
    mav.setViewName("/reply/list"); // /reply/list.jsp
    
    return mav;
  }
  
//http://localhost:9090/ojt/categrp/list_by_json.do?categrpno=11
 @ResponseBody
 @RequestMapping(value="/reply/list_by_json.do", 
                           method=RequestMethod.GET, 
                           produces = "application/json; charset=UTF-8")  
 public ResponseEntity list(int pr_no, HttpSession session){

   int mem_no = 0;
   
   if( (Integer)session.getAttribute("mem_no") != null){
     mem_no = (Integer)session.getAttribute("mem_no");
   }
   
   System.out.println("mem_no" + mem_no);
   
   System.out.println("list_by_json do");
   HttpHeaders responseHeaders = new HttpHeaders();
   
   List<Reply_MemberVO> list = replyProc.list_memno_prno(pr_no);
//list의 mem_no에 대해 memberVO의 mem_id를 가져옴
   JSONArray json = new JSONArray(list);        
   json.put(mem_no);
   return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
 }
  
  @ResponseBody
  @RequestMapping(value="/reply/update.do", 
                            method=RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String update(int rpl_no) {
    System.out.println("replyCont update(int rpl_no) GET called.");
    
    System.out.println("cont update.do rpl_no : " + rpl_no );
    ReplyVO replyVO = replyProc.read(rpl_no);
    
    
    JSONObject obj = new JSONObject();
    obj.put("rpl_no", replyVO.getRpl_no());
    obj.put("rpl_contents", replyVO.getRpl_contents());
    obj.put("rpl_rdate", replyVO.getRpl_rdate());
    
    System.out.println(obj.toJSONString());
    
    return obj.toJSONString();
  }
 
  @ResponseBody
  @RequestMapping(value = "/reply/update.do", method = RequestMethod.POST, 
                            produces = "text/json;charset=UTF-8")
  public String update(ReplyVO replyVO) {
 
    JSONObject obj = new JSONObject();
    JSONArray msgs = new JSONArray();
    
    if (replyProc.update(replyVO) == 1) {
      msgs.put("댓글을 수정했습니다.");
    } else {
      msgs.put("댓글 수정에 실패했습니다.");
      msgs.put("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
    }
    
    obj.put("msgs", msgs);
    return obj.toString();
  }
  
  /*@RequestMapping(value="/reply/update.do", method=RequestMethod.POST)
  public ModelAndView update(ReplyVO replyVO) {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    if (replyProc.update(replyVO) == 1) {
      mav.setViewName("redirect:/reply/list.do?pr_no=" + replyVO.getPr_no());
    } else {
      msgs.add("댓글 수정에 실패했습니다.");
      msgs.add("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");

      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/reply/message"); // /reply/message.jsp
    }

    return mav;
  }*/
  

  @ResponseBody
  @RequestMapping(value = "/reply/delete.do", 
                             method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String delete_form(int rpl_no, Locale locale) {
    System.out.println("--> delete() GET executed");


    JSONObject obj = new JSONObject();

    return obj.toJSONString();
  }
  
  /**
   * 삭제 처리
   * @param replyVO
   * @return
   */
  @RequestMapping(value="/reply/delete.do", method=RequestMethod.POST)
  public ModelAndView delete(int rpl_no, Locale locale) {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<String> msgs = new ArrayList<String>();
    ArrayList<String> links = new ArrayList<String>();
    
    // 현재 삭제되는 그룹정보 읽어옴.
    ReplyVO replyVO = replyProc.read(rpl_no);
    
    
    // 카테고리 그룹 삭제
    if (replyProc.delete(rpl_no) == 1) {
      // mav.setViewName("redirect:/reply/list.do");
 
      msgs.add(messages.getMessage("reply.delete.success", replyVO.getRpl_contents(), locale));

      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");
    } else {
      msgs.add(messages.getMessage("reply.delete.fail", replyVO.getRpl_contents(), locale));
      msgs.add(messages.getMessage("reply.delete.retry", locale));
      links.add("<button type='button' onclick=\"history.back();\">다시 시도</button>");
      links.add("<button type='button' onclick=\"location.href='./list.do'\">목록</button>");
      mav.addObject("msgs", msgs);
      mav.addObject("links", links);
      
      mav.setViewName("/reply/message"); // /reply/message.jsp
    }


    mav.setViewName("redirect:/reply/list.do?pr_no=" + replyVO.getPr_no());
    
    return mav;
  }
  // 답변
  
  @ResponseBody
  @RequestMapping(value = "/reply/answer.do", 
                             method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String answer(int rpl_no, Locale locale) {
    System.out.println("--> answer() GET executed");
    
    ReplyVO replyVO = replyProc.read(rpl_no);

    JSONObject obj = new JSONObject();
    obj.put("rpl_no", replyVO.getRpl_no());

    return obj.toJSONString();
  }
  

  
  @ResponseBody
  @RequestMapping(value = "/reply/answer.do", method = RequestMethod.POST, 
                            produces = "text/json;charset=UTF-8")
  public String answer(ReplyVO replyVO, HttpSession session) {
 
    JSONObject obj = new JSONObject();
    JSONArray msgs = new JSONArray();
    
   /* int categoryno = replyVO.getCategoryno();*/
  
     int mem_no = (Integer)session.getAttribute("mem_no");
    replyVO.setMem_no(mem_no);
    System.out.println("replyVO.getRpl_no : "  +  replyVO.getRpl_no());
    // --------------------------- 답변 관련 코드 시작 --------------------------
    ReplyVO parentVO = replyProc.read(replyVO.getRpl_no()); // 부모글 정보 추출
    System.out.println("parentVO:" +parentVO);
    
    replyVO.setRpl_grpno(parentVO.getRpl_grpno());     // 그룹 번호
    replyVO.setRpl_ansnum(parentVO.getRpl_ansnum()); // 답변 순서

    replyProc.updateAnsnum(replyVO); // 현재 등록된 답변 뒤로 +1 처리함.

    replyVO.setRpl_indent(parentVO.getRpl_indent() + 1); // 답변 차수 증가
    replyVO.setRpl_ansnum(parentVO.getRpl_ansnum() + 1); // 부모 바로 아래 등록
    // --------------------------- 답변 관련 코드 종료 --------------------------
    
    if(replyProc.answer(replyVO)==1){
      msgs.put("답글을 등록했습니다.");
    } else {
      msgs.put("답글 등록에 실패했습니다.");
      msgs.put("죄송하지만 다시한번 시도해주세요. ☏ 고객 센터: 000-0000-0000");
    }
      
  /*  if (count == 1) {
      categoryProc.increaseCnt(categoryno); // 글 수 증가
    }*/
    
    obj.put("msgs", msgs);
 
    return obj.toString();
  }


}
