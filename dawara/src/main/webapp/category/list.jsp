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
 
  function update(gory_no) {
    $('#panel_create').hide();
    $('#panel_update').show();
    
    $.ajax({
      url: "./update.do", // 요청을 보낼주소
      type: "get",  // or get 
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: 'gory_no=' +gory_no,  // $('#frm').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var frm_update = $('#frm_update');
        $('#grp_no', frm_update).val(rdata.grp_no);
        $('#gory_no', frm_update).val(rdata.gory_no);        
        $('#gory_title', frm_update).val(rdata.gory_title);
        $('#gory_seqno', frm_update).val(rdata.gory_seqno);
        $('#gory_visible', frm_update).val(rdata.gory_visible);
        $('#gory_ids', frm_update).val(rdata.gory_ids);        
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
  
  function deleteOne(gory_no) {
    var frm_delete = $('#frm_delete');
    $('#grp_no', frm_delete).val(${categrpVO.grp_no }); // Javascript + EL
    $('#gory_no', frm_delete).val(gory_no);
    
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
  
  function seqnoUp(gory_no) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_up.do');
    $('#gory_no', frm_seqno).val(gory_no);
    frm_seqno.submit();
  }
  
  function seqnoDown(gory_no) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_down.do');
    $('#gory_no', frm_seqno).val(gory_no);
    frm_seqno.submit();
  }
  
</script>
 
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%;'>

 
  
  <DIV id='main_panel'></DIV>
  
  <DIV class='title_line'>${categrpVO.grp_title } 카테고리 </DIV>
 
  <FORM name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
    <input type='hidden' name='grp_no' id='grp_no' value=''>
    <input type='hidden' name='gory_no' id='gory_no' value=''>
  </FORM>
 
  <!-- 우선 순위 증가 감소 폼 -->
  <FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='grp_no' id='grp_no' value=' ${categrpVO.grp_no }'>
    <input type='hidden' name='gory_no' id='gory_no' value=''>
  </FORM>
  
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <!-- 개발시 임시 값 사용 -->
      <!-- 
      <input type='hidden' name='categrpno' id='categrpno' value='1'>
       -->
      <input type="hidden" name="mem_no" id="mem_no" value="${sessionScope.mem_no }">
       
      <label for='grp_no'>카테고리 그룹 번호</label>
      <input type='text' name='grp_no' id='grp_no' size='5' value=' ${categrpVO.grp_no} ' required="required" style='width: 3%; text-align: center;'>
      
      <label for='gory_title'>카테고리 이름</label>
      <input type='text' name='gory_title' id='gory_title' size='10' value='' required="required" style='width: 10%;'>
 
      <label for='gory_seqno'>출력 순서</label>
      <input type='number' name='gory_seqno' id='gory_seqno' value=' ' required="required" style='width: 5%;'>
  
      <label for='gory_visible'>출력 형식</label> 
      <!-- 
      <input type='text' name='visible' id='visible' value='' required="required" style='width: 2%;'>
       -->
       <select name='gory_visible'>
         <option value='Y' selected="selected">Y</option>
         <option value='N'>N</option>
       </select>
       
      <label for='gory_ids'>접근 계정</label>
      <input type='text' name='gory_ids' id='gory_ids' value='${sessionScope.mem_id }' readonly="readonly" style='width: 10%;'>
 
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
  
  <!--  수정폼은 항상 PK 전달한다. -->
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>  
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='gory_no' id='gory_no' value=''> 
 
      <label for='grp_no'>카테고리 그룹 번호</label>
      <input type='text' name='grp_no' id='grp_no' size='5' value=' ' required="required" style='width: 3%; text-align: center;'>
        
      <label for='gory_title'>카테고리 이름</label>
      <input type='text' name='gory_title' id='gory_title' size='15' value='' required="required" style='width: 10%;'>
 
      <label for='gory_seqno'>출력 순서</label>
      <input type='number' name='gory_seqno' id='gory_seqno' value=' ' required="required" style='width: 5%;'>
  
      <label for='gory_visible'>출력 형식</label>
       <select name='gory_visible'>
         <option value='Y' selected="selected">Y</option>
         <option value='N'>N</option>
       </select>
 
      <label for='gory_ids'>접근 계정</label>
      <input type='text' name='gory_ids' id='gory_ids' value='admin' required="required" style='width: 10%;'>
 
      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="create_update_cancel()">취소</button>
    </FORM>
  </DIV>
  
  
<TABLE class="table table-hover">
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
    <input type="text" class="search form-control" placeholder="제조사명 검색하세요..."  > 
</div>

<span class="counter pull-right"></span>

<table class="table table-hover table-bordered results"> 
  <thead>
   
    <tr> 
     <!--  <th class="col-md-1 col-xs-1" style = "text-align: center;">categrpno</th> -->
      <th class="col-md-1 col-xs-1" style = "text-align: center;">gory_no</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">출력순서</th>
      <th class="col-md-3col-xs-3" style = "text-align: center;">카테고리이름</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">출력여부</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">접근계정</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">수정</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">삭제</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">출력↑</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">출력↓</th> 
    </tr>
     
  </thead>
  <tbody>
   <c:forEach var="categrp_CategoryVO" items="${list }">
    <tr> 
      <%-- <th scope="row"  style='text-align: center;'>${categrp_CategoryVO.categrpno}</th> --%>
      <th scope="row"  style='text-align: center;'>${categrp_CategoryVO.gory_no}</th>
      <%-- <td style='text-align: center;'>${categrp_CategoryVO.categoryno }</td> --%>
      <td style='text-align: center;'>${categrp_CategoryVO.gory_seqno }</td>
      <td style='text-align: center;'><a href="../product/list_by_category.do?grp_no=${categrp_CategoryVO.grp_no }&gory_no=${categrp_CategoryVO.gory_no}">${categrp_CategoryVO.gory_title }</a></td>
      <td style='text-align: center;'>${categrp_CategoryVO.gory_visible }</td>
      <td style='text-align: center;'>${categrp_CategoryVO.gory_ids }</td>

      <td style='text-align: center;'><A href="javascript:update(${categrp_CategoryVO.gory_no})"><IMG src='./images/update.png' title='수정'></A></td>
      <td style='text-align: center;'><A href="javascript:deleteOne(${categrp_CategoryVO.gory_no }, '${categrpVO.grp_title }')"><IMG src='./images/delete.png' title='삭제'></A></td>
      <td style='text-align: center;'><A href="javascript:seqnoUp(${categrp_CategoryVO.gory_no })"><IMG src='./images/up_20.jpg' title='우선 순위 높임' style='width: 20px;'></A></td>
      <td style='text-align: center;'><A href="javascript:seqnoDown(${categrp_CategoryVO.gory_no})"><IMG src='./images/down_20.jpg' title='우선 순위 감소' style='width: 20px;'></A></td>
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