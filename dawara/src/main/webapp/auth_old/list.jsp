<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function() {
    $('#panel_create').show();
    $('#panel_update').hide();
  });
  
  function update(auth_no) {
    $('#panel_create').hide();
    $('#panel_update').show();
    
    $.ajax({
      url: "./update.do", // 요청을 보낼주소
      type: "get",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: 'auth_no=' + auth_no,  // $('#frm').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var frm_update = $('#frm_update');
        $('#auth_no', frm_update).val(rdata.auth_no);
        $('#auth_info', frm_update).val(rdata.auth_info);
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
  
  function deleteOne(auth_no) {
    var frm_delete = $('#frm_delete');
    $('#auth_no', frm_delete).val(auth_no);
    
    var panel = '';
    panel += "<DIV id='panel' class='popup1' style='height: 150px; line-height: 30px;'>";
    panel += "  권한을 삭제합니다.<br>";
    panel += "  삭제하면 복구 할 수 없습니다.<br><br>";
    panel += "  <button type='button' onclick='frm_delete.submit();' class='popup_button'> 삭제 </button>";
    panel += "  <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'> 닫기 </button>";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);
    $('#main_panel').show();
  }
  
  function seqnoUp(categoryno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_up.do');
    $('#categoryno', frm_seqno).val(categoryno);
    frm_seqno.submit();
  }
  
  function seqnoDown(categoryno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_down.do');
    $('#categoryno', frm_seqno).val(categoryno);
    frm_seqno.submit();
  }
</script>

<script type="text/javascript">
</script>
</head>

<body>
<DIV class='container' style='width: 90%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%; margin: 10px auto;'>  

  <DIV id='main_panel'></DIV>
   
  <FORM name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
    <input type='hidden' name='auth_no' id='auth_no' value=''>
  </FORM>

  <!-- 우선 순위 증가 감소 폼 -->
  <FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='auth_no' id='auth_no' value='${authVO.auth_no }'>
  </FORM>
   
   
   
   
  <div>
    <form name='frm' id='frm' method="get" action="./list_search.do">
      <ASIDE style='float: left;'>
        <A href='../auth/list_search_paging.do?auth_info='>권한 목록</A>  
        <span class='menu_divide' >│</span>
        <A href='../urlauth/list.do'>권한별 접근 URL 목록</A> 
      </ASIDE>
      <ASIDE style='float: right;'>
        <A href="javascript:location.reload();">새로고침</A>
        <span class='menu_divide' >│</span>
        <c:choose>
          <c:when test="${param.auth_info != '' }">
            <input type='text' name='auth_info' id='auth_info' placeholder="권한 정보 입력" value='${param.auth_info }' style='width: 35%;'>
          </c:when>
          <c:otherwise>
            <input type='text' name='auth_info' id='auth_info' placeholder="권한 정보 입력" value='' style='width: 35%;'>
          </c:otherwise>
        </c:choose>
        <button type='submit'>검색</button>
        <button type='button' onclick="location.href='./list.do'">전체 보기</button>
      </ASIDE>
    </form> 
  </div>
  
  
  
  
  <DIV class='title_line'>권한 목록</DIV>
  
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; 
                                           width: 80%; text-align: center; margin: 0px auto;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <%-- <label for='title'>권한 번호</label>
      <input type='number' name='auth_no' id='auth_no' size='5' value='${authVO.auth_no}' required="required" style='width: 5%;'> --%>
      
      <label for='title'>권한 정보</label>
      <input type='text' name='auth_info' id='auth_info' size='20' value='' required="required">

      <!-- <label for='seqno'>출력 순서</label>
      <input type='number' name='seqno' id='seqno' value='' required="required" style='width: 5%;'> -->
  
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
  
  <!--  수정폼은 항상 PK 전달한다. -->
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; 
                                           width: 80%; text-align: center; margin: 0px auto;'>  
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='auth_no' id='auth_no' value=''>
    
      <label for='title'>권한 정보</label>
      <input type='text' name='auth_info' id='auth_info' size='20' value='' required="required">

      <!-- <label for='seqno'>출력 순서</label>
      <input type='number' name='seqno' id='seqno' value='' required="required" style='width: 5%;'> -->
  
      <button type="submit" id='submit'>변경</button>  
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
         
  <div style='width: 80%; margin: 10px auto;'>
    <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 20%;"></col>
        <col style="width: 50%;"></col>
        <col style="width: 30%;"></col>
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr >
          <th style='text-align: center;'>권한 번호</th>
          <th style='text-align: center;'>권한 정보</th>
          <th style='text-align: center;'>기타</th> 
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="authVO" items="${list }"> 
          <tr> 
            <td style='text-align: center;'>${authVO.auth_no}</td>
            <td style='text-align: center;'>${authVO.auth_info}</td>
            <td style='text-align: center;'>
              <A href="javascript:update(${authVO.auth_no })"><IMG src='../images/update.png' title='수정'></A>
              <A href="javascript:deleteOne(${authVO.auth_no })"><IMG src='../images/delete.png' title='삭제'></A>
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
    </table>
    <br><br>
  </div>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>
    
 