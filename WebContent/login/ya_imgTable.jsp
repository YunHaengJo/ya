<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int roomCnt = Integer.parseInt(request.getParameter("roomCnt"));
	String div = request.getParameter("div");
%>

<%if(div.equals("normal")){ %>
	<%if(roomCnt > 0){ %>
	<table>
	<col width="400"><col width="600">
	<tr>
		<td>일반실사진</td>
	</tr>
	<%for(int i=0; i< roomCnt; ++i){%>
	<tr>
		<td></td>
		<td>
			<div class="form-group">
				<input type="file" name="noimg<%=i %>" class="file" style="visibility: hidden;">
					
				<div class="input-group col-xs-15">
					<span class="input-group-addon">
					<i class="glyphicon glyphicon-picture"></i>
					</span> 
						<input type="text" class="form-control input-lg" disabled placeholder="일반실 사진 등록">
						<span class="input-group-btn">
						<button class="browse btn btn-primary input-lg" type="button">
							<i class="glyphicon glyphicon-search"></i> Browse
						</button>
					</span>
				</div>
			</div>
	    </td>
	</tr>
	<%} %>
	</table>
	<%} %>	
<%}else if(div.equals("premium")){%>
	<%if(roomCnt > 0){ %>
	<table>
	<col width="400"><col width="600">
	<tr>
		<td>특실</td>
	</tr>
	<%for(int i=0; i< roomCnt; ++i){%>
	<tr>
		<td></td>
		<td>
			<div class="form-group">
				<input type="file" name="primg<%=i %>" class="file" style="visibility: hidden;">
				<div class="input-group col-xs-15">
					<span class="input-group-addon">
					<i class="glyphicon glyphicon-picture"></i>
					</span> 
						<input type="text" class="form-control input-lg" disabled placeholder="특실 사진 등록">
						<span class="input-group-btn">
						<button class="browse btn btn-primary input-lg" type="button">
							<i class="glyphicon glyphicon-search"></i> Browse
						</button>
					</span>
				</div>
			</div>
	    </td>
	</tr>
	<%}%>
	</table>
	<%} %>
<%}%>

