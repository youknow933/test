<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function() {
    /*
    var msg = 'ERROR<br><br>';
    msg += '<strong>request.status</strong><br>ERROR<hr>';
    msg += '<strong>error</strong><br>ERROR<hr>';
    
    var panel = '';
    panel += "<DIV id='panel' class='popup1' style='heigth: 350px;'>";
    panel += msg;
    panel += "<br><button type='button' onclick=\"$('#main_panel').hide();\"> 닫기</button>";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);
    $('#main_panel').show();
    */
  });
  
  function update(auth_no) {
    $('#panel_create').hide();
    $('#panel_update').show();
    
    $.ajax({
      url: "./update.do", // 요청을 보낼주소
      type: "get",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: 'auth_no=' +auth_no,  // $('#frm').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var frm_update = $('#frm_update');
        $('#auth_no', frm_update).val(rdata.auth_no);
        $('#auth_info', frm_update).val(rdata.auth_info);
        $('#auth_seqno', frm_update).val(rdata.auth_seqno);
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var panel = '';
        panel += "<DIV id='panel' class='popup1' style='heigth: 350px;'>";
        panel += '  ERROR<br><br>';
        panel += '  <strong>request.status</strong><br>'+request.status + '<hr>';
        panel += '  <strong>error</strong><br>'+error + '<hr>';
        panel += "  <br><button type='button' onclick=\"$('#main_panel').hide();\">닫기</button>";
        panel += "</DIV>";
        
        $('#main_panel').html(panel);
        $('#main_panel').show();

      }
    });
  } 
  
  function create_update_cancel() {
    $('#panel_update').hide();
    $('#panel_create').show();

  }

  /*
  function deleteOne(categrpno) {
    var frm_delete = $('#frm_delete');
    $('#categrpno', frm_delete).val(categrpno);
    
    var panel = '';
    panel += "<DIV id='panel' class='popup1' style='height: 150px; line-height: 30px;'>";
    panel += "  카테고리 그룹을 삭제합니다.<br>";
    panel += "  삭제하면 복구 할 수 없습니다.<br><br>";
    panel += "  <button type='button' onclick='frm_delete.submit();' class='popup_button'> 삭제 </button>";
    panel += "  <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'> 닫기 </button>";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);
    $('#main_panel').show();
  }
  */

  function deleteOne(auth_no, auth_info) {
    $.ajax({
      url: "./delete.do", // 요청을 보낼주소
      type: "get",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: 'auth_no=' +auth_no,  // $('#frm').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var panel = '';
        panel = "<DIV id='panel' class='popup1' style='height: 250px; line-height: 30px;'>";
        panel += "카테고리 그룹을 삭제합니다.<br>";
        panel += '『'+ auth_info + "』 그룹에 소속된 멤버가 " + rdata.count_member + "개 발견되었습니다.<br>"
        panel += '『'+ auth_info + "』 멤버에 소속된 로그인정보가 " + rdata.count_login + "개 발견되었습니다.<br>"
        panel += '『'+ auth_info + "』 멤버에 소속된 접근권한정보가 " + rdata.count_access_url + "개 발견되었습니다.<br>"
        panel += "  삭제하면 복구 할 수 없습니다.<br><br>";
        panel += "  <button type='button' onclick='delete_check("+auth_no+","+rdata.count_member+","+rdata.count_login+","+rdata.count_access_url+");' class='popup_button'> 삭제 </button>";
        panel += "  <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'> 닫기 </button>";
        panel += "</DIV>";
        $('#main_panel').html(panel);
        
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var panel = '';
        panel = "<DIV id='panel' class='popup1' style='heigth: 350px;'>";
        panel += '  ERROR<br><br>';
        panel += '  <strong>request.status</strong><br>'+request.status + '<hr>';
        panel += '  <strong>error</strong><br>'+error + '<hr>';
        panel += "  <br><button type='button' onclick=\"$('#main_panel').hide();\">닫기</button>";
        panel += "</DIV>";
        $('#main_panel').html(panel);
        
      }
    });
    $('#main_panel').show();
    
  }

  function delete_check(auth_no, count_member, count_login, count_access_url) {
    var frm_delete = $('#frm_delete');
    $('#auth_no', frm_delete).val(auth_no); // 삭제할 번호 폼에 저장
    // alert($('#categrpno', frm_delete).val());
    
    if (count_member == 0) { // 소속된 카테고리가 없는 경우
    	if(count_login == 0){
    		if(count_access_url == 0){
    			  frm_delete.submit();
    		}
    	}
    }else {
      var sw = confirm('권한 그룹에 소속된 멤버가 ' + count_member + ' 건 있습니다. \n'
    		  + '해당멤버에 소속된 로그인정보가 ' + count_login + ' 건 있습니다. \n'
    		  + '해당멤버에 소속된 접근 권한정보가 ' + count_access_url + '건 있습니다. \n 삭제하시겠습니까?');
      
      if (sw == true) {
        frm_delete.submit();
      } else {
        alert('삭제를 취소합니다.');
      }
      
    }
    
  }
  
  function seqnoUp(auth_no) {
    var frm_auth_seqno = $('#frm_auth_seqno');
    frm_auth_seqno.attr('action', './update_seqno_up.do');
    $('#auth_no', frm_auth_seqno).val(auth_no);
    frm_auth_seqno.submit();
  }
  
  function seqnoDown(auth_no) {
    var frm_auth_seqno = $('#frm_auth_seqno');
    frm_auth_seqno.attr('action', './update_seqno_down.do');
    $('#auth_no', frm_auth_seqno).val(auth_no);
    frm_auth_seqno.submit();
  }
  
