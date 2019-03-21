<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
  String root = request.getContextPath();
			// 			out.println("root: " + root);
%>

<%-- <link href="<%=root%>/css/style.css" rel='Stylesheet' type='text/css'> --%>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script> -->
<!-- Bootstrap -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->

<style>
body {
  background: #333;
  background-color: #ffffff;
  font-family: Arial;
}

span.reference {
  position: fixed;
  left: 10px;
  bottom: 10px;
  font-size: 12px;
}

span.reference a {
  color: #aaa;
  text-transform: uppercase;
  text-decoration: none;
  text-shadow: 1px 1px 1px #000;
  margin-right: 30px;
}

span.reference a:hover {
  color: #ddd;
}

ul.sdt_menu {
  margin-top: 100px;
}

h1.title {
  text-indent: -9000px;
  background: transparent url(title.png) no-repeat top left;
  width: 633px;
  height: 69px;
}
</style>
<br>
<br>
<div style='margin: 0 auto; text-align: center;'>
  <!-- Dawara사진 -->
  <A href="<%=root%>/index.do" style="position: relative;"><IMG src='<%=root%>/menu/images/dawara.jpg' style="position: relative;"></A>
</div>
<div class="content" style="position: relative; display: inline-block;">
  <ul id="sdt_menu" class="sdt_menu">
    <li>
      <a href="<%=root%>/product/list_by_category.do?gory_no=1" style="background-color: #0099ff;"> <img src="<%=root%>/menu/images/1.png" alt="" />
        <span class="sdt_active"></span> 
        <span class="sdt_wrap"> <span class="sdt_link" style="position: relative; ">노트북</span>
        <span class="sdt_descr">Get to know me</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="<%=root%>/product/list_by_category.do?gory_no=1">SAMSUNG</a>
        <a href="<%=root%>/product/list_by_category.do?gory_no=1">LG</a>
        <a href="<%=root%>/product/list_by_category.do?gory_no=1">APPLE</a>
        <a href="<%=root%>/product/list_by_category.do?gory_no=1">DELL</a>
        <a href="<%=root%>/product/list_by_category.do?gory_no=1">MS</a>
      </div>
    </li>
    <li>
      <a href="<%=root%>/product/list_by_category.do?gory_no=2" style="background-color: #1aa3ff;"> <img src="<%=root%>/menu/images/2.png" alt="" />
        <span class="sdt_active"></span> <span class="sdt_wrap"> <span class="sdt_link" style="position: relative; ">게시판</span> 
				<span class="sdt_descr">My work</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="<%=root%>/product/list_by_category.do?gory_no=2">공지사항</a>
        <a href="<%=root%>/product/list_by_category.do?gory_no=2">QnA</a>
        <a href="<%=root%>/product/list_by_category.do?gory_no=2">Report</a>
      </div>
    </li>
    <li>
      <a href="<%=root%>/product/list_by_category.do?gory_no=3" style="background-color: #33adff;"> <img src="<%=root%>/menu/images/3.png" alt="" />
        <span class="sdt_active"></span> <span class="sdt_wrap"> <span class="sdt_link" style="position: relative; ">판매자</span>
      	<span class="sdt_descr">Where ideas get born</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="<%=root%>/product/list_by_category.do?gory_no=3">판매중인 상품</a>
        <a href="<%=root%>/product/list_by_category.do?gory_no=3">판매완료된 상품</a>
      </div>
    </li>
    
    <li>
      <a href="<%=root%>/product/list_by_category.do?gory_no=4" style="background-color: #4db8ff;"> <img src="<%=root%>/menu/images/4.png" alt="" />
        <span class="sdt_active"></span> <span class="sdt_wrap"> <span class="sdt_link" style="position: relative; ">구매자</span> 
        <span class="sdt_descr">I like to photograph</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="<%=root%>/product/list_by_category.do?gory_no=4">구매중인 상품</a>
        <a href="<%=root%>/product/list_by_category.do?gory_no=4">구매한 상품</a>
        <a href="<%=root%>/product/list_by_category.do?gory_no=4">결제 내역</a>
      </div>
    </li>
    
    <li>
      <a href="<%=root%>/product/list_by_category.do?gory_no=5" style="background-color: #66c2ff;"> <img src="<%=root%>/menu/images/5.png" alt="" />
        <span class="sdt_active"></span> <span class="sdt_wrap"> <span class="sdt_link" style="position: relative; ">마일리지</span> 
  			<span class="sdt_descr">I write about design</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="<%=root%>/product/list_by_category.do?gory_no=5">충전내역</a>
        <a href="<%=root%>/product/list_by_category.do?gory_no=5">사용내역</a>
      </div>
    </li>

