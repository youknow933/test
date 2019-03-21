<%@ page contentType="text/html; charset=UTF-8" %>

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

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/JavaScript">
  window.onload=function(){
    CKEDITOR.replace('pr_contents');  // <TEXTAREA>태그 id 값
  };
</script>

</head> 

<body>
<DIV class='container' style='width: 90%;'>
<%-- <jsp:include page="/menu/top.jsp" flush='false' /> --%>
<DIV class='content'>     

  <ASIDE style='float: left;'>
      <A href='../category/list.do'>게시판 목록</A>  
      <A href='./list.do?gory_no=${categoryVO.gory_no }'>${categoryVO.pr_title }</A>
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>등록</A>
  </ASIDE> 

  <div class='menu_line'></div>
  <DIV class='content' style='width: 100%;'>
    <FORM name='frm' method='POST' action='./create.do'
               enctype="multipart/form-data" class="form-horizontal">
               
      <input type='hidden' name='gory_no' id='gory_no' value='${param.gory_no }'>
      <input type='hidden' name='mem_no' id='mem_no' value='${mem_no }'>
<%--       <input type='hidden' name='mem_no' id='mem_no' value='${sessionScope.mem_no }'> --%>
      
      <div class="form-group">   
        <label for="pr_title" class="col-md-1 control-label">글 제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='pr_title' id='pr_title' value='[삼성전자]PEN NT930QAA-K28A' required="required" style='width: 80%;'>
        </div>
      </div>   
      <div class="form-group">   
        <label for="pr_contents" class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-lg" name='pr_contents' id='pr_contents'  rows='10'>크리스마스에 갔던곳</textarea>
        </div>
      </div>

       <div class="form-group">   
        <label for="content" class="col-md-1 control-label">구입 시기</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='pr_buyyear' id='pr_buyyear' value='2017-01-01' style='width:20%'>
         <span class='top_menu1'>예) 2017년 6월</span>
        </div>
        </div>
        
       <div class="form-group">   
        <label for="content" class="col-md-1 control-label">상태</label>
        <div class="col-md-11">
        <select name = 'pr_state' id='pr_state' style='width:10%'>
          <option value ='중고' >중고</option>
          <option value ='신상품'>신상품</option>
        </select>
        </div>
        </div>
        
        
        <div class="form-group">   
        <label for="content" class="col-md-1 control-label">거래 방식</label>
        <div class="col-md-11">
        <select name = 'pr_transaction' id='pr_transaction' style='width:10%'>
          <option value ='직거래' >직거래</option>
          <option value ='택배'>택배</option>
        </select>
          <!-- <input type='text' class="form-control input-lg" name='pr_transaction' id='pr_transaction' value='직거래' style='width:10%'> -->
        </div>
        </div>
        
        <div class="form-group">   
        <label for="content" class="col-md-1 control-label">지역</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='pr_local' id='pr_local' value='서울/종각' style='width:10%'>
         <span class='top_menu1'>예) 서울/종각</span>
        </div>
        </div>
        
        <div class="form-group">   
        <label for="content" class="col-md-1 control-label">구매 가격</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='pr_buyprice' id='pr_buyprice' value=1000 style='width:10%'>
        </div>
        </div>
        
         <div class="form-group">   
        <label for="content" class="col-md-1 control-label">판매 가격</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='pr_price' id='pr_price' value=800 style='width:10%'>
        </div>
        </div>
        

      
     
      <div class="form-group">   
        <label for="pr_filesMF" class="col-md-1 control-label">업로드 파일</label>
        <div class="col-md-11">
          <input type="file" class="form-control input-lg" name='pr_filesMF' id='pr_filesMF' size='40' multiple="multiple">
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   

      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list.do?gory_no=${param.gory_no}'">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
