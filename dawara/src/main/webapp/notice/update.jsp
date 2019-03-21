<!--C:\ai2\ws_frame\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\dawara\notice\storage  -->

<%@ page import="nation.web.tool.Tool"%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>공지사항 수정</title> 
<%  
String root = request.getContextPath(); 
// out.println("root: " + root);
%> 

<link href="<%=root%>/menu/css/style.css" rel='Stylesheet' type='text/css'>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- 첨부 파일을 클릭 시, 해당 파일을 삭제하시겠습니까? 출력  --> 
<script type="text/javascript">

/*
function panel_img(file){
    $('#form-group').hide();
    var panel = '';
    panel += "<DIV id='panel' class='message' style='width: 80%;'>";
    panel += "<fieldset class='fieldset_basic'>";
    panel += "<li class='li_none'>";
    panel += "삭제 되는 사진: "+ file + " <br><br>";
    panel += "해당 파일을 삭제하시겠습니까?";
    panel += "</li>";
    panel += "<li class='li_none'>"
    panel += "<button type='button' onclick=\"javascript:img_delete('"+file+"');\">삭제</button>"
//    panel += "<button type='button' onclick="+ Tool.deleteFile(file) + ">삭제</button>"
    panel += '&nbsp';
    panel += "<button type='button' onclick=\"location.href='./list_all.do?mem_no=${param.mem_no}'\">취소</button>"
    panel += "</li>"          
    
    panel += "</fieldset>";
    panel += "</DIV>";
    // 
    //panel += "<DIV id='panel' class='popup_img' style='width: 80%;'>";
    //panel += "  <A href=\"javascript: $('#main_panel').hide();\"><IMG src='./storage/"+file+"' style='width: 100%;'></A>";
    //panel += "</DIV>";
    // 
    $('#form-group').html(panel);
    $('#form-group').show();
  }
  
  
 
 // 첨부 파일 하나를 삭제 처리하기 위한 함수 
  function img_delete(file){
    $.ajax({
      url: "./img_delete_proc.jsp", // 요청을 보낼주소
      type: "POST",  // or get
      cache: false,
      dataType: "html", // 응답 데이터 형식, or json
      data: $('#frm').serialize(), // paramter
       data: 'file=' + file,
      // Ajax 통신 성공, JSP 정상 처리
      success: function() { // callback 함수
        var display_msgs = '삭제되었습니다.';
        //var msgs = received_data.msgs;
       
        //for (var i = 0; i <msgs.length; i++) {
        //  display_msgs += msgs[i] + '<br>';
       // }
       
        $('#panel').html(display_msgs); // 새로운 내용으로 할당
        var panel_close = $('#panel_close').clone(); // 태그 복제
        // panel_close.css('display','');
        $('#panel').append(panel_close.show()); // 마지막 자식 태그로 붙임.
        $('#panel').show();
        
        $('#btn_panel_close').focus();
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log('<strong>error</strong><br>'+ error + '<hr>');
      }
    });
  
  }
 */
 
/*  첨부 파일 전체를 삭제 처리를 확인하기 위한 함수  */
  function img_all_delete_ck(no_no){
    $('#form-group').hide();
    $('#form-file').hide();
    var panel = '';
    panel += "<DIV id='panel' class='message' style='width: 80%;'>";
    panel += "<fieldset class='fieldset_basic'>";
    panel += "<li class='li_none'>";
    panel += "첨부 파일들을 삭제하시겠습니까?";
    panel += "</li>";
    panel += "<li class='li_none'>"
    panel += "<button type='button' onclick=\"javascript:img_all_delete('"+no_no+"')\">삭제</button>"
//    panel += "<button type='button' onclick="+ Tool.deleteFile(file) + ">삭제</button>"
    panel += '&nbsp';
    //panel += "<button type='button' onclick=\"location.href='./list_all.do?mem_no=${param.mem_no}'\">취소</button>"
    panel += "<button type='button' onclick=\"location.href='./list_by_notice.do?notice_search=notice_no&word=&mem_no=1'\">취소</button>"
    panel += "</li>"          
    
    panel += "</fieldset>";
    panel += "</DIV>";
    $('#form-group').html(panel);
    $('#form-group').show();
}  
 
/*  첨부 파일 전체를 삭제 처리하기 위한 함수  */
  function img_all_delete(no_no){
    $.ajax({
      url: "./delete_img.do", // 요청을 보낼주소
      type: "POST",  // or get
      cache: false,
      dataType: "html", // 응답 데이터 형식, or json
      data: $('#frm').serialize(), // paramter
       data: 'no_no=' + no_no,
      // Ajax 통신 성공, JSP 정상 처리
      success: function() { // callback 함수
        //Tool.deleteFile(file);
        var display_msgs = '삭제되었습니다.';
       
        $('#panel').html(display_msgs); // 새로운 내용으로 할당
        var panel_close = $('#panel_close').clone(); // 태그 복제
        // panel_close.css('display','');
        $('#panel').append(panel_close.show()); // 마지막 자식 태그로 붙임.
        $('#panel').show();
        
        $('#btn_panel_close').focus();
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log('<strong>error</strong><br>'+ error + '<hr>');
      }
    });
  
  }
