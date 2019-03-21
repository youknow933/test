<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../js/jquery.cookie.js"></script>

<script type="text/javascript">
  
</script>


</head> 


<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <DIV id='main_panel'></DIV>

  <!-- Modal -->
  <div class="modal fade" id="modal_panel" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'></h4>
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div> <!-- Modal END -->
    
  <!--
  <ASIDE style='float: left;'>
      <A href='./list_by_member.do'>회원 목록</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
    </ASIDE>
     -->

  <DIV class='title_line'>회원 정보 조회 및 수정</DIV>

  <FORM name='frm' id='frm' method='POST' action='./update.do' 
              onsubmit="return send();" class="form-horizontal">
    <input type='hidden' name='mem_no' id='mem_no' value='${memberVO.mem_no }'>          

    <div class="form-group">
      <label for="mem_id" class="col-md-2 control-label">아이디</label>    
      <div class="col-md-10">
        ${memberVO.mem_id }        
      </div>
    </div>   
                
    <div class="form-group">
      <label for="mname" class="col-md-2 control-label">성명</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='mem_name' id='mem_name' 
                   value='${memberVO.mem_name }' required="required" style='width: 30%;' placeholder="성명">
      </div>
    </div>   

    <div class="form-group">
      <label for="tel" class="col-md-2 control-label">전화번호</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='mem_tel' id='mem_tel' 
                   value='${memberVO.mem_tel }' required="required" style='width: 30%;' placeholder="전화번호"> <h6>예) 010-0000-0000</h6>
      </div>
    </div>   
    
    <div class="form-group" style='width: 100%;'>
    <table>
      <tr>
        <td style='padding-left: 210px;'><label for="mem_job" class="col-md-2 control-label" style='width: 100%;'>직업</label></td> 
        <td><div class="col-md-10">
          <select name='mem_job' id='mem_job'>
            <option value="" selected="selected" disabled="disabled">직업선택</option>
            <option value='학생' <c:if test="${memberVO.mem_job eq '학생'}">selected="selected"</c:if>/>학생</option>
            <option value='회사원' <c:if test="${memberVO.mem_job eq '회사원'}">selected="selected"</c:if>/>회사원</option>
            <option value='무직' <c:if test="${memberVO.mem_job eq '무직'}">selected="selected"</c:if>/>무직</option>
          </select>
        </div></td>
        <td style='padding-left: 30px;'><label for="mem_job" class="col-md-2 control-label" style='width: 100%;'>성별</label></td>
        <td>
        <div class="col-md-10" style='width: 100%;'>
        <input type="radio" name="mem_sex" value="M" 
        <c:if test="${memberVO.mem_sex eq 'M'}">checked="checked"</c:if>/>남성
        <input type="radio" name="mem_sex" value="F" 
        <c:if test="${memberVO.mem_sex eq 'F'}">checked="checked"</c:if>/>여성
      </div>
      </td>
      </tr>
    </table>
    </div>   
    
    <div class="form-group">
      <label for="mem_mail" class="col-md-2 control-label">이메일</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='mem_mail' id='mem_mail' 
                  value='${memberVO.mem_mail }' required="required" style='width: 30%;' placeholder="메일주소">
      </div>
    </div> 

    <div class="form-group">
      <label for="zipcode" class="col-md-2 control-label">우편번호</label>    
      <div class="col-md-10">
      <ul class='list-inline'>
        <li><input type='text' class="form-control input-md" name='mem_zipcode' id='mem_zipcode' 
                   value='${memberVO.mem_zipcode }' required="required" style='width: 100%;' placeholder="우편번호"></li>
        <li><input type="button" onclick="DaumPostcode()" value="우편번호 찾기" class="btn btn-info btn-md"></li>
      </ul>
      </div>
    </div>  

    <div class="form-group">
      <label for="address1" class="col-md-2 control-label">주소</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='mem_addr1' id='mem_addr1' 
                   value='${memberVO.mem_addr1 }' required="required" style='width: 80%;' placeholder="주소">
      </div>
    </div>   

    <div class="form-group">
      <label for="address2" class="col-md-2 control-label">상세 주소</label>    
      <div class="col-md-10">
        <input type='text' class="form-control input-md" name='mem_addr2' id='mem_addr2' 
                   value='${memberVO.mem_addr2 }' required="required" style='width: 80%;' placeholder="상세 주소">
      </div>
    </div>   

    <div class="form-group">
      <div class="col-md-12">

<!-- ----- DAUM 우편번호 API 시작 ----- -->
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('mem_zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('mem_addr1').value = fullAddr;

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#mem_addr2').focus();
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<!-- ----- DAUM 우편번호 API 종료----- -->

      </div>
    </div>
    
    <fieldset>
    <legend><h4>관리자 전용 수정항목</h4></legend>
    <div class="form-group">
      <label for="mname" class="col-md-2 control-label">권한번호</label>    
      <div class="col-md-10">
        <input type='number' class="form-control input-md" name='auth_no' id='auth_no' min='0' max='9' step='1'
                   value='${memberVO.auth_no }' required="required" style='width: 15%;'>
      </div>
    </div>
    
    <div class="form-group">
      <label for="mname" class="col-md-2 control-label">신고당한 횟수</label>    
      <div class="col-md-10">
        <input type='number' class="form-control input-md" name='mem_acc' id='mem_acc' min='0' max='10000' step='1'
                   value='${memberVO.mem_acc }' required="required" style='width: 15%;'>
      </div>
    </div>
    
    <div class="form-group">
      <label for="mname" class="col-md-2 control-label">마일리지</label>    
      <div class="col-md-10">
        <input type='number' class="form-control input-md" name='mem_mile' id='mem_mile' min='0' max='999999999' step='10'
                   value='${memberVO.mem_mile }' required="required" style='width: 15%;'>
      </div>
    </div>
    </fieldset>
    
    <div class="form-group">
      <div class="col-md-offset-2 col-md-10">
        <button type="submit" class="btn btn-primary btn-md">저장</button>
        <button type="button" onclick="history.go(-1);" class="btn btn-primary btn-md">취소</button>

      </div>
    </div>   
  </FORM>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 