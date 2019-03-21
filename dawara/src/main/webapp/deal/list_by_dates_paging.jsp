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
  
  function deleteOne(deal_no) {
    var frm_delete = $('#frm_delete');
//     $('#categrpno', frm_delete).val(${Product_BuyMember_DealVO.deal_no}); // JavaScript + EL(톰캣 서버에서 먼저 처리)
                                                             // 또는 frm_delete에서 바로 hidden으로 보내줘도 됨.
    $('#deal_no', frm_delete).val(deal_no);
    
    var panel = '';
    panel += "<div id='panel' class='popup1' style='height: 200px; line-height: 30px;'>";
    panel += "  거래내역을 삭제합니다.<BR><BR>";
    panel += "  삭제하면 복구할 수 없습니다.<BR><BR>";
    panel += "  <button type='button' onclick='frm_delete.submit();' class='popup_button'> 삭제 </button>";
    panel += "  <button type='button' onclick=\"$('#main_panel').hide()\" class='popup_button'> 닫기 </button>";
    panel += "</div>";
    $('#main_panel').html(panel);
    $('#main_panel').show();
  }

</SCRIPT>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <!-- frm_delete -->
  <FORM name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
    <input type='hidden' name='deal_no' id='deal_no' value=''>
    <input type='hidden' name='startDate' id='startDate' value='${param.startDate}'>
    <input type='hidden' name='endDate' id='endDate' value='${param.endDate}'>
    <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
    <input type='hidden' name='gory_no' id='gory_no' value='${param.gory_no }'>
  </FORM>

  <DIV id='main_panel'></DIV>
  <br>
  
  <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>거래 목록</H2>
  
  <form name="frm" id="frm" method ='GET' action="./list_by_dates_paging.do" >
    <aside style='float: left;'>
      <a href="../product/list_by_category.do?">판매 목록</a><!-- 개발 중 . . . -->
      >
      <a href="./list_by_dates_paging.do">거래 목록</a>
      <c:if test="${param.startDate.length() > 0 or param.endDate.length() > 0}">
        >
        [${param.startDate } ~ ${param.endDate }] 검색 목록 (${search_count } 건)
      </c:if>
    </aside>
    <aside style="float: right;">
      <a href="javascript:location.reload();">새로고침</a>
      <span class="menu_divide"> | </span>
<%--       <a href="./create.do?pr_no=${Product_BuyMember_DealVO.pr_no }">등록</a><!-- 개발 중 . . . --> --%>
<!--       <span class="menu_divide"> | </span> -->

      <c:choose>
        <c:when test="${(param.startDate ne null or param.startDate ne '') and (param.endDate ne null or param.endDate ne '')}">
          <input type="date" name="startDate" id="startDate" value="${param.startDate }" style='height:24px;' size="8" >
          ~
          <input type="date" name="endDate" id="endDate" value="${param.endDate }" style='height:24px;' size="8" >
        </c:when>
        <c:otherwise>
          <input type="date" name="startDate" id="startDate" value="" style='height:24px;' size="8" >
          ~
          <input type="date" name="endDate" id="endDate" value="" style='height:24px;' size="8" >
        </c:otherwise>
      </c:choose>
      <button type="submit">검색</button>
      <button type="button" onclick="location.href='./list_by_dates_paging.do'">전체 보기</button>
    </aside>
  </form>
  
  <div class='menu_line' style='clear: both;'></div>
  <br>
  <!-- 수정폼(deal_update)은 항상 PK를 전달한다 -->
  <DIV id="deal_update" style='display: none; padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name="frm_update" id="frm_update" method="POST" action="./update.do">
      <INPUT type="hidden" name="startDate" id="startDate" value="${param.startDate }">
      <INPUT type="hidden" name="endDate" id="endDate" value="${param.endDate }">
      <INPUT type="hidden" name="nowPage" id="nowPage" value="${param.nowPage }">
      
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
  
  <TABLE class='table table-striped table-hover'>
  <colgroup>
    <col style='width: 6%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 8%;'/>
    <col style='width: 10%;'/>
    <col style='width: 8%;'/>
    <col style='width: 20%;'/>
    <col style='width: 10%;'/>
    <col style='width: 8%;'/>
    <col style='width: 10%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>NO<em class="fieldName">(deal_no)</em> </TH>
    <TH style='text-align: center ;'>거래상태</TH>
    <TH style='text-align: center ;'>거래방법</TH>
    <TH style='text-align: center ;'>거래확인</TH>
    <TH style='text-align: center ;'>거래등록일</TH>
    <TH style='text-align: center ;'>구매자<em class="fieldName">(mem_no)</em> </TH>
    <TH style='text-align: center ;'>제목<em class="fieldName">(pr_title)</em> </TH>
    <TH style='text-align: center ;'>상품가격</TH>
    <TH style='text-align: center ;'>판매자<em class="fieldName">(mem_no)</em> </TH>
    <TH style='text-align: center ;'>기타</TH>
  </TR>
  </thead>
  <tbody>
    <!-- BuyMember_DealVO: Join -->
    <c:forEach var="Product_BuyMember_DealVO" items="${list }">
      <TR>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.deal_no}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_state}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_way}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_check}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_date}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.buyer}<em class="fieldName">(${Product_BuyMember_DealVO.buyer_no})</em> </TD>
        <TD>
          <A href="./read.do?deal_no=${Product_BuyMember_DealVO.deal_no }">${Product_BuyMember_DealVO.pr_title}</A>
        </TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.pr_price}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.seller}<em class="fieldName">(${Product_BuyMember_DealVO.seller_no})</em> </TD>
        <TD style='text-align: center ;'>
          <A href="javascript:update(${Product_BuyMember_DealVO.deal_no })"><span class="glyphicon glyphicon-edit"></A>
<%--           <a href="./delete.do?deal_no=${Product_BuyMember_DealVO.deal_no}&nowPage=${nowPage}"><img src="./images/delete.png" title="삭제"  border='0'/></a> --%>
          <A href="javascript:deleteOne(${Product_BuyMember_DealVO.deal_no })"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>
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
