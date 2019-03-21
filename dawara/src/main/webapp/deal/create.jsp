<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>거래 등록</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function() {
    
  });
</script>

</head>

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'>
  <H2 style='line-height: 48px; border-bottom: 2px solid #383838;'>거래 등록</H2>

  <FORM name='create_frm' method='POST' action='./create.do'>
    <input type='hidden' name='pr_no' id='pr_no' value='${param.pr_no }'>
    <DIV>
      <H3>상품 정보</H3>
      <DIV style='padding: 30px; border: 1px solid #2772cd; box-sizing: border-box; margin: 0 auto;'>
        <P style='font-size: 24px;'>
          <span class="icon_bul_h"></span>${productVO.pr_state} 상품: ${productVO.pr_title} ---> 
          <a href="../product/read.do?pr_no=${param.pr_no }&gory_no=${param.gory_no }&pr_title=${productVO.pr_title }&nowPage=${param.nowPage }" style='font-size: 20px;'>
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
            <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>구매자명</th>
            <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>연락처</th>
            <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>이메일</th>
            <th style='background: #768393; color: #FFFFFF; padding: 10px 10px 10px 25px; border-left: 1px solid #dcdcdc; border-bottom: 1px solid #dcdcdc;'>주소</th>
          </tr>
          <tr>
            <!-- 구매자명 -->
            <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
              <input type="hidden" class="mem_name" id="mem_name" value="${buyerVO.mem_name }" style='width: 50px;' readonly="readonly">
              ${buyerVO.mem_name }
            </td>
            <!-- 연락처 -->
            <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
              <input type="hidden" class="mem_tel" id="mem_tel" value="${buyerVO.mem_tel }" style='width: 100px;' readonly="readonly">
              ${buyerVO.mem_tel }
            </td>
            <!-- 이메일 -->
            <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
              <input type="hidden" class="mem_mail" id="mem_mail" value="${buyerVO.mem_mail }" readonly="readonly" >
              ${buyerVO.mem_mail }
            </td>
            <!-- 구매자 주소 -->
            <td style='padding: 10px 10px 10px 20px; border-top: 1px solid #768393; border-bottom: 1px solid #dcdcdc;'>
              <input type="hidden" class="mem_zipcode" id="mem_zipcode" value="${buyerVO.mem_zipcode }" readonly="readonly" style='width: 50px;'>
              <input type="hidden" class="mem_addr1" id="mem_addr1" value="${buyerVO.mem_addr1 }" readonly="readonly">
              <input type="hidden" class="mem_addr2" id="mem_addr2" value="${buyerVO.mem_addr2 }" readonly="readonly">
              (${buyerVO.mem_zipcode }) ${buyerVO.mem_addr1 } ${buyerVO.mem_addr2 }
            </td>
          </tr>
        </TBODY>
      </table>
    </DIV>
    
    <fieldset class='fieldset_basic'>
      <ul>
        <li class='li_none'>
<!--       <label> 새 거래를 등록합니다.</label> -->
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
      <INPUT type="radio" name="d_way" id="d_way" value="직거래" checked="checked">직거래
<!--       <INPUT type="radio" name="d_way" id="d_way" value="택배거래" checked="checked">택배거래 -->
    </li>
    <li class='li_center'>
      <button type="submit">등록</button>
      <button type="button" onclick="location.href='./list.do'">목록</button>
    </li>         
      </ul>
    </fieldset>

  </FORM>
</DIV>
<!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV>
<!-- container END -->
</body>
</html>




