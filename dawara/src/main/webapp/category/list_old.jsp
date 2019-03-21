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
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  $(function() {
    $('#panel_create').show();
    $('#panel_update').hide();
    
  });
 
  function update(categoryno) {
    $('#panel_create').hide();
    $('#panel_update').show();
    
    $.ajax({
      url: "./update.do", // 요청을 보낼주소
      type: "get",  // or get 
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: 'categoryno=' +categoryno,  // $('#frm').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var frm_update = $('#frm_update');
        $('#categrpno', frm_update).val(rdata.categrpno);
        $('#categoryno', frm_update).val(rdata.categoryno);        
        $('#ntitle', frm_update).val(rdata.ntitle);
        $('#nseqno', frm_update).val(rdata.nseqno);
        $('#nvisible', frm_update).val(rdata.nvisible);
        $('#nids', frm_update).val(rdata.nids);        
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
  
  function deleteOne(categoryno) {
    var frm_delete = $('#frm_delete');
    $('#categrpno', frm_delete).val(${categrpVO.categrpno }); // Javascript + EL
    $('#categoryno', frm_delete).val(categoryno);
    
    var panel = '';
    panel += "<DIV id='panel' class='popup1' style='height: 150px; line-height: 30px;'>";
    panel += "  카테고리를 삭제합니다.<br>";
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
 
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%;'>

 
  
  <DIV id='main_panel'></DIV>
  
  <DIV class='title_line'>${categrpVO.categrptitle } 카테고리 </DIV>
 
  <FORM name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
    <input type='hidden' name='categrpno' id='categrpno' value=''>
    <input type='hidden' name='categoryno' id='categoryno' value=''>
  </FORM>
 
  <!-- 우선 순위 증가 감소 폼 -->
  <FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='categrpno' id='categrpno' value=' ${categrpVO.categrpno }'>
    <input type='hidden' name='categoryno' id='categoryno' value=''>
  </FORM>
  
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <!-- 개발시 임시 값 사용 -->
      <!-- 
      <input type='hidden' name='categrpno' id='categrpno' value='1'>
       -->
       
      <label for='categrpno'>카테고리 그룹 번호</label>
      <input type='text' name='categrpno' id='categrpno' size='5' value=' ${categrpVO.categrpno} ' required="required" style='width: 3%; text-align: center;'>
      
      <label for='ntitle'>카테고리 이름</label>
      <input type='text' name='ntitle' id='ntitle' size='10' value='' required="required" style='width: 10%;'>
 
      <label for='nseqno'>출력 순서</label>
      <input type='number' name='nseqno' id='nseqno' value=' ' required="required" style='width: 5%;'>
  
      <label for='nvisible'>출력 형식</label> 
      <!-- 
      <input type='text' name='visible' id='visible' value='' required="required" style='width: 2%;'>
       -->
       <select name='nvisible'>
         <option value='Y' selected="selected">Y</option>
         <option value='N'>N</option>
       </select>
       
      <label for='nids'>접근 계정</label>
      <input type='text' name='nids' id='nids' value='admin' required="required" style='width: 10%;'>
 
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
  
  <!--  수정폼은 항상 PK 전달한다. -->
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>  
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='categoryno' id='categoryno' value=''> 
 
      <label for='categrpno'>카테고리 그룹 번호</label>
      <input type='text' name='categrpno' id='categrpno' size='5' value=' ' required="required" style='width: 3%; text-align: center;'>
        
      <label for='ntitle'>카테고리 이름</label>
      <input type='text' name='ntitle' id='ntitle' size='15' value='' required="required" style='width: 10%;'>
 
      <label for='nseqno'>출력 순서</label>
      <input type='number' name='nseqno' id='nseqno' value=' ' required="required" style='width: 5%;'>
  
      <label for='nvisible'>출력 형식</label>
       <select name='nvisible'>
         <option value='Y' selected="selected">Y</option>
         <option value='N'>N</option>
       </select>
 
      <label for='nids'>접근 계정</label>
      <input type='text' name='nids' id='nids' value='admin' required="required" style='width: 10%;'>
 
      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
  
  
<TABLE class="table table-hover">
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/> 
    <col style='width: 14%;'/>
    <col style='width: 14%;'/>
    <col style='width: 16%;'/>
    <col style='width: 14%;'/>
    <col style='width: 14%;'/>
    <col style='width: 14%;'/>
    <col style='width: 14%;'/>
 
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>카테그룹번호</TH>
    <TH style='text-align: center ;'>카테고리번호</TH>
    <TH style='text-align: center ;'>출력순서</TH>
    <TH style='text-align: center ;'>카테고리이름</TH>
    <TH style='text-align: center ;'>출력여부</TH>
    <TH style='text-align: center ;'>접근계정</TH>
    <TH style='text-align: center ;'>기타</TH>
    
  </TR>
  </thead>
  <tbody>
    <c:forEach var="categrp_CategoryVO" items="${list }">
      <TR>
       <TD style='text-align: center ;'>${categrp_CategoryVO.categrpno}</TD>
       <TD style='text-align: center ;'>${categrp_CategoryVO.categoryno}</TD>
        <TD style='text-align: center ;'>${categrp_CategoryVO.category_seqno}</TD>
        <TD style='text-align: center ;'>${categrp_CategoryVO.ntitle}</TD>
        <TD style='text-align: center ;'>${categrp_CategoryVO.nvisible}</TD>
        <TD style='text-align: center ;'>${categrp_CategoryVO.nids}</TD>
        <TD style='text-align: center;'>
          <A href="javascript:update(${categrp_CategoryVO.categoryno })"><IMG src='./images/update.png' title='수정'></A>
          <A href="javascript:deleteOne(${categrp_CategoryVO.categoryno })"><IMG src='./images/delete.png' title='삭제'></A>
          <A href="javascript:seqnoUp(${categrp_CategoryVO.categoryno })"><IMG src='./images/up_20.jpg' title='우선 순위 높임' style='width: 20px;'></A>
          <A href="javascript:seqnoDown(${categrp_CategoryVO.categoryno })"><IMG src='./images/down_20.jpg' title='우선 순위 감소' style='width: 20px;'></A>
        </TD>
      </TR>
    </c:forEach>
  </tbody>
   
 
</TABLE>
  
 
 
</DIV> 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> 
</body>
 
</html> 