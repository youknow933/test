<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>DAWARA</title>
<link href="./css/style.css" rel='Stylesheet' type='text/css'>
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
 
<!-- Bootstrap -->
<!-- 부가적인 테마 -->
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
	<DIV class='content'>
  <hr style='color: 3px solid #2772cd;'>

  <DIV style='width: 50%; background-color: #EEEEFF; margin: 20px auto; font-size: 32px; text-align: center;'>
    DAWARA
  </DIV>
  
  <TABLE style='width: 50%; margin: 30px auto; border-collapse: collapse;'>
    <tr>
      <td style='width: 20%;'><img src='./menu/images/1.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/2.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/3.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/4.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/5.png' style='width: 100%; display: block;'></td>
    </tr>
    <tr>
      <td style='width: 20%;'><img src='./menu/images/6.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/7.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/1.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/2.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/3.png' style='width: 100%; display: block;'></td>
    </tr>
    <tr>
      <td style='width: 20%;'><img src='./menu/images/4.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/5.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/6.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/7.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/1.png' style='width: 100%; display: block;'></td>
    </tr>
    <tr>
      <td style='width: 20%;'><img src='./menu/images/2.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/3.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/4.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/5.png' style='width: 100%; display: block;'></td>
      <td style='width: 20%;'><img src='./menu/images/6.png' style='width: 100%; display: block;'></td>
    </tr>
  </TABLE>
  
  <DIV style='margin: 0px auto; width: 90%;'>
    <DIV style='float: left; width: 50%;'>
     </DIV>
     <DIV style='float: left; width: 50%;'>
    </DIV>  
  </DIV>
 
  <DIV style='width: 94.8%; margin: 0px auto;'>
  </DIV>  
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>
  