<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> 

<script type="text/javascript">
  $(function(){ 
  
  });
</script>
 
</head> 
<body>
<DIV class='container'>

<%-- <jsp:include page="/menu/top.jsp" flush='false' /> --%>
<c:import url="/menu/top.jsp"></c:import><!-- JSTL -->

<DIV class='content' style='width: 50%;'>
 
<DIV class='title_line'>알림</DIV>
  
  <DIV class="message">
    <FIELDSET class="field_basic">
      <UL>
<%--         <c:forEach var="msg" items="${param.msgs }"> --%>
        <c:forEach var="msg" items="${msgs }">
          <li class="li_none">${msg }</li>
        </c:forEach>
        
        <li class="li_none">
          <br>        
<%--           <c:forEach var="link" items="${param.links }"> --%>
          <c:forEach var="link" items="${links }">
            ${link }
          </c:forEach>
        </li>
      </UL>
    </FIELDSET>
  </DIV>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 
 