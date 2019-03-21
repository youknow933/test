<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>거래 목록</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<SCRIPT>
  $(function() {
    $('#panel_create').show();
    $('#panel_update').hide();
  });
  
  function update(deal_no) { 
    $('#deal_create').hide();
    $('#deal_update').show();
//     console.log('[list.jsp update()] deal_no: ' + deal_no);
    
    $.ajax({
      url: "./update.do",
      type: "get",
      cache: false,
      dataType: "json",
      data: 'deal_no=' + deal_no,
      success: function(rdata) {
//         console.log('frm_update: ' + $('#frm_update').serialize());
//         console.log('frm_update: ' + $('#frm_update'));
        var frm_update = $('#frm_update');
        $('#deal_no', frm_update).val(deal_no);
        $('#d_state', frm_update).val(rdata.d_state);
        $('#d_way', frm_update).val(rdata.d_way);
        $('#d_check', frm_update).val(rdata.d_check);
        console.log("$('#deal_no', frm_update).val(): " + $('#deal_no', frm_update).val());
        console.log('rdata.d_state: ' + rdata.d_state);
        console.log('rdata.d_way: ' + rdata.d_way);
        console.log('rdata.d_check: ' + rdata.d_check);
      },
      error: function(request, status, error){
        var panel = '';
        panel += "<div id='panel' class='popup1' style='height: 250px;'>";
        panel += '  ERROR<br>';
//         panel += '  <strong>request.status</strong><br>' + request.status + '<hr>';
        panel += request.status + '<hr>';
//         panel += '  <strong>error</strong><br>' + error + '<hr>';
        panel += error + '<hr>';
        panel += "  <button type='button' style='color:#000;' onclick=\"$('#main_panel').hide()\">닫기</button>";
        panel += "</div>";
        $('#main_panel').html(panel);
        $('#main_panel').show();
      }
    });
  }
   
  function create_update_cancel() {
    $('#deal_update').hide(); // 순서: hide -> show; 감추고(hide)나서 보여주는(show) 것이 UI가 매끄러움
    $('#deal_create').show();
  }

</SCRIPT>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <DIV id='main_panel'></DIV>
  <br>
  <form name="frm" id="frm" method ='GET' action="./searchList_btwn_date.do" >
    <aside style='float: left;'>
      <a href="../product/list.do?">판매 목록</a>
      >
      <a href="./list.do">거래 목록</a>
      <c:if test="${param.startDate.length() > 0}">
        >
        [${param.startDate } ~ ${param.endDate }] 검색 목록 (${search_count } 건)
      </c:if>
    </aside>
    <aside style="float: right;">
      <a href="javascript:location.reload();">새로고침</a>
      <span class="menu_divide"> | </span>
      <a href="./create.do?pr_no=${VO.pr_no }">등록</a><!-- 개발 중 . . . -->
      <span class="menu_divide"> | </span>
      <c:choose>
        <c:when test="${param.startDate != null or param.startDate != ''}">
          <input type="text" name="startDate" id="startDate" value="${param.startDate }" placeholder="YYMMDD" size="6" >
          ~
          <input type="text" name="endDate" id="endDate" value="${param.endDate }" placeholder="YYMMDD" size="6" >
        </c:when>
        <c:otherwise>
          <input type="text" name="startDate" id="startDate" value="" placeholder="YYMMDD" size="6" >
          ~
          <input type="text" name="endDate" id="endDate" value="" placeholder="YYMMDD" size="6" >
        </c:otherwise>
      </c:choose>
      <button type="submit">검색</button>
      <button type="button" onclick="location.href='./searchList_btwn_date.do'">전체 보기</button>
    </aside>
  </form>
  
  <div class='menu_line' style='clear: both;'></div>  
  <br>
  <!-- 수정폼(deal_update)은 항상 PK를 전달한다 -->
  <DIV id="deal_update" style='display: none; padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name="frm_update" id="frm_update" method="POST" action="./update.do">
      <LABEL for="deal_no">거래번호</LABEL>
      <INPUT type="text" name="deal_no" id="deal_no" value="" readonly="readonly" size="5">
      
      <LABEL for="d_state">거래상태</LABEL>
      <SELECT name="d_state" id="d_state">
        <OPTION value="거래진행중">거래 진행 중</OPTION>
        <OPTION value="결제중">결제 중</OPTION>
        <OPTION value="배송중">배송 중</OPTION>
        <OPTION value="수취확인중">수취 확인 중</OPTION>
        <OPTION value="거래완료">거래 완료</OPTION>
      </SELECT>
      
      <LABEL for="d_way">거래방법</LABEL>
      <SELECT name="d_way" id="d_way">
        <OPTION value="직거래">직거래</OPTION>
        <OPTION value="택배거래">택배거래</OPTION>
      </SELECT>
      
      <LABEL for="d_check">거래확인</LABEL>
      <SELECT name="d_check" id="d_check">
        <OPTION value="Y">Y</OPTION>
        <OPTION value="N">N</OPTION>
      </SELECT>
      
      <BUTTON type="submit" id="submit">수정</BUTTON>
      <BUTTON type="button" onclick="create_update_cancel();">취소</BUTTON>
    </FORM>
  </DIV>
  
  <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>거래 목록</H2>
  <TABLE class='table table-striped table-hover'>
  <colgroup>
