<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script type="text/javascript">
  $(function(){ 
  
  });
</script>

</head> 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

<DIV class='title_line'>알림</DIV>

<%
ArrayList<String> msgs = (ArrayList<String>)request.getAttribute("msgs");
ArrayList<String> links =(ArrayList<String>)request.getAttribute("links");
%>
<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
    <%
      for (int i=0; i < msgs.size(); i++) {
    %>
        <li class='li_none'><%=msgs.get(i) %></li>
    <%    
      }
    %>
    
    <li class='li_none'>
      <br>
    <%
      for (int i=0; i < links.size(); i++) {
    %>
        <%=links.get(i) %>
    <%    
      }
    %>
    </li>
    </UL>
  </fieldset>

</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 
  
  
  