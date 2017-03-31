<%@page import="java.util.ArrayList"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
ArrayList<Object> list = (ArrayList<Object>)request.getAttribute("list");
String pageNumStr = (request.getAttribute("pageNum")==null||request.getAttribute("pageNum")=="")?"1":(String)request.getAttribute("pageNum");
String pageSizeStr = (request.getAttribute("pageSize")==null||request.getAttribute("pageSize")=="")?"1":(String)request.getAttribute("pageSize");
String search_div = (request.getAttribute("search_div")==null||request.getAttribute("search_div")=="")?"":(String)request.getAttribute("search_div");
String search_word = (request.getAttribute("search_word")==null||request.getAttribute("search_word")=="")?"":(String)request.getAttribute("search_word");
Ya_MemberBean user = (Ya_MemberBean)session.getAttribute("member");


/* System.out.println("리스트으으으으 :  " + list.get(0).toString());
System.out.println("페이지너어어어엄 : " + pageNumStr);
System.out.println("페이지싸이즈으으으 : " + pageSizeStr);
System.out.println("써치다이이이브 : " + search_div);
System.out.println("써치워어어어드 : " + search_word); */
%>
</head>
<body>
<table style="border: 0; border-collapse:collapse; margin-top: 22px; width: 1000px; height: 100px; background-color: #ededed">
        <col width="50"><col width="400"><col width="100"><col width="350">
        <tr>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        	<td colspan="4" align="left" valign="center" style="border-bottom: 3px solid #a0a0a0; text-align: left;"><h3><b>회원 승인내역</b></h3></td>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        </tr>
        </table>
        
        <table style="border: 0; border-collapse:collapse;  width: 1000px; height: 550px; background-color: #ededed">
        <col width="50"><col width="400"><col width="100"><col width="350">
        <%if(null != list && list.size() > 0){%>
        	<tr>
        		<td></td>
        		<td style="text-align: left;">EMAIL</td>
        		<td>회원승인</td>
        		<td></td>
        	</tr>
        <%for(int i=0; i<list.size(); ++i){ %>
        <tr>
        	<td></td>
        	<td style="border-bottom: 1px solid #a0a0a0; height: 10; text-align: left;"><a href="mypage_Control.jsp?command=detail&email=<%=((Ya_MemberBean)list.get(i)).getEmail()%>"><%=((Ya_MemberBean)list.get(i)).getEmail() %></a></td>
        	<td style="border-bottom: 1px solid #a0a0a0; height: 10; text-align: left;"><a href="mypage_Control.jsp?command=detail&email=<%=((Ya_MemberBean)list.get(i)).getEmail()%>">승인하기</a></td>
        	<td></td>
        </tr>
        	<%}
        }else{%>
        	<tr style="text-align: center">
        	<td></td>
        	<td colspan="2">검색된 글이 없습니다.<td>	
        	<td></td>
        	</tr>
        <%}
        	%>
        <tr>
        	<td></td>
        	<td colspan="2" style="height: 20px;">
        	<% 
        	if(null != list && list.size() > 0){
        		int pageNum = Integer.parseInt(pageNumStr);
        		int pageSize = Integer.parseInt(pageSizeStr);
        		int tot_cnt = ((Ya_MemberBean)list.get(0)).getTot_cnt();
        		
        		int pageCnt = (tot_cnt%pageSize)==0 ? tot_cnt/pageSize : tot_cnt/pageSize +1;
        		System.out.println(pageSize);
        		
        		
        		if(pageNum == 1){%>
        			<span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px; visibility: hidden;"></span>
        		<%	for(int i=0; i<pageCnt; i++){
	        			if(i+1 == pageNum){
	        			%>	<a href="mypage_Control.jsp?command=adminAdmission&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: red;"><%=i+1%></a>
	        		<%	}
	        			else
	        			{%>
	        				<a href="mypage_Control.jsp?command=adminAdmission&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: black;"><%=i+1%></a>
	        		<%	}%>
        		<%	}
        			if(pageCnt != 1){
        		%>	<a href="mypage_Control.jsp?command=adminAdmission&pageNum=<%=pageNum+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>"><span class="glyphicon glyphicon-chevron-right" style="color: red; width: 30px; height: 20px"></span></a>
        		<%	}		
        		}
        		
        		
        		
        		else if(pageNum == pageCnt){%>
        			<a href="mypage_Control.jsp?command=adminAdmission&pageNum=<%=pageNum-1%>&search_word=<%=search_word %>&search_div=<%=search_div %>"><span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px"></span></a>
        		
        		<%	for(int i=0; i<pageCnt; i++){
	    			if(i+1 == pageNum){
	        			%>	<a href="mypage_Control.jsp?command=adminAdmission&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: red;"><%=i+1%></a>
	        		<%	}else{%>
	        				<a href="mypage_Control.jsp?command=adminAdmission&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: black;"><%=i+1%></a>
	        		<%	}%>
    			<%	} %>
    				<span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px; visibility: hidden;"></span>		
        	<%	}
        	
        	
        	
        	else{%>
        			<a href="mypage_Control.jsp?command=adminAdmission&pageNum=<%=pageNum-1%>&search_word=<%=search_word %>&search_div=<%=search_div %>"><span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px"></span></a>
        		<%	for(int i=0; i<pageCnt; i++){
	    			if(i+1 == pageNum){
	        			%>	<a href="mypage_Control.jsp?command=adminAdmission&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: red;"><%=i+1%></a>
	        		<%	}else{%>
	        				<a href="mypage_Control.jsp?command=adminAdmission&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: black;"><%=i+1%></a>
	        		<%	}%>
    			<%	}%>	
    				<a href="mypage_Control.jsp?command=adminAdmission&pageNum=<%=pageNum+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>"><span class="glyphicon glyphicon-chevron-right" style="color: red; width: 30px; height: 20px"></span></a>
        	<%	}
        	} //
        	%>
	      	</td>
	      	<td></td>
        </tr>
        <tr>
        	<td></td>
        	<td></td>
        </tr>
        </table>
        <table style="border: 0; border-collapse:collapse;  width: 1000px; height: 100px; background-color: #ededed">
        <col width="250"><col width="200"><col width="100"><col width="350">
        <tr>
        <td></td>
        <td colspan="2" style="height: 50px;" >
        <form action="./mypage_Control.jsp?command=adminAdmission" method="post"> 
          <div class="input-group" align="center">
	      <select name="search_div" id="search_div" class="form-control" style="width: 150px; height: 35px">
	      	<option value="email">email</option>
	      	<option value="nickname">닉네임</option>
	      </select>  
	    <input id="search_word" type="text" class="form-control" name="search_word" style="width: 200px; height: 35px">
	    <input type="submit" id="search" class="form-control" value="검색" style="width: 50px; height: 35px">
	    </div>
	    </form> 
        </td>
        <td></td>
        </tr>
        </table>
</body>
</html>