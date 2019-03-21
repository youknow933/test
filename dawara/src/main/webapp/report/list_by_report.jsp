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
<DIV class='content'>      

         
<!-- <form name='frm' id='frm' method="get" action="./list_by_report.do"> -->
  <ASIDE style='float: left;'>
    <!-- <A href='../report/list_all.do'>공지사항 목록</A> -->
    <A href='../report/list_by_report.do?report_search=report_no&mem_no=${param.mem_no }'>사기 신고 목록</A> 
    >  
<%--     <A href='./list_by_report.do?mem_no=${reportVO.mem_no }'>${reportVO.report_title }</A> --%>
<!--     <A href='./list_by_report.do'>검색 결과 </A> -->
    
    검색 결과 >
   
   <!-- mem_no 임의의 값  -->
    <input type='hidden' name='mem_no' id='mem_no' value=${param.mem_no }>

    <c:if test="${param.word.length() > 0}"> 
      >
     검색 조건: ${param.report_search } / 찾은 단어: [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
  </ASIDE>      
         
  <form name='frm' id='frm' method="get" action="./list_by_report.do">
  <ASIDE style='float: right; margin-bottom:5px;'>
   <A href='./list_by_report.do?report_search=report_no&mem_no=${param.mem_no }'">전체 보기</A>
    <span class='menu_divide' >│</span> 
   <A href="javascript:location.reload();">새로고침</A>

    <span class='menu_divide' >│</span> 
   <%--  <A href='./create.do?report_no=${reportVO.report_no }'>등록</A> --%>
    
  <select name="report_search">
    <option value="report_no">글 번호</option>
    <option value="report_title">제목</option>
    <option value="report_write">작성자</option>
  </select> 

    <%-- <input type='hidden' name='report_no' id='report_no' value='${reportVO.report_no }'> --%>

<!-- 로그인한 멤버의 권한 값을 전달해서 해당 인원이 볼 수 있는 데이터만 출력  -->
<%-- <input type='hidden' name='mem_no' id='mem_no' value='${reportVO.mem_no }'> --%>
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
                 <%-- onclick="location.href='./list_all.do?mem_no=${reportVO.mem_no }'">전체 보기</button> --%>
  </ASIDE>
  </form>
         
  <div style='width: 100%;'>
    <table class="type10" style='width: 100%;'>
      <colgroup>
        <col style="width: 15%;"></col>
        <col style="width: 40%;"></col>
        <col style="width: 15%;"></col>
        <col style="width: 15%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 5%;"></col>
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th style='text-align: center;'>글 번호</th>
          <th style='text-align: center;'>제목</th>
          <th style='text-align: center;'>작성자</th>
          <th style='text-align: center;'>등록일</th>
          <th style='text-align: center;'>조회수</th>
          <th style='text-align: center;'>기타</th>
        </tr>
      </thead>
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="reportVO" items="${list_by_report }">  <!-- items값: Controller의 mav.addObject ID  -->
          <tr> 
            <td style='vertical-align: middle; text-align: center;'>${reportVO.report_no}</td>
            <td style='vertical-align: middle;'>
              <c:choose>
                <c:when test="${reportVO.report_ansnum == 0 }"> <!-- 부모글인 경우 -->
                  <img src='./images/ting1.gif'>
                </c:when>
                <c:when test="${reportVO.report_ansnum > 0}">    <!-- 답변글인 경우 -->
                  <img src='./images/white.jpg' style='width: ${reportVO.report_indent * 20}px; opacity: 0.0;'>
                  <img src='./images/reply3.jpg'>
                </c:when>
              </c:choose>
          <c:choose>
            <c:when test='${reportVO.report_visible.equals("Y") }'> <!-- 공개글인 경우 -->
             <a href="./read.do?report_no=${reportVO.report_no}">${reportVO.report_title}</a> 
             </c:when>
             <c:when test='${reportVO.report_visible.equals("N") }'> <!-- 비공개글인 경우 -->                    
             <a href="./pwdCheck.jsp?report_no=${reportVO.report_no}">${reportVO.report_title}</a>     <!-- 제목을 누르면 게시물 번호를 갖고간 후 비밀번호 입력창을 띄운다.  -->
             </c:when>
           </c:choose>   
            </td>  
            <td style='vertical-align: middle; text-align: center;'>${reportVO.report_write}</td>
            <td style='vertical-align: middle; text-align: center;'>${reportVO.report_rdate.substring(0, 16)}</td>
            <td style='vertical-align: middle; text-align: center;'>${reportVO.report_cnt}</td>
            <td style='vertical-align: middle; text-align: center;'>
                  ${reportVO.report_visible}
            <%-- <a href="./show_hide.jsp?report_no=${reportVO.report_no}&mem_no=${reportVO.mem_no}&report_visible=${reportVO.report_visible}">
                  ${reportVO.report_visible}
            </a> --%>
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
  </table>
  
    <BUTTON type="button" onclick="location.href='./create.jsp'" style="float:right;">등록</BUTTON>
    <DIV class='bottom_menu'>${paging }</DIV> <!--  페이지 목록 출력 -->
  </div>
</DIV>
</DIV>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>
