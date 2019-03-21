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
<style type="text/css">

.h2underline {
    line-height: 48px; border-bottom: 2px solid #383838;
}

.searchbox {
    overflow: hidden;
    background: #faf8fb;
    border: 5px solid #dddddd;
    margin-top: 35px;
    padding: 25px 30px;
}

.searchbox .bloc {
    display: inline-block;
    height: 34px;
    line-height: 34px;
}

.searchbox .bloc .tit {
    display: inline-block;
    width: 500px;
    font-weight: 600;
}

.searchbox .right_area {
    float: right;
    width: 400px;
    margin: 0;
}

.btn_m03 {
    display: inline-block;
    color: #FFFFFF;
    font-weight: 600;
    background: #768393;
    border: 1px solid #6e7683;
    border-radius: 2px;
    padding: 0px 30px;
    height: 33px;
}

.btn_m03:hover {
    color: rgb(255, 255, 255);
    background: rgb(110, 118, 131);
    text-decoration: none;
}

.searchbox .right_area input {
    vertical-align: top;
    height: 33px;
}

.w240 {
    width: 240px !important;
}

.searchbox .btn_m03 .icon {
    display: inline-block;
    width: 23px;
    height: 16px;
    background: url(https://www.unicro.co.kr/webasp_common/new_images/common/uni_sprites.png) no-repeat -40px -30px;
    cursor: pointer;
}

.fr {
    float: right;
}

.searchbox .bloc label {
    margin-right: 5px;
}

</style>

<script type="text/javascript">
  $(function() {
    $("input").focus(function(){
        $(this).css("background-color", "#cccccc");
    });
    $("input").blur(function(){
        $(this).css("background-color", "#ffffff");
    });
	  
	  if($('#keyword').val() != null){
		  $('#keyword').focus().select();
	  }
	  
	  if('${param.searchItem}' == '통합검색'){
		  $("#all").prop("checked", "checked")
    } else if('${param.searchItem}' == '결제금액'){
        $("#pay_amount").attr("checked", "checked")
    } else if('${param.searchItem}' == '결제수단'){
        $("#pay_way").attr("checked", "checked")
	  } else if('${param.searchItem}' == '결제일'){
	      $("#pay_date").attr("checked", "checked")
    } else if('${param.searchItem}' == '결제메모'){
        $("#pay_memo").attr("checked", "checked")
    }
  });

</script>
  
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <c:choose>
    <c:when test="${sessionScope.mem_no eq null}">
      <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>모든 결제내역</H2>
    </c:when>
    <c:otherwise>
      <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>${sessionScope.mem_id }(${sessionScope.mem_name })님의 결제내역</H2>
    </c:otherwise>
  </c:choose>
  
  <div style='clear: both;'>
    <aside style='float: left;'>
<%--       <a href="../product/list_by_category.do?gory_no=${param.gory_no }">판매 목록</a><!-- 개발 중 . . . --> --%>
      <a href="../product/list_by_category.do?gory_no=1">상품 목록</a><!-- 개발 중 . . . -->
      >
      <a href="../shipping/searchList_by_mem_no_paging.do">택배거래 목록</a>
      >
      <a href="./searchList_by_mem_no_paging.do">결제내역</a>
      <!-- 검색 -->
      <c:if test="${param.keyword.length() > 0}">
        >
        [${searchItem}] '${keyword}' 검색결과: ${search_count_by_mem_no }건
      </c:if>
    </aside>
    <aside style='float: right;'>
      <a href="./searchList_by_mem_no_paging.do">전체 보기</a>
    </aside>
  </div>
  
  <form name="searchList" id="searchList" method ='GET' action="./searchList_by_mem_no_paging.do" >
    <div class="searchbox">
      <div class="bloc">
        <span class="tit">
          <label><input type="radio" id="all" name="searchItem" value="통합검색" checked="checked">통합검색</label>
          <label><input type="radio" id="pay_amount" name="searchItem" value="결제금액">결제금액</label>
          <label><input type="radio" id="pay_way" name="searchItem" value="결제수단">결제수단</label>
          <label><input type="radio" id="pay_date" name="searchItem" value="결제일">결제일</label>
          <label><input type="radio" id="pay_memo" name="searchItem" value="결제메모">결제메모</label>
        </span> 
      </div>
      <div class="bloc right_area">
        <c:choose>
          <c:when test="keyword == null or keyword == '' ">
            <input type="text" class="w240" name="keyword" id="keyword" value="" placeholder="검색어" size="8" >
          </c:when>
          <c:otherwise>
            <input type="text" class="w240" name="keyword" id="keyword" value="${keyword}" placeholder="검색어" size="8" >
          </c:otherwise>
        </c:choose>
        <button type="submit" class="btn_m03 fr"><span class="icon"></span>검색</button>
      </div>  
    </div>
  </form>
  
  <TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 20%;'/>
    <col style='width: 30%;'/>
    <col style='width: 8%;'/>
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>pay_no</TH>
    <TH style='text-align: center ;'>ship_no</TH>
    <TH style='text-align: center ;'>mem_no</TH>
    <TH style='text-align: center ;'>결제수단</TH>
    <TH style='text-align: center ;'>결제금액</TH>
    <TH style='text-align: center ;'>결제일</TH>
    <TH style='text-align: center ;'>메모</TH>
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
        <TD style='text-align: center ;'>${PaymentVO.pay_way }</TD>
        <TD style='text-align: center ;'>${tool.comma(PaymentVO.pay_amount) }원</TD>
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
        <!-- ajax 구현시 주석제거 -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:read(${paymentVO.ship_no })"><span class="glyphicon glyphicon-fullscreen"></span></A> --%>
<!--         </TD> -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:update(${paymentVO.ship_no })"><span class="glyphicon glyphicon-edit"></span></A> --%>
<!--         </TD> -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:deleteOne(${paymentVO.ship_no })"><span class="glyphicon glyphicon-trash"></span></A> --%>
<!--         </TD> -->
        <!-- ajax 구현시 주석제거 -->
      </TR>
    </c:forEach>
  </tbody>
</TABLE>
  
<DIV class='bottom_menu'>${paging }</DIV> <!-- 페이지 목록 출력 -->
<br><br>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>
