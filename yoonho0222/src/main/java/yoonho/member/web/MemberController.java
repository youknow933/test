package yoonho.member.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import yoonho.member.service.MemberService;

@Controller
public class MemberController {
  
 @Autowired
  private MemberService memberService;
  
  @RequestMapping("/hello")
   public String hello(){
    return "hello";
  }
  
  /*@RequestMapping("/memberList")
  public String member(){
    
   return "memberList";
 }*/
  
  @RequestMapping("/memberCount")
  public @ResponseBody Map<String, Object> memberCount(){
    Map<String, Object> map = new HashMap<String, Object>();
    
   map.put("memberCount", memberService.selectMemberCount());
    
   return map;
 }
  
  @RequestMapping("/memberList")
  public @ResponseBody ArrayList<Map<String, Object>> memberList(){
    
   return memberService.selectMember();
 }
}
