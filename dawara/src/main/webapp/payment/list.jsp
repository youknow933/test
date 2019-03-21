<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<SCRIPT>
  $(function() {
  });
  
</SCRIPT>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <c:choose>
    <c:when test="${sessionScope.mem_no eq null}">
      <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>모든 결제 내역</H2>
    </c:when>
    <c:otherwise>
      <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>회원 결제 내역</H2>
    </c:otherwise>
  </c:choose>
  
  <aside style='float: left;'>
<%--     <a href="../product/list_by_category.do?gory_no=${param.gory_no }">판매 목록</a><!-- 개발 중 . . . --> --%>
<!--     <a href="../product/list_by_category.do?gory_no=1">판매 목록</a>개발 중 . . . -->
    <a href="../shipping/searchList_by_mem_no_paging.do">택배거래 목록</a>
    >
    <a href="./list.do">결제 내역</a>
    <!-- 검색 -->
<%--     <c:if test="${param.startDate.length() > 0 or param.endDate.length() > 0}"> --%>
<!--       > -->
<%--       [${param.startDate } ~ ${param.endDate }] 검색 목록 (${search_count } 건) --%>
<%--     </c:if> --%>
  </aside>
  <aside style="float: right;">
    <a href="javascript:location.reload();">새로고침</a>
    <span class="menu_divide"> | </span>
  </aside>
  
  <TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
    
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 20%;'/>
    <col style='width: 20%;'/>
    
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>pay_no</TH>
    <TH style='text-align: center ;'>ship_no</TH>
    <TH style='text-align: center ;'>mem_no</TH>
    
    <TH style='text-align: center ;'>결제 금액</TH>
    <TH style='text-align: center ;'>결제 수단</TH>
    <TH style='text-align: center ;'>결제일</TH>
    <TH style='text-align: center ;'>결제 메모</TH>
    
    <TH style='text-align: center ;'>상세보기</TH>
    <TH style='text-align: center ;'>수정</TH>
    <TH style='text-align: center ;'>삭제</TH>
  </TR>
  </thead>
  <tbody>
    <c:forEach var="PaymentVO" items="${list }">
      <TR>
        <TD style='text-align: center ;'>${PaymentVO.pay_no }</TD>
        <TD style='text-align: center ;'>${PaymentVO.ship_no }</TD>
        <TD style='text-align: center ;'>${PaymentVO.mem_no}</TD>
        <TD style='text-align: center ;'>${PaymentVO.pay_amount }</TD>
        <TD style='text-align: center ;'>${PaymentVO.pay_way }</TD>
        <TD style='text-align: center ;'>${PaymentVO.pay_date}</TD>
        <TD style='text-align: center ;'>${PaymentVO.pay_memo }</TD>
        <!-- ajax 구현시 제거 -->
        <TD style='text-align: center;'>
          <A href="./read.do?pay_no=${PaymentVO.pay_no }"><span class="glyphicon glyphicon-fullscreen"></span></A>
        </TD>
        <TD style='text-align: center;'>
          <A href="./update.do?pay_no=${PaymentVO.pay_no }"><span class="glyphicon glyphicon-edit"></span></A>
        </TD>
        <TD style='text-align: center;'>
          <A href="./delete.do?pay_no=${PaymentVO.pay_no }"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>
        <!-- ajax 구현시 제거 -->
        <!-- ajax 구현시 주석제거 -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:read(${PaymentVO.ship_no })"><span class="glyphicon glyphicon-fullscreen"></span></A> --%>
<!--         </TD> -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:update(${PaymentVO.ship_no })"><span class="glyphicon glyphicon-edit"></span></A> --%>
<!--         </TD> -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:deleteOne(${PaymentVO.ship_no })"><span class="glyphicon glyphicon-trash"></span></A> --%>
<!--         </TD> -->
        <!-- ajax 구현시 주석제거 -->
      </TR>
    </c:forEach>
  </tbody>
</TABLE>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>
