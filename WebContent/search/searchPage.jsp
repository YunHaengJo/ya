
<%@page import="com.Beans.Ya_MotelBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%!//
//%>
<%//
int imgCount = 0;
int contentCount = 0;

int count= 0;


ArrayList<Ya_MotelBean> list = (ArrayList<Ya_MotelBean>)request.getAttribute("list");


//%> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- prevent IE6 flickering -->
<script type="text/javascript">
    try {
        document.execCommand('BackgroundImageCache', false, true);
    } catch (e) {
    }
    
    $(document).ready(function()
    		{
    		    $('#selectbox').change(function(){
    		    	<%
    		    	if(session.getAttribute("word")!=null){ 
    		    		String searchWord = (String)session.getAttribute("word");
    		    		if(searchWord.equals("서울")||searchWord.equals("경기")||searchWord.equals("부산")||searchWord.equals("대전")||searchWord.equals("대구")){
    		    	%>
        		        location.href='searchControll.jsp?isaddress=ok&command=word&type='+$('#selectbox option:selected').val()+ '&searchWord=<%=searchWord %>';
        		    <%
        		    }else{
        		    %>
    		        	location.href='searchControll.jsp?isaddress=no&command=word&type='+$('#selectbox option:selected').val()
    		        	+'&searchWord=<%=searchWord %>';
    		        <%
    		    		}
    		    	}
    		        %>
    		    });
    		});

    
	
    		


</script>

<title>Insert title here</title>
<style type="text/css">
	.header{
		position : fixed;
		height : 100px;
		background: #fc676e;
	}
	.foot{
		height : 200px;
		background: #3f3e3e;
	}
	.blank{
		height: 100px;
	}	.location{
		padding-top : 50px;
		height: 300px;
	}
	.popular{
		height: 300px;
	}
	table,tr,td{
		text-align: center;
		/* border: 1px solid black */
	}
	img:hover{
		opacity: 0.5;
	}
	
	.tabl{
		width: 60%;
		height: 100px;
		margin: auto;
		text-align: center;
	}
	
	.tabl01{
		width: 80%;
		height: 100px;
		margin: auto;
		
	}
	
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
<!-- 검색내용 -->	
<br>
	<table class="tabl" >
    	<tr>
    		
    		<td height="100px" align="center">
    		<%
    		if(session.getAttribute("word")!=null){ 
    		String searchWord = (String)session.getAttribute("word");
    		%>
    		<font face="맑은 고딕" size="15"><%=searchWord %> 검색 </font>
    		<%
    		}
    		%>
    		</td>
    		
    	</tr>
    	<tr>
    		<td height="30" style="text-align: right">
    		<select style="width: 150px; height: 30px;" name="choi" id="selectbox">
    			<option value="BASIC" >조건 정렬</option>
				<option value="PAY" >가격 순</option>
				<option value="STAR" >별점 높은 순</option>
				<option value="REVIEW" >후기 많은 순</option>
			</select>
    		</td>
    	</tr>
	</table>