</script>


<!--
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
<script type="text/javascript">
  window.onload=function(){
    CKEDITOR.replace('no_contents');  // <TEXTAREA>태그 id 값
  };
</script>
 -->
</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>     

  <ASIDE style='float: left;'>
    <!-- <A href='../notice/list_all.do'>공지사항 목록</A> -->
    <A href='../notice/list_by_notice.do?notice_search=notice_no&word=&mem_no=1'>공지사항 목록</A> 
    <span style='font-size: 1.2em;'> > </span>    
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    
    <!-- 페이징 구현 시 활용할 부분 (18.06.27)  -->
      <%-- <span class='menu_divide' >│</span> 
      <A href='./list_by_category.do?categoryno=${categoryVO.categoryno }&word=${param.word}&nowPage=${param.nowPage}'>목록</A>
      <span class='menu_divide' >│</span>  --%>
    <%-- <A href='./create.do?no_no=${noticeVO.no_no }'>등록</A> --%>
  </ASIDE> 

  <div class='menu_line'></div>
  <FORM name='frm' method='POST' action='./update.do'
               enctype="multipart/form-data" class="form-horizontal">
      <input type='hidden' name='no_no' id='no_no' value='${noticeVO.no_no }'>
      <input type='hidden' name='mem_no' id='mem_no' value='${noticeVO.mem_no }'>
        <DIV id='main_panel'></DIV>
      
      <div class="form-group">   
        <label for="no_title" class="col-md-1 control-label">제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-md" name='no_title' id='no_title' value='${noticeVO.no_title}' required="required" style='width: 80%;'>
        </div>
        
        <label for="no_visible" class="col-md-1 control-label">보이기 여부</label>
        <div>
        <select name="no_visible" id='no_visible'>
         <c:if test='${noticeVO.no_visible.equals("Y") }'>
              <option value="${noticeVO.no_visible}" selected>${noticeVO.no_visible}</option>
              <option value="N">N</option>
         </c:if>
         <c:if test='${noticeVO.no_visible.equals("N") }'>
            <option value="Y">Y</option>
            <option value="${noticeVO.no_visible}" selected>${noticeVO.no_visible}</option>
         </c:if>
        </select>
          <%-- <input type='radio' name='no_visible' id='no_visible' value='${noticeVO.no_visible}' required="required" style='width: 2px;'> --%>
        </div>
        
      </div>   
      <div class="form-group" id="form-group">   
        <label for="no_contents" class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-md" name='no_contents' id='no_contents'  rows='10'>${noticeVO.no_contents}</textarea>
        </div>
      </div>
      
  <!-- 첨부 파일 출력 -->
    <c:if test="${file_list.size() > 0 }">
      <DIV class="form-file" id="form-file">
        <c:forEach var ="No_fileVO"  items="${file_list }">       
           <A href="javascript: panel_img('${No_fileVO.no_files }')">
            <IMG src='./storage/${No_fileVO.no_thumbs }' style='margin-top: 2px;'>       
          </A>

        </c:forEach>
      </DIV>
    </c:if>
   <button type='button' onclick="javascript:img_all_delete_ck('+${noticeVO.no_no }+');">첨부 파일 삭제</button> 
   <%--  <button type='button' onclick="location.href='./delete_img.do?no_no=${noticeVO.no_no}' " >첨부 파일 삭제</button> --%>
   <%--  <button type="button" onclick="javascript:img_all_delete('+ ${file_list}+');">첨부 파일 삭제</button> --%>
   <div class="form-group">   
    <label for="filesMF" class="col-md-1 control-label">파일</label>
    <div class="col-md-11">
      <input type="file" class="form-control input-md" name='filesMF' id='filesMF' size='40' multiple="multiple">
      <br>
      Preview(미리보기) 이미지는 자동 생성됩니다.
     </div>
    </div>   
      <DIV style='text-align: right;'>
        <button type="submit">변경된 내용 저장</button>
<%--         <button type="button" onclick="location.href='./list_all.do?mem_no=${noticeVO.mem_no}'">취소[목록]</button> --%>
        <button type="button" onclick="location.href='./list_by_notice.do?notice_search=notice_no&word=&mem_no=1'">취소[목록]</button>
<%--         <button type="button" onclick="location.href='./list_all.do?no_no=${noticeVO.no_no}&word=${param.word}&nowPage=${param.nowPage}'">취소[목록]</button> --%>
      </DIV>
  </FORM>

</DIV> <!-- contents END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 