<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
  <A href="${pageContext.request.contextPath}/index.do" style="position: relative;"> <IMG
    src='${pageContext.request.contextPath}/menu/images/dawara.jpg' style="position: relative;"></A>
</div>
<div class="content" style="position: relative; display: inline-block; right: 112px;">
  <ul id="sdt_menu" class="sdt_menu">
    <li>
      <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=1" style="background-color: #0099ff;"> <img
        src="${pageContext.request.contextPath}/menu/images/1.png" alt="" /> <span class="sdt_active"></span> <span class="sdt_wrap"> <span
          class="sdt_link" style="position: relative; right: -11px">SAMSUNG</span> <!-- <span class="sdt_descr">Get to know me</span> -->
      </span>
      </a>
      <!--       <div class="sdt_box"> -->
      <%--         <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=1">Product</a> --%>
      <!--       </div> -->
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=2" style="background-color: #1aa3ff;"> <img
        src="${pageContext.request.contextPath}/menu/images/2.png" alt="" /> <span class="sdt_active"></span> <span class="sdt_wrap"> <span
          class="sdt_link" style="position: relative; right: -55px;">LG</span> <!-- 					<span class="sdt_descr">My work</span> -->
      </span>
      </a>
      <!--       <div class="sdt_box"> -->
      <%--         <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=2">Product</a> --%>
      <!--       </div> -->
    </li>
    <li>
      <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=3" style="background-color: #33adff;"> <img
        src="${pageContext.request.contextPath}/menu/images/3.png" alt="" /> <span class="sdt_active"></span> <span class="sdt_wrap"> <span
          class="sdt_link" style="position: relative; right: -35px;">APPLE</span> <!-- 	<span class="sdt_descr">Where ideas get born</span> -->
      </span>
      </a>
      <!--       <div class="sdt_box"> -->
      <%--         <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=3">Product</a> --%>
      <!--       </div> -->
    </li>

<!--     <li> -->
<%--       <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=4" style="background-color: #4db8ff;"> <img --%>
<%--         src="${pageContext.request.contextPath}/menu/images/4.png" alt="" /> <span class="sdt_active"></span> <span class="sdt_wrap"> <span --%>
<!--           class="sdt_link" style="position: relative; right: -55px;">MS</span> <span class="sdt_descr">I like to photograph</span> -->
<!--       </span> -->
<!--       </a> -->
      <!--       <div class="sdt_box"> -->
      <%--         <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=4">Product</a> --%>
      <!--       </div> -->
<!--     </li> -->

    <li>
      <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=4" style="background-color: #4db8ff;"> <img
        src="${pageContext.request.contextPath}/menu/images/4.png" alt="" /> <span class="sdt_active"></span> <span class="sdt_wrap"> <span
          class="sdt_link" style="position: relative; right: -41px;">DELL</span> <!-- 			<span class="sdt_descr">I write about design</span> -->
      </span>
      </a>
      <!--       <div class="sdt_box"> -->
      <%--         <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=5">Product</a> --%>
      <!--       </div> -->
    </li>

    <li>
      <c:choose>
        <c:when test="${sessionScope.mem_id == null}">
          <a href="${pageContext.request.contextPath}/notice/list_all.do" style="background-color: #66c2ff;"> 
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/notice/list_by_notice.do" style="background-color: #66c2ff;"> 
        </c:otherwise>
      </c:choose>
      <img src="${pageContext.request.contextPath}/menu/images/6.png" alt="" /> 
        <span class="sdt_active"></span> 
        <span class="sdt_wrap"> 
          <span class="sdt_link" style="position: relative; left: 32px;">게시판</span> <!-- 			<span class="sdt_descr">I like to code</span> -->
        </span>
      </a>
      <!--       <div class="sdt_box"> -->
      <%--         <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=6">Product</a> --%>
      <!--       </div> -->
      <div class="sdt_box sdt_box2"> 
        <c:choose>
          <c:when test="${sessionScope.mem_id == null}">
            <a href="#" style='color: #cc0;'>로그인 후 이용 가능</a>
