<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script type="text/javascript">
before_rpl_no = 0;
pr_no_answer =0;
  $(function() {
    list(${param.pr_no}); 
  });
  
  // list
  function list(pr_no) {
    pr_no_answer=pr_no;
    $('#panel_update').hide();
    $('#panel_create').show();
    $.ajax({
      url: "./list_by_json.do", // 요청을 보낼주소
      type: "get",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: "pr_no=" + pr_no, 
      // Ajax 통신 성공, JSP 정상 처리
      success: function(rdata) { // callback 함수
          var panel = '';
 
          panel+= "<div class=\"table_basic\" style ='width:70%' >";
         for(index=0; index < rdata.length-1; index++) {
      
           if(rdata[index].rpl_ansnum == 0){
            panel += " <img src='./images/ting1.gif'>";
           }else if(rdata[index].rpl_ansnum > 0){
            panel +=  "<img src='./images/white.jpg' style='width:"+rdata[index].rpl_indent * 20 +"px; height:10px; opacity: 0.0;'>";
            panel +=   "<img src='./images/reply3.jpg'>";
           } 
          panel += "<span class=\"form-group\">"+rdata[index].mem_id+"</span>";
          if(rdata[rdata.length-1]!= 0){  
          panel += " | <a href= \"javascript:answer_form_req("+rdata[index].rpl_no+")\">답변 등록</a>";
            if(rdata[rdata.length-1]== rdata[index].rpl_mem_no){  
            panel += " | <a href= \"javascript:update_form_req("+rdata[index].rpl_no+")\">수정</a> |";
            panel += " <a href= \"javascript:delete_form_req("+rdata[index].rpl_no+")\">삭제</a>"; 
            }  
          }
         
          panel += "<div class=\"form-group\">";
          if(rdata[index].rpl_ansnum > 0){
            panel +=  "<img src='./images/white.jpg' style='width:"+rdata[index].rpl_indent * 20 +"px; height:10px; opacity: 0.0;'>";
          }
          panel += "<span class=\"form-group\">"+rdata[index].rpl_contents+"</span>";
          panel += "</div>";
          panel +="<div>";
          panel +=  " <span class=\"form-group\">"+rdata[index].rpl_rdate+"</span>";
          panel +="</div>";
          
          panel += "<hr style=\"width: 100%; margin-left: 0px;border-color: black;\"> ";
          panel += "<div id='no"+rdata[index].rpl_no+"'>";
          panel += "</div>";
         }
       
         panel +="</div>";
        $('#tbody_panel').empty();
        $('#tbody_panel').append(panel); 
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
  
  
   // 등록 처리
  function create() {
    $.ajax({
      url: "./create.do", // 요청을 보낼주소
      type: "post",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
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
        
         list(${param.pr_no}); 
         
         var frm_create = $('#frm_create');
         $('#rpl_contents', frm_create).val(''); 
        
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

 //답변 폼  
  function answer_form_req(rpl_no){
   $('#no' + before_rpl_no).empty();  
    
    before_rpl_no = rpl_no;
    
    var panel = '';
    panel += " <DIV id='panel_answer' style= padding: 10px 0px 10px 0px; width: 100%; text-align: center;'>  ";
    panel += "<form name='frm_answer' id='frm_answer' action='' method='post'> ";
    panel += " <input type='hidden' name='pr_no' id='pr_no' value="+pr_no_answer +"> ";
    panel += " <input type='hidden' name='rpl_no' id='rpl_no' value="+rpl_no+">";
    panel += "   <textarea id=\"rpl_contents\" name=\"rpl_contents\" class=\"form-control col-lg-12\" ";
    panel += "   placeholder=\"댓글을 입력해 주세요.\"";
    panel += "     style=\"width: 80%; \" rows=\"5\"></textarea>";
    panel += "<button type=\"button\" id=\"button\" onclick=\"answer();\" >답변 등록</button>";
    panel += "<button type=\"button\" onclick=\"create_update_cancel();\">취소</button>";
    panel += "</form>";
    panel += "</DIV>";
    
    $('#no' + rpl_no).append(panel);
  } 
   
  // 답변 처리
  function answer() {
    $.ajax({
      url: "./answer.do", // 요청을 보낼주소
      type: "post",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: $('#frm_answer').serialize(), 
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
        
         list(${param.pr_no}); 
      
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

  //조회,수정폼
  function update_form_req(rpl_no) {
  $('#no' + before_rpl_no).empty();   
    
    before_rpl_no = rpl_no;
         
    $.ajax({
      url: "./update.do",
      type: "get",
      cache: false,  
      dataType: "json",
      data : 'rpl_no=' + rpl_no,
      success: function(rdata) {
        var panel="";
        panel += "<DIV id='panel_update' style=' padding: 10px 0px 10px 0px; width: 100%; text-align: center;'>";
        panel += "<form name='frm_update' id='frm_update' action='' method='post'> ";
        panel += "<input type='hidden' name='rpl_no' id='rpl_no' value="+rpl_no+">";
        panel += " <input type='hidden' name='pr_no' id='pr_no' value="+pr_no_answer+"> ";
        panel += " <DIV style='text-align: center;'>";
        panel += "  <textarea id=\"rpl_contents\" name=\"rpl_contents\" class=\"form-control col-lg-12\" ";
        panel += " style=\"width: 80%; \" rows=\"5\">"+rdata.rpl_contents + "</textarea>";
        panel += " <br>";
        panel += "<button type=\"button\" id=\"button\" onclick=\"update()\">저장</button>";
        panel += "<button type=\"button\"  onclick=\"create_update_cancel();\">취소</button>";
        panel += " </DIV>";
        panel += "<fieldset class='fieldset_basic' ></fieldset>";
        panel += "</form>";
        panel += "   </DIV>";
        
        $('#no' + rpl_no).append(panel);
      },
      error: function(request, status, error) {
        console.log('<strong>error</strong><br>'+ error + '<hr>');
      } 
    });
  }
  
  // 수정 처리
  function update() {
    console.log("update");
    $.ajax({
      url: "./update.do", // 요청을 보낼주소
      type: "post",  // or get
      cache: false,
      dataType: "json", // 응답 데이터 형식, or json
      data: $('#frm_update').serialize(), 
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
        
         list(${param.pr_no}); 
         
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

  
 //삭제폼
  function delete_form_req(rpl_no) {
    //$('#panel').hide();
    $('#panel').show();
    $('#frm_delete').show();
 
    $.ajax({
      url: "./delete.do",
      type: "get",
      cache: false,  
      dataType: "json",
      data : 'rpl_no=' + rpl_no,
      success: function(rdata) {
        
        var frm_delete = $('#frm_delete');
        $('#rpl_no', frm_delete).val(rpl_no); 
        $('#rpl_contents', frm_delete).val(rdata.rpl_contents); 
        
        $('#delete_panel').show();
        
        var delete_panel = $('#delete_panel');
      },
      error: function(request, status, error) {
        console.log('<strong>error</strong><br>'+ error + '<hr>');
      } 
    });
  } 
 
  function create_update_cancel() {
    $('#panel_update').hide();
    console.log("before_rpl_no : "  + before_rpl_no);
    $('#no' + before_rpl_no).hide();
    $('#panel_answer').hide();
    $('#panel_create').show();

  } 
  function delete_proc_req() {
    frm_delete.submit();
  }
  
</script>
</head>
<body>

<DIV class='container' style='width: 90%;'>
<DIV class='content'>

  <DIV id='main_panel'></DIV>
  <!-- create -->
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; width: 100%; '>  
  <form name='frm_create' id='frm_create' action='' method='post'> 
     <input type='hidden' name='pr_no' id='pr_no' value='${param.pr_no }'> 
 <input type='hidden' name='mem_no' id='mem_no' value="${mem_no}"> 
         <fieldset class='fieldset_basic' style='width:80%;'>
          <legend class='legend_basic'  style='margin-right: 700px;'>댓글쓰기</legend>
               <br>
                <DIV style='text-align: center;'>
       <c:choose>
        <c:when test="${param.mem_no!=0}">
          <span>
          <textarea id="rpl_contents" name="rpl_contents" class="form-control col-lg-12" 
          placeholder="댓글을 입력해 주세요."
          style="width: 80%; " rows="5"></textarea>
          </span>
             <span>
             <br>
            <button type="button" id="button" onclick="create();" style='margin-left: 550px;'>등록</button>
            <button type="button" onclick="create_update_cancel();">취소</button>
            <DIV>
            <br>
            </DIV>
          </span>
                    </c:when>
    </c:choose> 
          </DIV>
          </fieldset>
        </form>
        </DIV>

  <FORM name='frm_delete' id='frm_delete'  method='post' action='./delete.do'>
    <input type='hidden' name='rpl_no' id='rpl_no' value='0'>
  </FORM>
  
  <DIV id='delete_panel' style='display: none;'>
    <br>
    <DIV id='panel' class='popup1' style='height: 120px; line-height: 28px;'>
         삭제하면 복구 할 수 없습니다.<br>
      <button type='button' onclick='frm_delete.submit();' class='popup_button'> 삭제 </button>
      <button type='button' onclick="$('#delete_panel').hide();" class='popup_button'> 닫기 </button>
    </DIV>
  </DIV>     
  <!-- list -->
       <DIV id='tbody_panel' >
    </div>
   
  
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
</html>