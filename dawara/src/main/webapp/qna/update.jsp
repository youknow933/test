<!--C:\ai2\ws_frame\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\dawara\qna\storage  -->

<%@ page import="nation.web.tool.Tool"%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>QnA 수정</title> 
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
/*  첨부 파일 전체를 삭제 처리를 확인하기 위한 함수  */
  function img_all_delete_ck(qna_no){
    $('#form-group').hide();
    $('#form-file').hide();
    var panel = '';
    panel += "<DIV id='panel' class='message' style='width: 80%;'>";
    panel += "<fieldset class='fieldset_basic'>";
    panel += "<li class='li_none'>";
    panel += "첨부 파일들을 삭제하시겠습니까?";
    panel += "</li>";
    panel += "<li class='li_none'>"
    panel += "<button type='button' onclick=\"javascript:img_all_delete('"+qna_no+"')\">삭제</button>"
//    panel += "<button type='button' onclick="+ Tool.deleteFile(file) + ">삭제</button>"
    panel += '&nbsp';
    //panel += "<button type='button' onclick=\"location.href='./list_all.do?mem_no=${param.mem_no}'\">취소</button>"
    panel += "<button type='button' onclick=\"location.href='./list_by_qna.do?qna_search=qna_no&mem_no=1'\">취소</button>"
    panel += "</li>"          
    
    panel += "</fieldset>";
    panel += "</DIV>";
    $('#form-group').html(panel);
    $('#form-group').show();
}  
 
/*  첨부 파일 전체를 삭제 처리하기 위한 함수  */
  function img_all_delete(qna_no){
    $.ajax({
      url: "./delete_img.do", // 요청을 보낼주소
      type: "POST",  // or get
      cache: false,
      dataType: "html", // 응답 데이터 형식, or json
      data: $('#frm').serialize(), // paramter
       data: 'qna_no=' + qna_no,
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
function pop(file){ 
window.open("./storage/"+file, 
            "pop", 
            "width=400,height=500,left=500,top=100,history=no,resizable=no,status=no,scrollbars=yes,menubar=no")
}
</script>

<!--
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
<script type="text/javascript">
  window.onload=function(){
    CKEDITOR.replace('qna_contents');  // <TEXTAREA>태그 id 값
  };
</script>
 -->
</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>     

 <DIV class='content'>   
    <!-- <A href='../qna/list_all.do'>QnA 목록</A> -->
     <div style="height: auto; width: 100%; border-bottom:2px solid black; margin-bottom: 5px">
    <A href='../qna/list_by_qna.do?qna_search=qna_no&mem_no=1'>
    <h3>
    QnA 목록 >  
    </h3>
    </A> 
    </div>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    
    <!-- 페이징 구현 시 활용할 부분 (18.06.27)  -->
      <%-- <span class='menu_divide' >│</span> 
      <A href='./list_by_category.do?categoryno=${categoryVO.categoryno }&word=${param.word}&nowPage=${param.nowPage}'>목록</A>
      <span class='menu_divide' >│</span>  --%>
    <%-- <A href='./create.do?qna_no=${qnaVO.qna_no }'>등록</A> --%>
  </ASIDE> 

  <div class='menu_line'></div>
  <FORM name='frm' method='POST' action='./update.do'
               enctype="multipart/form-data" class="form-horizontal">
      <input type='hidden' name='qna_no' id='qna_no' value='${qnaVO.qna_no }'>
      <input type='hidden' name='mem_no' id='mem_no' value='${qnaVO.mem_no }'>
        <DIV id='main_panel'></DIV>
      
   <div class="col" style='float:inline-block'>
      <ul class='list-inline'>
        <li><label for="qna_title">제목</label></li>
        <li>
          <input type='text' class="form-control input-md" name='qna_title' id='qna_title' value='${qnaVO.qna_title}' required="required" style='width: 800px;'>
        </li>
        
        <li><label for="qna_visible" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;보이기 여부</label></li>
        <li>
        <select name="qna_visible" id='qna_visible'>
         <c:if test='${qnaVO.qna_visible.equals("Y") }'>
              <option value="${qnaVO.qna_visible}" selected>${qnaVO.qna_visible}</option>
              <option value="N">N</option>
         </c:if>
         <c:if test='${qnaVO.qna_visible.equals("N") }'>
            <option value="Y">Y</option>
            <option value="${qnaVO.qna_visible}" selected>${qnaVO.qna_visible}</option>
         </c:if>
        </select>
          <%-- <input type='radio' name='qna_visible' id='qna_visible' value='${qnaVO.qna_visible}' required="required" style='width: 2px;'> --%>
        </li>
        </ul>
        </div>
      <div id="form-group">   
        <label for="qna_contents">내용</label>
          <textarea class="form-control input-md" name='qna_contents' id='qna_contents'  required="required"  rows='20' style="resize: none;">${qnaVO.qna_contents}</textarea>
        <div>
        <div>
       <label for="qna_web">Web</label>
       <input type='text' class="form-control input-md" name='qna_web' id='qna_web' value='${qnaVO.qna_web}' required="required" style='width: 80%;'>
        </div>
      </div>
    </div>
      
  <!-- 첨부 파일 출력 -->
  <div>   
    <label for="filesMF">파일</label>
    <div>
      <input type="file" class="form-control input-md" name='filesMF' id='filesMF' size='40' multiple="multiple" >
      <br>
      Preview(미리보기) 이미지는 자동 생성됩니다.
     </div>
    </div>   
  <div>
    <c:if test="${file_list.size() > 0 }">
      <DIV class="form-file" id="form-file">
        <c:forEach var ="Qna_fileVO"  items="${file_list }">       
           <A href="javascript: pop('${Qna_fileVO.qna_files }')">
            <IMG src='./storage/${Qna_fileVO.qna_thumbs }' style='margin-top: 2px;'>       
          </A> 

        </c:forEach>
      </DIV>
      <!-- 첨부 파일이 존재할 경우 '첨부 파일 삭제' 버튼 출력 -->
   <button type='button' onclick="javascript:img_all_delete_ck('+${qnaVO.qna_no }+');">첨부 파일 삭제</button> 
    </c:if>
   <%--  <button type='button' onclick="location.href='./delete_img.do?qna_no=${qnaVO.qna_no}' " >첨부 파일 삭제</button> --%>
   <%--  <button type="button" onclick="javascript:img_all_delete('+ ${file_list}+');">첨부 파일 삭제</button> --%>
   
    </div>
    
 <label for="qna_passwd" >비밀번호</label>
  <input type='password' class="form-control input-md" name='qna_passwd' id='qna_passwd' value='${qnaVO.qna_passwd}' required="required" style='width: 30%;'>
     
    
    
      <DIV style='text-align: right;'>
        <button type="submit">변경된 내용 저장</button>
<%--         <button type="button" onclick="location.href='./list_all.do?mem_no=${qnaVO.mem_no}'">취소[목록]</button> --%>
        <button type="button" onclick="location.href='./list_by_qna.do?qna_search=qna_no&mem_no=1'">취소[목록]</button>
<%--         <button type="button" onclick="location.href='./list_all.do?qna_no=${qnaVO.qna_no}&word=${param.word}&nowPage=${param.nowPage}'">취소[목록]</button> --%>
      </DIV>
  </FORM>

</DIV> <!-- contents END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 