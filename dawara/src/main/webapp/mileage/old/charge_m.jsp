<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title>  
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js">

  
</script>


  <DIV class='title_line' f>${sessionScope.mem_name}님의 마일리지 충전소</DIV> 
  
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #ffffff; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
  
  <div style = "margin:5%;'">
  
<label for='mem_no'><b>회원번호</b></label>
      <input type='text' readonly="readonly" name='mem_no' id='mem_no' size='10' value=' ${sessionScope.mem_no}' required="required" style='width: 10%; text-align: center;'>
    <br>
    <br>
        <label class='label' for='cway_no' ><b>충전방법</b></label>
        <select name='cway_no' id='cway_no'>
          <option value='1' selected="selected">카드</option>     
          <option value='2'>계좌이체</option>
          <option value='3'>무통장입금</option>
          <option value='4'>핸드폰</option>  
        </select> 
  
  <br>
  <br>
  
   <label class='label' for='char_m' ><b>충전금액</b></label>
        <select name='char_m' id='char_m'>
          <option value='1000' selected="selected">1,000</option>     
          <option value='3000' >3,000</option>     
          <option value='5000' >5,000</option>     
          <option value='10000' >10,000</option>     
          <option value='30000' >30,000</option>     
          <option value='50000' >50,000</option>     
          <option value='100000' >100,000</option>     
         
        </select> 
  
    <!-- <label for=char_m>충전금액</label>
      <input type='text' name=char_m id='char_m' value=' ' required="required" style='width: 15%;'> -->
        
  </div>
  
       <button type="submit" id='submit'>충전</button>
       <button type="button" onclick="window.close()">취소</button>
    
</FORM>
  </DIV>
 </head>
 <!-- 상단 BUTTON 태그클릭시 보여줄 레이어팝업 태그 --> 
</html>


<script>
$("#button").click(function(){ $( "#dialog" ).dialog( "open" ); });

//레이어팝업 UI 생성후 화면에 안보여주기
     $( "#dialog" ).dialog({
      //이벤트 발생했을때 보여주려면 autoOpen : false로 지정해줘야 한다.
      autoOpen: false,
      //레이어팝업 넓이
      width: 400,
      //뒷배경을 disable 시키고싶다면 true
      modal: true,
      //버튼종류
      buttons: [
        {
          //버튼텍스트
          text: "Ok",
          //클릭이벤트발생시 동작
          click: function() {
            $( this ).dialog( "close" );
          }
        },
        {
          //버튼텍스트
          text: "Cancel",
          //클릭이벤트발생시 동작
          click: function() {
            $( this ).dialog( "close" );
          }
        }
      ]
    });
</script>

