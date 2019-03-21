<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<!-- <title>택배거래 삭제</title>  -->
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript">
 
</script>
 
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>   
     
  <ASIDE style='float: left;'>
    <A href='../product/list_by_category.do?gory_no=1'>노트북 브랜드 목록</A>
    >  
<%--     <A href='./list_by_mem_no.do?mem_no=${shippingVO.mem_no}'>회원 택배거래 목록</A> --%>
    <A href='./searchList_by_mem_no_paging.do?mem_no=${shippingVO.mem_no}'>회원 택배거래 목록</A>
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
<%--     <A href='./list_by_mem_no.do?mem_no=${shippingVO.mem_no}&keyword=${keyword}'>목록</A> --%>
    <A href='./searchList_by_mem_no_paging.do?mem_no=${shippingVO.mem_no}<%-- &keyword=${keyword} --%>'>목록</A>
 
  </ASIDE> 
  
  <div class='menu_line'></div>
 
  <FORM name='shipping_delete' method='POST' action='./delete.do'>
      <input type='hidden' name='ship_no' value='${shippingVO.ship_no}'>
      <input type="hidden" name="mem_no" value="${shippingVO.mem_no}">
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
      <input type='hidden' name='keyword' id='keyword' value='${param.keyword }'>
      <div class="form-group">   
        <div class="col-md-12" style='text-align: center; margin: 30px;'>
          삭제되는 택배거래 번호: ${shippingVO.ship_no }번 <br><br>
          배송지: (${shippingVO.ship_zipcode}) ${shippingVO.ship_addr1} ${shippingVO.ship_addr2}<!--  --><br><br>
          <!--  -->
          <!--  -->
          <!--  -->
          <!--  -->
          삭제하시겠습니까? 삭제하시면 복구 할 수 없습니다.<br><br>
          <button type = "submit">삭제 진행</button>
          <button type = "button" onclick="location.href='./searchList_by_mem_no_paging.do?keyword=${param.keyword}&searchItem=${param.searchItem}&nowPage=${param.nowPage}'">취소</button>
        </div>
      </div>   
  </FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 
 