<!--     <li> -->
<%--       <a href="<%=root%>/product/list_by_category.do?gory_no=6" style="background-color: #80ccff;"> <img src="<%=root%>/menu/images/6.png" alt="" /> --%>
<!--         <span class="sdt_active"></span> <span class="sdt_wrap"> <span class="sdt_link" style="position: relative;">HP</span> 			<span class="sdt_descr">I like to code</span> -->
<!--       </span> -->
<!--       </a> -->
<!--       <div class="sdt_box"> -->
<%--         <a href="<%=root%>/product/list_by_category.do?gory_no=6">Product</a> --%>
<!--       </div> -->
<!--     </li> -->

<!--     <li style="right: -1020px; top: -85px;"> -->
<%--       <a href="#" style="background-color: #99d6ff;"> <img src="<%=root%>/menu/images/7.png" alt="" /> <span class="sdt_active"></span> <span --%>
<!--         class="sdt_wrap"> <span class="sdt_link" style="position: relative; right: -54px;">etc</span>      <span class="sdt_descr">I like to code</span> -->
<!--       </span> -->
<!--       </a> -->
<!--       <div class="sdt_box"> -->
<!--         <a href="#">MSI, ASUS</a> <a href="#">GIGABYTE, ACER</a> <a href="#">HANSUNG</a> <a href="#">LENOVO</a> -->
<!--       </div> -->
<!--     </li> -->

    <!-- Login -->
    <li>
      <a href="${pageContext.request.contextPath}/member/login.do" style="background-color: #b3e0ff;"> <img src="<%=root%>/menu/images/login.png"
        alt="" /> <span class="sdt_active"></span> <span class="sdt_wrap"> <span class="sdt_link" style="position: relative; ">회원</span>
      </span>
      </a>
      <div class="sdt_box sdt_box2">
        <c:choose>
          <c:when test="${sessionScope.mem_id == null}">
            <A href='${pageContext.request.contextPath}/member/login.do'>Login</A>
            <A href='<%=root%>/member/confirm.jsp'>회원 가입</A>
            <a href="<%=root%>/notice/list_all.do">Notice</a>
          </c:when>
          <c:otherwise>
            <A href='<%=root %>/member/read.do?mem_no=${sessionScope.mem_no}'>내 정보 변경</A>
            <A href="javascript:void(popupwindow('<%=root%>/member/passwd_update.do', '_blank', 500, 500))">패스워드 변경</A>
            <c:if test="${sessionScope.auth_no == 1 or sessionScope.auth_no == 2 }">
              <A href='<%=root%>/member/list_by_member.do'>회원 목록</A>
              <a href="<%=root%>/auth/list_search_paging.do">Auth</a>
              <a href="<%=root%>/urlauth/list_search_paging.do">URLAuth</a>
            </c:if>
            <A href='<%=root %>/member/list_by_login.do?mem_no=${sessionScope.mem_no}'>나의 로그인 내역</A>
<%--             <a href="<%=root%>/notice/list_all.do">Notice</a> --%>
<%--             <a href="<%=root%>/categrp/list.do">Categrp</a> --%>
<%--             <a href="<%=root%>/category/list.do">Category</a> --%>
<%--             <a href="<%=root%>/product/list_mem_no.do">판매하는 물품 확인</a> --%>
<%--             <a href="<%=root%>/product/list_sell_mem_no.do">판매한 물품 확인</a> --%>
            <a href="<%=root%>/product/cart_list.do">장바구니</a>
