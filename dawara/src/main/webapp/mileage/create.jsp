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

<DIV class='content''>
 
 <DIV class='title_line' >${sessionScope.mem_name}님의 마일리지 충전소</DIV> 
<FORM name='frm' method='POST' action='./create.do'>
    <ul>
    
   <li class='li_none' style= "text-align: center;">
        <label class='label' for='cway'>충전방법</label>
        <select name='cway' id='cway'>
          <option value='카드' selected="selected">카드</option>
          <option value='핸드폰'>핸드폰</option>
          <option value='계좌이체'>계좌이체</option>
          <option value='무통장입금'>무통장입금</option>
        </select>
      </li>
      
      <li class='li_none' style= "text-align: center;">
        <label class='label' for='char_m'>충전금액</label>
        <select name='char_m' id='char_m'>
          <option value='1000' selected="selected">1,000원</option>
          <option value='3000'>3,000원</option>
          <option value='5000'>5,000원</option>
          <option value='10000'>10,000원</option>
          <option value='30000'>30,000원</option>
          <option value='50000'>50,000원</option>
        </select>
      </li>
      
      <li class='li_right'>
        <button type="submit" style= "text-align: center;">충전</button>
        <button type="button" onclick="window.close()" style= "text-align: center;">취소</button>
      </li>         
      
    </ul>
  </fieldset>
</FORM>
 
 
</DIV> <!-- content END -->

</DIV> <!-- container END -->
</body>
 
</html> 