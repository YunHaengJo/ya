<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
Date currentTime = new Date();
String dTime = formatter.format ( currentTime );
	String seq = request.getParameter("seq");
	String email = request.getParameter("email");
	System.out.println("seqseqseq : " + seq);
	System.out.println("email email : " + email);
%>

<form action="qnaControl.jsp" method="post">
        <input type="hidden" name="command" value="answer">
        <input type="hidden" name="seq" value="<%=seq%>">
        <input type="hidden" name="email" value="<%=email%>">
        <table height="300px" style="border: 0; table-layout:fixed; width: 1240px; background-color: #ededed">
        <col width="50"><col width="400"><col width="100"><col width="350">
        <tr>
        	<td></td>	
        	<td height="5" style="border-bottom: 1px solid #a0a0a0; text-align: left;"><input type="text" class="form-control" placeholder="제목입력" name="title" style="width: 550px"></td>
        	<td height="5" style="border-bottom: 1px solid #a0a0a0; text-align: left;"><%= dTime%></td>
        	<td></td>	
        </tr>
        <tr>
        	<td></td>
        	<td height="100" colspan="2" valign="top" style="border-bottom: 1px solid #a0a0a0; text-align: left;"><textarea rows="50" cols="400" name="content" class="form-control" style="width: 690px;height: 280px; color: gray"></textarea></td>
        	<td></td>	
        </tr>
        </table>
        <table height="300px" style="border: 0; table-layout:fixed; width: 1240px; background-color: #ededed">
        <col width="50"><col width="400"><col width="100"><col width="350">
        <tr>
        	<td colspan="4" height="20"></td>
        </tr>
        <tr>
        <td></td>
        <td valign="top"><input type="button" class="form-control" value="목록" style="width: 100px; height: 50px" onclick="history.back();"></td>
        <td valign="top"><input type="submit" class="form-control" value="답변하기" style="width: 100px; height: 50px"></td>
        <td></td>
        </tr>
        </table>
        </form>