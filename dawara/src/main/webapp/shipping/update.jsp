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
      
  function setAddress(){
//     console.log("$('#same_addr').is(':checked')): "+$('#same_addr').is(":checked")) // true
    if($('#same_addr').is(":checked") != 0){
      $('#ship_rname').val('${memberVO.mem_name }');
      $('#ship_rtel').val('${memberVO.mem_tel }');
      $('#ship_zipcode').val('${memberVO.mem_zipcode }');
      $('#ship_addr1').val('${memberVO.mem_addr1 }');
      $('#ship_addr2').val('${memberVO.mem_addr2 }');
    } else if($('#new_addr').is(":checked") != 0){
      $('#ship_rname').val('');
      $('#ship_rtel').val('');
      $('#ship_zipcode').val('');
      $('#ship_addr1').val('');
      $('#ship_addr2').val('');
    } else{
      recentAddress();
    } 
  }
  
  function recentddress(){
      if($('#recent_addr').is(":checked") != 0){
        $('#ship_rname').val('${memberVO.mem_name }');
        $('#ship_rtel').val('${memberVO.mem_tel }');
        $('#ship_zipcode').val('${memberVO.mem_zipcode }');
        $('#ship_addr1').val('${memberVO.mem_addr1 }');
        $('#ship_addr2').val('${memberVO.mem_addr2 }');
      }
  }
  
</script>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>택배거래 수정</H2>
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
    <!-- 임시 PK값 사용 -->
<%--     <input type='hidden' name='mem_no' id='mem_no' value='${shippingVO.mem_no}'> --%>
    <input type='hidden' name='ship_no' id='ship_no' value='${param.ship_no }'>
    <input type='hidden' name='keyword' id='keyword' value='${param.keyword }'>
    <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
<%--     <input type='hidden' name='mem_no' id='mem_no' value='${sessionScope.mem_no }'> --%>
<!--     <input type='hidden' name='gory_no' id='gory_no' value='1'> -->
    <DIV>
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
              <LABEL for='pr_tracsaction'>택배배송(판매자부담)</LABEL>
            </td>
          </tr>
          <tr>
            <!-- 배송지 정보 -->
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>배송지 정보</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <INPUT type="radio" name="ship_addr" id="same_addr" checked="checked" onclick="javascript:setAddress();">
              <LABEL for="same_addr">주문자 정보와 동일</LABEL>
              <INPUT type="radio" name="ship_addr" id="new_addr" onclick="javascript:setAddress();">
              <LABEL for="new_addr">새로 입력</LABEL>
              <!-- 나중에 추가 -->
              <INPUT type="radio" name="ship_addr" id="recent_addr" onclick="javascript:setAddress();">
              <LABEL for="recent_addr">최근 배송지로 입력(x)</LABEL>
              <!-- 나중에 추가 -->
            </td>
          </tr>
          <tr>
            <!-- 배송받는 분 -->
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>배송받는 분</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
<%--               <input type="hidden" class="mem_name" id="mem_name" value="${memberVO.mem_name }" style='width: 50px;' readonly="readonly"> --%>
              <INPUT type="text" name="ship_rname" id="ship_rname" style='width: 50px; height: 26px;' value="${shippingVO.ship_rname }" required="required">
            </td>
          </tr>
          <tr>
            <!-- 연락처 -->
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>연락처</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
<%--               <input type="hidden" class="mem_tel" id="mem_tel" value="${memberVO.mem_tel }" style='width: 100px;' readonly="readonly"> --%>
              <INPUT type="tel" name="ship_rtel" id="ship_rtel" style='width: 120px; margin: 1px 0; height: 26px;' value="${shippingVO.ship_rtel }">
            </td>
          </tr>
          <tr>
            <!-- 배송지 -->
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>주소</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <!-- 우편번호 -->
<%--               <input type="hidden" class="mem_zipcode" id="mem_zipcode" value="${memberVO.mem_zipcode }" readonly="readonly" style='width: 50px;'> --%>
              <INPUT type="text" name='ship_zipcode' id='ship_zipcode' style="width: 60px; margin: 1px 0; height: 26px;" value="${shippingVO.ship_zipcode }" required="required"
                placeholder="우편번호">
              <!-- 주소 찾기(API 호출) -->
              <A href="javascript: DaumPostcode()" style='padding: 0 12px;'>주소 찾기</A><BR>
              <div id="wrap" style="display: none; border: 1px solid; width: 500px; height: 300px; position: relative">
                <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap"
                  style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1" onclick="foldDaumPostcode()" alt="접기 버튼">
              </div>
              <!-- 주소 -->
