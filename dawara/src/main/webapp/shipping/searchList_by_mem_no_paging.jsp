<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

<SCRIPT>
  $(function() {
    $("input").focus(function(){
        $(this).css("background-color", "#cccccc");
    });
    $("input").blur(function(){
        $(this).css("background-color", "#ffffff");
    });
    
    if($('#keyword').val() != null){
      $('#keyword').focus().select();
    }
    
    if('${param.searchItem}' == '통합검색'){
      $("#all").prop("checked", "checked")
    } else if('${param.searchItem}' == '배송지'){
        $("#ship_addr").attr("checked", "checked")
    } else if('${param.searchItem}' == '받는사람'){
        $("#ship_rname").attr("checked", "checked")
    } else if('${param.searchItem}' == '연락처'){
        $("#ship_rtel").attr("checked", "checked")
    } else if('${param.searchItem}' == '등록일'){
        $("#ship_date").attr("checked", "checked")
    } else if('${param.searchItem}' == '배송여부'){
        $("#ship_check").attr("checked", "checked")
    }
  });
  
//   function payRange(step) {
// 	    var settingDate = new Date();

// 	    settingDate.setMonth(settingDate.getMonth()-step,1);
// 	    $("#s_date").val(dateToYYYYMMDD(settingDate));
// 	    settingDate.setMonth(settingDate.getMonth()+1,0);
// 	    $("#e_date").val(dateToYYYYMMDD(settingDate));
// 	}
  
</SCRIPT>
<style type="text/css">

.h2underline {
    line-height: 48px; border-bottom: 2px solid #383838;
}

.searchbox {
    overflow: hidden;
    background: #faf8fb;
    border: 5px solid #dddddd;
    margin-top: 35px;
    padding: 25px 30px;
}

.searchbox .bloc {
    display: inline-block;
    height: 34px;
    line-height: 34px;
}

.searchbox .bloc .tit {
    display: inline-block;
    width: 500px;
    font-weight: 600;
}

.searchbox .right_area {
    float: right;
    width: 400px;
    margin: 0;
}

.btn_m03 {
    display: inline-block;
    color: #FFFFFF;
    font-weight: 600;
    background: #768393;
    border: 1px solid #6e7683;
    border-radius: 2px;
    padding: 0px 30px;
    height: 33px;
}

.btn_m03:hover {
    color: rgb(255, 255, 255);
    background: rgb(110, 118, 131);
    text-decoration: none;
}

.searchbox .right_area input {
    vertical-align: top;
    height: 33px;
}

.w240 {
    width: 240px !important;
}

