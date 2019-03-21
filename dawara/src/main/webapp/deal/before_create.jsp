<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>거래 하기</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function() {
    
  });
</script>

</head>

<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />
    <DIV class='content' style='width: 90%;'>

      <FORM name='dealfrm' method='POST' action='./create.do'>
        <!-- 임시 PK값 사용 -->
        <input type='hidden' name='pr_no' id='pr_no' value='1'>
        <input type='hidden' name='buy_no' id='buy_no' value='1'>

        <fieldset class='fieldset_basic'>
          <ul>
            <li class='li_none'>
              <label> 새 거래를 등록합니다.</label>
            </li>
            <li class='li_none'>
              <label for='d_state'>거래상태</label>
              <input type='text' name='d_state' id='d_state' value='' required="required" placeholder="거래중" autofocus="autofocus">
            </li>
            <li class='li_none'>
              <label for='d_way'>거래방법</label>
              <input type='text' name='d_way' id='d_way' value='' required="required" placeholder="택배거래" style='width: 70%;'>
            </li>
            <li class='li_right'>
              <button type="submit">등록</button>
              <button type="button" onclick="location.href='./list.do'">목록</button>
            </li>         
          </ul>
        </fieldset>

      </FORM>

    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->
</body>
</html>




