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
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 50%;'>
 
<DIV class='title_line'>알림</DIV>
  
  <DIV class="message">
    <FIELDSET class="field_basic">
      <UL>
        <c:choose>
          <c:when test="${param.count == 0}">
            <li class="li_none">택배거래 삭제에 실패했습니다.</li>
            <li class="li_none">다시 한번 시도해주세요.<BR></li>
            <li class="li_none">
              <button type='button' onclick="history.back()" >다시 시도</button>
              <button type='button' onclick="location.href='./searchList_by_mem_no_paging.do?nowPage=${param.nowPage}<%-- 
                                                                                 &word=${param.word }
                                                                                 &nowPage=${param.nowPage } --%>'" >택배거래 목록으로</button>
            </li>
          </c:when>
          <c:when test="${param.count == 1}">
            <li class="li_none">택배거래 삭제에 성공했습니다.<BR></li>
            <li class="li_none">
              <button type='button' onclick="location.href='./searchList_by_mem_no_paging.do?nowPage=${param.nowPage}<%-- 
                                                                                 &word=${param.word }
                                                                                 &nowPage=${param.nowPage } --%>'" >택배거래 목록으로</button>
            </li>
          </c:when>
        </c:choose>
      </UL>
    </FIELDSET>
  </DIV>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 
 