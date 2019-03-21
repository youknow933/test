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
  });
  
</script>
</head>
<body>
<DIV class='container'>
<%-- <jsp:include page="/menu/top.jsp" flush='false' /> --%>
<c:import  url="/menu/top.do" />
<DIV class='content'>
  <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>상품 결제</H2>
  <DIV>
    <H3>구매상품 정보</H3>
    <DIV style='padding: 30px; border: 1px solid #2772cd; box-sizing: border-box; margin: 0 auto;'>
      <P style='font-size: 24px;'>
        <span class="icon_bul_h"></span>${productVO.pr_state} 상품: ${productVO.pr_title} ---> 
        <a href="../product/read.do?pr_no=${productVO.pr_no }&gory_no=${param.gory_no }&pr_title=${param.pr_title }&nowPage=${param.nowPage }" style='font-size: 20px;'>
          상품 보기
        </a>
      </P>
      <P style='font-size: 18px;'>
        구매가: ${productVO.pr_buyprice}원&nbsp;(구매시기: ${productVO.pr_buyyear.substring(0, 7)}) 
      </P>
      <P style='font-size: 18px; font-weight: bold;'>
        판매가: ${productVO.pr_price}원
      </P>
<%--       <P style='font-size: 24px; font-weight: 600; color: #2772cd;'>총 결제금액: ${productVO.pr_price}원</P> --%>
    </DIV>
  </DIV>
  <DIV style='display: none'>
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
          <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-bottom: 1px solid #dcdcdc;'>구매자명</th>
          <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-bottom: 1px solid #dcdcdc;'>연락처</th>
          <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-bottom: 1px solid #dcdcdc;'>이메일</th>
          <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-bottom: 1px solid #dcdcdc;'>주소</th>
        </tr>
        <tr>
          <!-- 구매자명 -->
          <td class="textcenter" style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            <input type="hidden" class="mem_name" id="mem_name" value="${memberVO.mem_name }" style='width: 50px;' readonly="readonly">
            ${memberVO.mem_name }
          </td>
          <!-- 연락처 -->
          <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            <input type="hidden" class="mem_tel" id="mem_tel" value="${memberVO.mem_tel }" style='width: 100px;' readonly="readonly">
            ${memberVO.mem_tel }
          </td>
          <!-- 이메일 -->
          <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            <input type="hidden" class="mem_mail" id="mem_mail" value="${memberVO.mem_mail }" readonly="readonly" >
            ${memberVO.mem_mail }
          </td>
          <!-- 주문자 주소 -->
          <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
            <input type="hidden" class="mem_zipcode" id="mem_zipcode" value="${memberVO.mem_zipcode }" readonly="readonly" style='width: 50px;'>
            <input type="hidden" class="mem_addr1" id="mem_addr1" value="${memberVO.mem_addr1 }" readonly="readonly">
            <input type="hidden" class="mem_addr2" id="mem_addr2" value="${memberVO.mem_addr2 }" readonly="readonly">
            (${memberVO.mem_zipcode }) ${memberVO.mem_addr1 } ${memberVO.mem_addr2 }
          </td>
        </tr>
      </TBODY>
    </table>
  </DIV>

  <FORM name='pay_create' method='POST' action='./create.do'>
    <input type='hidden' name='ship_no' id='ship_no' value='${param.ship_no }'>
    <input type='hidden' name='pay_amount' id='pay_amount' value='${productVO.pr_price}' readonly="readonly">
    <DIV style="display: none">
      <H3>카드결제</H3>
      <table style='font-size: 13px; width: 100%; border-top: 1px solid #768393'>
        <COLGROUP>
          <COL style='width: 150px;'>
          <COL>
        </COLGROUP>
        <TBODY>
          <!-- 배송방법 선택 -->
<!--           <tr> -->
<!--             <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>배송방법 선택</th> -->
<!--             <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'> -->
<!--               <INPUT type="radio" id="pr_tracsaction" name="pr_tracsaction" value="택배거래" checked="checked"> -->
<!--               <LABEL for='pr_tracsaction'>택배배송(판매자부담)</LABEL> -->
<!--             </td> -->
<!--           </tr> -->
<!--           <tr> -->
<!--             <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>결제 수단</th> -->
<!--             <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'> -->
<!--               <input type="radio" name="payway" id="card" onclick="" value="신용카드" checked="checked"> -->
<!--               <label for="card" class="mr15">신용카드</label> -->
<!--               <input type="radio" name="payway" id="account" onclick="" value="계좌이체"> -->
<!--               <label for="account" class="mr15">계좌이체</label> -->
<!--               <input type="radio" name="payway" id="mobile" onclick="" value="휴대폰"> -->
<!--               <label for="account" class="mr15">휴대폰</label> -->
<!--             </td> -->
<!--           </tr> -->
<!--           <tr> -->
            <!-- 카드사 -->
