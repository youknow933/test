<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%  
String root = request.getContextPath(); 
// out.println("root: " + root);
%> 


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
 
  function update(mileage_no) {
    $('#panel_create').hide();
    $('#panel_update').show();
    
    $.ajax({
      url: "./update.do", // 요청을 보낼주소
      type: "get",  // or get 
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: 'mileage_no=' +mileage_no,  // $('#frm').serialize(), 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
        var frm_update = $('#frm_update');
        $('#mileage_no', frm_update).val(rdata.mileage_no);
        $('#mem_no', frm_update).val(rdata.mem_no);        
        $('#cway', frm_update).val(rdata.cway);
        $('#cway_no', frm_update).val(rdata.cway_no);
        $('#char_m', frm_update).val(rdata.char_m);
        $('#mymileage', frm_update).val(rdata.mymileage);
        $('#cmileage_date', frm_update).val(rdata.cmileage_date);        
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
  
  function deleteOne(mileage_no) {
    var frm_delete = $('#frm_delete');
   /*  $('#grp_no', frm_delete).val(${categrpVO.grp_no }); // Javascript + EL */
    $('#mileage_no', frm_delete).val(mileage_no); 
    
    var panel = '';
    panel += "<DIV id='panel' class='popup1' style='height: 150px; line-height: 30px; top: 200px;'>";
    panel += "  마일리지 내역을 삭제합니다.<br>";
    panel += "  삭제하면 복구 할 수 없습니다.<br><br>";
    panel += "  <button type='button' onclick='frm_delete.submit();' class='popup_button'> 삭제 </button>";
    panel += "  <button type='button' onclick=\"$('#main_panel').hide();\" class='popup_button'> 닫기 </button>";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);
    $('#main_panel').show();
  }
   

  
</script>
 
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%;'>

  <DIV id='main_panel'></DIV>
  <DIV class='title_line'>${sessionScope.mem_name}님의 마일리지 충전내역</DIV> 
 
   
 <%-- <div style = "right: -690px; top:-50px; position: relative;">
  <A href="<%=root%>/mileage/list.do"><img src = "./images/f5.png"> </A>
 </div> --%>
 
  <FORM name='frm_delete' id='frm_delete' method='post' action='./delete.do'>
    <input type='hidden' name='mileage_no' id='mileage_no' value=''>
  </FORM>
   
<!--    <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'> -->
<!--     <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'> -->
       
<!-- <!--     <label for='mileage_no'>충전순서</label> --> 
<%-- <%--       <input type='text' name=mileage_no id='mileage_no' size='5' value=' ${mileage_no} ' required="required" style='width: 3%; text-align: center;'> --%> 
      
<!--       <label for='mem_no'>회원번호</label> -->
<%--       <input type='text' readonly="readonly" name='mem_no' id='mem_no' size='10' value=' ${sessionScope.mem_no}' required="required" style='width: 10%; text-align: center;'> --%>
 
<!--          <label class='label' for='cway'>마일리지 충전방법</label> -->
<!--         <select name='cway' id='cway'> -->
<!--           <option value='카드' selected="selected">카드</option>      -->
<!--           <option value='계좌이체'>계좌이체</option> -->
<!--           <option value='무통장입금'>무통장입금</option> -->
<!--           <option value='핸드폰'>핸드폰</option>   -->
<!--         </select> -->
 
<!-- <!--       <label for=mymileage>내 마일리지</label> --> 
<%-- <%--       <input type='text' name='mymileage' id='mymileage' value=' ${way_myM.char_m + way_myM.mymileage }' required="required" style='width: 5%;'> --%> 
  
<!--       <label for=char_m>충전금액</label> -->
<!--       <input type='text' name=char_m id='char_m' value=' ' required="required" style='width: 5%;'> -->
  
<!--       <button type="submit" id='submit'>충전</button> -->
<!--       <button type="button" onclick="create_update_cancel()">취소</button> -->
<!--     </FORM> -->
<!--   </DIV>  -->
  
  <!--  수정폼은 항상 PK 전달한다. -->
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #DDDDDD; width: 100%; text-align: center;'>  
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='mileage_no' id='mileage_no' value=''> 
 
      <label for='mileage_no'>충전순서</label>
      <input type='text' name='mileage_no' id='mileage_no' size='5' value=' ' required="required" style='width: 3%; text-align: center;'>
          
               <label for='mem_no'>회원번호</label>
      <input type='text' readonly="readonly" name='mem_no' id='mem_no' size='15' value=' ${sessionScope.mem_no}' required="required" style='width: 10%; text-align: center;'>
 
<!--        <label class='label' for='cway_no'>마일리지 충전방법</label> -->
<!--         <select name='cway_no' id='cway_no'> -->
<!--           <option value='1' selected="selected">카드</option>      -->
<!--           <option value='2'>계좌이체</option> -->
<!--           <option value='3'>무통장입금</option> -->
<!--           <option value='4'>핸드폰</option>   -->
<!--         </select>    -->
        
  <%--     <label for='mymileage'>내 마일리지</label>
      <input type='text' name='mymileage' id='mymileage' value=' ${way_myM.char_m + way_myM.mymileage }' required="required" style='width: 5%; text-align: center;'>
   --%>
      <label for=char_m>충전금액</label>
      <input type='text' name=char_m id='char_m' value=' ' required="required" style='width: 5%;'>
  
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



<span class="counter pull-right"></span>

<table class="table table-hover table-bordered results"> 
  <thead>
   
    <tr> 
     <th class="col-md-1 col-xs-1" style = "text-align: center;">충전순서</th>  
      <th class="col-md-1col-xs-1" style = "text-align: center;">회원번호</th> 
      <th class="col-md-2 col-xs-2" style = "text-align: center;">충전방법</th>
      <th class="col-md-2 col-xs-2" style = "text-align: center;">충전금액</th>
      <th class="col-md-2 col-xs-2" style = "text-align: center;">충전날짜</th>
    <!--   <th class="col-md-2 col-xs-2" style = "text-align: center;">총 마일리지</th> -->
      <th class="col-md-1 col-xs-1" style = "text-align: center;">수정</th>
      <th class="col-md-1 col-xs-1" style = "text-align: center;">삭제</th> 
    </tr>
     
  </thead>
  <tbody>
   <c:forEach var="MileageVO" items="${list }">
    <tr> 
     <%--  <th scope="row"  style='text-align: center;'>${way_myM.mileage_no }</th>  --%>
      
      <th scope="row"  style='text-align: center;'>${MileageVO.mileage_no }</th>
      <td style='text-align: center;'>${MileageVO.mem_no }</th>
      <td style='text-align: center;'>${MileageVO.cway }</td>
      <td style='text-align: center;'>${MileageVO.char_m }원</td>  
      <td style='text-align: center;'>${MileageVO.cmileage_date }</td>
      <%-- <td style='text-align: center;'>${way_myM.char_m + way_myM.mymileage }</td> --%>
 
      <td style='text-align: center;'><A href="javascript:update(${MileageVO.mileage_no})"><IMG src='./images/update.png' title='수정'></A></td>
      <td style='text-align: center;'><A href="javascript:deleteOne(${MileageVO.mileage_no})"><IMG src='./images/delete.png' title='삭제'></A></td>
     <%--  <td style='text-align: center;'><A href="javascript:seqnoUp(${categrp_CategoryVO.gory_no })"><IMG src='./images/up_20.jpg' title='우선 순위 높임' style='width: 20px;'></A></td>
      <td style='text-align: center;'><A href="javascript:seqnoDown(${categrp_CategoryVO.gory_no})"><IMG src='./images/down_20.jpg' title='우선 순위 감소' style='width: 20px;'></A></td>
     --%></tr>
  
    </c:forEach>
    
   </tbody>

</table>
    

 <!--  <script>
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
   -->
     </TD>
  </TR>
 

 
</TABLE>
 
     
</DIV> 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> 
</body>
 
</html> 