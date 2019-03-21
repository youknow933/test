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

<link href="<%=root%>/menu/css/style.css" rel='Stylesheet' type='text/css'>

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
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>   
    <!-- <A href='../notice/list_all.do'>공지사항 목록</A> -->
    <A href='../notice/list_by_notice.do?notice_search=notice_no&word=&mem_no=1'>공지사항 목록</A> 
    >  

  <DIV id='main_panel'></DIV>
 
  <!-- 제목 클릭 시 해당 내용을 가져오기 위한 부분 -->
  <div class='menu_line'></div>
  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="no_no" value="${noticeVO.no_no}">
    <fieldset class="fieldset">
      <ul>
        <li class="li_none">
         <div class="div_type01">
          <label for="no_title" class="col-md-1 control-label">글 제목</label>        
           ${noticeVO.no_title}
        </div>
       </li>
     </ul>
    </fieldset>
    
   <label for="no_content" class="col-md-1 control-label">내용</label>
   
    <fieldset class="fieldset">
      <ul> 
       <li class="li_none">
        <div class="div_read02">
          ${noticeVO.no_contents}
         </div>
      </li>
      </ul>
      
      
   
      
      

    <!-- 첨부 파일 출력 -->
    <c:if test="${file_list.size() > 0 }">
      <DIV>
        <c:forEach var ="No_fileVO"  items="${file_list }">
           <A href="javascript: panel_img('${No_fileVO.no_files }')"><IMG src='./storage/${No_fileVO.no_thumbs }' style='margin-top: 2px;'></A>
          <A href="${No_fileVO.no_files }"></A>
        </c:forEach>
      </DIV>
    </c:if>
    </fieldset >
    
  <label for="no_visible">보이기 여부</label>
  <div>
  <input type="text" name="no_visible" value="${noticeVO.no_visible }" disabled size="1px">
  <%-- <input type="text" name="no_visible" value="${noticeVO.no_visible }" readonly size="1px"> --%>
  <%--   <select name="no_visible" id='no_visible'>
    <option value="${noticeVO.no_visible }" selected disabled>${noticeVO.no_visible }</option>
  </select> --%>
  </div>
    
    <aside style='float: right;'>
     <BUTTON type="button" onclick="location.href='./update.do?no_no=${noticeVO.no_no}'">수정</BUTTON>
     <BUTTON type="button" onclick="location.href='./delete.do?no_no=${noticeVO.no_no}'">삭제</BUTTON>
     <BUTTON type="button" onclick="location.href='./list_by_notice.do?notice_search=notice_no&word=&mem_no=1'">목록</BUTTON>
    </aside>
  </FORM>
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>

