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
 
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
  
  <aside style='float: left;'>
      <a href="../product/list_by_category.do?">판매 목록</a><!-- 개발 중 . . . -->
      >
      <a href="./list_by_dates_paging.do">거래 목록</a>
      >
      <a href="./read.do?deal_no=${param.deal_no }">거래 </a>
    </aside>
    <aside style="float: right;">
      <a href="javascript:location.reload();">새로고침</a>
      <span class="menu_divide"> | </span>
    </aside>
  
  <TABLE class='table table-striped table-hover'>
    <tbody>
      <TR>
        <TH style='text-align: center ;'>NO<em class="fieldName">(deal_no)</em> </TH>
        <TD style='text-align: center ;'>${dealVO.deal_no}</TD>
      </TR>
      <TR>
        <TH style='text-align: center ;'>거래상태</TH>
        <TD style='text-align: center ;'>${dealVO.d_state}</TD>
      </TR>
      <TR>
        <TH style='text-align: center ;'>거래방법</TH>
        <TD style='text-align: center ;'>${dealVO.d_way}</TD>
      </TR>
      <TR>
        <TH style='text-align: center ;'>거래확인</TH>
        <TD style='text-align: center ;'>${dealVO.d_check}</TD>
      </TR>
      <TR>
        <TH style='text-align: center ;'>거래등록일</TH>
        <TD style='text-align: center ;'>${dealVO.d_date}</TD>
      </TR>
      <TR>
        <TH style='text-align: center ;'>상품번호<em class="fieldName">(pr_no)</em> </TH>
        <TD style='text-align: center ;'>${dealVO.pr_no}</TD>
      </TR>
    </tbody>
  </TABLE>
    <div style='margin: 20px; text-align: center;'>
      <BUTTON type="button" class="btn" onclick="location.href='./searchList_by_mem_no_paging.do?mem_no=${shippingVO.mem_no}&nowPage=${param.nowPage}'">택배거래 목록으로</BUTTON>
      &nbsp;
      <BUTTON type="button" class="btn btn-primary" onclick="location.href='./update.do?ship_no=${shippingVO.ship_no}&nowPage=${param.nowPage}'">수정하기</BUTTON>
      <BUTTON type="button" class="btn btn-primary" onclick="../payment/create.do?ship_no=${shippingVO.ship_no} ">지금 결제하기</BUTTON>
    </div>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>




