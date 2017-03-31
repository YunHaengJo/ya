<%@page import="com.Beans.Ya_ReserveBean"%>
<%@page import="java.io.IOException"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.Dao.MotelDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nomCnt = request.getParameter("nomCnt");
System.out.println(nomCnt + "노말방개수");
String date =request.getParameter("date");
System.out.println(date + "date");
String motelNum = request.getParameter("motelNum");
System.out.println(motelNum + "motelNum");
String preCnt = request.getParameter("preCnt");
System.out.println(preCnt + "preCnt");

MotelDao dao = MotelDao.getInstance();
Ya_ReserveBean dto = dao.roomCnt(Integer.parseInt(motelNum), date);
int noCnt = Integer.parseInt(nomCnt);
int prCnt = Integer.parseInt(preCnt);
if(dto!=null){
 noCnt = Integer.parseInt(nomCnt)-dto.getNoroomCnt();
 prCnt = Integer.parseInt(preCnt)-dto.getPreroomCnt();
}


String roomJson = "{\"noroomCnt\":\""+ noCnt 
				+"\",\"preroomCnt\":\""+prCnt
				+"\"}";

try {
    response.getWriter().print(roomJson);
} catch (IOException e) {
    e.printStackTrace();
}   

%>