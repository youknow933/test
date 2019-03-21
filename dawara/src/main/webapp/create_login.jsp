<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
String root = request.getContextPath();
// out.println("root: " + root);`
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./css/style.css" rel='Stylesheet' type='text/css'>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <ASIDE style='float: right;'>
  <c:choose>
      <c:when test="${sessionScope.mem_id == null}">
        <A href='${pageContext.request.contextPath}/member/login.do' >Login</A> <span class='top_menu1'> | </span>
        <A href='./member/create.do'>회원 가입</A><span class='menu_divide' >│</span>  
      </c:when>
      <c:otherwise>
        ${sessionScope.mem_id } 님 반갑습니다!
        <br>
        <A href='<%=root %>/member/read.do?mem_no=${sessionScope.mem_no}'>내 정보 변경</A><span class='top_menu1'> | </span>
        <A href='<%=root %>/member/passwd_update.do'>패스워드 변경</A><span class='top_menu1'> | </span><br>
        <A href='<%=root %>/member/list_by_member.do'>회원 목록</A><span class='top_menu1'> | </span>
        <A href='${pageContext.request.contextPath}/member/logout.do' >Logout</A> <span class='top_menu1'> | </span>
      </c:otherwise>
    </c:choose>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' > | </span> 
  </ASIDE> 
  
  <DIV style='width: 50%; background-color: #EEEEFF; margin: 20px auto; font-size: 32px; text-align: center;'>
    DAWARA
  </DIV>

  
  <TABLE style='width: 50%; margin: 30px auto; border-collapse: collapse;'>
    <tr>
      <td style='width: 20%;'><img src='./menu/images/1.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/2.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/3.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/1.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/2.png' style='width: 100%; display: block;'></td>
    </tr>
    <tr>
      <td style='width: 20%;'><img src='./menu/images/1.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/2.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/3.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/1.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/2.png' style='width: 100%; display: block;'></td>
    </tr>
    <tr>
      <td style='width: 20%;'><img src='./menu/images/1.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/2.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/3.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/1.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/2.png' style='width: 100%; display: block;'></td>
    </tr>
  </TABLE>
  
  <DIV style='margin: 0px auto; width: 90%;'>
    <DIV style='float: left; width: 50%;'>
     </DIV>
     <DIV style='float: left; width: 50%;'>
    </DIV>  
  </DIV>

  <DIV style='width: 94.8%; margin: 0px auto;'>
  </DIV>  

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->

</body>
</html>