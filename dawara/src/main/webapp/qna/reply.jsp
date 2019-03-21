<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>답변 등록</title> 
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
<script type="text/JavaScript">

</script>
 
</head> 
 
<body>
<DIV class='container' style='width: 90%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>     
 
  <ASIDE style='float: left;'>
    <A href='./qna/list_by_qna.do?qna_search=qna_no&mem_no=1'>QnA 목록</A>
    >   
    <A href='./read.do?qna_no=${qnaVO.qna_no }'>${qnaVO.qna_title }</A>
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do?qna_no=${qnaVO.qna_no }'>등록</A>
    <span class='menu_divide' >│</span> 
    <A href='javascript: history.back()'>답변 등록 취소</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
  <DIV>
    <FORM name='frm' method='POST' action='./reply.do'
               enctype="multipart/form-data" class="form-horizontal">
      <input type='hidden' name='qna_no' id='qna_no' value='${qnaVO.qna_no }'>
      <input type="hidden" name="mem_no" id='mem_no' value="${qnaVO.mem_no}">
      <input type="hidden" name="qna_write" id='qna_write' value="관리자1">
      <input type="hidden" name="nowPage" id='nowPage' value="${param.nowPage}">
       
  <div class="col" style='float:inline-block'>
      <ul class='list-inline'>
         <li><label for="qna_title">제목</label></li>
         <li>
          <input type='text' class="form-control input-lg" name='qna_title' id='qna_title' value='답변 제목입니다!' required="required" style='width: 800px;'>
        </li>
           <li> <label for="qna_visible" >보이기 여부</label></li>
    <li>
    <select name="qna_visible" id='qna_visible'>
      <option value="Y" >Y</option>
      <option value="N" selected>N</option>
    </select>
    </li>
</ul>
</div>
      <div>   
        <label for="qna_contents">내용</label>
        <div >
          <textarea class="form-control input-lg" name='qna_contents' id='qna_contents'  rows='20' style="resize: none;">답변 내용입니다.</textarea>
        </div>
      </div>
      
  <div >   
  <label for="qna_web">Web</label>
  <input type='text' class="form-control input-md" name='qna_web' id='qna_web' value='${qnaVO.qna_web}' required="required" style='width: 80%;'>
  </div>
  
        
      <div>   
        <label for="file1MF" >업로드 파일</label>
        <div>
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40' multiple="multiple">
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   
 
      <div>   
        <label for="qna_passwd" >비밀번호</label>
        <div>
          <input type='password' class="form-control input-lg" name='qna_passwd' id='qna_passwd' value='123' style='width: 30%;'>
        </div>
      </div>  
      
      <DIV style='text-align: right;'>
        <button type="submit">답변 등록</button>
        <button type="button" onclick="location.href='./list_by_qna.do?qna_search=qna_no&mem_no=1'">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 