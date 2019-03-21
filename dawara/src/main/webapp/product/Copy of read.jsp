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

<script type="text/javascript">
  function panel_img(file){
    var panel = '';
    panel += "<DIV id='panel' class='popup_img' style='width: 80%;'>";
    panel += "  <A href=\"javascript: $('#main_panel').hide();\"><IMG src='./storage/"+file+"' style='width: 100%;'></A>";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);
    $('#main_panel').show();
    
  }
</script>
</head>

<body>
  <DIV class='container' style='width: 90%;'>
    <%-- <jsp:include page="/menu/top.jsp" flush='false' /> --%>
    <DIV class='content'>

      <DIV id='main_panel'></DIV>

      <ASIDE style='float: left;'>
        <%-- <A href='../category/list.do?categrpno=${categoryVO.categrpno }'>카테고리</A> --%>
        <span style='font-size: 1.2em;'>></span>
        <%-- <A href='./list_by_category.do?gory_no=${categoryVO.gory_no }&pr_word=${param.pr_word}&nowPage=${param.nowPage}'>${categoryVO.title }</A> --%>
      </ASIDE>

      <ASIDE style='float: right;'>
        <c:if test="${productVO.pr_files.length() > 0 }">
          <A href='./download.do?pr_no=${productVO.pr_no}'>다운로드</A>
          <span class='menu_divide'>│</span>
        </c:if>
        <span class='menu_divide'>│</span> <A href='./list_by_category.do?gory_no=1&pr_word=${param.pr_word}&nowPage=${param.nowPage}'>목록</A> <A
          href="javascript:location.reload();">새로고침</A> <span class='menu_divide'>│</span>

        <c:if test="${sessionScope.id ne null }">
          <A href='./create.do?gory_no=1'>등록</A>
          <span class='menu_divide'>│</span>
          <A href='./update.do?pr_no=${productVO.pr_no }&pr_word=${param.pr_word}&nowPage=${param.nowPage}'>수정</A>
          <span class='menu_divide'>│</span>
          <A href='./delete.do?pr_no=${productVO.pr_no }&gory_no=1&pr_word=${param.pr_word}&nowPage=${param.nowPage}'>삭제</A>
        </c:if>
      </ASIDE>

      <div class='menu_line'></div>


      <FORM name='frm' method="get" action='./update.do'>
        <input type="hidden" name="pr_no" value="${productVO.pr_no}">
        <fieldset class="fieldset">
          <ul>
            <li class="li_none"><span>${productVO.pr_title}</span> <span>${productVO.pr_rdate.substring(0, 16)}</span> <br> [상품정보]
              <TABLE class=' table_basic'>
                <TR>
                  <TH>상품구분 :</TH>
                  <TD>${productVO.pr_state }</TD>
                  &nbsp;
                  <TH>거래지역 :</TH>
                  <TD>${productVO.pr_local }</TD>
                  <TH>거래방식 :</TH>
                  <TD>${productVO.pr_transaction }</TD>
                </TR>
                <TR>
                  <TH>구입시기 :</TH>
                  <TD>${productVO.pr_buyyear }</TD>
                  &nbsp;
                  <TH>구입가격 :</TH>
                  <TD>${productVO.pr_buyprice }</TD>
                  <TH>판매가격 :</TH>
                  <TD>${productVO.pr_price }</TD>
                </TR>
              </TABLE> <br> [판매자 정보]
              <TABLE class=' table_basic'>
                <TR>
                  <TH>아이디 :</TH>
                  <TD>youknow</TD>
                  <TH>전화번호 :</TH>
                  <TD>000-0000-0000</TD>
                  <TH>이메일</TH>
                  <TD>aaa@google.com</TD>
                </TR>
              </TABLE> <c:if test="${file_list.size() > 0 }">
                <DIV>
                  <c:forEach var="fileVO" items="${file_list }">
                    <A href="javascript: panel_img('${fileVO.pr_file }')"><IMG src='./storage/${fileVO.pr_file }'
                      style='margin-top: 2px; width: 50%'></A>
                  </c:forEach>
                </DIV>
              </c:if></li>
            <li class="li_none">
              <DIV>${productVO.pr_contents }</DIV>
            </li>

          </ul>
        </fieldset>
      </FORM>

      <button type='button' onclick="location.href='../deal/list.do">구매하기</button>

      <iframe name='ifrm' id='ifrm' src='../reply/list.do?pr_no=${productVO.pr_no}' style='width: 100%; height: 720px; border: none;'></iframe>


    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->
</body>

</html>

