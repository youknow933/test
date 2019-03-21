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
 
<script>
  $(function() {
    setAddress();
  });
      
</script>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>결제내역 수정</H2>
  <aside style='float: left;'>
<%--     <c:choose> --%>
<%--       <c:when test="${param.mem_no eq '' or param.mem_no eq null}"> --%>
<!--         <a href="../product/list_by_category.do?gory_no=1">판매 목록</a>개발 중 . . . -->
<!--         > -->
<!--         <a href="./list.do">모든 택배거래 목록</a> -->
<!--         <br> -->
<%--       </c:when> --%>
<%--       <c:otherwise> --%>
        <a href="../product/list_by_category.do?gory_no=1">판매 목록</a><!-- 개발 중 . . . -->
        >
<%--         <a href="./list_by_mem_no.do?mem_no=${shippingVO.mem_no}">회원 택배거래 목록</a> --%>
        <a href="./searchList_by_mem_no_paging.do">회원 택배거래 목록</a>
        <br>
<%--       </c:otherwise> --%>
<%--     </c:choose> --%>
  </aside>
  <aside style="float: right;">
    <a href="javascript:location.reload();">새로고침</a>
    <span class="menu_divide"> | </span>
  </aside>
  
  <FORM name='ship_update' method='POST' action='./update.do'>
    <input type='hidden' name='pay_no' id='pay_no' value='${param.pay_no }'>
    <input type='hidden' name='keyword' id='keyword' value='${param.keyword }'>
    <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
    <DIV>
      <br>
      <H3>결제 내역</H3>
      <table style='font-size: 13px; width: 100%; border-top: 1px solid #768393'>
        <COLGROUP>
          <COL style='width: 150px;'>
          <COL>
        </COLGROUP>
        <TBODY>
          <!-- 결제번호 선택 -->
          <tr>
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>결제번호</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <span>${paymentVO.pay_no }</span>
            </td>
          </tr>
          <!-- 택배거래 번호 -->
          <tr>
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>택배거래 번호</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <span>${paymentVO.ship_no }</span>
            </td>
          </tr>
          <!-- 회원번호 -->
          <tr>
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>회원번호</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <span>${paymentVO.mem_no }</span>
            </td>
          </tr>
          <!-- 결제 금액 -->
          <tr>
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>결제 금액</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <span>${paymentVO.pay_amount}</span>
            </td>
          </tr>
          <!-- 결제 수단 -->
          <tr>
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>결제 수단</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <INPUT type="radio" id="pay_no" name="pay_no" value="결제번호" checked="checked">
              <LABEL for='pay_no'>${paymentVO.pay_way}</LABEL>
            </td>
          <!-- 결제일 -->
          </tr>
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>결제일</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <span>${paymentVO.pay_date}</span>
            </td>
          </tr>
          <!-- 결제 메모 -->
          <tr>
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>결제 메모</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <input type='text' name='pay_memo' id='pay_memo' style='width: 300px; margin: 1px 0; height: 26px;' value="${paymentVO.pay_memo }">
            </td>
          </tr>
        </TBODY>
      </table>
    </DIV>
    
    <DIV style='text-align: center; margin: 0 auto; padding: 40px 20px 40px 20px;'>
      <BUTTON type="button" class="btn btn-link" onclick="location.href='./list_by_mem_no.do'">취소(결제내역 List로)</BUTTON>
      <BUTTON type="submit" class="btn btn-primary"
        style='font-weight: 300; background: #2772cd; color: #FFFFFF; padding: 12px 40px; cursor: pointer;'>수정하기</BUTTON>
    </DIV>
  </FORM>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>

