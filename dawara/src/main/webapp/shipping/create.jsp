<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

<style type="text/css">
.icon_bul_h {
    display: inline-block;
    width: 12px;
    height: 14px;
    background: url(https://www.unicro.co.kr/webasp_common/new_images/common/uni_sprites.png) no-repeat -148px -75px;
}

.textcenter{
  text-align: center;
}
</style>

<script type="text/javascript">
  $(function() {
    setAddress();
  });
    	
  function setAddress(){
//     console.log("$('#same_addr').is(':checked')): "+$('#same_addr').is(":checked")) // true
    if($('#same_addr').is(":checked") != 0){
        $('#ship_rname').val('${buyerVO.mem_name }');
        $('#ship_rtel').val('${buyerVO.mem_tel }');
        $('#ship_zipcode').val('${buyerVO.mem_zipcode }');
        $('#ship_addr1').val('${buyerVO.mem_addr1 }');
        $('#ship_addr2').val('${buyerVO.mem_addr2 }');
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
// 	    if($('#recent_addr').is(":checked") != 0){
//         $('#ship_rname').val('${buyerVO.mem_name }');
//         $('#ship_rtel').val('${buyerVO.mem_tel }');
//         $('#ship_zipcode').val('${buyerVO.mem_zipcode }');
//         $('#ship_addr1').val('${buyerVO.mem_addr1 }');
//         $('#ship_addr2').val('${buyerVO.mem_addr2 }');
// 	    }
  }
  
</script>
</head>

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
  <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>택배 거래 등록</H2>
  
  <div style='clear: both;'>
    <aside style='float: left;'>
      <a href="../product/list_by_category.do?gory_no=${param.gory_no }">판매 목록</a>
      >
      <c:choose>
        <c:when test="${sessionScope.mem_no eq '' or sessionScope.mem_no eq null}">
          <a href="./searchList_by_mem_no_paging.do">모든 택배거래 목록(관리자)</a>
        </c:when>
        <c:otherwise>
          <a href="./searchList_by_mem_no_paging.do">회원 택배거래 목록</a>
        </c:otherwise>
      </c:choose>
    </aside>
  </div>
  
  <DIV>
    <br>
    <H3>상품 정보</H3>
    <DIV style='padding: 30px; border: 1px solid #2772cd; box-sizing: border-box; margin: 0 auto;'>
      <P style='font-size: 24px;'>
        <span class="icon_bul_h"></span>${productVO.pr_state} 상품: ${productVO.pr_title} ---> 
        <a href="../product/read.do?pr_no=${productVO.pr_no }&gory_no=${param.gory_no }&pr_title=${productVO.pr_title }&nowPage=${param.nowPage }" style='font-size: 20px;'>
          상품 보기
        </a>
      </P>
      <P style='font-size: 18px;'>
        구매가: ${tool.comma(productVO.pr_buyprice)}원&nbsp;(구매시기: ${productVO.pr_buyyear.substring(0, 7)}) 
      </P>
      <P style='font-size: 18px; font-weight: bold;'>
        판매가: ${tool.comma(productVO.pr_price)}원
      </P>
<%--       <P style='font-size: 24px; font-weight: 600; color: #2772cd;'>총 결제금액: ${tool.comma(productVO.pr_price)}원</P> --%>
    </DIV>
  </DIV>
  <DIV>
    <H3>판매자 정보</H3>
    <table style='width: 100%;'>
      <COLGROUP>
        <COL>
        <COL>
        <COL>
        <COL style='width: 100px;'>
      </COLGROUP>
      <TBODY>
        <tr>
          <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>판매자 ID</th>
          <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>연락처</th>
          <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>이메일</th>
          <th class="textcenter" style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>신고접수</th>
        </tr>
        <tr>
          <!-- 판매자 ID (판매자 직업) -->
          <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            ${sellerVO.mem_id }&nbsp;(${sellerVO.mem_job})
          </td>
          <!-- 연락처 -->
          <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            ${sellerVO.mem_tel }
          </td>
          <!-- 이메일 -->
          <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            ${sellerVO.mem_mail }
          </td>
          <!-- 신고접수 횟수 -->
          <td class="textcenter" style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            ${sellerVO.mem_acc} 건
          </td>
        </tr>
      </TBODY>
    </table>
  </DIV>
  <DIV>
    <H3>구매자 정보 <A href="#" style='padding: 0 12px;'>개인정보 수정</A> </H3>
    <table style='width: 100%;'>
      <COLGROUP>
        <COL style='width: 100px;'>
        <COL style='width: 150px;'>
        <COL style='width: 150px;'>
        <COL>
      </COLGROUP>
      <TBODY>
        <tr>
          <th class="textcenter" style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>성명</th>
          <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>연락처</th>
          <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>이메일</th>
          <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>주소</th>
        </tr>
        <tr>
          <!-- 구매자명 -->
          <td class="textcenter" style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            ${buyerVO.mem_name }
          </td>
          <!-- 연락처 -->
          <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            ${buyerVO.mem_tel }
          </td>
          <!-- 이메일 -->
          <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            ${buyerVO.mem_mail }
          </td>
          <!-- 주문자 주소 -->
          <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            (${buyerVO.mem_zipcode }) ${buyerVO.mem_addr1 } ${buyerVO.mem_addr2 }
          </td>
        </tr>
      </TBODY>
    </table>
  </DIV>

  <FORM name='ship_create' method='POST' action='./create.do'>
    <!-- 임시 PK값 사용 -->
    <input type='hidden' name='gory_no' id='gory_no' value='${param.gory_no }'>
    <input type='hidden' name='pr_no' id='pr_no' value='${param.pr_no }'>
<%--     <input type='hidden' name='mem_no' id='mem_no' value='${param.mem_no }'><!-- mem_no = 1: 판매자, 2: 구매자 --> --%>
<%--     <input type='hidden' name='mem_no' id='mem_no' value='${sessionScope.mem_no }'> --%>
    <DIV>
      <H3>배송지 정보</H3>
      <table style='font-size: 13px; width: 100%; border-top: 1px solid #768393'>
        <COLGROUP>
          <COL style='width: 150px;'>
          <COL>
        </COLGROUP>
        <TBODY>
          <!-- 배송방법 선택 -->
          <tr>
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>배송방법</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <INPUT type="radio" id="pr_tracsaction" name="pr_tracsaction" value="택배거래" checked="checked">
              <LABEL for='pr_tracsaction'>택배배송(판매자부담)</LABEL>
            </td>
          </tr>
          <!-- 배송지 정보 -->
          <tr>
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>배송지 정보</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <INPUT type="radio" name="ship_addr" id="same_addr" checked="checked" onclick="javascript:setAddress();">
              <LABEL for="same_addr">주문자 정보와 동일</LABEL>
              <INPUT type="radio" name="ship_addr" id="new_addr" onclick="javascript:setAddress();">
              <LABEL for="new_addr">새로 입력</LABEL>
              <!-- 나중에  -->
              <INPUT type="radio" name="ship_addr" id="recent_addr" onclick="javascript:setAddress();">
              <LABEL for="recent_addr">최근 배송지로 입력(x)</LABEL>
              <!-- 나중에  -->
            </td>
          </tr>
          <!-- 배송받는 분 -->
          <tr>
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>배송받는 분</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <INPUT type="text" name="ship_rname" id="ship_rname" style='width: 50px; height: 26px;' value="" required="required">
            </td>
          </tr>
          <!-- 연락처 -->
          <tr>
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>연락처</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <INPUT type="tel" name="ship_rtel" id="ship_rtel" style='width: 120px; margin: 1px 0; height: 26px;' value="">
            </td>
          </tr>
          <tr>
            <!-- 배송지 -->
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>주소</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <!-- 우편번호 -->
              <INPUT type="text" name='ship_zipcode' id='ship_zipcode' style="width: 60px; margin: 1px 0; height: 26px;" value="" required="required"
                placeholder="우편번호">
              <!-- 주소 찾기(API 호출) -->
              <A href="javascript: DaumPostcode()" style='padding: 0 12px;'>주소 찾기</A><BR>
              <div id="wrap" style="display: none; border: 1px solid; width: 500px; height: 300px; position: relative">
                <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap"
                  style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1" onclick="foldDaumPostcode()" alt="접기 버튼">
              </div>
              <!-- 주소 -->
              <INPUT type="text" name='ship_addr1' id='ship_addr1' style='width: 400px; margin: 1px 0; height: 26px;' required="required"
                placeholder="주소" required="required" value="">
              <BR>
              <!-- 상세주소 -->
              <INPUT type="text" name='ship_addr2' id='ship_addr2' style='width: 400px; margin: 1px 0; height: 26px;' required="required"
                placeholder="상세주소" value="">
            </td>
          </tr>
          <tr>
            <!-- 택배 배송 시 요청사항 -->
            <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>배송시 요청사항</th>
            <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'>
              <INPUT type="text" name="ship_memo" id="ship_memo" style='width: 400px; margin: 1px 0; height: 26px;' value=""
                placeholder="배송시 요청사항을 작성해주세요. ^^">
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
  
    <DIV>
      <H3>반품교환 안내</H3>
      <DIV style='padding: 15px; border: 1px solid #dcdcdc;'>
        <table style='width: 100%;'>
          <COLGROUP>
            <col style="width: 130px;">
            <COL>
          </COLGROUP>
          <TBODY>
            <tr>
              <TD>
                <span class="icon_bul"
                  style='display: inline-block; background: url("../new_images/common/uni_sprites.png") no-repeat -75px -60px);'></span>
                지정택배사
              </TD>
              <td style='padding: 10px;'>- 우체국/ 기본배송비(편도) 4,000원</td>
            </tr>
            <tr>
              <TD>
                <span class="icon_bul"
                  style='display: inline-block; background: url("../new_images/common/uni_sprites.png") no-repeat -75px -60px);'></span> 반품/교환 주소
              </TD>
              <td style='padding: 10px;'>
                - <SPAN style="color: green; /* font-weight: bold; */">(${sellerVO.mem_zipcode })&nbsp;${sellerVO.mem_addr1 }&nbsp;${sellerVO.mem_addr2 }&nbsp;(판매자 주소)</SPAN>
              </td>
            </tr>
            <tr>
              <TD>
                <span class="icon_bul"
                  style='display: inline-block; background: url("../new_images/common/uni_sprites.png") no-repeat -75px -60px);'></span> 반품/교환 절차
              </TD>
              <TD style='padding: 10px;'>
                - [반품절차] 1. 구매자 반품요청 &gt; 2. 판매자 반품동의 &gt; 3. 구매자 반품상품 배송 &gt; 4. 판매자 반품확인<br> - [교환절차] 교환은 판매자와 직접 협의 후 진행해주셔야 합니다.
              </TD>
            </tr>
            <tr>
              <TD>
                <span class="icon_bul"
                  style='display: inline-block; background: url("../new_images/common/uni_sprites.png") no-repeat -75px -60px);'></span> 환불처리
              </TD>
              <TD style='padding: 10px;'>
                - 판매자의 반품확인 후 구매자에게 환불/결제취소 진행됩니다. <BR> - 신용카드/실시간계좌이체 3~4영업일, 평생계좌/무통장입금 1영업일 소요
              </TD>
            </tr>
          </TBODY>
        </table>
      </DIV>
      <DIV>
        <INPUT type="checkbox" name="rtn_check" id="agree" required="required">
        <label for="agree" style="color: #2772cd;">[필수] 반품/교환에 관한 안내사항을 확인하였으며, 택배거래를 진행합니다. </label>
      </DIV>
    </DIV>
      
    <DIV style='text-align: center; margin: 0 auto; padding: 40px 20px 40px 20px;'>
      <BUTTON type="submit" class="btn btn-primary"
        style='font-weight: 300; background: #2772cd; color: #FFFFFF; padding: 12px 40px; cursor: pointer;'>배송지 등록</BUTTON>
      <BUTTON type="button" class="btn btn-link" onclick="location.href='../product/list_by_category.do?gory_no=${param.gory_no}'">뒤로(상품목록으로)</BUTTON>
    </DIV>
  </FORM>
    
  <%-- 
  <FORM name='payment_create' method='POST' action='../payment/create.do'>
    <DIV>
      <H3>결제방법 선택</H3>
      <DIV style='padding: 30px; border: 1px solid #2772cd; box-sizing: border-box; margin: 0 auto;'>
        <P style='font-size: 24px; font-weight: 600; color: #2772cd;'>총 결제금액: ${tool.comma(productVO.pr_price)}원</P>
        <DIV>
          <input type="radio" name="card" onclick="" value="1" checked="checked">
          <label for="card" class="mr15">신용카드</label>
          <input type="radio" name="account" onclick="" value="2">
          <label for="account" class="mr15">계좌이체</label>
          <input type="radio" name="kakaopay" onclick="" value="3">
          <label for="kakaopay" class="mr15">휴대폰</label>
        </DIV>
        <UL style='list-style: none;'>
          <li>- 구매대금이 실시간으로 다와라 계좌로 이체됩니다.</li>
          <li>- 이체가 완료되면 
            <SPAN style="font-weight: bold;">결제완료 상태</SPAN>로 변하며 판매자(<SPAN style="color: green; /* font-weight: bold; */">${sellerVO.mem_id }</SPAN>)님에게 배송요청 메시지가 발송됩니다.
          </li>
        </UL>
        <label for="pay_memo">결제 메모</label>
        <input type='text' name='pay_memo' id='pay_memo' style='width: 400px; margin: 1px 0; height: 26px;' value="">
      </DIV>
    </DIV>
    <div style='margin: 20px; text-align: center;'>
      <BUTTON type="button" class="btn btn-primary" onclick="location.href='../payment/create.do?ship_no=${shippingVO.ship_no}'"
            style='font-weight: 300; background: #2772cd; color: #FFFFFF; padding: 10px 40px; cursor: pointer;'>지금 결제하기</BUTTON>
    </div>
  </FORM>
   --%>
   
</DIV>
<!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV>
<!-- container END -->
</body>
</html>




