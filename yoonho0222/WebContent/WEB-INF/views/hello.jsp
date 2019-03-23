<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>

</head>
<body>
  <c:set var="aaa" value="1" scope="session"/>
  <% int a=1; %>  
    <c:if test="${aaa == 1}">
        <p>a는 1입니다.99999<p>
    </c:if>
   
   <h1>Hello World</h1> 
</body>
</html>
