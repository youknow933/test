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
  
  <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>택배거래 상세보기</H2>
  
  <aside style='float: left;'>
<%--     <a href="../product/list_by_category.do?gory_no=${param.gory_no }">판매 목록</a><!-- 개발 중 . . . --> --%>
    <c:choose>
      <c:when test="${sessionScope.mem_no eq '' or sessionScope.mem_no eq null}">
        <a href="../product/list_by_category.do?gory_no=1">판매 목록</a><!-- 개발 중 . . . -->
        >
        <a href="./list.do">모든 택배거래 목록</a>
        <br>
      </c:when>
      <c:otherwise>
        <a href="../product/list_by_category.do?gory_no=1">판매 목록</a><!-- 개발 중 . . . -->
        >
        <a href="./searchList_by_mem_no_paging.do }">회원 택배거래 목록</a>
        <br>
      </c:otherwise>
    </c:choose>
  </aside>
  <aside style="float: right;">
    <a href="javascript:location.reload();">새로고침</a>
    <span class="menu_divide"> | </span>
    <a href='./update.do?ship_no=${shippingVO.ship_no}&nowPage=${param.nowPage}'>수정하기</a>
  </aside>
  <br>
  <H3>배송지 정보</H3>
    <table style='font-size: 13px; width: 100%; border-top: 1px solid #768393'>
      <COLGROUP>
        <COL style='width: 150px;'>
        <COL>
      </COLGROUP>
      <TBODY>
        <!-- 배송방법 선택 -->
        <tr>
          <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>배송방법 선택</th>
          <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
            <INPUT type="radio" id="pr_tracsaction" name="pr_tracsaction" value="택배거래" checked="checked">
            <span></span>
            <LABEL for='pr_tracsaction'>택배배송(판매자부담)</LABEL>
          </td>
        </tr>
        <!-- 받는 사람 -->
        <tr>
          <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>받는 사람</th>
          <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
            <span>${shippingVO.ship_rname }</span>
          </td>
        </tr>
        <!-- 연락처 -->
        <tr>
          <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>연락처</th>
          <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
            <span>${shippingVO.ship_rtel }</span>
          </td>
        </tr>
        <!-- 배송지 -->
        <tr>
          <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>배송지</th>
          <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
            <!-- 우편번호 -->
            <span>(${shippingVO.ship_zipcode }) ${shippingVO.ship_addr1 } ${shippingVO.ship_addr2 }</span>
          </td>
        </tr>
        <!-- 택배 배송 시 요청사항 -->
        <tr>
          <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>배송시 요청사항</th>
          <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
            <p>${shippingVO.ship_memo }</p>
          </td>
        </tr>
      </TBODY>
    </table>
    <div style='margin: 20px; text-align: center;'>
      <BUTTON type="button" class="btn" onclick="location.href='./searchList_by_mem_no_paging.do?keyword=${param.keyword}&searchItem=${param.searchItem}&nowPage=${param.nowPage}'">택배거래 목록으로</BUTTON>
      &nbsp;
<%--       <BUTTON type="button" class="btn btn-primary" onclick="location.href='./update.do?ship_no=${shippingVO.ship_no}&nowPage=${param.nowPage}'" --%>
<!--             style='font-weight: 300; background: #2772cd; color: #FFFFFF; padding: 6px 30px; cursor: pointer;'>수정하기</BUTTON> -->
      <BUTTON type="button" class="btn btn-primary" onclick="location.href='../payment/create.do?ship_no=${shippingVO.ship_no} '"
            style='font-weight: 300; background: #2772cd; color: #FFFFFF; padding: 6px 30px; cursor: pointer;'>지금 결제하기</BUTTON>
    </div>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>




