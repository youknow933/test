<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page import="java.util.ArrayList" %>


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<%
String root = request.getContextPath();
// out.println("root: " + root);
%> 
 
<DIV class='top_menu' style="background-image: url('<%=root%>/menu/images/top_image.jpg' ); height: 200px;">
  <nav class="navbar navbar-default" style='text-align: center; top: 148px;'>
    <div class="container-fluid">       
      <div class="navbar-header">
        <a class="navbar-brand" href="<%=root%>/index.jsp"><img src ="<%=root %>/menu/images/003-home3.png" ></a><!-- WebSiteName -->
      </div>
      <ul class="nav navbar-nav">
       
<%--         <li><a href="<%=root%>#" ><b>GOODS</b></a></li> --%>
        
<!--         <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" ><b>BUY</b> <span class="caret"></span></a> -->
<!--           <ul class="dropdown-menu"> -->
<%--             <li><a href="<%=root%>#"><b>구매내역</b></a></li> --%>
<%--             <li><a href="<%=root%>#"><b>장바구니</b></a></li> --%>
<!--           </ul></li> -->
        
<!--         <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><b>마일리지</b><span class="caret"></span></a> -->
<!--           <ul class="dropdown-menu"> -->
<%--             <li><a href="<%=root%>#"><b>내 마일리지</b></a></li> --%>
<%--             <li><a href="<%=root%>#"><b></b></a></li> --%>
<!--           </ul></li> -->
          
<!--         <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" ><b>카테고리</b> <span class="caret"></span></a> -->
<!--           <ul class="dropdown-menu"> -->
<%--             <li><a href="<%=root%>#"><b>1</b></a></li> --%>
<%--             <li><a href="<%=root%>#"><b>2</b></a></li> --%>
<!--           </ul></li> -->
       
<%--         <li><a href="<%=root%>/deal/create.do?pr_no=1&buy_no=1" ><b>거래등록</b></a></li> --%>
        <li><a href="<%=root%>/deal/list.do" ><b>거래 목록</b></a></li>
         
<!--           <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" ><b>고객센터</b> <span class="caret"></span></a> -->
<!--           <ul class="dropdown-menu"> -->
<%--             <li><a href="<%=root%>#"><b>공지사항</b></a></li> --%>
<%--             <li><a href="<%=root%>#"><b>Q&A</b></a></li> --%>
<!--             </ul></li> -->
            
          
<!--             <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" ><b>내정보</b> <span class="caret"></span></a> -->
<!--           <ul class="dropdown-menu"> -->
<%--             <li><a href="<%=root%>#"><b>?</b></a></li> --%>
<%--             <li><a href="<%=root%>#"><b>?</b></a></li> --%>
<!--             </ul></li> -->
           
            
      </ul>
    
      
            
      <%-- <ul class="nav navbar-nav navbar-right">
        <% 
          if (MemberTool.isAdmin(request)) { // 로그인 중이면?
        %>
        <li><a href="<%=root%>/member/logout_proc.jsp" ><span class="glyphicon glyphicon-log-out"></span> <b>로그아웃</b></a></li>
        <%
            if (MemberTool.isMaster(request)) { // 관리자라면?
        %>
            <li><a href="<%=root%>/member/list.jsp" ><span class="glyphicon glyphicon-user"></span> <b>회원목록</b></a></li>
        <%              
            }
          } else { // 로그인 중이 아니면?
        %>
        <li><a href="<%=root%>/member/create_form.jsp" ><span class="glyphicon glyphicon-user"></span> <b>회원가입</b></a></li>
        <li><a href="<%=root%>/member/login_ck_form.jsp" ><span class="glyphicon glyphicon-log-in"></span> <b>로그인</b></a></li>
        <%
          }
        %>
      </ul> --%>
    </div>
  </nav>
</DIV> 

 
 
 
 
 
 