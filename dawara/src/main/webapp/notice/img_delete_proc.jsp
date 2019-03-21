<%@page import="java.util.StringTokenizer"%>
<%@page import="nation.web.tool.Tool"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/plain; charset=UTF-8" %>
<%
String file = request.getParameter("file");

//System.out.println(file);
%>

<%
String upDir = Tool.getRealPath(request, "/notice/storage");
file = upDir + file;

//System.out.println(upDir);
//System.out.println("file: " + file);

Tool.deleteFile(file);
/* 
StringTokenizer thumbs_st = new StringTokenizer(file, "/");  // Thumbs
while(thumbs_st.hasMoreTokens()) { // 단어가 있는지 검사
  thumb_file = upDir + thumbs_st.nextToken(); // 단어 추출
  Tool.deleteFile(thumb_file);
} */


String[] splitData = file.split("\\.");
String fileType = splitData[(splitData.length)-1];
//System.out.println("fileType: " + fileType);
String thumb_fileType = "_t." + fileType;

String thumb_file = "";


file = file.replace("."+fileType, thumb_fileType);      // file = 원본파일_t.fileType
//System.out.println("치환 후 file: " + file);


thumb_file = file;

//System.out.println("upDir: " + upDir);
//System.out.println("thumb_file: " +thumb_file);

Tool.deleteFile(thumb_file);
%>
