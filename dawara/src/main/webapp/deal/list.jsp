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

  <FORM id="deal_create" name='frm_create' method='POST' action='./create.do'>
    <!-- 임시 PK값 사용 -->
    <input type='hidden' name='pr_no' id='pr_no' value='${param.pr_no }'>
    <fieldset class='fieldset_basic'>
      <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>거래 등록</H2>
      <DIV id="buyproduct">
        <c:forEach var="Buy_ProductVO" items="${BPList }">
          <H3> 구매 상품 정보<em class="fieldName">(buy_no: ${Buy_ProductVO.buy_no})</em> </H3>
          <DIV style='padding: 30px; border: 1px solid #2772cd; box-sizing: border-box; margin: 0 auto;'>
            <P style='font-size: 24px;'>
              상품: ${Buy_ProductVO.pr_title}<em class="fieldName">(pr_title)</em>
            </P>
            <P style='font-size: 18px;'>
              판매가: ${Buy_ProductVO.pr_price}원<em class="fieldName">(pr_price)</em>
            </P>
            <P style='font-size: 24px; font-weight: 600; color: #2772cd;'>
              총 결제금액: ${Buy_ProductVO.pr_price}원<em class="fieldName">(pr_price)</em>
            </P>
          </DIV>
        </c:forEach>
      </DIV>
      
      <DIV id="buyer">
        <c:forEach var="Buy_MemberVO" items="${BMList }">
          <H3>주문자 정보<em class="fieldName">(mem_no: ${Buy_MemberVO.mem_no})</em></H3>
          <table style='width: 100%;'>
            <COLGROUP>
              <COL style='width: 150px;'>
              <COL>
            </COLGROUP>
            <TBODY>
              <tr>
                <!-- 주문자명 -->
                <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-bottom: 1px solid #dcdcdc;'>주문자명</th>
                <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
                  ${Buy_MemberVO.mem_name }<em class="fieldName">(mem_name)</em>
                   - <A href="#">개인정보 수정</A>
                </td>
              </tr>
              <tr>
                <!-- 연락처 -->
                <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-bottom: 1px solid #dcdcdc;'>연락처</th>
                <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
                  ${Buy_MemberVO.mem_tel }<em class="fieldName">(mem_tel)</em>
                </td>
              </tr>
              <tr>
                <!-- 이메일 -->
                <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-bottom: 1px solid #dcdcdc;'>이메일</th>
                <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
                  ${Buy_MemberVO.mem_mail }<em class="fieldName">(mem_mail)</em>
                </td>
              </tr>
              <tr>
                <!-- 주문자 주소 -->
                <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-bottom: 1px solid #dcdcdc;'>주소</th>
                <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
                  ${Buy_MemberVO.mem_addr1 }<em class="fieldName">(mem_addr1)</em>
                </td>
              </tr>
            </TBODY>
          </table>
        </c:forEach>
      </DIV>
        
      <ul>
        <li class='li_none'>
          <label> 새 거래를 등록합니다.</label>
        </li>
        <li class='li_none'>
          <label for='d_state'>거래상태</label>
          <SELECT name="d_state" id="d_state">
            <OPTION value="거래진행중" selected="selected">거래진행중</OPTION>
            <OPTION value="결제중">결제중</OPTION>
            <OPTION value="배송중">배송중</OPTION>
            <OPTION value="수취확인중">수취확인중</OPTION>
            <OPTION value="거래완료">거래완료</OPTION>
          </SELECT>
        </li>
        <li class='li_none'>
          <label for='d_way'>거래방법</label>
<!--           <input type='text' name='d_way' id='d_way' value='' required="required" placeholder="택배거래" style='width: 70%;'> -->
          <INPUT type="radio" name="d_way" id="d_way" value="직거래"  disabled="disabled">직거래
          <INPUT type="radio" name="d_way" id="d_way" value="택배거래" checked="checked">택배거래
        </li>
        <li class='li_center'>
          <button type="submit">등록</button>
          <button type="button" onclick="location.href='./list.do'">목록</button>
        </li>         
      </ul>
    </fieldset>
  </FORM>
  
  <!-- 수정폼은 항상 PK를 전달한다 -->
  <!-- deal_update -->
  <DIV id="deal_update" style='display: none; padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name="frm_update" id="frm_update" method="POST" action="./update.do">
      <LABEL for="deal_no">거래번호</LABEL>
      <INPUT type="text" name="deal_no" id="deal_no" value="" readonly="readonly" size="5">
      
      <LABEL for="d_state">거래상태</LABEL>
      <SELECT name="d_state" id="d_state">
        <OPTION value="거래진행중">거래진행중</OPTION>
        <OPTION value="결제중">결제중</OPTION>
        <OPTION value="배송중">배송중</OPTION>
        <OPTION value="수취확인중">수취확인중</OPTION>
        <OPTION value="거래완료">거래완료</OPTION>
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
  <TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 7%;'/>
    <col style='width: 7%;'/>
    <col style='width: 10%;'/>
<%--     <col style='width: 10%;'/> --%>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 7%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
  </colgroup>
  <thead>  
  <TR>
<!--     <TH style='text-align: center ;'>구매번호</TH> -->
<!--     <TH style='text-align: center ;'>회원번호</TH> -->
    <TH style='text-align: center ;'>번호</TH>
    <TH style='text-align: center ;'>등록일</TH>
    <TH style='text-align: center ;'>거래상태</TH>
    <TH style='text-align: center ;'>거래방법</TH>
    <TH style='text-align: center ;'>거래확인</TH>
    <TH style='text-align: center ;'>제목</TH>
    <TH style='text-align: center ;'>상품가격</TH>
<!--     <TH style='text-align: center ;'>구매등록일</TH> -->
    <TH style='text-align: center ;'>구매자 ID</TH>
    <TH style='text-align: center ;'>기타</TH>
  </TR>
  </thead>
  <tbody>
    <!-- BuyMember_DealVO: Join -->
    <c:forEach var="Product_BuyMember_DealVO" items="${list }">
      <TR>
<%--         <TD style='text-align: center ;'>${BuyMember_DealVO.buy_no}</TD> --%>
<%--         <TD style='text-align: center ;'>${BuyMember_DealVO.mem_no}</TD> --%>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.deal_no}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_date}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_state}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_way}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.d_check}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.pr_title}</TD>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.pr_price}</TD>
<%--         <TD style='text-align: center ;'>${BuyMember_DealVO.buy_rdate}</TD> --%>
        <TD style='text-align: center ;'>${Product_BuyMember_DealVO.mem_id}</TD>
        <TD style='text-align: center;'>
          <A href="javascript:update(${Product_BuyMember_DealVO.deal_no })"><IMG src='./images/update.png' title='수정'></A>
          <A href="javascript:deleteOne(${Product_BuyMember_DealVO.deal_no })"><IMG src='./images/delete.png' title='삭제'></A>
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
