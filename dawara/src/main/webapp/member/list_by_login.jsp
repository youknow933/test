<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<script type="text/javascript">
  $(function(){

  });
</script>
</head> 

<body>

<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

<form name='frm' id='frm' method="get" action="./list_by_login.do">
  <ASIDE style='float: left;'>
      <!-- <A href='./list_by_member.do'>회원 목록</A>  -->
       
    <c:if test="${param.word.length() >= 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
 
  </ASIDE>
  
  <ASIDE style='float: right;'>
  <!-- 
    <A href="../index.jsp">홈으로</A>
    <span class='menu_divide' >│</span> 
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./login_ck_form.do'>로그인</A>
    <span class='menu_divide' >│</span><br>  -->
    
    <select name='mem_search' id='mem_search'>
    <option value='mem_search_all' selected="selected">전체</option>
        <option value='mem_search_memno'>회원번호</option>
        <option value='mem_search_login_ip'>아이피</option>
        <option value='mem_search_login_bro'>접속브라우저</option>
    </select>
    <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' style='width: 35%;'>
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' style='width: 35%;'>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
  </ASIDE>
  </form>

  <div class='menu_line'></div>
  
  <table class="table table-striped" style='width: 100%;'>
  <caption>관리자만 접근가능합니다.</caption>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 20%;'/>
    <col style='width: 15%;'/>
    <col style='width: 40%;'/>
    <col style='width: 5%;'/>
  </colgroup>
  <TR>
    <TH class='th'>로그인 번호</TH>
    <TH class='th'>회원 번호</TH>
    <TH class='th'>로그인 아이피</TH>
    <TH class='th'>로그인 날짜</TH>
    <TH class='th'>로그인 브라우저 정보</TH>
    <TH class='th'>기타</TH>
  </TR>

  <c:forEach var="memberVO" items="${list }">
    <c:set var="login_no" value ="${memberVO.login_no }" /> 
    
  <TR>
    <TD class='td'>${login_no}</TD>
    <TD class='td'>${memberVO.mem_no}</A></TD>
    <TD class='td'>${memberVO.login_ip}</A></TD>
    <TD class='td'>${memberVO.login_date}</TD>
    <TD class='td'>
      <c:choose>
        <c:when test="${memberVO.login_agent.length() > 50 }">
          ${memberVO.login_agent.substring(0, 50) }...
        </c:when>
        <c:otherwise>
          ${memberVO.login_agent}
        </c:otherwise>
      </c:choose>
    </TD>
    <TD class='td'>
      <A href="./read_by_login.do?login_no=${login_no}"><IMG src='./images/update.png' title='읽기'></A>
      <A href="./delete_by_login.do?login_no=${login_no}"><IMG src='./images/delete.png' title='삭제'></A>
    </TD>
  </TR>
  </c:forEach>
  
</TABLE>

  <DIV class='bottom_menu'>${login_paging }</DIV>
  <br>

<DIV class='bottom_menu'>
  <button type='button' onclick="location.reload();">새로 고침</button>
</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>