<%--               <input type="hidden" class="mem_addr1" id="mem_addr1" value="${memberVO.mem_addr1 }" readonly="readonly"> --%>
              <INPUT type="text" name='ship_addr1' id='ship_addr1' style='width: 400px; margin: 1px 0; height: 26px;' required="required"
                placeholder="주소" required="required" value="${shippingVO.ship_addr1 }">
              <BR>
              <!-- 상세주소 -->
<%--               <input type="hidden" class="mem_addr2" id="mem_addr2" value="${memberVO.mem_addr2 }" readonly="readonly"> --%>
              <INPUT type="text" name='ship_addr2' id='ship_addr2' style='width: 400px; margin: 1px 0; height: 26px;' required="required"
                placeholder="상세주소" value="${shippingVO.ship_addr2 }">
            </td>
          </tr>
          <tr>
            <!-- 택배 배송 시 요청사항 -->
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>배송시 요청사항</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <INPUT type="text" name="ship_memo" id="ship_memo" style='width: 400px; margin: 1px 0; height: 26px;' value="${shippingVO.ship_memo }"
                placeholder="배송시 요청사항을 작성해주세요. ^^">
<%--               <textarea rows="3" cols="60" name="ship_memo" id="ship_memo" placeholder="배송시 요청사항을 작성해주세요. ^^" >${shippingVO.ship_memo }</textarea> --%>
            </td>
          </tr>
        </TBODY>
      </table>
    </DIV>
    <!-- ------------------- DAUM 우편번호 API 시작 ------------------- -->
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
      // 우편번호 찾기 화면을 넣을 element
      var element_wrap = document.getElementById('wrap');
      
      function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
      }

      function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop,
            document.documentElement.scrollTop);
        new daum.Postcode(
            {
              oncomplete : function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
                
                // 기본 주소가 도로명 타입일때 조합한다.
                if (data.addressType === 'R') {
                  //법정동명이 있을 경우 추가한다.
                  if (data.bname !== '') {
                    extraAddr += data.bname;
                  }
                  // 건물명이 있을 경우 추가한다.
                  if (data.buildingName !== '') {
                    extraAddr += (extraAddr !== '' ? ', '
                        + data.buildingName : data.buildingName);
                  }
                  // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                  fullAddr += (extraAddr !== '' ? ' (' + extraAddr
                      + ')' : '');
                }
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('ship_zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('ship_addr1').value = fullAddr;
                
                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';
                
                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#ship_addr2').focus();
              },
              // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
              onresize : function(size) {
                element_wrap.style.height = size.height + 'px';
              },
              width : '100%',
              height : '100%'
            }).embed(element_wrap);
        
        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
      }
    </script>
    <!-- ------------------- DAUM 우편번호 API 종료 ------------------- -->
    
    <DIV style='text-align: center; margin: 0 auto; padding: 40px 20px 40px 20px;'>
<%--       <BUTTON type="button" class="btn btn-link" onclick="location.href='./list_by_mem_no.do?mem_no=${shippingVO.mem_no}'">취소(상품목록으로)</BUTTON> --%>
      <BUTTON type="button" class="btn" onclick="location.href='./searchList_by_mem_no_paging.do'">취소(상품목록으로)</BUTTON>
      <BUTTON type="submit" class="btn btn-primary"
        style='font-weight: 300; background: #2772cd; color: #FFFFFF; padding: 12px 40px; cursor: pointer;'>수정하기</BUTTON>
    </DIV>
  </FORM>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>

