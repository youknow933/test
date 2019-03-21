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
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<SPAN style="font-size:20px">내가 판매한 물품 <SPAN>

<DIV class='content' style='width: 100%;'>     
  
    
  <div class='menu_line' style='clear: both;'></div>       

  <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 5%;"></col>
        <col style="width: 30%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 15%;"></col>
        <col style="width: 20%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th>사진</th>
          <th>제목</th>
          <th>상태</th>
          <th>거래 방식</th>
          <th>가격</th>
          <th>등록일</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="productVO" items="${list }">
          <tr>
           <td style='vertical-align: middle;'>
              <c:choose>
                <c:when test="${productVO.pr_thumbs != ''}">
                  <IMG id='pr_thumb' src='./storage/${productVO.pr_thumbs}' > <!-- 이미지 파일명 출력 -->
                </c:when>
                <c:otherwise>
                  <IMG id='pr_thumb' src='./images/none1.jpg' style='width: 120px; height: 80px;'> <!-- 파일이 존재하지 않는 경우 -->
                </c:otherwise>
            </c:choose>
           </td>            
           <td style='vertical-align: middle;'>             
              <a href="./read.do?pr_no=${productVO.pr_no}">${productVO.pr_title}</a> 
<%--               <a href="./read.do?pr_no=${productVO.pr_no}&categoryno=${productVO.categoryno}&pr_title=${param.pr_title}&nowPage=${nowPage}">${productVO.title}</a>  --%>
            </td> 

            <td style='vertical-align: middle;'>${productVO.pr_state}</td>
            <td style='vertical-align: middle;'>${productVO.pr_transaction}</td>
            <td style='vertical-align: middle;'>${productVO.pr_price}</td>
            <td style='vertical-align: middle;'>${productVO.pr_rdate.substring(0, 16)}</td>
            
            <td style='vertical-align: middle;'>
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
  </table>
  
  <DIV class='bottom_menu'>${paging }</DIV> <!--  페이지 목록 출력 -->
    
  <br><br>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>