<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<%  
String root = request.getContextPath(); 
// out.println("root: " + root);
%> 

<!-- <link href="../css/style.css" rel="Stylesheet" type="text/css">-->
<link href="<%=root%>/menu/css/style.css" rel='Stylesheet' type='text/css'>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function(){

});
</script>

<script type="text/javascript">
</script>
</head>

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'>      

         
<!-- <form name='frm' id='frm' method="get" action="./list_by_notice.do"> -->
  <ASIDE style='float: left;'>
    <!-- <A href='../notice/list_all.do'>공지사항 목록</A> -->
    <A href='../notice/list_by_notice.do?notice_search=notice_no&word=&mem_no=1'>공지사항 목록</A> 
    >  
<%--     <A href='./list_by_notice.do?mem_no=${noticeVO.mem_no }'>${noticeVO.no_title }</A> --%>
<!--     <A href='./list_by_notice.do'>검색 결과 </A> -->
    
    검색 결과 >
   
   <!-- mem_no 임의의 값  -->
    <input type='hidden' name='mem_no' id='mem_no' value=1>

    <c:if test="${param.word.length() > 0}"> 
      >
     검색 조건: ${param.notice_search } / 찾은 단어: [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
  </ASIDE>      
         
  <form name='frm' id='frm' method="get" action="./list_by_notice.do">
  <ASIDE style='float: right; margin-bottom:5px;'>
   <A href='./list_by_notice.do?notice_search=notice_no&word=&mem_no=1'">전체 보기</A>
    <span class='menu_divide' >│</span> 
   <A href="javascript:location.reload();">새로고침</A>

    <span class='menu_divide' >│</span> 
   <%--  <A href='./create.do?no_no=${noticeVO.no_no }'>등록</A> --%>
    
  <select name="notice_search">
    <option value="notice_no">글 번호</option>
    <option value="notice_title">제목</option>
    <option value="notice_write">작성자</option>
  </select> 

    <%-- <input type='hidden' name='no_no' id='no_no' value='${noticeVO.no_no }'> --%>

<!-- 로그인한 멤버의 권한 값을 전달해서 해당 인원이 볼 수 있는 데이터만 출력  -->
<%-- <input type='hidden' name='mem_no' id='mem_no' value='${noticeVO.mem_no }'> --%>
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' style='width: 30%;'>
        <input type='hidden' name='mem_no' id='mem_no' value=1>
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' style='width: 30%;'>
        <input type='hidden' name='mem_no' id='mem_no' value=1>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
   
    <!-- <button type='button' onclick="location.href='./list_all.do?mem_no=1'">전체 보기</button> -->
                 <%-- onclick="location.href='./list_all.do?mem_no=${noticeVO.mem_no }'">전체 보기</button> --%>
  </ASIDE>
  </form>
         
         
         
  <div style='width: 100%;'>
    <table class="type10" style='width: 100%;'>
      <colgroup>
        <col style="width: 10%;"></col>
        <col style="width: 60%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 15%;"></col>
        <col style="width: 5%;"></col>
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th style='text-align: center;'>글 번호</th>
          <th style='text-align: center;'>제목</th>
          <th style='text-align: center;'>작성자</th>
          <th style='text-align: center;'>등록일</th>
          <th style='text-align: center;'>기타</th>
        </tr>
      </thead>
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="noticeVO" items="${list_by_notice }">  <!-- items값: Controller의 mav.addObject ID  -->
          <tr> 
            <td style='vertical-align: middle; text-align: center;'>${noticeVO.no_no}</td>
            <td style='vertical-align: middle;'>
             <a href="./read.do?no_no=${noticeVO.no_no}">${noticeVO.no_title}</a>
            </td>  
            <td style='vertical-align: middle; text-align: center;'>${noticeVO.no_write}</td>
            <td style='vertical-align: middle; text-align: center;'>${noticeVO.no_rdate.substring(0, 16)}</td>
            <td style='vertical-align: middle; text-align: center;'>
            <a href="./show_hide.jsp?no_no=${noticeVO.no_no}&mem_no=${noticeVO.mem_no}&no_visible=${noticeVO.no_visible}">
                  ${noticeVO.no_visible}
            </a>
            </td>
                
    <%--          <td style='vertical-align: middle;'>
              <a href="./update.do?contentsno=${contentsVO.contentsno}&categoryno=${contentsVO.categoryno}&nowPage=${nowPage}"><img src="./images/update.png" title="수정" border='0'/></a>
              <a href="./delete.do?contentsno=${contentsVO.contentsno}&categoryno=${contentsVO.categoryno}&nowPage=${nowPage}"><img src="./images/delete.png" title="삭제"  border='0'/></a>
              ${contentsVO.indent} / ${contentsVO.ansnum}
            </td> 
     --%>
          </tr>
        </c:forEach>
        
      </tbody>
    </table>
    <c:if test="${sessionScope.auth_no == 1}"> 
      <BUTTON type="button" onclick="location.href='./create.jsp'">등록</BUTTON>
    </c:if>
    <DIV class='bottom_menu'>${paging }</DIV> <!--  페이지 목록 출력 -->
  </div>
</DIV>
</DIV>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>