<%--     <col style='width: 5%;'/> --%>
    <col style='width: 6%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 8%;'/>
    <col style='width: 10%;'/>
    <col style='width: 8%;'/>
    <col style='width: 20%;'/>
    <col style='width: 10%;'/>
    <col style='width: 8%;'/>
<%--     <col style='width: 10%;'/> --%>
<%--     <col style='width: 10%;'/> --%>
    <col style='width: 10%;'/>
  </colgroup>
  <thead>  
  <TR>
<!--     <TH style='text-align: center ;'>pr_no</TH> -->
    <TH style='text-align: center ;'>NO</TH>
    <TH style='text-align: center ;'>거래상태</TH>
    <TH style='text-align: center ;'>거래방법</TH>
    <TH style='text-align: center ;'>거래확인</TH>
    <TH style='text-align: center ;'>거래등록일</TH>
    <TH style='text-align: center ;'>구매자<em class="fieldName">(mem_no)</em> </TH>
    <TH style='text-align: center ;'>제목</TH>
    <TH style='text-align: center ;'>상품가격</TH>
    <TH style='text-align: center ;'>판매자<em class="fieldName">(mem_no)</em> </TH>
<!--     <TH style='text-align: center ;'>구매등록일</TH> -->
<!--     <TH style='text-align: center ;'>구매자 ID</TH> -->
    <TH style='text-align: center ;'>기타</TH>
  </TR>
  </thead>
  <tbody>
    <!-- BuyMember_DealVO: Join -->
    <c:forEach var="Product_BuyMember_DealVO" items="${list }">
      <TR>
<%--         <TD style='text-align: center ;'>${Product_BuyMember_DealVO.pr_no}</TD> --%>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.deal_no}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_state}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_way}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_check}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_date}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.seller}<em class="fieldName">(${Product_BuyMember_DealVO.seller_no})</em> </TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.pr_title}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.pr_price}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.buyer}<em class="fieldName">(${Product_BuyMember_DealVO.buyer_no})</em> </TD>
<%--         <TD style='text-align: center ;'>${BuyMember_DealVO.buy_rdate}</TD> --%>
<%--         <TD style='text-align: center ;'>${Product_BuyMember_DealVO.mem_id}</TD> --%>
        <TD style='text-align: center;'>
          <A href="javascript:update(${Product_BuyMember_DealVO.deal_no })"><IMG src='./images/update.png' title='수정'></A>
          <a href="./delete.do?deal_no=${Product_BuyMember_DealVO.deal_no}&nowPage=${nowPage}"><img src="./images/delete.png" title="삭제"  border='0'/></a>
<%--           <A href="javascript:deleteOne(${Product_BuyMember_DealVO.deal_no })"><IMG src='./images/delete.png' title='삭제'></A> --%>
          <A href="javascript:seqnoUp(${Product_BuyMember_DealVO.deal_no })"><IMG src='./images/up.jpg' title='우선 순위 높임' style="width: 16px;"></A>
          <A href="javascript:seqnoDown(${Product_BuyMember_DealVO.deal_no })"><IMG src='./images/down.jpg' title='우선 순위 내림' style="width: 16px;"></A>
        </TD>
      </TR>
    </c:forEach>
  </tbody>
</TABLE>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>
