<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<script type="text/javascript">
  $(function(){

  });
</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 50%;'>

<DIV class='title_line' style='width: 40%;'>권한별 접근 URL 등록</DIV>

<FORM name='frm' method='POST' action='./create_access_url.do'>
  <fieldset class='fieldset_basic'>
    <ul>
      <li class='li_none'>
        <label class='label' for='auth_no'>권한 번호</label>
        <input type='number' name='auth_no' id='auth_no' value='' required="required" placeholder="${auth_no }" min="1" max="1000" style='width: 70%;'>
      </li>
            <li class='li_none'>
        <label class='label' for='url_no'>주소 번호</label>
        <input type='number' name='url_no' id='url_no' value='' required="required" placeholder="${url_no }" min="1" max="1000" style='width: 70%;'>
      </li>
      <li class='li_none'>
        <label class='label' for='access_url_info'>권한별 접근 URL 정보</label>
        <input type='text' name='access_url_info' id='access_url_info' value='' required="required">
      </li>
      <li class='li_none'>
        <label class='label' for='access_url_seqno'>출력 순서</label>
        <input type='number' name='access_url_seqno' id='access_url_seqno' value='' required="required" placeholder="${url_seqno }" min="1" max="1000" style='width: 70%;'>
      </li>
      <li class='li_right'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list_access_url.do'">목록</button>
      </li>         
    </ul>
  </fieldset>
</FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
  
   