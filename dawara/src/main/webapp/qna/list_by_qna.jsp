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
$(function() {
});
</script>

<script type="text/javascript">
</script>
</head>

<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>      

         
<!-- <form name='frm' id='frm' method="get" action="./list_by_qna.do"> -->
  <ASIDE style='float: left;'>
    <!-- <A href='../qna/list_all.do'>공지사항 목록</A> -->
    <A href='../qna/list_by_qna.do?qna_search=qna_no&mem_no=${param.mem_no }'>QnA 목록</A> 
    >  
<%--     <A href='./list_by_qna.do?mem_no=${qnaVO.mem_no }'>${qnaVO.qna_title }</A> --%>
<!--     <A href='./list_by_qna.do'>검색 결과 </A> -->
    
    검색 결과 >
   
   <!-- mem_no 임의의 값  -->
    <input type='hidden' name='mem_no' id='mem_no' value=${param.mem_no }>

    <c:if test="${param.word.length() > 0}"> 
      >
     검색 조건: ${param.qna_search } / 찾은 단어: [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
  </ASIDE>      
         
  <form name='frm' id='frm' method="get" action="./list_by_qna.do">
  <ASIDE style='float: right; margin-bottom:5px;'>
   <A href='./list_by_qna.do?qna_search=qna_no&mem_no=${param.mem_no }'">전체 보기</A>
    <span class='menu_divide' >│</span> 
   <A href="javascript:location.reload();">새로고침</A>

    <span class='menu_divide' >│</span> 
   <%--  <A href='./create.do?qna_no=${qnaVO.qna_no }'>등록</A> --%>
    
  <select name="qna_search">
    <option value="qna_no">글 번호</option>
    <option value="qna_title">제목</option>
    <option value="qna_write">작성자</option>
  </select> 

    <%-- <input type='hidden' name='qna_no' id='qna_no' value='${qnaVO.qna_no }'> --%>

<!-- 로그인한 멤버의 권한 값을 전달해서 해당 인원이 볼 수 있는 데이터만 출력  -->
<%-- <input type='hidden' name='mem_no' id='mem_no' value='${qnaVO.mem_no }'> --%>
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' style='width: 30%;'>
        <input type='hidden' name='mem_no' id='mem_no' value=${param.mem_no }>
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' style='width: 30%;'>
        <input type='hidden' name='mem_no' id='mem_no' value=${param.mem_no }>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
   
    <!-- <button type='button' onclick="location.href='./list_all.do?mem_no=1'">전체 보기</button> -->
                 <%-- onclick="location.href='./list_all.do?mem_no=${qnaVO.mem_no }'">전체 보기</button> --%>
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
        </tr>`
      </thead>
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="qnaVO" items="${list_by_qna }">  <!-- items값: Controller의 mav.addObject ID  -->
          <tr> 
            <td style='text-align: center; vertical-align: middle;'>${qnaVO.qna_no}</td>
            <td style='vertical-align: middle;'>
              <c:choose>
                <c:when test="${qnaVO.qna_ansnum == 0 }"> <!-- 부모글인 경우 -->
                  <img src='./images/ting1.gif'>
                </c:when>
                <c:when test="${qnaVO.qna_ansnum > 0}">    <!-- 답변글인 경우 -->
                  <img src='./images/white.jpg' style='width: ${qnaVO.qna_indent * 20}px; opacity: 0.0;'>
                  <img src='./images/reply3.jpg'>
                </c:when>
              </c:choose>
          <c:choose>
            <c:when test='${qnaVO.qna_visible.equals("Y") }'> <!-- 공개글인 경우 -->
             <a href="./read.do?qna_no=${qnaVO.qna_no}">${qnaVO.qna_title}</a>   
             </c:when>
             <c:when test='${qnaVO.qna_visible.equals("N") }'> <!-- 비공개글인 경우 -->                    
             <a href="./pwdCheck.jsp?qna_no=${qnaVO.qna_no}">${qnaVO.qna_title}</a>     <!-- 제목을 누르면 게시물 번호를 갖고간 후 비밀번호 입력창을 띄운다.  -->
             </c:when>
           </c:choose>   
            </td>  
            <td style='vertical-align: middle; text-align: center;'>${qnaVO.qna_write}</td>
            <td style='vertical-align: middle; text-align: center;'>${qnaVO.qna_rdate.substring(0, 16)}</td>
            <td style='vertical-align: middle; text-align: center;'>${qnaVO.qna_cnt}</td>
            <td style='vertical-align: middle; text-align: center;'>
                  ${qnaVO.qna_visible}
            <%-- <a href="./show_hide.jsp?qna_no=${qnaVO.qna_no}&mem_no=${qnaVO.mem_no}&qna_visible=${qnaVO.qna_visible}">
                  ${qnaVO.qna_visible}
            </a> --%>
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
  
    <BUTTON type="button" onclick="location.href='./create.jsp'" style="float:right;">등록</BUTTON>
    <DIV class='bottom_menu'>${paging }</DIV> <!--  페이지 목록 출력 -->
  </div>
</DIV>
</DIV>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>
