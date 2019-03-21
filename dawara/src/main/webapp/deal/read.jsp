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
      <a href="../product/list_by_category.do?gory_no=${productVO.gory_no }">판매 목록</a><!-- 개발 중 . . . -->
      >
      <a href="./searchList_paging.do">직거래 목록</a>
      >
      <a href="./read.do?deal_no=${param.deal_no }">거래 </a>
    </aside>
    <aside style="float: right;">
      <a href="javascript:location.reload();">새로고침</a>
      <span class="menu_divide"> | </span>
    </aside>
    
    <br>
    
  <DIV>
    <H3>상품 정보</H3>
    <DIV style='padding: 30px; border: 1px solid #2772cd; box-sizing: border-box; margin: 0 auto;'>
      <P style='font-size: 24px;'>
        <span class="icon_bul_h"></span>${productVO.pr_state} 상품: ${productVO.pr_title} ---> 
        <a href="../product/read.do?pr_no=${productVO.pr_no }&gory_no=${productVO.gory_no }&pr_title=${productVO.pr_title }&nowPage=${param.nowPage }" style='font-size: 20px;'>
          상품 보기
        </a>
      </P>
      <P style='font-size: 18px;'>
        구매가: ${tool.comma(productVO.pr_buyprice)}원&nbsp;(구매시기: ${productVO.pr_buyyear.substring(0, 7)}) 
      </P>
      <P style='font-size: 18px; font-weight: bold;'>
        판매가: ${tool.comma(productVO.pr_price)}원
      </P>
<%--         <P style='font-size: 24px; font-weight: 600; color: #2772cd;'>총 결제금액: ${tool.comma(productVO.pr_price)}원</P> --%>
      <p style='font-size: 18px;'>
        직거래 지역: ${productVO.pr_local }
      </p>
    </DIV>
  
  <TABLE class='table table-striped table-hover' style='margin: 0 auto; width: 50%;'>
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
<%--       <BUTTON type="button" class="btn" onclick="location.href='./list_by_mem_no.do?mem_no=${shippingVO.mem_no}'">택배거래 목록으로</BUTTON> --%>
    <BUTTON type="button" class="btn" onclick="location.href='./searchList_paging.do?nowPage=${param.nowPage}'">거래 목록으로</BUTTON>
    &nbsp;
    <BUTTON type="button" class="btn btn-primary" onclick="location.href='./update.do?deal_no=${dealVO.deal_no}&nowPage=${param.nowPage}'">수정하기</BUTTON>
<%--       <BUTTON type="button" class="btn btn-primary" onclick="../payment/create.do?deal_no=${shippingVO.deal_no} ">지금 결제하기</BUTTON> --%>
  </div>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>




