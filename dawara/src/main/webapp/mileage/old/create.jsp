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
 
<DIV class='title_line' style='width: 40%;'>마일리지 등록</DIV>
 
<FORM name='frm' method='POST' action='./create.do'>
  <fieldset class='fieldset_basic'>
    <ul>
      <li class='li_none'>
        <label class='label' for='cway_no'>마일리지 충전방법</label>
        <select name='cway_no' id='cway_no'>
          <option value='1' selected="selected">1-카드</option>
          <option value='2'>2-계좌이체</option>
          <option value='3'>3-무통장입금</option>
          <option value='4'>4-핸드폰</option>
        </select>
      </li>
      <li class='li_none'>
        <label class='label' for='mileage_no'>충전순서</label>
        <input type='text' name='mileage_no' id='mileage_no' value='' required="required" autofocus="autofocus">
      </li>
      <li class='li_none'>
        <label class='label' for='mem_no'>회원번호</label>
        <input type='number' name='mem_no' id='mem_no' value='' required="required" placeholder="${mem_no }" min="1" max="1000" style='width: 70%;'>
      </li>
      <li class='li_none'>
        <label class='label' for='char_m'>충전금액</label>
        <input type='text' name='char_m' id='char_m' value='Y' required="required"> 
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
  