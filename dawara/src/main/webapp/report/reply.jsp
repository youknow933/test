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
    <A href='./report/list_by_report.do?report_search=report_no&mem_no=1'>사기 신고 목록</A>
    >   
    <A href='./read.do?report_no=${reportVO.report_no }'>${reportVO.report_title }</A>
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do?report_no=${reportVO.report_no }'>등록</A>
    <span class='menu_divide' >│</span> 
    <A href='javascript: history.back()'>답변 등록 취소</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
  <DIV style='width: 100%;'>
    <FORM name='frm' method='POST' action='./reply.do'
               enctype="multipart/form-data" class="form-horizontal">
      <input type='hidden' name='report_no' id='report_no' value='${reportVO.report_no }'>
      <input type="hidden" name="mem_no" id='mem_no' value="${reportVO.mem_no}">
      <input type="hidden" name="report_write" id='report_write' value="관리자1">
      <input type="hidden" name="nowPage" id='nowPage' value="${param.nowPage}">
       
      <div class="form-group">   
        <label for="report_title" class="col-md-1 control-label">글 제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='report_title' id='report_title' value='답변 제목입니다!' required="required" style='width: 80%;'>
        </div>
      </div>   
      <div class="form-group">   
        <label for="report_contents" class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-lg" name='report_contents' id='report_contents'  rows='10'>답변 내용입니다.</textarea>
        </div>
      </div>
      
  <div class="form-group">   
  <label for="report_web" class="col-md-1 control-label">Web</label>
  <input type='text' class="form-control input-md" name='report_web' id='report_web' value='${reportVO.report_web}' required="required" style='width: 80%;'>
  </div>
  
  <div>
    <label for="report_visible" class="col-md-1 control-label">보이기 여부</label>
    <select name="report_visible" id='report_visible'>
      <option value="Y" >Y</option>
      <option value="N" selected>N</option>
    </select>
  </div>        
      <div class="form-group">   
        <label for="file1MF" class="col-md-1 control-label">업로드 파일</label>
        <div class="col-md-11">
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40' multiple="multiple">
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   
 
      <div class="form-group">   
        <label for="report_passwd" class="col-md-1 control-label">비밀번호</label>
        <div class="col-md-11">
          <input type='password' class="form-control input-lg" name='report_passwd' id='report_passwd' value='123' style='width: 80%;'>
        </div>
      </div>  
      
      <DIV style='text-align: right;'>
        <button type="submit">답변 등록</button>
        <button type="button" onclick="location.href='./list_by_report.do?report_search=report_no&mem_no=1'">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 