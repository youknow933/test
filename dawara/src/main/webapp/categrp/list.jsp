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
  
   function update(grp_no) { 
    $('#panel_create').hide();
    $('#panel_update').show();
    
    $.ajax({
      url: "./update.do", // 요청을 보낼주소
      type: "get",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: 'grp_no=' +grp_no,  // $('#frm').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var frm_update = $('#frm_update');
        $('#grp_classification', frm_update).val(rdata.grp_classification);
        $('#grp_no', frm_update).val(rdata.grp_no);
        $('#grp_title', frm_update).val(rdata.grp_title);
        $('#grp_seqno', frm_update).val(rdata.grp_seqno);
        $('#grp_visible', frm_update).val(rdata.grp_visible);
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
   
  /*  function deleteOne(categrpno) {
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
   } */
    

   function deleteOne(grp_no, grp_title) {
     $.ajax({
       url: "./delete.do", // 요청을 보낼주소
       type: "get",  // or get
       cache: false,
       dataType: "json", // 응답 데이터 형식, or json
       data: 'grp_no=' +grp_no,  // $('#frm').serialize(), 
       // Ajax 통신 성공, JSP 정상 처리
       success: function(rdata) { // callback 함수
         var panel = '';
         panel = "<DIV id='panel' class='popup1' style='height: 200px; line-height: 30px;'>";
         panel += "카테고리 그룹을 삭제합니다.<br>";
         panel += '『'+ grp_title + "』 그룹에 소속된 카테고리가 " + rdata.count + "개 발견되었습니다.<br>"
         panel += "  삭제하면 복구 할 수 없습니다.<br><br>";
         panel += "  <button type='button' onclick='delete_check("+grp_no+","+rdata.count+");' class='popup_button'> 삭제 </button>";
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

   function delete_check(grp_no, count) {
     var frm_delete = $('#frm_delete');
     $('#grp_no', frm_delete).val(grp_no); // 삭제할 번호 폼에 저장
     // alert($('#categrpno', frm_delete).val());
     
     if (count == 0) { // 소속된 카테고리가 없는 경우
       frm_delete.submit();
     } else {
       var sw = confirm('카테고리 그룹에 소속된 카테고리가 ' + count + ' 건 있습니다. \n삭제하시겠습니까?');
       
       if (sw == true) {
         frm_delete.submit();
       } else {
         alert('삭제를 취소합니다.');
       }
       
     }
     
   }
  function create_update_cancel() {
    $('#panel_update').hide();
    $('#panel_create').show();
 
  }
  
  function seqnoUp(grp_no) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_up.do');
    $('#grp_no', frm_seqno).val(grp_no);
    frm_seqno.submit();
  }
  
  function seqnoDown(grp_no) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_down.do');
    $('#grp_no', frm_seqno).val(grp_no);
    frm_seqno.submit();
  }
  
</script>
 
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
  <!-- 우선 순위 증가 감소 폼 -->
  <FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='grp_no' id='grp_no' value=''>
  </FORM>
  
  <FORM name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
    <input type='hidden' name='grp_no' id='grp_no' value=''>
  </FORM>
  
  <DIV id='main_panel'></DIV>
  
  <DIV class='title_line'>카테고리 그룹</DIV>
 
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
    
    <label for='grp_classification'>카테고리 그룹번호</label>
      <input type='number' name='grp_classification' id='grp_classification' size='15' value='' required="required" style='width: 5%; text-align: center;'>
          
      <label for='grp_title'>카테고리 그룹 이름</label>
      <input type='text' name='grp_title' id='grp_title' size='15' value='' required="required" style='width: 20%;'>
 
      <label for='grp_seqno'>출력 순서</label>
      <input type='number' name='grp_seqno' id='grp_seqno' value='' required="required" style='width: 5%;'>
  
      <label for='grp_visible'>출력 형식</label>
      <select name='grp_visible' id='grp_visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
      
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="create_update_cancel();">취소</button>
    </FORM>
  </DIV> 
 
  <DIV id='panel_update' style='display: none; padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' 
                action='./update.do'>
      <input type='hidden' name='grp_no' id='grp_no' value=''>
 
      <label for='grp_classification'>카테고리 그룹번호</label>
      <input type='number' name='grp_classification' id='grp_classification' size='15' value='' required="required" style='width: 5% ;text-align: center; '>
            
      <label for='grp_title'>카테고리 그룹 이름</label>
      <input type='text' name='grp_title' id='grp_title' size='15' value='' required="required" style='width: 20%;'>
 
      <label for='grp_seqno'>출력 순서</label>
      <input type='number' name='grp_seqno' id='grp_seqno' value='' required="required" style='width: 5%;'>
  
      <label for='grp_visible'>출력 형식</label>
      <select name='grp_visible' id='grp_visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
 
      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="create_update_cancel();">취소</button>
    </FORM>
  </DIV>
  
<TABLE class='table table-hover'>
<style>
  body{
    padding:20px 20px;
  }

  .results tr[visible='false'],
  .no-result{
    display:none;
  }

  .results tr[visible='true']{
    display:table-row;
  }

  .counter{
    padding:8px; 
    color:#ccc;
  }
  </style>
    
    
    
  </head>

  <body>

<div class="form-group pull-right">
    <input type="text" class="search form-control" placeholder="그룹이름 검색" > 
</div>

<span class="counter pull-right"></span>

<table class="table table-hover table-bordered results">
  <thead>

    <tr>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">그룹번호</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">출력순서</th>
      <th class="col-md-3 col-xs-3" style = "text-align: center;">그룹이름</th>
      <th class="col-md-2 col-xs-2" style = "text-align: center;">등록일</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">수정</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">삭제</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">출력↑</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">출력↓</th>
    </tr>
     
  </thead>
  <tbody>
   <c:forEach var="categrpVO" items="${list }">
    <tr> 
      <th scope="row"  style='text-align: center;'>${categrpVO.grp_no }</th>
      <td style='text-align: center;'>${categrpVO.grp_seqno }</td>
      <td style='text-align: center;'><A href="../category/list.do?grp_no=${categrpVO.grp_no}&grp_title=${categrpVO.grp_title}">${categrpVO.grp_title}</A></td>
      <td style='text-align: center;'>${categrpVO.grp_rdate.substring(0, 10) }</td>
      <td style='text-align: center;'><A href="javascript:update(${categrpVO.grp_no })"><IMG src='./images/update.png' title='수정'></A></td>
      <td style='text-align: center;'><A href="javascript:deleteOne(${categrpVO.grp_no }, '${categrpVO.grp_title }')"><IMG src='./images/delete.png' title='삭제'></A></td>
      <td style='text-align: center;'><A href="javascript:seqnoUp(${categrpVO.grp_no })"><IMG src='./images/up_20.jpg' title='우선 순위 높임' style='width: 20px;'></A></td>
      <td style='text-align: center;'><A href="javascript:seqnoDown(${categrpVO.grp_no })"><IMG src='./images/down_20.jpg' title='우선 순위 감소' style='width: 20px;'></A></td>
    </tr>
  
    </c:forEach>
    
   </tbody>

</table>
    

  <script>
  $(document).ready(function() {
    $(".search").keyup(function () {
    var searchTerm = $(".search").val();
    var listItem = $('.results tbody').children('tr');
    var searchSplit = searchTerm.replace(/ /g, "'):containsi('")
    
    $.extend($.expr[':'], {'containsi': function(elem, i, match, array){
      return (elem.textContent || elem.innerText || '').toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
    }
    });
    
    $(".results tbody tr").not(":containsi('" + searchSplit + "')").each(function(e){
    $(this).attr('visible','false');
    });

    $(".results tbody tr:containsi('" + searchSplit + "')").each(function(e){
    $(this).attr('visible','true');
    });

    var jobCount = $('.results tbody tr[visible="true"]').length;
    $('.counter').text(jobCount + ' item');

    if(jobCount == '0') {$('.no-result').show();}
    else {$('.no-result').hide();}
        });
  }); 
  </script>
     </TD>
  </TR>
 
 
 
</TABLE>
  
</DIV> 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> 

</body>
 
</html> 