<br>
<br>
<hr>	 
	<input type="hidden" name="command" value="detail">
	<table class="tabl01" style="background-color: #f2f2f2;">
		
		<%
		if(list!=null){
		
		int listSize = list.size()%4 > 0 ? (list.size()/4)+1 : (list.size()/4);
		//System.out.println("리스트 사이즈 " + listSize);
		
		
		for(int i=0; i<listSize; i++){ 
			count++;
			//System.out.println("count"+count);
		%>
		<tr>
		<%
		
		for(int j=0; j<4; j++){ 
		
			
    			if(count==listSize && list.size()%4 != 0){ 
    				if( j < list.size()%4){
    					//System.out.println("imgCount"+imgCount);
    					//System.out.println(list.get(imgCount).getImgs().get(0).getImg_name());
    	%>	
    			<td height="230" width="60"></td>
        		<td height="230" width="380">
        		<a href="searchControll.jsp?command=detail&motel_num=<%=list.get(imgCount).getMotel_num() %>">
        		<img onerror="this.src='../img/noImg.gif'" src="<%=list.get(imgCount).getImgs().get(0).getImg_name() %>" width="350" height="230">
        		</a>
        		</td>
        		<td height="230" width="60"></td> 
        <%			imgCount++;
    				}else{
        %>
    				
    				<td height="230" width="60"></td>
            		<td height="230" width="380" >
            		</td>
            		<td height="230" width="60"></td> 
        <%		
    			}
    		}else{
    			//System.out.println("imgCount++"+imgCount);
    	%>			
    			<td height="230" width="60"></td>
        		<td height="230" width="380" >
        		<a href="searchControll.jsp?command=detail&motel_num=<%=list.get(imgCount).getMotel_num() %>">
        		<img onerror="this.src='../img/noImg.gif'" src="<%=list.get(imgCount).getImgs().get(0).getImg_name() %>" width="350" height="230">
        		</a></td>
        		<td height="230" width="60"></td> 			
    	<%		
    			imgCount++;
    		}
    	} 
    	%>	
    	</tr>
    	<tr>
    	<%
    	for(int k=0; k<4; k++){  
    		System.out.println("count K "+count);
    			if(count==listSize && list.size()%4 != 0){ 
    				
    				if( k < list.size()%4){
    					//System.out.println("contentCount"+contentCount);		
    	%>
    				<td height="80" width="60"></td>
    				<td height="80" width="380" >
    				<p>모텔 이름 : <%=list.get(contentCount).getName() %></p>
    				<p>주소 : <%=list.get(contentCount).getAddress() %> </p>
    				<p>일반실 가격 : <%=list.get(contentCount).getNormal_pri() %></p>
    	    		<%	
    	    			int cnt = list.get(contentCount).getStarAVG();	
    	    			for(int p = 0; p < cnt; ++p){
    	    		%>
    	    		<img alt="" src="../img/pointstar.png" width="15px" height="15px">
    	    		<%
    	    			}
    					for(int p = cnt; p < 10; ++p){
    	    		%>
    	    		<img alt="" src="../img/empty.png" width="15px" height="15px">
    	    		<%
    					}
    	    		%>
    	    	
    			</td>
    			<td height="80" width="60"></td>	
        <%		contentCount++;
    				}else{
        %>
    				
    			<td height="80" width="60"></td>
    			<td height="80" width="380" >
    			</td>
    			<td height="80" width="60"></td>
        <%		
    			}
    		}else{
    	%>
    			<td height="80" width="60"></td>
    			<td height="80" width="380" >
    			<p>모텔 이름 : <%=list.get(contentCount).getName() %></p>
    			<p>주소 : <%=list.get(contentCount).getAddress() %> </p>
    			<p>일반실 가격 : <%=list.get(contentCount).getNormal_pri() %></p> 
    			<%
    				int cnt = list.get(contentCount).getStarAVG();
    	    		for(int p = 0; p < cnt; ++p){
    	    	%>
    	    		<img alt="" src="../img/pointstar.png" width="15px" height="15px">
    	    		<%
    	    		}
    					for(int p = cnt-1; p < 10; ++p){
    	    		%>
    	    		<img alt="" src="../img/empty.png" width="15px" height="15px">
    	    		<%
    				}
    	    		%>
    			</td>
    			<td height="80" width="60"></td>			
    	<%	
    	//System.out.println("contentCount++"+contentCount);
    	contentCount++;
    		}
    	} 
    	%>	
    	
    	</tr>
    	
    	<tr>
    		<td height="50" colspan="9"></td>
    	
    	</tr>
    	<%
    	
		} 
    	%>
    	<%-- <tr>
    	<td colspan="9" align="right">
    	<%
    	int pageCount = list.get(0).getTOT_CNT()%12 > 0 ? (list.get(0).getTOT_CNT()/12)+1 : (list.get(0).getTOT_CNT()/12); 
    	for(int i=0; i<pageCount;i++){
    	%>
    	<%=i+1 %>
    	<%} %>
    	</td>
    	</tr> --%>
    	
	</table>
	
	<table style="width: 50%; margin: auto;">
		<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    <tr>
    	<td colspan="9" align="center">
    	
    	<%
    	String str = " ";
    	int pageCount = list.get(0).getTOT_CNT()%12 > 0 ? (list.get(0).getTOT_CNT()/12)+1 : (list.get(0).getTOT_CNT()/12); 
    	for(int i=0; i<pageCount;i++){
    	%>
    	
    	<%
    	if(session.getAttribute("word")!=null || session.getAttribute("type")!=null){ 
    		String searchWord = (String)session.getAttribute("word");
    		String stype = (String)session.getAttribute("type");
    	%>
 <a href="javascript:;" onclick= "location.href='searchControll.jsp?command=word&isaddress=no&pageNum=<%=i+1 %>&searchWord=<%=searchWord %>&type=<%=stype %>'" >
    	<%	
    	}else{
    	%>
 <a href="javascript:;" onclick="location.href='searchControll.jsp?command=word&pageNum=<%=i+1 %>&isaddress=no'" >
    	<%
    	}
    	%>
    	<font size="5">
    	<%=i+1 %><%=str %>
    	<%} 
    	%>
    	</font>
    	</a>
    	</td>
    </tr>
	
	
	</table>
	<%}
	else{
		%>
	
	
	<div style="width: 100%; height: 700px; text-align: center; margin-top: 400px;">
	<h1>검색 결과가 없습니다.</h1>
	</div>
	
	<%
	}
	%>
	
	
	<br>
	
<!--Foot -->
	<jsp:include page="../super/superFoot.jsp"></jsp:include>
</body>
</html>