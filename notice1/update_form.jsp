<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
 
<%
Connection con = null;              // DBMS 연결   
PreparedStatement pstmt = null; // SQL 실행
ResultSet rs = null;                   // SELECT 결과를 저장
StringBuffer sql = null;              // SQL 저장
int count = 0;                          // 처리된 레코드 갯수
 
String className = "org.gjt.mm.mysql.Driver"; // MySQL 연결 Drvier 
String url = "jdbc:mysql://localhost:3306/javadb?useUnicode=true&characterEncoding=euckr"; 
String user = "root"; 
String pass = "1234";
%>
 
<%
// 수정할 레코드의 pk 컬럼의 값
int noticeno = Integer.parseInt(request.getParameter("noticeno"));
String title = "";
String rname = "";
 
try {
  Class.forName(className); // memory로 클래스를 읽어옴, 객체는 생성하지 않음.
  con = DriverManager.getConnection(url, user, pass); // MySQL 연결
  sql = new StringBuffer();
 
  sql.append(" SELECT noticeno, title, rname, rdate"); // 맨 앞에 공백 한 칸이 있어야함.
  sql.append(" FROM notice");
  sql.append("  WHERE noticeno = ?");
  

  pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
  pstmt.setInt(1, noticeno);
  rs = pstmt.executeQuery(); // SELECT SQL 실행
  
  if(rs.next()){
    title=rs.getString("title");
    rname = rs.getString("rname");
  }


  
} catch (Exception e) {
  e.printStackTrace();
} finally {
  try {
    rs.close();
  } catch (Exception e) { // 하나의 문장을 쓰는 건 하나의 문장을 잡는단 뜻.
  }
  
  try {
    pstmt.close();
  } catch (Exception e) { // 하나의 문장을 쓰는 건 하나의 문장을 잡는단 뜻.
  }
 
  try {
    con.close();
  } catch (Exception e) {
  }
}
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
 
  <form name='frm' action='./update_proc.jsp' method='POST'>
    <input type='hidden' name='noticeno' id='noticeno' value='<%=noticeno%>'>
    
    <fieldset style='width: 70%; margin: 10px auto;'>
      <legend class ='legend_basic'>공지사항 수정</legend>
      <ul>
      <li class= 'li_none'>
          <label for='title'>내용: </label>
          <input type='text' name='title'  id='title' value='<%=title %>' 
                    style = 'width: 80%'>           <!-- id는 javascript에서 씀  -->
        </li>
        <li class= 'li_none'>
          <label for='rname'>성명: </label>
          <input type='text' name='rname'  id='rname' value='<%=rname %>' 
                    style = 'width: 30%'>       
        </li>
 
      </ul>
    </fieldset>
    
    <DIV class='bottom_menu'>
      <button type='submit'>저장</button>
      <button type='button' onclick="location.href='./list.jsp'">취소</button>
    </DIV>    
  </form>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>