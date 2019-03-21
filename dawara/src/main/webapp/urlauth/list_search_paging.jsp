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
  
  //등록 처리
  function create() {
    $.ajax({
      url: "./create.do", // 요청을 보낼주소
      type: "post",
      cache: false,
      dataType: "json",
      data: $('#frm_create').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var panel = '';
        panel += "<DIV id='panel' class='popup1' style='heigth: 350px;'>";
        panel += '  알림<br>';
        
        for(index=0; index < rdata.msgs.length; index++) {
          panel += rdata.msgs[index]+'<br>';
        }
        
        panel += "  <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'>닫기</button>";
        panel += "</DIV>";
        
        $('#main_panel').html(panel);
        $('#main_panel').show();
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
  
  function update(urlauth_no) {
    $('#panel_create').hide();
    $('#panel_update').show();
    
    $.ajax({
      url: "./update.do", // 요청을 보낼주소
      type: "get",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: 'urlauth_no=' + urlauth_no,  // $('#frm').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var frm_update = $('#frm_update');
        $('#urlauth_no', frm_update).val(rdata.urlauth_no);
        $('#urlauth_address', frm_update).val(rdata.urlauth_address);
        $('#auth_no', frm_update).val(rdata.auth_no);
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
  
  function deleteOne(urlauth_no) {
    var frm_delete = $('#frm_delete');
    $('#urlauth_no', frm_delete).val(urlauth_no);
    
    var panel = '';
    panel += "<DIV id='panel' class='popup1' style='height: 150px; line-height: 30px;'>";
    panel += "  권한별 접근 URL을 삭제합니다.<br>";
    panel += "  삭제하면 복구 할 수 없습니다.<br><br>";
    panel += "  <button type='button' onclick='frm_delete.submit();' class='popup_button'> 삭제 </button>";
    panel += "  <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'> 닫기 </button>";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);
    $('#main_panel').show();
  }
</script>

<script type="text/javascript">
</script>
</head>

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%; margin: 10px auto;'>  

  <DIV id='main_panel'></DIV>
   
  <FORM name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
    <input type='hidden' name='urlauth_no' id='urlauth_no' value=''>
  </FORM>

  <div>
    <form name='frm' id='frm' method="get" action="./list_search_paging.do">
      <ASIDE style='float: left;'>
        <A href='../auth/list_search_paging.do'>권한 목록</A> 
        <span class='menu_divide' >│</span>
        <A href='../urlauth/list_search_paging.do'>권한별 접근 URL 목록</A> 
      </ASIDE>
      <ASIDE style='float: right;'>
        <A href="javascript:location.reload();">새로고침</A>
        <span class='menu_divide' >│</span>
        <c:choose>
          <c:when test="${param.urlauth_address != '' }">
            <input type='text' name='urlauth_address' id='urlauth_address' placeholder="권한별 접근 URL 정보 입력" 
                      value='${param.urlauth_address }' style='width: 35%;'>
          </c:when>
          <c:otherwise>
            <input type='text' name='urlauth_address' id='urlauth_address' placeholder="권한별 접근 URL 정보 입력" 
                    value='' style='width: 35%;'>
          </c:otherwise>
        </c:choose>
        <button type='submit'>검색</button>
        <button type='button' onclick="location.href='./list_search_paging.do'">전체 보기</button>
      </ASIDE>
    </form> 
  </div>
  
  <DIV class='title_line'>권한별 접근 URL 목록</DIV>
  
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; 
                                           width: 80%; text-align: center; margin: 0px auto;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <label for='title'>권한 번호</label>
      <input type='number' name='auth_no' id='auth_no' size='5' min="0" value='' required="required" style='width: 5%;'>
      
      <label for='title'>권한별 접근 URL 정보</label>
      <input type='text' name='urlauth_address' id='urlauth_address' size='20' value='' required="required">
  
      <button type="button" id='submit' onclick="create()">등록</button>
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
  
  <!--  수정폼은 항상 PK 전달한다. -->
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; 
                                           width: 80%; text-align: center; margin: 0px auto;'>  
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='urlauth_no' id='urlauth_no' value=''>

      <label for='title'>권한 번호</label>
      <input type='number' name='auth_no' id='auth_no' size='5' min="0" value='' required="required" style='width: 5%;'>
      
      <label for='title'>권한별 접근 URL 정보</label>
      <input type='text' name='urlauth_address' id='urlauth_address' size='20' value='' required="required">
  
      <button type="submit" id='submit'>변경</button>  
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
         
  <div style='width: 80%; margin: 10px auto;'>
    <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 20%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 40%;"></col>
        <col style="width: 30%;"></col>
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr >
          <th style='text-align: center;'>권한별 접근 URL 번호</th>
          <th style='text-align: center;'>권한 번호</th>
          <th style='text-align: center;'>권한별 접근 URL 정보</th>
          <th style='text-align: center;'>기타</th> 
        </tr>
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="urlauthVO" items="${list }"> 
          <tr> 
            <td style='text-align: center;'>${urlauthVO.urlauth_no}</td>
            <td style='text-align: center;'>${urlauthVO.auth_no}</td>
            <td style='text-align: center;'>${urlauthVO.urlauth_address}</td>
            <td style='text-align: center;'>
              <A href="javascript:update(${urlauthVO.urlauth_no })"><IMG src='../images/update.png' title='수정'></A>
              <A href="javascript:deleteOne(${urlauthVO.urlauth_no })"><IMG src='../images/delete.png' title='삭제'></A>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    
    <DIV class='bottom_menu'>${paging }</DIV> <!--  페이지 목록 출력 -->
    <br><br>
  </div>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>
    
 