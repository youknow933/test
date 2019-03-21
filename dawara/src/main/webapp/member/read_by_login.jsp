<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
</head> 


<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <DIV id='main_panel'></DIV>

  <DIV class='title_line'>로그인 정보 조회 및 수정</DIV>

  <FORM name='frm' id='frm' method='POST' action='./update.do' 
              enctype="multipart/form-data" onsubmit="return send();" class="form-horizontal">
    <input type='hidden' name='mem_no' id='mem_no' value='${memberVO.mem_no }'>          

    <div class="form-group">
      <label for="mem_id" class="col-md-2 control-label">로그인 번호</label>    
      <div class="col-md-10">
        ${memberVO.login_no }        
      </div>
    </div>   
    
    <div class="form-group">
      <label for="mem_id" class="col-md-2 control-label">회원 번호</label>    
      <div class="col-md-10">
        ${memberVO.mem_no }        
      </div>
    </div>   
    
    <div class="form-group">
      <label for="mem_id" class="col-md-2 control-label">로그인 아이피</label>    
      <div class="col-md-10">
        ${memberVO.login_ip }        
      </div>
    </div>   
    
    <div class="form-group">
      <label for="mem_id" class="col-md-2 control-label">로그인 날짜</label>    
      <div class="col-md-10">
        ${memberVO.login_date }        
      </div>
    </div>   
                
    <div class="form-group">
      <label for="address1" class="col-md-2 control-label">로그인 브라우저 정보</label>    
      <div class="col-md-10">
         ${memberVO.login_agent }      
      </div>
    </div>   

    <div class="form-group">
      <div class="col-md-offset-2 col-md-10">
        <button type="button" onclick="history.go(-1);" class="btn btn-primary btn-md">취소</button>

      </div>
    </div>   
  </FORM>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 