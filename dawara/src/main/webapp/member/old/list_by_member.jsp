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

<form name='frm' id='frm' method="get" action="./list_by_member.do">
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
        <option value='mem_search_id'>아이디</option>
        <option value='mem_search_name'>이름</option>
        <option value='mem_search_tel'>전화번호</option>
        <option value='mem_search_mail'>메일</option>
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
    <col style='width: 5%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 15%;'/>
    <col style='width: 10%;'/>
    <col style='width: 5%;'/>
    <col style='width: 23%;'/>
    <col style='width: 5%;'/>
    <col style='width: 10%;'/>
    <col style='width: 7%;'/>
  </colgroup>
  <TR>
    <TH class='th'>번호</TH>
    <TH class='th'>ID</TH>
    <TH class='th'>성명</TH>
    <TH class='th'>전화번호</TH>
    <TH class='th'>이메일</TH>
    <TH class='th'>성별</TH>
    <TH class='th'>주소</TH>
    <TH class='th'>권한</TH>
    <TH class='th'>등록일</TH>
    <TH class='th'>기타</TH>
  </TR>

  <c:forEach var="memberVO" items="${list }">
    <c:set var="mem_no" value ="${memberVO.mem_no }" /> 
    <TR>
      <TD class='td'>${mem_no}</TD>
      <TD class='td'><A href="./read.do?mem_no=${mem_no}">${memberVO.mem_id}</A></TD>
      <TD class='td'><A href="./read.do?mem_no=${mem_no}">${memberVO.mem_name}</A></TD>
      <TD class='td'>${memberVO.mem_tel}</TD>
      <TD class='td'>${memberVO.mem_mail }</TD>
      <TD class='td'>${memberVO.mem_sex }</TD>
      <TD class='td'>
        <c:choose>
          <c:when test="${memberVO.mem_addr1.length() > 15 }">
            ${memberVO.mem_addr1.substring(0, 15) }...
          </c:when>
          <c:otherwise>
            ${memberVO.mem_addr1}
          </c:otherwise>
        </c:choose>
      </TD>
      <TD class='td'>${memberVO.auth_no }</TD>
      <TD class='td'>${memberVO.mem_date.substring(0, 10)}</TD> <!-- 년월일 -->
      <TD class='td'>
        <A href="./passwd_update.do?mem_no=${mem_no}?"><IMG src='./images/passwd.png' title='패스워드 변경'></A>
        <A href="./read.do?mem_no=${mem_no}"><IMG src='./images/update.png' title='수정'></A>
        <A href="./delete.do?mem_no=${mem_no}"><IMG src='./images/delete.png' title='삭제'></A>
      </TD>
    </TR>
  </c:forEach>
  
</TABLE>

  <DIV class='bottom_menu'>${paging }</DIV>
  <br>

<DIV class='bottom_menu'>
  <button type='button' onclick="location.href='./create.do'">등록</button>
  <button type='button' onclick="location.reload();">새로 고침</button>
</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>


