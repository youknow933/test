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
    <c:when test="${param.mem_no eq '' or param.mem_no eq null}">
      <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>모든 택배거래 목록</H2>
    </c:when>
    <c:otherwise>
      <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>회원 택배거래 목록</H2>
    </c:otherwise>
  </c:choose>
  
  <aside style='float: left;'>
<%--     <a href="../product/list_by_category.do?gory_no=${param.gory_no }">판매 목록</a><!-- 개발 중 . . . --> --%>
    <a href="../product/list_by_category.do?gory_no=1">판매 목록</a><!-- 개발 중 . . . -->
    >
    <a href="./list_by_mem_no.do?mem_no=${param.mem_no }">택배거래 목록</a>
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
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 30%;'/>
    <col style='width: 10%;'/>
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>ship_no</TH>
    <TH style='text-align: center ;'>pr_no</TH>
    <TH style='text-align: center ;'>등록일</TH>
    <TH style='text-align: center ;'>받는 사람<em class="fieldName">(mem_no)</em></TH>
    <TH style='text-align: center ;'>연락처</TH>
    <TH style='text-align: center ;'>배송지</TH>
    <TH style='text-align: center ;'>발송여부</TH>
    <TH style='text-align: center ;'>상세보기</TH>
    <TH style='text-align: center ;'>수정</TH>
    <TH style='text-align: center ;'>삭제</TH>
  </TR>
  </thead>
  <tbody>
    <c:forEach var="ShippingVO" items="${list }">
      <TR>
        <TD style='text-align: center ;'>${ShippingVO.ship_no }</TD>
        <TD style='text-align: center ;'>${ShippingVO.pr_no }</TD>
        <TD style='text-align: center ;'>${ShippingVO.ship_date.substring(0, 10) }</TD>
        <TD style='text-align: center ;'>${ShippingVO.ship_rname }<em class="fieldName">(${ShippingVO.mem_no})</em></TD>
        <TD style='text-align: center ;'>${ShippingVO.ship_rtel }</TD>
        <TD style='text-align: center ;'>
          <A href="./read.do?ship_no=${ShippingVO.ship_no }">(${ShippingVO.ship_zipcode }) ${ShippingVO.ship_addr1 } ${ShippingVO.ship_addr2 }</A>
        </TD>
        <TD style='text-align: center ;'>${ShippingVO.ship_check }</TD>
        <!-- ajax 구현시 제거 -->
        <TD style='text-align: center;'>
          <A href="./read.do?ship_no=${ShippingVO.ship_no }"><span class="glyphicon glyphicon-fullscreen"></span></A>
        </TD>
        <TD style='text-align: center;'>
          <A href="./update.do?ship_no=${ShippingVO.ship_no }"><span class="glyphicon glyphicon-edit"></span></A>
        </TD>
        <TD style='text-align: center;'>
          <A href="./delete.do?ship_no=${ShippingVO.ship_no }"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>
        <!-- ajax 구현시 제거 -->
        <!-- ajax 구현시 주석제거 -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:read(${ShippingVO.ship_no })"><span class="glyphicon glyphicon-fullscreen"></span></A> --%>
<!--         </TD> -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:update(${ShippingVO.ship_no })"><span class="glyphicon glyphicon-edit"></span></A> --%>
<!--         </TD> -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:deleteOne(${ShippingVO.ship_no })"><span class="glyphicon glyphicon-trash"></span></A> --%>
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
