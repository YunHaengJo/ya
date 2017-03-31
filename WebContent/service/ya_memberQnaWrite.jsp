<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.Beans.Ya_NoticeBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy-MM-dd", Locale.KOREA );
	Date currentTime = new Date();
	String dTime = formatter.format ( currentTime );
	Ya_MemberBean user = (Ya_MemberBean)session.getAttribute("member");
%>
<!-- Top -->
	<jsp:include page="../super/superTop.jsp"></jsp:include>
	<div class="blank">
	<table>
		<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    	<tr>
    		<td></td>
    		<td colspan="7">________</td>
    		<td></td>
    	</tr>
	</table>
	</div>
	<div class="container">
      <div class="row">
        <div class="col-sm-2">
		<!-- 사이드바 -->
            <div style="border-right: solid 2px #e3ebf7 ; height: 700px;">
            	<h3><b>&nbsp;&nbsp;고객센터</b></h3>
            	<a href="noticeControl.jsp?command=list" id="notice">공지사항</a>
            	<p></p>
     			<p></p>
     			<p align="left" id="qna" style="color: red"><span class="glyphicon glyphicon-chevron-right" style="color: red"></span>1:1문의</p>
            	<p></p>
            </div>
        </div>
        <div class="col-sm-10">
        <!-- 본문-->
        <table style="border: 0; border-collapse:collapse; margin-top: 22px; width: 1240px; height: 100px; background-color: #ededed">
        <col width="50"><col width="400"><col width="100"><col width="350">
        <tr>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        	<td colspan="4" align="left" valign="center" style="border-bottom: 3px solid #a0a0a0; text-align: left;"><h3><b>1:1문의</b></h3></td>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        </tr>
        </table>
         <table height="100px" style="border: 0; table-layout:fixed; width: 1240px; background-color: #ededed">
        <col width="20"><col width="400"><col width="100"><col width="350">
        <tr>
        <td colspan="4" height="20"></td>
        </tr>
       
        <tr>
         <form action="" name="f1">
         <input type="hidden" name="email" value="<%=user.getEmail()%>">
         <input type="hidden" name="command" value="memberlist">
        	<td></td>
        	<td colspan="2">
        	<div class="input-group">
        	<button class="input-group-addon" id="write" style="width: 356px; height: 30px; background-color: white;" onclick="mySubmit(1)">문의하기</button>
            <button class="input-group-addon" style="width: 356px; height: 30px" onclick="mySubmit(2)">나의 문의내역</button>
        	
        	</div>
        	</td>
        	<td></td>
        	</form>
        </tr>
       
        </table>
        <form action="qnaControl.jsp" method="post" name="f2">
        <input type="hidden" name="command" value="register">
        <input type="hidden" name="email" value="<%=user.getEmail()%>">
        <table height="300px" style="border: 0; table-layout:fixed; width: 1240px; background-color: #ededed">
        <col width="50"><col width="400"><col width="100"><col width="350">
        <tr>
        	<td></td>	
        	<td height="5" style="border-bottom: 1px solid #a0a0a0; text-align: left;"><input type="text" class="form-control" placeholder="제목입력" name="title" id="title" style="width: 550px"></td>
        	<td height="5" style="border-bottom: 1px solid #a0a0a0; text-align: left;"><%= dTime%></td>
        	<td></td>	
        </tr>
        <tr>
        	<td></td>
        	<td height="100" colspan="2" valign="top" style="border-bottom: 1px solid #a0a0a0; text-align: left;"><textarea rows="50" cols="400" name="content" id="content" class="form-control" style="width: 690px;height: 280px; color: gray"></textarea></td>
        	<td></td>	
        </tr>
        </table>
        <table height="200px" style="border: 0; table-layout:fixed; width: 1240px; background-color: #ededed">
        <col width="50"><col width="400"><col width="100"><col width="350">
        <tr>
        	<td colspan="4" height="20"></td>
        </tr>
        <tr>
        <td></td>
        <td valign="top"><input type="button" class="form-control" value="문의하기" style="width: 100px; height: 50px" onclick="myVali()"></td>
        <td></td>
        </tr>
        </table>
        </form>
        
       </div>
       </div>
       </div>
       <script>
        	function mySubmit(index){
        		if(index == 1){
        			document.f1.action = 'ya_memberQnaWrite.jsp';
        		}
        		if(index == 2){
        			document.f1.action = 'qnaControl.jsp';
        		}
        		document.f1.submit();
        	}
        	function myVali(){
        		if(document.getElementById("title").value=="" || document.getElementById("title").value== null){
        			alert("제목을 입력해주세요 !!");
        			return;
        		}
        		if(document.getElementById("content").value=="" || document.getElementById("content").value== null){
        			alert("내용을 입력해주세요 !!");
        			return;
        		}
        		document.f2.submit();
        		
        	}
        </script>	
      
<!--Foot -->
	<jsp:include page="../super/superFoot.jsp"></jsp:include>
</body>
</html>


