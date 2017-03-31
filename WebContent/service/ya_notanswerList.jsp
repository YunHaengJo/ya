<%@page import="com.Beans.Ya_QnaBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Beans.Ya_MemberBean"%>
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
<%!
public String arrow(int depth){
	String rs = "<img src='../img/arrow.png' width='20px' height='20px'>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
	String ts = "";
	for(int i = 0; i<depth; i++){
		ts += nbsp;
	}
	return depth==0 ? "" : ts + rs;  
}
%>

<%
	ArrayList<Object> list = (ArrayList<Object>)request.getAttribute("list");
	for(int i=0; i<list.size(); ++i){
		System.out.println(((Ya_QnaBean)list.get(i)).toString());
	}
	String pageNumStr = (request.getAttribute("pageNum")==null||request.getAttribute("pageNum")=="")?"1":(String)request.getAttribute("pageNum");
	String pageSizeStr = (request.getAttribute("pageSize")==null||request.getAttribute("pageSize")=="")?"1":(String)request.getAttribute("pageSize");
	String search_div = (request.getAttribute("search_div")==null||request.getAttribute("search_div")=="")?"":(String)request.getAttribute("search_div");
	String search_word = (request.getAttribute("search_word")==null||request.getAttribute("search_word")=="")?"":(String)request.getAttribute("search_word");
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
        	<form action="qnaControl.jsp" name="f1">
         <input type="hidden" id="command" name="command" value="">
        	<td></td>
        	<td colspan="2">
        	<div class="input-group">
        	<button class="input-group-addon" id="write" style="width: 356px; height: 30px; background-color: #ededed;" onclick="mySubmit(1)">전체 문의 내역</button>
            <button class="input-group-addon" style="width: 356px; height: 30px; background-color: white;" onclick="mySubmit(2)">답변 미처리 내역</button>
        	</div>
        	</td>
        	<td></td>
        	</form>
        </tr>
        </table>
        <table style="border: 0; border-collapse:collapse;  width: 1240px; height: 550px; background-color: #ededed">
        <col width="50"><col width="350"><col width="50"><col width="100"><col width="350">
        <%if(null != list && list.size() > 0){
        	for(int i=0; i<list.size(); ++i){ %>
        <tr>
        	<td></td>
        	<td style="border-bottom: 1px solid #a0a0a0; height: 10; text-align: left;"><%=arrow(((Ya_QnaBean)list.get(i)).getDepth()) %><a href="qnaControl.jsp?command=detail&seq=<%=((Ya_QnaBean)list.get(i)).getSeq()%>"><%=((Ya_QnaBean)list.get(i)).getTitle() %></a></td>
        	<td style="border-bottom: 1px solid #a0a0a0; height: 10; text-align: left;"><%=((Ya_QnaBean)list.get(i)).getEmail() %></td>
        	<td style="border-bottom: 1px solid #a0a0a0; height: 10; text-align: left;"><%=((Ya_QnaBean)list.get(i)).getUpload_dt() %></td>
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
        		int tot_cnt = ((Ya_QnaBean)list.get(0)).getTot_cnt();
        		
        		int pageCnt = (tot_cnt%pageSize)==0 ? tot_cnt/pageSize : tot_cnt/pageSize +1;
        		System.out.println(pageSize);
        		
        		
        		if(pageNum == 1){
        			System.out.println("페이지넘버가 1일때"+pageNum);
        		%>
        			<span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px; visibility: hidden;"></span>
        		<%	for(int i=0; i<pageCnt; i++){
	        			if(i+1 == pageNum){
	        			%>	<a href="qnaControl.jsp?command=adminlist&pageNum=<%=i+1%>&email=<%=user.getEmail()%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: red;"><%=i+1%></a>
	        		<%	}
	        			else
	        			{%>
	        				<a href="qnaControl.jsp?command=adminlist&pageNum=<%=i+1%>&email=<%=user.getEmail() %>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: black;"><%=i+1%></a>
	        		<%	}%>
        		<%	}
        			if(pageCnt != 1){
        		%>	<a href="qnaControl.jsp?command=adminlist&pageNum=<%=pageNum+1%>&email=<%=user.getEmail() %>&search_word=<%=search_word %>&search_div=<%=search_div %>"><span class="glyphicon glyphicon-chevron-right" style="color: red; width: 30px; height: 20px"></span></a>
        		<%	}		
        		}
        		
        		
        		
        		else if(pageNum == pageCnt){
        		
        			System.out.println("페이지넘버가 페이지카운트랑 같을때"+pageNum);
        		%>
        			<a href="qnaControl.jsp?command=adminlist&pageNum=<%=pageNum-1%>&email=<%=user.getEmail() %>&search_word=<%=search_word %>&search_div=<%=search_div %>"><span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px"></span></a>
        		
        		<%	for(int i=0; i<pageCnt; i++){
	    			if(i+1 == pageNum){
	        			%>	<a href="qnaControl.jsp?command=adminlist&pageNum=<%=i+1%>&email=<%=user.getEmail() %>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: red;"><%=i+1%></a>
	        		<%	}else{%>
	        				<a href="qnaControl.jsp?command=adminlist&pageNum=<%=i+1%>&email=<%=user.getEmail() %>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: black;"><%=i+1%></a>
	        		<%	}%>
    			<%	} %>
    				<span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px; visibility: hidden;"></span>		
        	<%	}
        	
        	
        	
        	else{%>
        			<a href="qnaControl.jsp?command=adminlist&pageNum=<%=pageNum-1%>&email=<%=user.getEmail() %>&search_word=<%=search_word %>&search_div=<%=search_div %>">
        			<span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px">
        			</span></a>
        		<%	for(int i=0; i<pageCnt; i++){
	    			if(i+1 == pageNum){
	        			%>	<a href="qnaControl.jsp?command=adminlist&pageNum=<%=i+1%>&email=<%=user.getEmail() %>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: red;"><%=i+1%></a>
	        		<%	}else{%>
	        				<a href="qnaControl.jsp?command=adminlist&pageNum=<%=i+1%>&email=<%=user.getEmail() %>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: black;"><%=i+1%></a>
	        		<%	}%>
    			<%	}
    			%>	
    				<a href="qnaControl.jsp?command=adminlist&pageNum=<%=pageNum+1%>&email=<%=user.getEmail() %>&search_word=<%=search_word %>&search_div=<%=search_div %>" >
    				<span class="glyphicon glyphicon-chevron-right" style="color: red; width: 30px; height: 20px">
    				</span>
    				</a>
        	<%	
        		}
        	} 
        	%>
	      	</td>
	      	<td></td>
        </tr>
        <tr>
        	<td></td>
        	<td></td>
        </tr>
        </table>
        <table style="border: 0; border-collapse:collapse;  width: 1240px; height: 50px; background-color: #ededed">
        <col width="250"><col width="200"><col width="100"><col width="350">
        <tr>
        <td></td>
        <td colspan="2" style="height: 50px;" >
        <form action="./qnaControl.jsp?command=adminlist" method="post"> 
          <div class="input-group" align="center">
	      <select name="search_div" id="search_div" class="form-control" style="width: 150px; height: 35px">
	      	<option value="title">제목</option>
	      	<option value="content">내용</option>
	      </select>  
	    <input id="search_word" type="text" class="form-control" name="search_word" style="width: 200px; height: 35px">
	    <input type="hidden" name="email" value="<%=user.getEmail()%>">
	    <input type="submit" id="search" class="form-control" value="검색" style="width: 50px; height: 35px">
	    </div>
	    </form> 
        </td>
        <td></td>
        </tr>
        </table>
        
       </div>
       </div>
       </div>
       
       <script>
        	function mySubmit(index){
        		if(index == 1){
        			document.getElementById("command").value = "adminlist";
        		}
        		if(index == 2){
        			document.getElementById("command").value = "adminnoanswer";
        		}
        		document.f1.submit();
        	}
        </script>	
      
<!--Foot -->
	<jsp:include page="../super/superFoot.jsp"></jsp:include>
</body>
</html>