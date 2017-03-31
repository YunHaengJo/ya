<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.Beans.Ya_ImgBean"%>
<%@page import="com.Beans.Ya_MotelBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.Dao.ImgDao"%>
<%@page import="com.Dao.MotelDao"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="com.Dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%	
		String command = request.getParameter("command");
		System.out.println(command);
		
				
		if(command.equals("login")){
			pageContext.forward("ya_login.jsp");
		}else if(command.equals("logout")){
			pageContext.forward("ya_loginAfter.jsp?type=logout");
		}else if(command.equals("motelupdate")){
			Ya_MemberBean memberBean = (Ya_MemberBean)session.getAttribute("member");
			String email = memberBean.getEmail();
			
			///////////////////////////////////////////////////이미지 업로드 초기세팅 
			request.setCharacterEncoding("utf-8");
			String realFolder = "";
			String uploadfile = "";
			int maxSize = 1024*1024*100;
			String encType = "utf-8";
			String contextRoot = application.getContextPath();
			System.out.println("contextRoot : " + contextRoot);
			String dir = application.getRealPath("/img");
			String savefile = dir;
			ServletContext scontext = getServletContext();
			
			MotelDao motelDao = MotelDao.getInstance();
			ImgDao imgDao = ImgDao.getInstance();

			Ya_MotelBean motelBean = new Ya_MotelBean();
			Ya_ImgBean imgBean = new Ya_ImgBean();
			//회원생성 --> 승인여부는 아직 0!
			String str ="";
			
			/////////////////////////////////////////////////////////////////////////////// 서버에 저장 하는 부분 
			try{ 
				MultipartRequest multi = new MultipartRequest(request, savefile, maxSize, encType, new DefaultFileRenamePolicy());
				
				uploadfile = multi.getFilesystemName("mainimg");
				
				System.out.println(uploadfile);
				File file = new File(savefile + uploadfile); // 파일생성 
				System.out.println("uploadfile : " + uploadfile + "savefile" + savefile);
				imgBean.setImg_name(contextRoot + "/img/" + uploadfile); // 파일저장하면서 이름 저장 
				int num = motelDao.getMotelNum(email);
				imgBean.setMotel_num(num);
				System.out.println("num : " + num );
				imgBean.setImg_auth(0);
				System.out.println("이미지이름 : " + imgBean.getImg_name());
				///////////////////////////////////////////////////////////////////////////////////////
				//String email = memberBean.getEmail();
				
				//모텔수정 
				String name = multi.getParameter("motel");
				System.out.println("모텔명 :" + name);
				
				String phone = multi.getParameter("phone");
				System.out.println("전화번호 :" + phone);
				
				String checkin = multi.getParameter("checkIn");
				System.out.println("checkin :" + checkin);
				
				String checkout = multi.getParameter("checkOut");
				System.out.println("checkOut :" +checkout);
				
				String normalPrice = multi.getParameter("normalPrice");
				System.out.println("normalPrice :" + normalPrice);
				
				String premiumPrice = multi.getParameter("premiumPrice");
				System.out.println("premiumPrice :" + premiumPrice);
				
				String normalCnt = multi.getParameter("normalCnt");
				System.out.println("normalCnt :" + normalCnt);
				
				String premiumCnt = multi.getParameter("premiumCnt");
				System.out.println("premiumCnt :" + premiumCnt);
				
				motelBean.setEmail(email);
				motelBean.setName(name);
				motelBean.setPhone(phone);
				motelBean.setNormal_cnt(Integer.parseInt(normalCnt));
				motelBean.setPremium_cnt(Integer.parseInt(premiumCnt));
				motelBean.setNormal_pri(Integer.parseInt(normalPrice));
				motelBean.setPremium_pri(Integer.parseInt(premiumPrice));
				motelBean.setCheck_in(checkin);
				motelBean.setCheck_out(checkout);
				
				//int num = motelDao.getMotelNum(email);				
				//imgBean.setMotel_num(0);
				/* imgBean.setMotel_num(num);
				System.out.println("num : " + num );
				imgBean.setImg_auth(0);
				System.out.println("이미지이름 : " + imgBean.getImg_name()); */

			}catch(Exception e){
				e.printStackTrace();
			}			
			//사진 박기
			
			if(motelDao.do_update(motelBean)){
				System.out.println("모텔수정성공");
				if(!(imgBean.getImg_name().equals("/SIST_GIT_YA01/img/null"))){
					if(imgDao.do_update(imgBean)){
						System.out.println("이미지 됐다잉");
						pageContext.forward("../main/ya_main.jsp");
					}else{
						System.out.println("이미지 업로드실패");
						pageContext.forward("../main/ya_main.jsp");
					}
				}else{
					pageContext.forward("../main/ya_main.jsp");
				}
			}else{
				System.out.println("걍 첨부터 좆됌");
				pageContext.forward("../main/ya_main.jsp");
			}
			
		
		}else if(command.equals("update")){
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			
			MemberDao memberDao = MemberDao.getInstance();
			Ya_MemberBean memberBean = new Ya_MemberBean();
			memberBean.setEmail(email);
			memberBean.setPassword(password);
			if(memberDao.do_update(memberBean)){
	%>
			<script type="text/javascript">
			alert("정상 수정 되었습니다!");
			</script>
	<%
				pageContext.forward("../mypage/mypage_Main.jsp");
			}else{
				System.out.println(email);
				System.out.println(password);
				System.out.println("실패~");
			}
		}else if(command.equals("guestjoin")){
			
			MemberDao memberDao = MemberDao.getInstance();
			
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String nickname = request.getParameter("nickname");
			System.out.println(email + "," + nickname + "," + password);
			//nickname = new String(nickname.getBytes("ISO-8859-1"), "utf-8"); 
			//System.out.println("nickname=" + nickname );

			System.out.println(email + "," + nickname + "," + password);
			
			Ya_MemberBean memberBean = new Ya_MemberBean(email, password, nickname, 0, 0, 1,
					-1);			
			
			if(memberDao.do_insert(memberBean)){
				System.out.println("성공");
	%>
			<script type="text/javascript">
			alert("가입성공!");
			</script>
	<%
			pageContext.forward("../main/ya_main.jsp");
			}else{
				System.out.println("실패");
	%>
				<script type="text/javascript">
				alert("가입실패!");
				</script>
	<%
			pageContext.forward("../main/ya_main.jsp");
			}
	/////////////////////////////////////////////////////////////////////////사장회원가입	
		}else if(command.equals("hostjoin")){		
			String premiumImgCnt = "";
			String normalImgCnt = "";
			String str ="";			
			// 사진 추가 부분 
			MemberDao memberDao = MemberDao.getInstance();
					MotelDao motelDao = MotelDao.getInstance();
					
					Ya_MemberBean memberBean = new Ya_MemberBean();
					Ya_MotelBean motelBean = new Ya_MotelBean();
			 	
				ImgDao imgDao = ImgDao.getInstance();
				
				// 메인 사진 추가 
				try{ 
					Ya_ImgBean imgBean = new Ya_ImgBean();
					String contextRoot = application.getContextPath();
					System.out.println("contextRoot : " + contextRoot);
					// 저장경로
					String dir = application.getRealPath("/img");
					String savefile = dir;
					
					String realFolder = "";
					String filename1 = "";
					String uploadfile = "";
					int maxSize = 1024*1024*100;
					String encType = "utf-8";
									
					ServletContext scontext = getServletContext();
					
					
					MultipartRequest multi = new MultipartRequest(request, savefile, maxSize, encType, new DefaultFileRenamePolicy());
					
					premiumImgCnt = multi.getParameter("premiumImgCnt");
					normalImgCnt = multi.getParameter("normalImgCnt");
					
				///////회원정보와, 모텔정보 받아서 dto에 저장 
					String email = multi.getParameter("email");
					String password = multi.getParameter("password");
					String nickname = multi.getParameter("nickname");
					System.out.println(email + "," + nickname + "," + password);
					
					
					//회원생성 --> 승인여부는 아직 0!
					
									
					str = email;
					memberBean.setEmail(email);
					memberBean.setPassword(password);
					memberBean.setNickname(nickname);
					memberBean.setAuth(1);
					memberBean.setPoint(0);
					memberBean.setIs_ok(0);
					
					//모텔생성 --> 승인여부는 아직 0!
					String name = multi.getParameter("motel");
					String address = multi.getParameter("address");
					String phone = multi.getParameter("phone");
					String checkin = multi.getParameter("checkIn");
					String checkout = multi.getParameter("checkOut");
					String normalPrice = multi.getParameter("normalPrice");
					String premiumPrice = multi.getParameter("premiumPrice");
					String normalCnt = multi.getParameter("normalCnt");
					String premiumCnt = multi.getParameter("premiumCnt");
					
					motelBean.setMotel_num(0);
					motelBean.setEmail(email);
					motelBean.setName(name);
					motelBean.setAddress(address);
					motelBean.setPhone(phone);
					motelBean.setNormal_cnt(Integer.parseInt(normalCnt));
					motelBean.setPremium_cnt(Integer.parseInt(premiumCnt));
					motelBean.setNormal_pri(Integer.parseInt(normalPrice));
					motelBean.setPremium_pri(Integer.parseInt(premiumPrice));
					motelBean.setIs_ok(0);
					motelBean.setCheck_in(checkin);
					motelBean.setCheck_out(checkout);
				
				///////////////////////////////////////////////////////////////////////////////////////////			
				
				
				 if(memberDao.do_insert(memberBean)){
						System.out.println("맴버추가성공");
						if(motelDao.do_insert(motelBean)){
							System.out.println("모텔추가성공");
									
		%>
						<script type="text/javascript">
						alert("가입성공!");
						</script>
		<%
						
						}else{
						System.out.println("실패");
		%>
						<script type="text/javascript">
						alert("가입실패!");
						</script>
		<%
						pageContext.forward("../main/ya_main.jsp");
						return;
					}
				}else{
					System.out.println("실패");
		%>
					<script type="text/javascript">
					alert("가입실패!");
					</script>
		<%
				pageContext.forward("../main/ya_main.jsp");
				return;
				}
				
					
					uploadfile = multi.getFilesystemName("mainimg");
					System.out.println("업로드파일"+uploadfile);
					File file = new File(savefile + uploadfile);
					System.out.println("uploadfile : " + uploadfile + "savefile" + savefile);
					
					
					
					int num = motelDao.getMotelNum(str);
					imgBean.setMotel_num(num);
					imgBean.setImg_name(contextRoot + "/img/" + uploadfile);
					imgBean.setImg_auth(0);
					
					imgDao.do_insert(imgBean);
					//////////////////////일반실 사진 
					for(int i=0;i<Integer.parseInt(normalImgCnt);i++){
						imgBean = new Ya_ImgBean();
						
						System.out.println("contextRoot : " + contextRoot);
						// 저장경로
												
						uploadfile = multi.getFilesystemName("noimg"+i);
						System.out.println("업로드파일"+uploadfile);
						file = new File(savefile + uploadfile);
						System.out.println("uploadfile : " + uploadfile + "savefile" + savefile);
						
						
						System.out.println("일반실사진 추가시 str" + str);
						num = motelDao.getMotelNum(str);
						imgBean.setMotel_num(num);
						imgBean.setImg_name(contextRoot + "/img/" + uploadfile);
						imgBean.setImg_auth(1);
						
						imgDao.do_insert(imgBean);
						
						
					}
					//////////////////////특실 사진 추가 
					if(Integer.parseInt(premiumImgCnt)>0){
					for(int i=0;i<Integer.parseInt(premiumImgCnt);i++){
						imgBean = new Ya_ImgBean();
						
						System.out.println("contextRoot : " + contextRoot);
						// 저장경로
												
						uploadfile = multi.getFilesystemName("preimg"+i);
						System.out.println("업로드파일"+uploadfile);
						file = new File(savefile + uploadfile);
						System.out.println("uploadfile : " + uploadfile + "savefile" + savefile);
						
						
						System.out.println("특실사진 추가시 str" + str);
						num = motelDao.getMotelNum(str);
						imgBean.setMotel_num(num);
						imgBean.setImg_name(contextRoot + "/img/" + uploadfile);
						imgBean.setImg_auth(2);
						
						imgDao.do_insert(imgBean);
						}
					
						pageContext.forward("../main/ya_main.jsp");
						return;
					}else{
						pageContext.forward("../main/ya_main.jsp");
						return;
					}
					
				}catch(Exception e){
					e.printStackTrace();
				}finally{
					
				}

						
			
				
		}
	%> 
	
	
	
</body>
</html>