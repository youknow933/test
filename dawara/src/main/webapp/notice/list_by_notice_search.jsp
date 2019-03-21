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
<DIV class='content' style='width: 100%;'>     
  <form name='frm' id='frm' method="get" action="./list_all.do">
  <ASIDE style='float: left;'>
    <A href='../notice/list_all.do'>공지사항 목록</A>
    >  
    <A href='./list_all.do?no_no=${noticeVO.no_no }'>${noticeVO.no_title }</A>

    <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>

  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>

    <span class='menu_divide' >│</span> 
    <A href='./create.do?no_no=${noticeVO.no_no }'>등록</A>
    
    <input type='hidden' name='no_no' id='no_no' value='${noticeVO.no_no }'>
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' style='width: 35%;'>
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' style='width: 35%;'>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
    <button type='button' 
                 onclick="location.href='./list_all.do?mem_no=${noticeVO.mem_no }'">전체 보기</button>
  </ASIDE>
  </form>
    
  <div class='menu_line' style='clear: both;'></div>       

  <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 5%;"></col>
        <col style="width: 50%;"></col>
        <col style="width: 20%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 15%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th>파일</th>
          <th>제목</th>
          <th>등록일</th>
          <th>추천</th>
          <th>기타</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="noticeVO" items="${list }">
          <tr>
            <td style='vertical-align: middle;'>
            <c:choose>
              <c:when test="${noticeVO.no_thumbs != ''}">
                <IMG id='no_thumbs' src='./storage/${noticeVO.no_thumbs}' > <!-- 이미지 파일명 출력 -->
              </c:when>
              <c:otherwise>
                <IMG id='no_thumbs' src='./images/none1.jpg' style='width: 120px; height: 80px;'> <!-- 파일이 존재하지 않는 경우 -->
              </c:otherwise>
            </c:choose>
            </td>          
            <td style='vertical-align: middle;'>
              <a href="./read.do?contentsno=${noticeVO.contentsno}&no_no=${noticeVO.no_no}&word=${param.word}">${noticeVO.no_title}</a> 
            </td> 

            <td style='vertical-align: middle;'>${noticeVO.rdate.substring(0, 16)}</td>
            <td style='vertical-align: middle;'>${noticeVO.good}</td>
            <td style='vertical-align: middle;'>
              <a href="./update.do?contentsno=${noticeVO.contentsno}&no_no=${noticeVO.no_no}"><img src="./images/update.png" no_title="수정" border='0'/></a>
              <a href="./delete.do?contentsno=${noticeVO.contentsno}&no_no=${noticeVO.no_no}"><img src="./images/delete.png" no_title="삭제"  border='0'/></a>
              ${noticeVO.no_no}
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
  </table>
  <br><br>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>