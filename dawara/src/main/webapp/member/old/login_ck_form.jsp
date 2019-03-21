<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>로그인</title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../js/jquery.cookie.js"></script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
<!-- 
<ASIDE style='float: right;'>
    <A href="../index.jsp">홈으로</A>
    <span class='menu_divide' >│</span> 
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
</ASIDE>
 -->

<DIV class='title_line' style='width: 20%;'>로그인</DIV>

<DIV style='width: 80%; margin: 0px auto;'>
  <FORM name='frm' method='POST' action='./login.do' class="form-horizontal">
  
    <div class="form-group">
      <label for="id" class="col-md-5 control-label">아이디</label>    
      <div class="col-md-5">
        <input type='text' class="form-control input-md" name='mem_id' id='mem_id' value='user' required="required" style='width: 60%;' placeholder="아이디" autofocus="autofocus">
        <!-- <input type='text' class="form-control input-md" name='mem_id' id='mem_id' value='${ck_id }' required="required" style='width: 60%;' placeholder="아이디" autofocus="autofocus"> -->
        <Label>   
          <input type='checkbox' name='id_save' value='Y' 
                    ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
        </Label>
      </div>
    </div>   

    <div class="form-group">
      <label for="passwd" class="col-md-5 control-label">패스워드</label>    
      <div class="col-md-5">
        <!-- <input type='password' class="form-control input-md" name='mem_pass' id='mem_pass' value='${ck_passwd }' required="required" style='width: 60%;' placeholder="패스워드"> -->
        <input type='password' class="form-control input-md" name='mem_pass' id='mem_pass' value='1234' required="required" style='width: 60%;' placeholder="패스워드">
        <Label>
          <input type='checkbox' name='passwd_save' value='Y' 
                    ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
        </Label>
      </div>
    </div>   

    <div class="form-group">
      <div class="col-md-offset-5 col-md-5">
        <button type="submit" class="btn btn-primary btn-md">로그인</button>
        <button type="button" onclick="history.back()" class="btn btn-primary btn-md">취소</button>
      </div>
    </div>   
    
  </FORM>
</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
  