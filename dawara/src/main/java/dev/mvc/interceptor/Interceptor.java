package dev.mvc.interceptor;
 
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import dev.mvc.auth.AuthProcInter;
 
public class Interceptor extends HandlerInterceptorAdapter {
  @Autowired
  @Qualifier("dev.mvc.auth.AuthProc") // 할당되는 Class 객체의 이름
  private AuthProcInter authProc;
 
  // JSP등 View 페이지 출력전에 작동됨.
  @Override
  public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
      throws Exception {
    System.out.println("afterCompletion executed.");
  }
 
  // 요청 주소 결과 생성후 작동함
  @Override
  public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
      ModelAndView modelAndView) throws Exception {
    System.out.println("postHandle executed.");
  }
  
  // 요청 주소 결과 생성전에 작동함
  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    HttpSession session = request.getSession(true);
    //System.out.println("session.getAttribute(\"auth_no\"): " + session.getAttribute("auth_no"));
    System.out.println("preHandle executed.");
    //System.out.println("URL: " + request.getContextPath());
    
    String url = request.getRequestURI();
    System.out.println("-- URL2: " + url);
    
    // 관리자 로그인시 "grade" 세션 변수 생성
    int url_no = authProc.url_no_check(url);
//    System.out.println("url_no :" + url_no);
    
    int auth_no = 4;
    
    if(session.getAttribute("mem_id") != null){
      auth_no = (Integer)session.getAttribute("auth_no");
    }
    System.out.println("auth_no:" + auth_no);
        
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("url_no", url_no);    
    hashMap.put("auth_no", auth_no);  
    
    int count = authProc.access_url_check(hashMap);
    //System.out.println("count : " + count);
    
    if (count == 1){ // 접근 가능, 요청 페이지 처리
      return true; // 요청 페이지로 계속 진행
    } else{
      // 에러 출력또는 로그인 페이지로 이동
      response.sendRedirect(request.getContextPath() + "/member/interceptor.jsp");
      return false;
    }
  }
}