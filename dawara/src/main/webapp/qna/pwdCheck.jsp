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

<!-- <link href="../css/style.css" rel="Stylesheet" type="text/css">-->
<link href="<%=root%>/menu/css/style.css" rel='Stylesheet' type='text/css'>

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../js/jquery.cookie.js"></script>

<script type="text/javascript">
  $(function() {

});
  
  function pwdCheck(qna_no){
    var frm = $('#frm');
/*      var params = 'qna_passwd='+$('#passwd', frm).val() // #: qna_passwd
                     +'qna_no='+${param.qna_no};         // #: qna_no 
     alert('params: ' + params);
*/
     var qna_passwd = $('#passwd', frm).val(); // #: qna_passwd
     var qna_no = ${param.qna_no};         // #: qna_no */
     //var count = document.getElementById('count');
    $.ajax({
      url: "./pwdCheck.do",
      type: "POST",
      cache: false,
      dataType: "JSON", // json or html
     // async: false,
   //   data: "qna_no=" + qna_no + "&qna_passwd=" + qna_passwd,
      data: {qna_no: qna_no, qna_passwd: qna_passwd} ,
      success: function(rdata){
       // var vo = JSON.parse(ajax.responseText);
         var data = JSON.parse(rdata);
       // alert("ajax 성공, qna_passwd="+qna_passwd);
       // alert("ajax 성공, qna_no="+qna_no);
       // alert("ajax 성공, count="+ data.count);
        var msg = "";
         // response.sendRedirect("/qna/read.do?qna_no="+qna_no);     /* 게시물 비밀번호 일치 시 페이지 이동 */

        if (data.count == 0) {
          $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap
          msg = "『Danger!』 비밀번호를 다시 확인해주세요.";
          alert(msg);
        } else {      // qna_no와 qna_passwd를 통해 검색이 되는 경우. (비밀번호가 일치하는 경우)
          $('#modal_content').attr('class', 'alert alert-success'); // Bootstrap
          msg = "『환영합니다!』.";
          alert(msg);
          location.href = "./read.do?qna_no="+qna_no;     /* 게시물 비밀번호 일치 시 페이지 이동 */
        //  $.cookie('checkPwd', 'TRUE'); // Cookie 값 변경
        }

        $('#modal_title').html('비밀번호 확인');
        $('#modal_content').html(msg);
        $('#modal_panel').modal(); // 다이얼로그 출력   
      },
      // 통신 에러, 요청 실패, 200 아닌 경우, dataType이 다른경우
      error: function (request, status, error){  
        alert("ajax 에러, qna_passwd="+qna_passwd);
        alert("ajax 에러, qna_no="+qna_no);
        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

        
        var msg = "에러가 발생했습니다. <br><br>";
        msg += "다시 시도해주세요.<br><br>";
        msg += "request.status: " + request.status + "<br>";
        msg += "request.responseText: " + request.responseText + "<br>";
        msg += "status: " + status + "<br>";
        msg += "error: " + error;

        $('#modal_title').html('비밀번호 확인');
        $('#modal_content').attr('class', 'alert alert-danger');
        $('#modal_content').html(msg);
        $('#modal_panel').modal(); // 다이얼로그 출력   
      }
    });

  }
   
</script>


</head> 


<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <DIV id='main_panel'></DIV>

  <!-- Modal -->
  <div class="modal fade" id="modal_panel" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'> 비밀번호 확인</h4>
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div> <!-- Modal END -->
    
  <FORM name='frm' id='frm' method='POST' action='' 
             onsubmit="javascript:pwdCheck('${param.qna_no }')"   class="form-horizontal">

    <div class="form-group">
      <label for="passwd" class="col-md-2 control-label">패스워드</label>    
      <div class="col-md-10">
        <input type='password' class="form-control input-md" name='passwd' id='passwd' value='' required="required" style='width: 30%;' placeholder="패스워드">
      </div>
    </div>   

    <div class="form-group">
      <div class="col-md-offset-2 col-md-10">
        <button type="submit" class="btn btn-primary btn-md">확인</button>
        <button type="button" onclick="location.href='../index.jsp'" class="btn btn-primary btn-md">취소</button>

      </div>
    </div>   
  </FORM>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
  
  