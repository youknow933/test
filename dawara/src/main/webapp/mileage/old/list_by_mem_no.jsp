<%@ page contentType="text/html; charset=UTF-8"%>
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
 
<script type="text/javascript">
</script>
</head>
 
<body>
<DIV class='container''>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>     
 
  <ASIDE style='float: left;'>
    <A href='./mileage/list.do'>게시판 목록</A>
    <span style='font-size: 1.4em;'>></span> 
    <A href='./list_by_mem_no.do'></A> 
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
  </ASIDE> 
         
  <div style='width: 100%;'>
   <table class="table table-hover table-bordered results"> 
  <thead>
   
    <tr> 
    <!--   <th class="col-md-1 col-xs-1" style = "text-align: center;">출력순서</th> -->
      <th class="col-md-1col-xs-1" style = "text-align: center;">회원번호</th> 
      <th class="col-md-2 col-xs-2" style = "text-align: center;">충전방법</th>
      <th class="col-md-3 col-xs-3" style = "text-align: center;">충전금액</th>
      <th class="col-md-2 col-xs-2" style = "text-align: center;">충전날짜</th>
    <!--   <th class="col-md-2 col-xs-2" style = "text-align: center;">총 마일리지</th> -->
      <th class="col-md-1 col-xs-1" style = "text-align: center;">수정</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">삭제</th> 
    </tr>
     
  </thead>
  <tbody>
   <c:forEach var="way_myM" items="${list }">
    <tr> 
     <%--  <th scope="row"  style='text-align: center;'>${way_myM.mileage_no }</th>  --%>
      
      <th scope="row"  style='text-align: center;'>${way_myM.mem_no }</td>
      <td style='text-align: center;'>${way_myM.cway }</td>
      <td style='text-align: center;'>${way_myM.char_m }원</td>  
      <td style='text-align: center;'>${way_myM.cmileage_date }</td>
      <%-- <td style='text-align: center;'>${way_myM.char_m + way_myM.mymileage }</td> --%>
 
      <td style='text-align: center;'><A href="javascript:update(${way_myM.mileage_no})"><IMG src='./images/update.png' title='수정'></A></td>
      <td style='text-align: center;'><A href="javascript:deleteOne(${way_myM.mileage_no})"><IMG src='./images/delete.png' title='삭제'></A></td>
     <%--  <td style='text-align: center;'><A href="javascript:seqnoUp(${categrp_CategoryVO.gory_no })"><IMG src='./images/up_20.jpg' title='우선 순위 높임' style='width: 20px;'></A></td>
      <td style='text-align: center;'><A href="javascript:seqnoDown(${categrp_CategoryVO.gory_no})"><IMG src='./images/down_20.jpg' title='우선 순위 감소' style='width: 20px;'></A></td>
     --%></tr>
  
    </c:forEach>
    
   </tbody>

</table>
    <br><br>
  </div>
 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>