<%--             <a href="<%=root%>/product/buy_list.do">내가 구매한 물품 확인</a> --%>
            <a href="<%=root%>/deal/searchList_paging.do">Deal list</a>
            <a href="<%=root%>/shipping/searchList_by_mem_no_paging.do">Shipping list</a>
            <a href="<%=root%>/payment/searchList_by_mem_no_paging.do">Payment list</a>
            <a href="<%=root%>/mileage/list_by_mileage.do">마일리지 내역</a>
            <A href="javascript:void(popupwindow('<%=root%>/mileage/charge_m.jsp', '_blank', 420, 355))">마일리지충전소</A>
            <A href='${pageContext.request.contextPath}/member/logout.do'>Logout</A>
            <A href='<%=root %>/member/delete_confirm.jsp?mem_no=${sessionScope.mem_no}''><span style='color: #f00;'>회원탈퇴</span></A>
            <script>
              function popupwindow(url, title, w, h) {
            	  var left = (screen.width/2)-(w/2);
            	  var top = (screen.height/2)-(h/2);
            	  return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
            	} 
            </script>
          </c:otherwise>
        </c:choose>
      </div>
    </li>
  </ul>

</div>

<!-- The JavaScript -->
<script src="<%=root%>/menu/jquery-1.4.3.min.js"></script>
<script src="<%=root%>/menu/jquery.easing.1.3.js"></script>
<script>
	$(function() {
		$('#sdt_menu > li')
				.bind(
						'mouseenter',
						function() {
							var $elem = $(this);
							$elem
									.find('img')
									.stop(true)
									.animate({
										'width' : '170px',
										'height' : '170px',/* top menu 오버시 뜨는 위의 흰부분 높이 */
										'left' : '0px'
									}, 400, 'easeOutBack')
									.andSelf()
									.find('.sdt_wrap')
									.stop(true)
									.animate({
										'top' : '140px'
									}, 500, 'easeOutBack')
									.andSelf()
									.find('.sdt_active')
									.stop(true)
									.animate(
											{
												'height' : '170px'/* top menu 오버시 뜨는 밑의 흰부분 높이 */
											},
											300,
											function() {
												var $sub_menu = $elem
														.find('.sdt_box');
												if ($sub_menu.length) {
													var left = '170px';/* other */
													var height = '170px';/* other */
													if ($elem.parent()
															.children().length == $elem
															.index() + 1)
														left = '-170px';/* login */
													$sub_menu.show().animate({
														'left' : left,
													}, 200);
												}
												/*  */
												var $sub_menu2 = $elem
														.find('.sdt_box2');
												if ($sub_menu2.length) {
													var left = '170px';/* other */
													// 													var right = '170px';/* other */
													// 													var top = '255px';/* other */
													// 													var height = '500px';/* 검정부분 길이 */
													if ($elem.parent()
															.children().length == $elem
															.index() + 1)
														height = 35 * 14; /* login */
													$sub_menu2.show().animate({
														'left' : -left,
														// 														'right' : right,
														// 														'top' : top,
														'height' : height
													/* 추가 */
													}, 500); // 나오는 시간(속도)
													// 													console.log('height: '+ height)
													// 													console.log('$elem.parent().children().: '+ $elem.parent().children().length)
													// 													console.log('$elem.index(): '+ $elem.index())
												}
												/*  */
											});
						}).bind('mouseleave', function() {
					var $elem = $(this);
					var $sub_menu = $elem.find('.sdt_box');
					if ($sub_menu.length)
						$sub_menu.hide().css('left', '0px');
					// 추가 start
					var $sub_menu2 = $elem.find('.sdt_box2');
					if ($sub_menu.length & $sub_menu2.length) {
						$sub_menu2.hide().css('bottom', '0px');
						$sub_menu2.hide().css('height', '0px');
					} // 추가 end
					$elem.find('.sdt_active').stop(true).animate({
						'height' : '0px'
					}, 300).andSelf().find('img').stop(true).animate({
						'width' : '0px',
						'height' : '0px',
						'left' : '85px'
					}, 400).andSelf().find('.sdt_wrap').stop(true).animate({
						'top' : '25px'
					}, 500);
				});
	});
</script>
