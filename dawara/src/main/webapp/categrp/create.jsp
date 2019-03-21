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
 
<DIV class='title_line' style='width: 40%;'>카테고리 그룹 등록</DIV>
 
<FORM name='frm' method='POST' action='./create.do'>
  <fieldset class='fieldset_basic'>
    <ul>
      <li class='li_none'>
      <label for='grp_classification'>카테고리 그룹번호</label>
      <input type='number' name='grp_classification' id='grp_classification' value='' required="required" style='width: 5%;'>
      </li>
      <li class='li_none'>
        <label class='label' for='grp_title'>카테고리 그룹 이름</label>
        <input type='text' name='grp_title' id='grp_title' value='' required="required" autofocus="autofocus">
      </li>
      <li class='li_none'>
        <label class='label' for='grp_seqno'>출력 순서</label>
        <input type='number' name='grp_seqno' id='grp_seqno' value='' required="required" placeholder="${grp_seqno }" min="1" max="1000" style='width: 70%;'>
      </li>
      <li class='li_none'>
        <label class='label' for='grp_visible'>출력 형식</label>
        <input type='text' name='grp_visible' id='grp_visible' value='Y' required="required">
      </li>
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
  