.searchbox .btn_m03 .icon {
    display: inline-block;
    width: 23px;
    height: 16px;
    background: url(https://www.unicro.co.kr/webasp_common/new_images/common/uni_sprites.png) no-repeat -40px -30px;
    cursor: pointer;
}

.fr {
    float: right;
}

.searchbox .bloc label {
    margin-right: 5px;
}

</style>
  
</head>
<body>
<DIV class='container'>
<%-- <jsp:include page="/menu/top.jsp" flush='false' /> --%>
<c:import  url="/menu/top.do" />
<DIV class='content'>

  <c:choose>
    <c:when test="${sessionScope.mem_no eq '' or sessionScope.mem_no eq null}">
      <H2 class="h2underline">모든 택배거래 목록(관리자)</H2>
    </c:when>
    <c:otherwise>
      <H2 class="h2underline">${sessionScope.mem_id }(${sessionScope.mem_name })님의 택배거래 목록</H2>
    </c:otherwise>
  </c:choose>
  
  <div style='clear: both;'>
    <aside style='float: left;'>
<%--       <a href="../product/list_by_category.do?gory_no=${param.gory_no }">판매 목록</a><!-- 개발 중 . . . --> --%>
      <a href="../product/list_by_category.do?gory_no=1">판매 목록</a><!-- 개발 중 . . . -->
      >
<%--       <a href="./list_by_mem_no.do?mem_no=${param.mem_no }">택배거래 목록</a> --%>
      <c:choose>
        <c:when test="${sessionScope.mem_no eq '' or sessionScope.mem_no eq null}">
          <a href="./searchList_by_mem_no_paging.do">모든 택배거래 목록(관리자)</a>
        </c:when>
        <c:otherwise>
          <a href="./searchList_by_mem_no_paging.do">회원 택배거래 목록</a>
        </c:otherwise>
      </c:choose>
      
      <!-- 검색 -->
      <c:if test="${param.keyword.length() > 0}">
        >
        [${searchItem}] '${keyword}' 검색결과: ${search_count }건
      </c:if>
    </aside>
    <aside style='float: right;'>
      <a href="./searchList_by_mem_no_paging.do">전체 보기</a>
    </aside>
  </div>
  
  <form name="list" id="list" method ='GET' action="./searchList_by_mem_no_paging.do" >
    <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
    
    <div class="searchbox">
      <div class="bloc">
        <span class="tit">
          <input type="radio" id="all" name="searchItem" value="통합검색" checked="checked">
          <label for="all">통합검색</label>
          <input type="radio" id="ship_addr" name="searchItem" value="배송지">
          <label for="ship_addr">배송지</label> 
          <input type="radio" id="ship_rname" name="searchItem" value="받는사람">
          <label for="ship_rname">받는사람</label>
          <input type="radio" id="ship_rtel" name="searchItem" value="연락처">
          <label for="ship_rtel">연락처</label>
          <input type="radio" id="ship_date" name="searchItem" value="등록일">
          <label for="ship_date">등록일</label>
          <input type="radio" id="ship_check" name="searchItem" value="배송여부">
          <label for="ship_check">배송여부</label>
        </span> 
      </div>
      <div class="bloc right_area">
        <c:choose>
          <c:when test="keyword == null or keyword == '' ">
            <input type="text" class="w240" name="keyword" id="keyword" value="" placeholder="검색어" size="8" >
          </c:when>
          <c:otherwise>
            <input type="text" class="w240" name="keyword" id="keyword" value="${keyword}" placeholder="검색어" size="8" >
          </c:otherwise>
        </c:choose>
        <button type="submit" class="btn_m03 fr"><span class="icon"></span>검 색</button>
      </div>  
    </div>
  </form>
  
  <TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 15%;'/>
    <col style='width: 35%;'/>
    <col style='width: 5%;'/>
    <col style='width: 5%;'/>
    <col style='width: 4%;'/>
    <col style='width: 4%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>ship_no</TH>
    <TH style='text-align: center ;'>pr_no</TH>
    <TH style='text-align: center ;'>mem_no</TH>
    <TH style='text-align: center ;'>등록일</TH>
    <TH style='text-align: center ;'>받는 사람</TH>
    <TH style='text-align: center ;'>연락처</TH>
    <TH style='text-align: center ;'>배송지</TH>
    <TH style='text-align: center ;'>배송여부</TH>
    <TH style='text-align: center ;'>상세보기</TH>
    <TH style='text-align: center ;'>수정</TH>
    <TH style='text-align: center ;'>삭제</TH>
  </TR>
  </thead>
  <tbody>
    <c:forEach var="ShippingVO" items="${list }">
      <TR>
        <TD style='text-align: center ;'>${ShippingVO.ship_no }</TD>
        <TD style='text-align: center ;'>${ShippingVO.pr_no }</TD>
        <TD style='text-align: center ;'><em class="fieldName">${ShippingVO.mem_no}</em></TD>
        <TD style='text-align: center ;'>${ShippingVO.ship_date.substring(0, 10) }</TD>
        <TD style='text-align: center ;'>${ShippingVO.ship_rname }</TD>
        <TD style='text-align: center ;'>${ShippingVO.ship_rtel }</TD>
        <TD>
          <A href="./read.do?ship_no=${ShippingVO.ship_no }&keyword=${param.keyword}&searchItem=${param.searchItem}&nowPage=${param.nowPage}">(${ShippingVO.ship_zipcode }) ${ShippingVO.ship_addr1 } ${ShippingVO.ship_addr2 } </A>
        </TD>
        <TD style='text-align: center ;'>${ShippingVO.ship_check }</TD>
        <!-- ajax 구현시 제거 -->
        <TD style='text-align: center;'>
          <A href="./read.do?ship_no=${ShippingVO.ship_no }&keyword=${param.keyword}&searchItem=${param.searchItem}&nowPage=${param.nowPage}"><span class="glyphicon glyphicon-fullscreen"></span></A>
        </TD>
        <TD style='text-align: center;'>
          <A href="./update.do?ship_no=${ShippingVO.ship_no }&keyword=${param.keyword}&searchItem=${param.searchItem}&nowPage=${param.nowPage}"><span class="glyphicon glyphicon-edit"></span></A>
        </TD>
        <TD style='text-align: center;'>
          <A href="./delete.do?ship_no=${ShippingVO.ship_no }&keyword=${param.keyword}&searchItem=${param.searchItem}&nowPage=${param.nowPage}"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>
        <!-- ajax 구현시 제거 -->
        <!-- ajax 구현시 주석제거 -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:read(${ShippingVO.ship_no })"><span class="glyphicon glyphicon-fullscreen"></span></A> --%>
<!--         </TD> -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:update(${ShippingVO.ship_no })"><span class="glyphicon glyphicon-edit"></span></A> --%>
<!--         </TD> -->
<!--         <TD style='text-align: center;'> -->
<%--           <A href="javascript:deleteOne(${ShippingVO.ship_no })"><span class="glyphicon glyphicon-trash"></span></A> --%>
<!--         </TD> -->
        <!-- ajax 구현시 주석제거 -->
      </TR>
    </c:forEach>
  </tbody>
</TABLE>

<DIV class='bottom_menu'>${paging }</DIV> <!-- 페이지 목록 출력 -->
<br><br>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
</html>