</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
  <!-- 우선 순위 증가 감소 폼 -->
  <FORM name='frm_auth_seqno' id='frm_auth_seqno' method='post' action=''>
    <input type='hidden' name='auth_no' id='auth_no' value=''>
  </FORM>
  
  <FORM name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
    <input type='hidden' name='auth_no' id='auth_no' value=''>
    <!-- <input type='hidden' name='lang' id='lang' value='en'> --> <!-- ko, en -->
    
  </FORM>
  
  <DIV id='main_panel'></DIV>
  
  <DIV class='title_line'>권한 그룹</DIV>

  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <input type='hidden' name='lang' id='lang' value='ko'> <!-- ko, en -->
          
      <label for='name'>권한 이름</label>
      <input type='text' name='auth_info' id='auth_info' value='' required="required" style='width: 25%;'>

      <label for='seqno'>출력 순서</label>
      <input type='number' name='auth_seqno' id='auth_seqno' value='' required="required" style='width: 5%;'>
      
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="create_update_cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='panel_update' style='display: none; padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' 
                action='./update.do'>
      <input type='hidden' name='auth_no' id='auth_no' value=''>

      <label for='name'>권한 이름</label>
      <input type='text' name='auth_info' id='auth_info' value='' required="required" style='width: 25%;'>

      <label for='seqno'>출력 순서</label>
      <input type='number' name='auth_seqno' id='auth_seqno' value='' required="required" style='width: 5%;'>
      
      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="create_update_cancel();">취소</button>
    </FORM>
  </DIV>
  
<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 40%;'/>
    <col style='width: 20%;'/>
    <col style='width: 20%;'/>
  </colgroup>

  <thead>  
  <TR>
    <TH style='text-align: center ;'>순서</TH>
    <TH style='text-align: center ;'>코드</TH>
    <TH>대분류명</TH>
    <TH style='text-align: center ;'>등록일</TH>
    <TH style='text-align: center ;'>기타</TH>
  </TR>
  </thead>

  <c:forEach var="authVO" items="${list }">
  <TR>
    <TD style='text-align: center;'>${authVO.auth_seqno }</TD>
    <TD style='text-align: center;'>${authVO.auth_no }</TD>
    <TD>${authVO.auth_info }</TD>
    <TD style='text-align: center;'>${authVO.auth_rdate.substring(0, 10) }</TD>
    <TD style='text-align: center;'>
      <A href="javascript:update(${authVO.auth_no })"><IMG src='./images/update.png' title='수정'></A>
      <A href="javascript:deleteOne(${authVO.auth_no }, '${authVO.auth_info }')"><IMG src='./images/delete.png' title='삭제'></A>
      <A href="javascript:seqnoUp(${authVO.auth_no })"><IMG src='./images/up.jpg' title='우선 순위 높임' style='width: 20px;'></A>
      <A href="javascript:seqnoDown(${authVO.auth_no })"><IMG src='./images/down.jpg' title='우선 순위 감소' style='width: 20px;'></A>
    </TD>
  </TR>
  </c:forEach>

</TABLE>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 