<!--             <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>카드사</th> -->
<!--             <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'> -->
<!--               <INPUT type="radio" name="card" id="same_addr" checked="checked" onclick="javascript:setAddress();"> -->
<!--               <LABEL for="same_addr">1</LABEL> -->
<!--               <INPUT type="radio" name="card" id="new_addr" onclick="javascript:setAddress();"> -->
<!--               <LABEL for="new_addr">2</LABEL> -->
<!--               나중에  -->
<!--               <INPUT type="radio" name="card" id="recent_addr" onclick="javascript:setAddress();"> -->
<!--               <LABEL for="recent_addr">3</LABEL> -->
<!--               나중에  -->
<!--             </td> -->
<!--           </tr> -->
          <!-- 카드번호 -->
<!--           <tr> -->
<!--             <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>카드번호</th> -->
<!--             <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'> -->
<!--               <INPUT type="text" name="" id="" style='width: 50px; height: 26px;' value="" required="required"> -->
<!--               <INPUT type="text" name="" id="" style='width: 50px; height: 26px;' value="" required="required"> -->
<!--               <INPUT type="text" name="" id="" style='width: 50px; height: 26px;' value="" required="required"> -->
<!--               <INPUT type="text" name="" id="" style='width: 50px; height: 26px;' value="" required="required"> -->
<!--             </td> -->
<!--           </tr> -->
          <!-- 비밀번호 -->
<!--           <tr> -->
<!--             <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>카드비밀번호</th> -->
<!--             <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'> -->
<!--               <INPUT type="password" name="" id="" size="4" style='margin: 1px 0; height: 26px;' value=""> -->
<!--             </td> -->
<!--           </tr> -->
          <!-- 이메일 -->
<!--           <tr> -->
<!--             <th style='background: #f7f7f7; padding: 10px 5px 10px 15px; border-bottom: 1px solid #dcdcdc; font-weight: normal;'>이메일</th> -->
<!--             <td style='padding: 10px; border-bottom: 1px solid #dcdcdc;'> -->
<!--               <INPUT type="text" name="mailid" id="mailid" style='width: 100px; margin: 1px 0; height: 26px;' value=""> -->
<!--               @ -->
<!--               <INPUT type="text" name="mail" id="mail" style='width: 100px; margin: 1px 0; height: 26px;' value=""> -->
<!--               <select id="selectMail"> -->
<!--                 <option value="naver" onclick="javascript:selectMail()">네이버</option> -->
<!--                 <option value="gmail" onclick="javascript:selectMail()">지메일</option> -->
<!--                 <option value="daum" onclick="javascript:selectMail()">다음</option> -->
<!--               </select>  -->
<!--             </td> -->
<!--           </tr> -->
        </TBODY>
      </table>
    </DIV>
  
    <DIV>
      <H3>결제수단 선택</H3>
      <DIV style='padding: 30px; border: 1px solid #2772cd; box-sizing: border-box; margin: 0 auto;'>
        <P style='font-size: 24px; font-weight: 600; color: #2772cd;'>총 결제금액: ${productVO.pr_price}원</P>
        <DIV>
          <input type="radio" name="pay_way" id="card" onclick="javascript:Cardpay()" value="신용카드" checked="checked">
          <label for="card" class="mr15">신용카드</label>
          <input type="radio" name="pay_way" id="account" onclick="javascript:Accountpay()" value="계좌이체">
          <label for="account" class="mr15">계좌이체</label>
          <input type="radio" name="pay_way" id="mobile" onclick="javascript:Mobilepay()" value="휴대폰">
          <label for="account" class="mr15">휴대폰</label>
        </DIV>
        <UL style='list-style: none;'>
          <li>- 구매대금이 실시간으로 다와라 계좌로 이체됩니다.</li>
          <li>- 이체가 완료되면 
            <SPAN style="font-weight: bold;">결제완료</SPAN> 상태로 변하며 판매자<%-- (<SPAN style="color: green; /* font-weight: bold; */">${Product_MemberVO.pr_mem_id }</SPAN>님) --%>에게 배송요청 메시지가 발송됩니다.
          </li>
        </UL>
        <label for="pay_memo">결제 메모</label>
        <input type='text' name='pay_memo' id='pay_memo' style='width: 400px; margin: 1px 0; height: 26px;' value="">
      </DIV>
    </DIV>
    
    <DIV style='text-align: center; margin: 0 auto; padding: 40px 20px 40px 20px;'>
      <BUTTON type="submit" class="btn btn-primary"
        style='font-weight: 300; background: #2772cd; color: #FFFFFF; padding: 12px 40px; cursor: pointer;'>지금 결제</BUTTON>
      <BUTTON type="button" class="btn btn-link" onclick="location.href='../shipping/searchList_by_mem_no_paging.do?mem_no=${param.mem_no}'">뒤로(거래목록으로)</BUTTON>
    </DIV>
  </FORM>
<%--     </c:forEach>  --%>

</DIV>
<!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV>
<!-- container END -->
</body>
</html>




