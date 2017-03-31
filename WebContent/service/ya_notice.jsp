<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="com.Beans.Ya_NoticeBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- prevent IE6 flickering -->
<script type="text/javascript">
    try {
        document.execCommand('BackgroundImageCache', false, true);
    } catch (e) {
    }
</script> 

<%
ArrayList<Object> list = (ArrayList<Object>)request.getAttribute("list");
String pageNumStr = (request.getAttribute("pageNum")==null||request.getAttribute("pageNum")=="")?"1":(String)request.getAttribute("pageNum");
String pageSizeStr = (request.getAttribute("pageSize")==null||request.getAttribute("pageSize")=="")?"1":(String)request.getAttribute("pageSize");
String search_div = (request.getAttribute("search_div")==null||request.getAttribute("search_div")=="")?"":(String)request.getAttribute("search_div");
String search_word = (request.getAttribute("search_word")==null||request.getAttribute("search_word")=="")?"":(String)request.getAttribute("search_word");
Ya_MemberBean user = (Ya_MemberBean)session.getAttribute("member");

%>


<style type="text/css">
  	a{
    cursor: default;
    text-decoration:none !important; 
  	}
	.checkbox-wrap { cursor: pointer; }
	.checkbox-wrap .check-icon  { display: inline-block; width: 18px; height: 18px; background: url(../img/unchecked.png) left center no-repeat; vertical-align: middle; transition-duration: .3s; }
	.checkbox-wrap input[type=checkbox] { display: none; }
	.checkbox-wrap input[type=checkbox]:checked + .check-icon { background-image: url(../img/checked.png)
</style>
</head>
<body>
	<!-- Top -->
	<jsp:include page="../super/superTop.jsp"></jsp:include>
<!-- 빈곳   -->	
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
<!-- 이용약관 -->
	<div class="container">
      <div class="row">
        <div class="col-sm-2">
        <!-- 사이드바 -->
            <div style="border-right: solid 2px #e3ebf7 ; height: 700px;">
            	<h3><b>&nbsp;&nbsp;고객센터</b></h3>
            	<p align="left" id="notice" style="color: red"><span class="glyphicon glyphicon-chevron-right" style="color: red"></span>공지사항</p>
            	<p></p>
     			<p></p>
            	<a href=<%=user.getAuth()==2 ? "qnaControl.jsp?command=adminlist" : "ya_memberQnaWrite.jsp" %> id="qna">1:1문의</a>
            	<p></p>
            </div>
        </div>
        <div class="col-sm-10">
        <!-- 본문-->
        <table style="border: 0; border-collapse:collapse; margin-top: 22px; width: 1240px; height: 100px; background-color: #ededed">
        <col width="50"><col width="400"><col width="100"><col width="350">
        <tr>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        	<td colspan="4" align="left" valign="center" style="border-bottom: 3px solid #a0a0a0; text-align: left;"><h3><b>공지사항</b></h3></td>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        </tr>
        </table>
        
        <table style="border: 0; border-collapse:collapse;  width: 1240px; height: 550px; background-color: #ededed">
        <col width="50"><col width="400"><col width="100"><col width="350">
        <%if(null != list && list.size() > 0){
        	for(int i=0; i<list.size(); ++i){ %>
        <tr>
        	<td></td>
        	<td style="border-bottom: 1px solid #a0a0a0; height: 10; text-align: left;"><a href="noticeControl.jsp?command=detail&seq=<%=((Ya_NoticeBean)list.get(i)).getSeq()%>"><%=((Ya_NoticeBean)list.get(i)).getTitle() %></a></td>
        	<td style="border-bottom: 1px solid #a0a0a0; height: 10; text-align: left;"><%=((Ya_NoticeBean)list.get(i)).getUpload_dt() %></td>
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
        		int tot_cnt = ((Ya_NoticeBean)list.get(0)).getTot_cnt();
        		
        		int pageCnt = (tot_cnt%pageSize)==0 ? tot_cnt/pageSize : tot_cnt/pageSize +1;
        		System.out.println(pageSize);
        		
        		
        		if(pageNum == 1){%>
        			<span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px; visibility: hidden;"></span>
        		<%	for(int i=0; i<pageCnt; i++){
	        			if(i+1 == pageNum){
	        			%>	<a href="noticeControl.jsp?command=list&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: red;"><%=i+1%></a>
	        		<%	}
	        			else
	        			{%>
	        				<a href="noticeControl.jsp?command=list&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: black;"><%=i+1%></a>
	        		<%	}%>
        		<%	}
        			if(pageCnt != 1){
        		%>	<a href="noticeControl.jsp?command=list&pageNum=<%=pageNum+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>"><span class="glyphicon glyphicon-chevron-right" style="color: red; width: 30px; height: 20px"></span></a>
        		<%	}		
        		}
        		
        		
        		
        		else if(pageNum == pageCnt){%>
        			<a href="noticeControl.jsp?command=list&pageNum=<%=pageNum-1%>&search_word=<%=search_word %>&search_div=<%=search_div %>"><span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px"></span></a>
        		
        		<%	for(int i=0; i<pageCnt; i++){
	    			if(i+1 == pageNum){
	        			%>	<a href="noticeControl.jsp?command=list&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: red;"><%=i+1%></a>
	        		<%	}else{%>
	        				<a href="noticeControl.jsp?command=list&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: black;"><%=i+1%></a>
	        		<%	}%>
    			<%	} %>
    				<span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px; visibility: hidden;"></span>		
        	<%	}
        	
        	
        	
        	else{%>
        			<a href="noticeControl.jsp?command=list&pageNum=<%=pageNum-1%>&search_word=<%=search_word %>&search_div=<%=search_div %>"><span class="glyphicon glyphicon-chevron-left" style="color: red; width: 30px; height: 20px"></span></a>
        		<%	for(int i=0; i<pageCnt; i++){
	    			if(i+1 == pageNum){
	        			%>	<a href="noticeControl.jsp?command=list&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: red;"><%=i+1%></a>
	        		<%	}else{%>
	        				<a href="noticeControl.jsp?command=list&pageNum=<%=i+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>" style="color: black;"><%=i+1%></a>
	        		<%	}%>
    			<%	}%>	
    				<a href="noticeControl.jsp?command=list&pageNum=<%=pageNum+1%>&search_word=<%=search_word %>&search_div=<%=search_div %>"><span class="glyphicon glyphicon-chevron-right" style="color: red; width: 30px; height: 20px"></span></a>
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
        <table style="border: 0; border-collapse:collapse;  width: 1240px; height: 50px; background-color: #ededed">
        <col width="250"><col width="200"><col width="100"><col width="350">
        <tr>
        <td></td>
        <td colspan="2" style="height: 50px;" >
        <form action="./noticeControl.jsp?command=list" method="post"> 
          <div class="input-group" align="center">
	      <select name="search_div" id="search_div" class="form-control" style="width: 150px; height: 35px">
	      	<option value="title">제목</option>
	      	<option value="content">내용</option>
	      </select>  
	    <input id="search_word" type="text" class="form-control" name="search_word" style="width: 200px; height: 35px">
	    <input type="submit" id="search" class="form-control" value="검색" style="width: 50px; height: 35px">
	    </div>
	    </form> 
        </td>
        <td></td>
        </tr>
      	<%if(user != null){ 
      		if(user.getAuth() == 2){
      	%>
        <tr>
        	<td></td>
        	<td></td>
        	<td><input type="button" class="form-control" value="공지하기" style="width: 135px; height: 50px" onclick="location.href='ya_noticeRegister.jsp'"></td>
        	<td></td>
        </tr>
        <%} 
      	}
        %>
        </table>
        </div>
    </div>
    </div>
	
	<!--Foot -->
	<jsp:include page="../super/superFoot.jsp"></jsp:include>
	<script>
$( "#qna" ).hover(
  function() {
    $( this ).prepend( $( "<span id='span' class='glyphicon glyphicon-chevron-right' style='color: red'></span>" ) );
  }, function() {
    $( this ).find( "#span" ).remove();
  }
);
</script>
</body>

</html>