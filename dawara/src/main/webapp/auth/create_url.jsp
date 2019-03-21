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

<DIV class='title_line' style='width: 40%;'>접속 URL 등록</DIV>

<FORM name='frm' method='POST' action='./create_url.do'>
  <fieldset class='fieldset_basic'>
    <ul>
      <li class='li_none'>
        <label class='label' for='url'>URL 주소</label>
        <input type='text' name='url' id='url' value='' required="required" autofocus="autofocus">
      </li>
      <li class='li_none'>
        <label class='label' for='url_info'>URL 정보</label>
        <input type='text' name='url_info' id='url_info' value='' required="required">
      </li>
      <li class='li_none'>
        <label class='label' for='url_seqno'>출력 순서</label>
        <input type='number' name='url_seqno' id='url_seqno' value='' required="required" placeholder="${url_seqno }" min="1" max="1000" style='width: 70%;'>
      </li>
      <li class='li_right'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list_url.do'">목록</button>
      </li>         
    </ul>
  </fieldset>
</FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
  
   