<%@ page contentType="text/html; charset=UTF-8"%>

<%
  String root = request.getContextPath();
			// out.println("root: " + root);
%>

<div class="content" style="position: relative; display: inline-block; right: 112px;">
  <ul id="sdt_menu" class="sdt_menu">
    <li>
      <a href="#"> <img src="<%=root%>/menu/images/1.png" alt="" /> <span class="sdt_active"></span>
        <span class="sdt_wrap"> <span class="sdt_link"
          style="position: relative; right: -11px">SAMSUNG</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="#">Product</a>
      </div>
    </li>

    <li>
      <a href="#"> <img src="<%=root%>/menu/images/2.png" alt="" /> <span class="sdt_active"></span>
        <span class="sdt_wrap"> <span class="sdt_link"
          style="position: relative; right: -55px;">LG</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="#">Product</a>
      </div>
    </li>

    <li>
      <a href="#"> <img src="<%=root%>/menu/images/3.png" alt="" /> <span class="sdt_active"></span>
        <span class="sdt_wrap"> <span class="sdt_link"
          style="position: relative; right: -35px;">APPLE</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="#">Product</a>
      </div>
    </li>

    <li>
      <a href="#"> <img src="<%=root%>/menu/images/4.png" alt="" /> <span class="sdt_active"></span>
        <span class="sdt_wrap"> <span class="sdt_link"
          style="position: relative; right: -55px;">MS</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="#">Product</a>
      </div>
    </li>

    <li>
      <a href="#"> <img src="<%=root%>/menu/images/5.png" alt="" /> <span class="sdt_active"></span>
        <span class="sdt_wrap"> <span class="sdt_link"
          style="position: relative; right: -41px;">DELL</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="#">Product</a>
      </div>
    </li>

    <li>
      <a href="#"> <img src="<%=root%>/menu/images/6.png" alt="" /> <span class="sdt_active"></span>
        <span class="sdt_wrap"> <span class="sdt_link"
          style="position: relative; right: -55px;">HP</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="#">Product</a>
      </div>
    </li>

    <li style="right: -1020px; top: -85px;">
      <a href="#"> <img src="<%=root%>/menu/images/7.png" alt="" /> <span class="sdt_active"></span>
        <span class="sdt_wrap"> <span class="sdt_link"
          style="position: relative; right: -54px;">etc</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="#">MSI, ASUS</a> <a href="#">GIGABYTE, ACER</a> <a href="#">HANSUNG</a> <a href="#">LENOVO</a>
      </div>
    </li>

    <li style="right: -1020px; top: -85px;">
      <a href="#"> <img src="<%=root%>/menu/images/login.png" alt="" /> <span
        class="sdt_active"></span> <span class="sdt_wrap"> <span class="sdt_link"
          style="position: relative; right: -38px;">Login</span>
      </span>
      </a>
      <div class="sdt_box">
        <a href="#">Login</a> <a href="<%=root%>/categrp/list.do">Categrp</a>
      </div>
    </li>
  </ul>
</div>

<div style='height: 112px; width: 100%; border-bottom: 3px solid #2772cd;'></div>

<!-- The JavaScript -->
<script type="text/javascript" src="<%=root%>/menu/jquery-1.4.3.min.js"></script>
<script type="text/javascript" src="<%=root%>/menu/jquery.easing.1.3.js"></script>
<script type="text/javascript">
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
										'height' : '170px',
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
												'height' : '170px'
											},
											300,
											function() {
												var $sub_menu = $elem
														.find('.sdt_box');
												if ($sub_menu.length) {
													var left = '170px';
													if ($elem.parent()
															.children().length == $elem
															.index() + 1)
														left = '-170px';
													$sub_menu.show().animate({
														'left' : left
													}, 200);
												}
											});
						}).bind('mouseleave', function() {
					var $elem = $(this);
					var $sub_menu = $elem.find('.sdt_box');
					if ($sub_menu.length)
						$sub_menu.hide().css('left', '0px');

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