<%--             <a href="${pageContext.request.contextPath}/notice/list_all.do">공지사항</a> --%>
<%--             <a href="${pageContext.request.contextPath}/qna/list_all.do">Q & A</a> --%>
<%--             <a href="${pageContext.request.contextPath}/report/list_all.do">신고접수</a> --%>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/notice/list_by_notice.do">공지사항</a>
            <a href="${pageContext.request.contextPath}/qna/list_by_qna.do">Q & A</a>
            <a href="${pageContext.request.contextPath}/report/list_by_report.do">신고접수</a>
          </c:otherwise>
        </c:choose>
      </div>
    </li>

    <li>
      <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=5" style="background-color: #80ccff;"> <img
        src="${pageContext.request.contextPath}/menu/images/5.png" alt="" /> <span class="sdt_active"></span> <span class="sdt_wrap"> <span
          class="sdt_link" style="position: relative; left: 45px;">판매</span> <!-- 			<span class="sdt_descr">I write about design</span> -->
      </span>
      </a>
      <!--       <div class="sdt_box"> -->
      <%--         <a href="${pageContext.request.contextPath}/product/list_by_category.do?gory_no=5">Product</a> --%>
      <!--       </div> -->
      <div class="sdt_box sdt_box2">
        <c:choose>
          <c:when test="${sessionScope.mem_id == null}">
            <a href="#" style='color: #cc0;'>로그인 후 이용 가능</a>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/product/list_mem_no.do">판매하는 물품 확인</a>
            <a href="${pageContext.request.contextPath}/product/list_sell_mem_no.do">판매한 물품 확인</a>
          </c:otherwise>
        </c:choose>
      </div>
    </li>

    <li style="right: -1020px; top: -85px;">
      <a href="#" style="background-color: #99d6ff;"> 
      <img src="${pageContext.request.contextPath}/menu/images/deal.png" alt="" /> 
      <span class="sdt_active"></span> 
      <span class="sdt_wrap"> 
        <span class="sdt_link" style="position: relative; left:45px;">구매</span> <!--      <span class="sdt_descr">I like to code</span> -->
      </span>
      </a>
      <!--       <div class="sdt_box"> -->
      <!--         <a href="#">MSI, ASUS</a> <a href="#">GIGABYTE, ACER</a> <a href="#">HANSUNG</a> <a href="#">LENOVO</a> -->
      <!--       </div> -->
      <div class="sdt_box sdt_box2">
        <c:choose>
          <c:when test="${sessionScope.mem_id == null}">
            <a href="#" style='color: #cc0;'>로그인 후 이용 가능</a>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/product/buy_list.do">내가 구매한 물품 확인</a>
            <a href="${pageContext.request.contextPath}/deal/searchList_paging.do">직거래 내역</a>
            <a href="${pageContext.request.contextPath}/shipping/searchList_by_mem_no_paging.do">택배거래 내역</a>
            <a href="${pageContext.request.contextPath}/payment/searchList_by_mem_no_paging.do">결제 내역</a>
          </c:otherwise>
        </c:choose>
      </div>
    </li>

    <!-- Login -->
    <li style="right: -1020px; top: -85px;">
      <c:choose>
        <c:when test="${sessionScope.mem_id == null}">
          <a href="${pageContext.request.contextPath}/member/login.do" style="background-color: #b3e0ff;"> 
            <img src="${pageContext.request.contextPath}/menu/images/login.png" alt="" /> 
            <span class="sdt_active"></span> 
            <span class="sdt_wrap"> 
              <span class="sdt_link" style="position: relative; left: 40px;">Login</span>
            </span>
          </a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/member/logout.do" style="background-color: #b3e0ff;"> 
            <img src="${pageContext.request.contextPath}/menu/images/logout.png" alt="" /> 
            <span class="sdt_active"></span> 
            <span class="sdt_wrap"> 
              <span class="sdt_link" style="position: relative; left: 33px;">Logout</span>
            </span>
          </a>
        </c:otherwise>
      </c:choose>
      <div class="sdt_box sdt_box2">
        <c:choose>
          <c:when test="${sessionScope.mem_id == null}">
            <A href='${pageContext.request.contextPath}/member/login.do'>Login</A>
            <A href='${pageContext.request.contextPath}/member/confirm.jsp'>회원가입</A>
<%--             <a href="${pageContext.request.contextPath}/notice/list_all.do">공지사항</a> --%>
          </c:when>
          <c:otherwise>
            <c:if test="${sessionScope.auth_no == 1}">
              <A href='${pageContext.request.contextPath}/member/list_by_member.do'><span style='color: #cc0;'>회원 목록</span></A>
              <A href='${pageContext.request.contextPath}/auth/list.do'><span style='color: #cc0;'>권한 목록</span></A>
              <a href="${pageContext.request.contextPath}/auth/list_url.do"><span style='color: #cc0;'>접속URL목록</span></a>
              <a href="${pageContext.request.contextPath}/auth/list_access_url.do"><span style='color: #cc0;'>권한별 접근URL목록</span></a>
              <a href="${pageContext.request.contextPath}/categrp/list.do"><span style='color: #cc0;'>카테고리 그룹</span></a>
            </c:if>
            <A href='${pageContext.request.contextPath}/member/read.do?mem_no=${sessionScope.mem_no}'>내 정보 변경</A>
            <A href='${pageContext.request.contextPath}/member/list_by_login.do?mem_no=${sessionScope.mem_no}'>나의 로그인 내역</A>
            <A href="javascript:void(popupwindow('${pageContext.request.contextPath}/member/passwd_update.do', '_blank', 500, 500))">패스워드 변경</A>
            <A href="javascript:void(popupwindow('${pageContext.request.contextPath}/mileage/charge_m.jsp', '_blank', 420, 355))">마일리지 충전</A>
            <a href="${pageContext.request.contextPath}/mileage/list_by_mileage_search_paging.do">마일리지 충전내역</a>
            <a href="${pageContext.request.contextPath}/product/cart_list.do">장바구니</a>
            
            <A href='${pageContext.request.contextPath}/member/logout.do'>Logout</A>
            <A href='${pageContext.request.contextPath}/member/delete_confirm.jsp?mem_no=${sessionScope.mem_no}''><span style='color: #f00;'>회원탈퇴</span></A>
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


<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/menu/jquery-1.4.3.min.js"></script> --%>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/menu/jquery.easing.1.3.js"></script> --%>
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script> -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
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
												var $sub_menu = $elem.find('.sdt_box');
												if ($sub_menu.length) {
													var left = '170px';/* other */
													var height = '170px';/* other */
													if ($elem.parent().children().length == $elem.index() + 1)
														left = '-170px';/* login */
													$sub_menu.show().animate({
														'left' : left
													}, 300);
												}
												var $sub_menu2 = $elem.find('.sdt_box2');
												if ($sub_menu2.length) {
													var right = '170px';/* other */
                          var height = '170px';/* other */
													if ($elem.parent().children().length == $elem.index() + 1)
														height = 32 * 13; /* login탭 길이 */
													$sub_menu2.show().animate({
														'right' : -right,
														'height' : height
													/* 추가 */
													}, 300); // 나오는 시간(속도)
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
