<%@ page contentType="text/html; charset=UTF-8" %>

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

<!-- <script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/JavaScript">
  window.onload=function(){
    CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  }; 
</script>
-->
</head> 

<body>
<DIV class='container' style='width: 90%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>     

  <ASIDE style='float: left;'>
    <!-- <A href='../notice/list_all.do'>공지사항 목록</A> -->
    <A href='../notice/list_by_notice.do?notice_search=notice_no&word=&mem_no=1'>공지사항 목록</A> 
      <%-- <A href='./list.do?no_no=${noticeVO.no_no }'>${noticeVO.title }</A> --%>
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <!-- <A href='./create.do'>등록</A> -->
  </ASIDE> 

  <div class='menu_line'></div>
  <DIV class='content' style='width: 100%;'>
    <FORM name='frm' method='POST' action='./create.do'
               enctype="multipart/form-data" class="form-horizontal">
               
     <%--  <input type='hidden' name='no_no' id='no_no' value='${param.no_no }'>
      <input type='hidden' name='mno' id='mno' value='${sessionScope.mno }'> --%>
      
      <div class="form-group">   
        <label for="no_title" class="col-md-1 control-label">글 제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='no_title' id='no_title' value='바다건너' required="required" style='width: 80%;'>
        </div>
       
        <label for="no_visible" class="col-md-1 control-label">보이기 여부</label>
        <div>
        <select name="no_visible" id='no_visible'>
          <option value="Y" >Y</option>
          <option value="N">N</option>
        </select>
        </div>
        
      </div>   
      <div class="form-group">   
        <label for="no_content" class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-lg" name='no_contents' id='no_contents'  rows='10'>크리스마스에 갔던곳</textarea>
        </div>
      </div>
      <div class="form-group">   
        <label for="filesMF" class="col-md-1 control-label">업로드 파일</label>
        <div class="col-md-11">
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40' multiple="multiple">
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   
      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list_by_notice.do?notice_search=notice_no&word=&mem_no=1'">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
