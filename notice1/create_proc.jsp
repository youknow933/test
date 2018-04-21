<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
 
<% 
request.setCharacterEncoding("utf-8"); /*한글깨짐방지  */
%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
  
  <fieldset style='width: 70%; margin: 10px auto;'>
    <legend class='legend_basic'>공지사항 등록</legend>
    <ul>
    <%
 
    
    Connection con = null;              // DBMS 연결
    PreparedStatement pstmt = null; // SQL 실행
    StringBuffer sql = null;              // SQL 문장 저장
    int count = 0;                         // 처리된 레코드 갯수
   
    String className = "org.gjt.mm.mysql.Driver"; // MySQL 연결 Drvier 
    String url = "jdbc:mysql://localhost:3306/javadb?useUnicode=true&characterEncoding=euckr"; 
    String user = "root"; 
    String pass = "1234";
    String title = request.getParameter("title");
    String rname = request.getParameter("rname");
    
    try {
      Class.forName(className); // memory로 클래스를 로딩함, 객체는 생성하지 않음.
      con = DriverManager.getConnection(url, user, pass); // MySQL 연결
      sql = new StringBuffer();
      
      sql.append(" INSERT INTO notice(title, rname, rdate)");
      sql.append(" VALUES(?,?, now())");
      
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1,  title);
      pstmt.setString(2,  rname);
      
      count = pstmt.executeUpdate();
      
      if (count == 1) {
      %>
        <li class='li_none'>등록처리에 성공했습니다.</li>
      <%
      } else {
        %>
        <li class='li_none'>등록처리에 실패했습니다.</li>
        <li class='li_none'>다시한번 시도해주세요.</li>
      <%
      }
 
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try{
        if (pstmt != null){ pstmt.close(); }
      }catch(Exception e){ }
 
      try{
        if (con != null){ con.close(); }
      }catch(Exception e){ }
    }
    
    %>
    </ul>
  </fieldset>
      
  <DIV style='margin: 30px auto; text-align: center; background-color: #FFFFFF'>
    <button type='button' onclick="location.href='./create_form.jsp'">계속 등록</button>
    <button type='button' onclick="location.href='./list.jsp'">목록</button>
  </DIV>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>