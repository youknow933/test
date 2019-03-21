<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<%  
String root = request.getContextPath(); 
// out.println("root: " + root);
%> 

<link href="<%=root%>/menu/css/style.css" rel='Stylesheet' type='text/css'>
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

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
<c:import url="/menu/top.jsp" />
<DIV class='content'>

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.count == 0}">
          <li class='li_none'>글 수정에 실패했습니다.</li>
          <li class='li_none'>다시한번 시도해주세요.</li>
          <li class='li_none'>
            <br>
            <button type='button' onclick='history.back()'>다시 시도</button>
<%--             <button type='button' onclick="location.href='./list_all.do?mem_no=${param.mem_no}'">목록</button> --%>
            <button type='button' onclick="location.href='./list_by_notice.do?notice_search=notice_no&word=&mem_no=1'">목록</button>
          </li>
                     
        </c:when>
        <c:when test="${param.count == 1}">
          <li class='li_none'>글 수정에 성공했습니다.</li>
          <li class='li_none'>
            <br>
            <button type='button' onclick="location.href='./read.do?no_no=${param.no_no}'">변경 확인</button>
            <%-- <button type='button' onclick="location.href='./list_all.do?mem_no=${param.mem_no}'">목록</button> --%>
            <button type='button' onclick="location.href='./list_by_notice.do?notice_search=notice_no&word=&mem_no=1'">목록</button>
          </li>          
        </c:when>
      </c:choose>    
    </UL>
  </fieldset>

</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 
  
  
  