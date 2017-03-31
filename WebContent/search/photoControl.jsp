<%@page import="com.Beans.Ya_ImgBean"%>
<%@page import="java.util.List"%>
<%@page import="com.Dao.MotelDao"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%!//
//%>
<%//
MotelDao dao = MotelDao.getInstance();
String motelNum = request.getParameter("motelNum");
System.out.println("모텔넘버 포토 컨트롤  " + motelNum);
String str = request.getParameter("str");
List<Ya_ImgBean> list =  dao.do_detail_photo(Integer.parseInt(request.getParameter("motelNum")));
request.setAttribute("list", list);

pageContext.forward("detailPhoto.jsp?motelNum="+motelNum+"&str="+str);
//%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script>
</script>
<style>
</style>
</head>
<body>
</body>
</html>