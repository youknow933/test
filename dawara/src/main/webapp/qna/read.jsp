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


<style type="text/css">
a:link { color: black; text-decoration: underline;}
a:visited { color: black; text-decoration: none;}
a:hover { color: blue; text-decoration: underline;}
</style>

<link href="<%=root%>/menu/css/style.css" rel='Stylesheet' type='text/css'>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
function pop(file){ 
  window.open("./storage/"+file, 
              "pop", 
              "width=400,height=500,left=500,top=100,history=no,resizable=no,status=no,scrollbars=yes,menubar=no")
  }
  //scrollbars = yes  :: 스크롤바 사용 (미사용 no) 
  //resizeable = yes :: 좌우스크롤바 사용 (미사용 no) 
  //menubar = yes    :: 메뉴바 사용 (미사용 no) 
  //toolbar = yes       :: 툴바사용 (미사용 no) 
  //width = 100          :: 팝업창의 가로사이즈 
  //height = 100         :: 팝업창의 세로사이즈 
  //left = 10               :: 좌측에서 10픽셀을 띄운다. 
  //top = 10               :: 상단에서 10픽셀을 띄운다. 
  </script>


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
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>   
    <!-- <A href='../qna/list_all.do'>QnA 목록</A> -->
     <div style="height: auto; width: 100%; border-bottom:2px solid black; margin-bottom: 5px">
    <A href='../qna/list_by_qna.do?qna_search=qna_no&mem_no=1'>
    <h3 class='notice_title'>
    QnA >  
    </h3>
    </A> 
    </div>
    

  <DIV id='main_panel'></DIV>
 
  <!-- 제목 클릭 시 해당 내용을 가져오기 위한 부분 -->
  <div class='menu_line'></div>
  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="qna_no" value="${qnaVO.qna_no}">
       <table border="1">
       <tr>
      <div class="div_type01" style='font-size:18px'>        
           ${qnaVO.qna_title}
               <div style='float:right'>
       <label for="qna_visible">보이기 여부</label>
  <input type="text" name="qna_visible" value="${qnaVO.qna_visible }" disabled size="1px">
       </div>
      </div>
  <%-- <input type="text" name="qna_visible" value="${qnaVO.qna_visible }" readonly size="1px"> --%>
  <%--   <select name="qna_visible" id='qna_visible'>
    <option value="${qnaVO.qna_visible }" selected disabled>${qnaVO.qna_visible }</option>
  </select> --%>
     </tr> 
   <tr>
    
   <th style="width: 100px; text-align: center; font-size:15px; background: #fdeef2;">내용</label>
   
<th width="1800" height="500px">
      <div class="div_read02" style="height: 500px;">
      <div id='contents_panel'></div>
        <fieldset class="fieldset">
          ${qnaVO.qna_contents}
        </fieldset>
       </div>
  </th>
  </tr>
  <tr>
  <th style="width: 100px; text-align: center; font-size:15px; background: #fdeef2;">
<label for="qna_web">Web</label>
</th>
<th>
 <div class="div_read02">
 ${qnaVO.qna_web }   
  </div>
  </th>
  </tr>
</table> 
      

    <!-- 첨부 파일 출력 -->
      <fieldset class="fieldset">
    <c:if test="${file_list.size() > 0 }">
      <DIV>
      <table border="1">
        <tr>
        <th style="width: 70px; text-align: center; font-size:15px; background: #fdeef2;">
          <label for="file_list">첨부파일</label>
        </th>
        <th>
        <c:forEach var ="Qna_fileVO"  items="${file_list }">
           <A href="javascript: pop('${Qna_fileVO.qna_files }')"><IMG src='./storage/${Qna_fileVO.qna_thumbs }' style='margin-top: 2px;'></A>
          <A href="${Qna_fileVO.qna_files }"></A>
         </c:forEach>
        </th>
        </tr>
       </table>
      </DIV>
    </c:if>
  </fieldset>
    
 
    <aside style='float: right;'>
     <%-- <A href='./reply.do?mem_no=${qnaVO.mem_no }&qna_no=${qnaVO.qna_no }&word=${param.word}&nowPage=${param.nowPage}'>답변</A> --%>
          <BUTTON type="button" onclick="location.href='./reply.do?mem_no=${qnaVO.mem_no }&qna_no=${qnaVO.qna_no }&word=${param.word}&nowPage=${param.nowPage}'">답변</BUTTON>
     <BUTTON type="button" onclick="location.href='./update.do?qna_no=${qnaVO.qna_no}'">수정</BUTTON>
     <BUTTON type="button" onclick="location.href='./delete.do?qna_no=${qnaVO.qna_no}'">삭제</BUTTON>
<!--      <BUTTON type="button" onclick="location.href='./list_by_qna.do?qna_search=qna_no&word=&mem_no=1'">목록</BUTTON> -->
     <BUTTON type="button" onclick="location.href='./list_by_qna.do?qna_search=qna_no&mem_no=1'">목록</BUTTON>
    </aside>
  </FORM>
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>

