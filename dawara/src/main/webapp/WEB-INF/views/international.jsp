<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
<style type="text/css">
  *{font-size: 32px;}
  DIV {margin-top: 30px;}
</style>
</head>
<body>
  <DIV>
    [<a href="<c:url value="/international.do?lang=ko" />">한국어</a>]
    [<a href="<c:url value="/international.do?lang=en" />">English</a>]
  </DIV>
  <DIV>
    1. member.logout : <spring:message code="member.logout" /><br>
    2. member.logout : <spring:message code="member.logout" text="기본 문자열" /><br>
    3. member.logout : <spring:message code="member.logout" arguments="${sessionScope.id }" />
  </DIV>
 
</body>
</html>