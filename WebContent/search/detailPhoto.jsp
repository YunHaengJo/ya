<%@page import="java.util.ArrayList"%>
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
   

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
     <style>
      
      a{
      text-decoration : none;
      color : black;
      }
         
      .prev, .next {
      cursor: pointer;
      position: absolute;
      top: 0;
      top: 50%;
      width: auto;
      margin-top: -22px;
      padding: 16px;
      color: black;
      font-size: 20px;
      transition: 0.4s ease;
      border-radius: 0 3px 3px 0;
      }
      .next {
      right: 0;
      border-radius: 3px 0 0 3px;
      }
      .prev:hover,.next:hover {
      background-color: rgba(0,0,0,0.8);
      }
     
</style>
</head>
<body>
<%//

String motelNum = request.getParameter("motelNum");
String str = request.getParameter("str");
String type = request.getParameter("type");

int noCount =0;
int preCount = 0;

MotelDao dao = MotelDao.getInstance();

List<Ya_ImgBean> list =  dao.do_detail_photo(Integer.parseInt(request.getParameter("motelNum")));
   
    if(type.equals("123")){
       System.out.println("일반실 이프 부분입니다.444444444444");
         for(int i=0;i<list.size();i++){ 
               if(list.get(i).getImg_auth()==1){noCount++;}
               System.out.println("파일어스"+list.get(i).getImg_auth()+"파일이름"+list.get(i).getImg_name());
         }
         System.out.println("일반실 이프 포문 끝나고 부분입니다.55555555555555===" + noCount);
    %>
    <script type="text/javascript">
    
    $(document).ready(function() {
      // 일반실 사진 개수     
      var noCount ='타입'+'<%=noCount%>'; 
      //alert(typeof(noCount));
      var img1 ="";
      var img2 ="";
      var img3 ="";

      <% if(noCount==1){%>
          img1 = "<%=list.get(0).getImg_name()%>";
      <%}%>   
      <% if(noCount==2){%>
         
          img1 = "<%=list.get(0).getImg_name()%>";
          img2 = "<%=list.get(1).getImg_name()%>";
      <%}%>      
      <% if(noCount==3){%>
           img1 = "<%=list.get(0).getImg_name()%>";
           img2 = "<%=list.get(1).getImg_name()%>";
           img3 = "<%=list.get(2).getImg_name()%>";
           
      <%}%>   // 일반실 사진 개수 부분 끝 
      
      //alert("일반 이미지1"+img1);
     // alert("일반 이미지2"+img2);
      //alert("일반 이미지3"+img3); 
      
      $("#next").click(function(){
    	 
    	  if(noCount==='타입1'){
              alert("사진이 한장입니다.");
          
           }else if(noCount==='타입2'){
              
              if($("#first").attr('src')==img1){
                  $("#first").attr('src',img2);
                  
                  //alert("일반 이미지2"+img2);
                 
               }else if($("#first").attr('src')==img2){
                  $("#first").attr('src',img1);
                  //alert("일반 이미지1"+img1);
                 
               }
           
           }else if(noCount==='타입3'){
              
              if($("#first").attr('src')==img1){
                  $("#first").attr('src',img2);
                
                  //alert("일반 이미지2"+img2);
                  
               }else if($("#first").attr('src')==img2){
                  $("#first").attr('src',img3);
                 
                  //alert("일반 이미지2"+img2);
                  
               }else if($("#first").attr('src')==img3){
                  $("#first").attr('src',img1);
                  //alert("일반 이미지1"+img1);
                  
               }
        
              }
    	  
      });
      
      
      $("#prev").click(function(){
                   
          if(noCount==='타입1'){
             alert("사진이 한장입니다.");
          
          }else if(noCount==='타입2'){
             	if($("#first").attr('src')==img1){
                 $("#first").attr('src',img2);
               //  alert("일반 이미지2"+img2);
              	}else if($("#first").attr('src')==img2){
                 $("#first").attr('src',img1);
               //  alert("일반 이미지1"+img1);
             	}
          
          }else if(noCount==='타입3'){
             if($("#first").attr('src')==img1){
                 $("#first").attr('src',img3);
                // alert("일반 이미지3"+img3);
              }else if($("#first").attr('src')==img3){
                 $("#first").attr('src',img2);
                // alert("일반 이미지2"+img2);
              }else if($("#first").attr('src')==img2){
                 $("#first").attr('src',img1);
                // alert("일반 이미지1"+img1);
              }
               
          } 
          
         
          
         
        });
      
        
        
    });
    
    
    </script>
    
    <a class="prev" id="prev" >&#10094;</a>
         
         <img id ="first" src="<%=list.get(0).getImg_name() %>" width="90%" height="700" style="margin-top: 7%; margin-left: 6%">
         
    <a class="next" id="next" >&#10095;</a>
    
    <%
    return;
    }// 일반실 if 카운트 
    
    if(type.equals("789")){
       System.out.println("특실 이프 부분입니다.666666666666666666======" + list.size());
         for(int i=0;i<list.size();i++){ 
            if(list.get(i).getImg_auth()==2){preCount++;}
            if(list.get(i).getImg_auth()==1){noCount++;  }
         }
         System.out.println("특실 이프 포문 끝나고 부분입니다.7777777777777=====" + noCount );
         System.out.println("특실 이프 포문 끝나고 부분입니다.8888888888888=====" + preCount );
    
    %>
    <script type="text/javascript">

    	$(document).ready(function(){
  
    		var noCount=<%=noCount%>; 
    	     // alert(typeof(noCount));
    	    var preCount='특실'+'<%=preCount%>';
    	      var img1="";
    	      var img2="";
    	      var img3="";
    
      <% if(preCount==1){%>
        img1 = "<%=list.get(noCount).getImg_name()%>";
      <%}%>
      
      <% if(preCount==2){%>
   		img1 = "<%=list.get(noCount).getImg_name()%>";
        img2 = "<%=list.get(noCount+1).getImg_name()%>";
        
      <%}%>
      
      <% if(preCount==3){%>
   		img1 = "<%=list.get(noCount).getImg_name()%>";
        img2 = "<%=list.get(noCount+1).getImg_name()%>";
        img3 = "<%=list.get(noCount+2).getImg_name()%>";
      <%}%>
     
      
      //  alert("특실 이미지1"+img1);
       // alert("특실 이미지2"+img2);
      //  alert("특실 이미지3"+img3);
  
        $("#next").click(function(){
       	 
      	  if(preCount==='특실1'){
                alert("사진이 한장입니다.");
            
             }else if(preCount==='특실2'){
                
                if($("#first").attr('src')==img1){
                    $("#first").attr('src',img2);
                 }else if($("#first").attr('src')==img2){
                    $("#first").attr('src',img1);
                 }
             
             }else if(preCount==='특실3'){
                
                if($("#first").attr('src')==img1){
                    $("#first").attr('src',img2);
                 }else if($("#first").attr('src')==img2){
                    $("#first").attr('src',img3);
                 }else if($("#first").attr('src')==img3){
                    $("#first").attr('src',img1);
                 }
          
                }
      	  
        });
        
        $("#prev").click(function(){
            
            if(preCount==='특실1'){
               alert("사진이 한장입니다.");
            
            }else if(preCount==='특실2'){
               	if($("#first").attr('src')==img1){
                   $("#first").attr('src',img2);
                  // alert("일반 이미지2"+img2);
                	}else if($("#first").attr('src')==img2){
                   $("#first").attr('src',img1);
                  // alert("일반 이미지1"+img1);
               	}
            
            }else if(preCount==='특실3'){
               if($("#first").attr('src')==img1){
                   $("#first").attr('src',img3);
                  // alert("일반 이미지3"+img3);
                }else if($("#first").attr('src')==img3){
                   $("#first").attr('src',img2);
                  // alert("일반 이미지2"+img2);
                }else if($("#first").attr('src')==img2){
                   $("#first").attr('src',img1);
                   //alert("일반 이미지1"+img1);
                }
                 
            } 
            
           
            
           
          });
  
  
});    
</script>

 	 <a class="prev" id="prev" >&#10094;</a>
          <img id ="first" src="<%=list.get(noCount).getImg_name() %>" width="90%" height="700" style="margin-top: 7%; margin-left: 6%">
     <a class="next" id="next" >&#10095;</a>  


    <%
    }



//%>

</body>
</html>