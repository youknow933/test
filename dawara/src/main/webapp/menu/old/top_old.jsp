<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 
<%@ page import="java.util.ArrayList" %>
<%@ page import="nation.web.tool.Tool" %>
 
<%
String root = request.getContextPath();
// out.println("root: " + root);
%>
 
<!-- 화면 상단 메뉴 -->
<DIV class='top_menu_label'>Spring project</DIV>
<DIV class='top_menu' style="background-image: url('<%=root %>/menu/images/top_image.jpg')" >
  <NAV class='top_menu_list'>
    <A class='menu_link' href='<%=root %>/index.jsp'>HOME</A><span class='top_menu1'> | </span>
    
    <c:choose>
      <c:when test="${sessionScope.id == null}">
<%--         <A class='menu_link' href='${pageContext.request.contextPath}/member/login.do' >Login</A> <span class='top_menu1'> | </span> --%>
      </c:when>
      <c:otherwise>
         <span style='font-weight: bold; color: #333333; margin: 10px;'>${sessionScope.id }</span><A class='menu_link'  href='${pageContext.request.contextPath}/member/logout.do' >Logout</A> <span class='top_menu1'> | </span>
<%--         <A class='menu_link' href='<%=root %>/member/passwd_update.do'>패스워드 변경</A><span class='top_menu1'> | </span> --%>
      </c:otherwise>
    </c:choose>
  
<%--     <A class='menu_link' href='<%=root %>/categrp/list.do'>카테고리 그룹</A><span class='top_menu1'> | </span> --%>
<%--     <A class='menu_link' href='<%=root %>/member/create.do'>회원가입</A><span class='top_menu1'> | </span> --%>
<%--     <A class='menu_link' href='<%=root %>/member/list.do'>회원목록</A><span class='top_menu1'> | </span> --%>
    
  </NAV>
</DIV>

<!-- 화면을 2개로 분할하여 좌측은 메뉴, 우측은 내용으로 구성 -->  
  <DIV class="row" style='margin-top: 2px;'>
  <!-- bottom.jsp에서 닫음 1 -->
  
    <DIV class="col-md-2"> <!-- 메뉴 출력 컬럼 -->
      <img src='${pageContext.request.contextPath}/menu/images/myimage.jpg' style='width: 100%;'><!-- 추후에 이미지 바꿀 것 -->
      <div style='margin-top: 5px;'>
        <img src='${pageContext.request.contextPath}/menu/images/myface.png'>왕눈이<!-- 추후에 이미지 바꿀 것 -->
      </div>
       ▷ 블로그 소개
       <!-- Spring 출력 카테고리 그룹 / 카테고리 -->
      <c:import url="/category/list_index_left.do" /> 
    </div>
      
    <DIV class="col-md-10 cont">  <!-- 내용 출력 컬럼 -->  
    <!-- bottom.jsp에서 닫음 2 -->
   
   