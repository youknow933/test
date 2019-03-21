<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
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

<DIV class='title_line' style='width: 40%;'>권한 등록</DIV>

<FORM name='frm' method='POST' action='./create.do'>
  <!-- 개발시 임시 값 사용 -->
  <%-- <input type='hidden' name='categrpno' id='categrpno' value='${param.categrpno }'> --%>

  <fieldset class='fieldset_basic'>
    <ul>
      <li class='li_none'>
        <label for='auth_info'>권한 정보</label>
        <input type='text' name='auth_info' id='auth_info' value='' required="required" autofocus="autofocus">
      </li>
      <%-- <li class='li_none'>
        <label for='seqno'>출력 순서</label>
        <input type='number' name='seqno' id='seqno' value='' required="required" placeholder="${seqno }" min="1" max="1000" style='width: 70%;'>
      </li> --%>

      <li class='li_right'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list.do'">목록</button>
      </li>         
    </ul>
  </fieldset>
</FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
