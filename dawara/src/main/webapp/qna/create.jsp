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
  <ASIDE style='float: left;'>
  <!-- 로그인 가정, 검색어 기본일 때 상황  -->
<!--     <A href='../qna/list_by_qna.do?qna_search=qna_no&word=&mem_no=1'>QnA 목록</A> --> 
    <A href='../qna/list_by_qna.do?'>QnA 목록</A> 
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
               
        <input type='hidden' name='mem_no' id='mem_no' value='${sessionScope.mem_no }'>
               
     <%--  <input type='hidden' name='qna_no' id='qna_no' value='${param.qna_no }'>
      <input type='hidden' name='mno' id='mno' value='${sessionScope.mno }'> --%>
      
      <div class="col" style='float:inline-block'>
        <ul class='list-inline'>
        <li><label for="qna_title">제목</label></li>
        <li>
          <input type='text' class="form-control input-lg" name='qna_title' id='qna_title' placeholder="QnA 제목" required="required" style='width: 800px;'>
         </li>
       
 <li><label for="qna_visible" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;보이기 여부</label></li>
      <li>
        <select name="qna_visible" id='qna_visible'>
          <option value="Y" >Y</option>
          <option value="N">N</option>
        </select>
      </li>
    </ul>
    </div>   
      <div>   
        <label for="qna_content">내용</label>
        <div>
          <textarea class="form-control input-lg" name='qna_contents' id='qna_contents' required="required" rows='20' style="resize: none;" placeholder="QnA 내용"></textarea>
        </div>
      </div>
      <div>   
        <label for="qna_web">Web</label>
        <div>
          <textarea class="form-control input-lg" name='qna_web' id='qna_web'  rows='1'>http://</textarea>
        </div>
      </div>
      <div>   
        <label for="filesMF" >업로드 파일</label>
        <div>
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40' multiple="multiple">
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   
      <div>   
        <label for="qna_passwd">비밀번호</label>
        <div>
          <input type='password' class="form-control input-lg" name='qna_passwd' id='qna_passwd' value='123' required="required" style='width: 20%;'>
        </div>
      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <!-- <button type="button" onclick="location.href='./list_by_qna.do?qna_search=qna_no&word=&mem_no=1'">취소[목록]</button> -->
<!--         <button type="button" onclick="location.href='./list_by_qna.do">취소[목록]</button> --> 
        <button type="button" onclick="location.href='./list_by_qna.do?qna_search=qna_no&mem_no=1'">취소[목록]</button> 
      </DIV>
    </DIV>
    </FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
