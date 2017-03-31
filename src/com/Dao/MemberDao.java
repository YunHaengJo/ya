package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.Beans.Ya_ImgBean;
import com.Beans.Ya_MemberBean;
import com.Beans.Ya_MotelBean;

public class MemberDao implements WorkArea {

	private boolean isS = true;
	private ConnectionMaker connectionMaker;
	
	private MemberDao() {}
	
	
	public MemberDao(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}

	public void close(Connection conn, Statement stmt, ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
	}

	public void close(Connection conn, Statement stmt) {
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
	}

	public void log(String msg) {
		if (isS) {
			System.out.println(getClass() + ": " + msg);
		}
	}

	public void log(String msg, Exception e) {
		if (isS) {
			System.out.println(e + " : " + getClass() + " : " + msg);
		}
	}

	public String do_givePw(String email) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String password = null;

		StringBuilder sql = new StringBuilder();

		sql.append("SELECT PASSWORD FROM YA_MEMBER WHERE EMAIL= ? \n");

		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());

			psmt.setString(1, email);

			rs = psmt.executeQuery();

			while (rs.next()) {
				password = rs.getString("password");
			}
		} catch (SQLException e) {
			log("비밀번호 전송 오류!", e);
			password = null;
		} catch (ClassNotFoundException e) {
			log("비밀번호 전송 오류!", e);
			password = null;
		}finally {
			this.close(conn, psmt, rs);
		}

		return password;
	}

	public Ya_MemberBean do_login(String email, String password) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		Ya_MemberBean member = null;

		StringBuilder sql = new StringBuilder();

		sql.append("SELECT EMAIL,           \n");
		sql.append("  NICKNAME,             \n");
		sql.append("  AUTH,                 \n");
		sql.append("  POINT,                \n");
		sql.append("  IS_OK                 \n");
		sql.append("FROM YA_MEMBER          \n");
		sql.append("WHERE EMAIL = ?         \n");
		sql.append("AND PASSWORD= ?         \n");

		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());

			psmt.setString(1, email);
			psmt.setString(2, password);

			rs = psmt.executeQuery();

			while (rs.next()) {
				member = new Ya_MemberBean();
				member.setEmail(rs.getString("email"));
				member.setNickname(rs.getString("nickname"));
				if (rs.getInt("auth") == 1) {
					member.setAuth(rs.getInt("auth"));
					member.setMotel_num(search_motelNum(email));
				} else {
					member.setAuth(rs.getInt("auth"));
					member.setMotel_num(-1);
				}
				member.setPoint(rs.getInt("point"));
				member.setIs_ok(rs.getInt("is_ok"));
			}
		} catch (SQLException e) {
			log("로그인 오류!", e);
			member = null;
		}catch (ClassNotFoundException e) {
			log("로그인 오류!", e);
			member = null;
		} finally {
			this.close(conn, psmt, rs);
		}

		return member;
	}

	public boolean do_idValidation(String email) {
		Connection conn = null;
		PreparedStatement psmt = null;

		StringBuilder sql = new StringBuilder();

		sql.append("SELECT EMAIL FROM YA_MEMBER WHERE EMAIL=? \n");

		int count = 0;
		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());

			psmt.setString(1, email);

			count = psmt.executeUpdate();

		} catch (SQLException e) {
			log("아이디 중복 검사 오류!", e);
			count = -1;
		} catch (ClassNotFoundException e) {
			log("아이디 중복 검사 오류!", e);
			count = -1;
		} finally {
			this.close(conn, psmt);
		}

		return count == 0 ? true : false;
	}

	public boolean do_nicknameValidation(String nickname) {
		Connection conn = null;
		PreparedStatement psmt = null;

		StringBuilder sql = new StringBuilder();

		sql.append("SELECT EMAIL FROM YA_MEMBER WHERE NICKNAME=? \n");

		int count = 0;
		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());

			psmt.setString(1, nickname);

			count = psmt.executeUpdate();

		} catch (SQLException e) {
			log("닉네임 중복검사 오류!", e);
			count = -1;
		} catch (ClassNotFoundException e) {
			log("닉네임 중복검사 오류!", e);
			count = -1;
		}finally {
			this.close(conn, psmt);
		}

		return count == 0 ? true : false;
	}

	@Override
	public boolean do_update(Object bean) {
		// TODO Auto-generated method stub
		Connection conn = null;
		PreparedStatement psmt = null;
		Ya_MemberBean castBean = (Ya_MemberBean) bean;

		StringBuilder sql = new StringBuilder();
		sql.append("	UPDATE  YA_MEMBER              \n");
		sql.append("	SET PASSWORD = ?			   \n");
		sql.append("    WHERE EMAIL = ?		           \n");

		int count = 0;
		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());

			psmt.setString(1, castBean.getPassword());
			psmt.setString(2, castBean.getEmail());

			count = psmt.executeUpdate();
		} catch (SQLException e) {
			log("회원가입 오류!", e);
		} catch (ClassNotFoundException e) {
			log("회원가입 오류!", e);
		} finally {
			this.close(conn, psmt);
		}

		return count > 0 ? true : false;
	}

	public ArrayList<Object> do_search_notIsOk(int pageNum, int pageSize, String search_div, String search_word) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		ArrayList<Object> list = new ArrayList<Object>();
		try {
			conn = connectionMaker.makeConnection();
			StringBuilder sql = new StringBuilder();

			StringBuilder sqlParam = new StringBuilder();

			if (search_div.toUpperCase().equals("NICKNAME")) {
				sqlParam.append("AND NICKNAME like '%" + search_word + "%' \n");
			} else if (search_div.toUpperCase().equals("EMAIL")) {
				sqlParam.append("AND EMAIL like '%" + search_word + "%' \n");
			}

			sql.append(
					"SELECT X.*                                                                                                                         \n");
			sql.append(
					"FROM(                                                                                                                              \n");
			sql.append(
					"	SELECT ROWNUM AS RNUM, A.*, B.*                                                              \n");
			sql.append(
					"	FROM  (                                                                                                                        \n");
			sql.append(
					"		SELECT *                                                                                      \n");
			sql.append(
					"		FROM YA_MEMBER WHERE IS_OK=0                                                                                                             \n");
			sql.append(sqlParam.toString());
			sql.append(
					"			) A                                                                                                                    \n");
			sql.append(
					"		NATURAL JOIN                                                                                                               \n");
			sql.append(
					"		(                                                                                                                          \n");
			sql.append(
					"			SELECT COUNT(*) TOT_CNT                                                                                                \n");
			sql.append(
					"			FROM YA_MEMBER WHERE IS_OK=0                                                                                                        \n");
			sql.append(sqlParam.toString());
			sql.append(
					"                                                                                                                                   \n");
			sql.append(
					"		) B                                                                                                                        \n");
			sql.append(
					"	) X                                                                                                                            \n");
			sql.append("WHERE RNUM BETWEEN (? * (? -1)+1) AND (( ? * (? -1))+ ? ) \n");

			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());

			psmt.setInt(1, pageSize);
			psmt.setInt(2, pageNum);
			psmt.setInt(3, pageSize);
			psmt.setInt(4, pageNum);
			psmt.setInt(5, pageSize);

			rs = psmt.executeQuery();

			while (rs.next()) {
				Ya_MemberBean bean = new Ya_MemberBean();
				bean.setEmail(rs.getString("email"));
				bean.setNickname(rs.getString("nickname"));
				bean.setAuth(rs.getInt("auth"));
				bean.setIs_ok(rs.getInt("is_ok"));
				bean.setTot_cnt(rs.getInt("tot_cnt"));
				list.add(bean);
			}

		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
			return null;
		} finally {
			close(conn, psmt, rs);
		}
		return list;
	}

	@Override
	public ArrayList<Object> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		ArrayList<Object> list = new ArrayList<Object>();
		try {
			conn = connectionMaker.makeConnection();
			StringBuilder sql = new StringBuilder();
			sql.append(
					"  SELECT X.*									                                                 \n");
			sql.append(
					"  FROM(                                                                                           \n");
			sql.append(
					" SELECT ROWNUM AS RNUM, T1.*,T2.*                                                                 \n");
			sql.append(
					"  FROM(                                                                                           \n");
			sql.append(
					"      SELECT EMAIL, NAME, ADDRESS, NORMAL_CNT, PREMIUM_CNT, IS_OK,			                       \n");
			sql.append(
					"      MOTEL_NUM		                                                                            \n");
			sql.append(
					"          FROM YA_MOTEL										                                 \n");
			sql.append(
					"       WHERE IS_OK=1			                                                                  \n");
			sql.append(
					"      ORDER BY MOTEL_NUM DESC		                    						                   \n");
			sql.append(
					"      ) T1					                                                     				   \n");
			sql.append(
					"      NATURAL JOIN (		                                                                      \n");
			sql.append(
					"      select count(MOTEL_NUM) from YA_MOTEL	                                                 \n");
			sql.append(
					"       ) T2										                                            \n");
			sql.append(
					"        ) X					                                                                \n");
			sql.append(
					"      WHERE RNUM BETWEEN 			                                                               \n");
			sql.append(
					"      (? * (?-1)+1) AND (?*( ? - 1)+? )              												\n");

			// sql.append("WHERE RNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND
			// (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE ) \n");

			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());

			psmt.setInt(1, pageSize);
			psmt.setInt(2, pageNum);
			psmt.setInt(3, pageSize);
			psmt.setInt(4, pageNum);
			psmt.setInt(5, pageSize);

			rs = psmt.executeQuery();

			while (rs.next()) {
				Ya_MotelBean motelBean = new Ya_MotelBean();
				motelBean.setEmail(rs.getString(2));
				motelBean.setName(rs.getString(3));
				motelBean.setAddress(rs.getString(4));
				motelBean.setNormal_cnt(rs.getInt(5));
				motelBean.setPremium_cnt(rs.getInt(6));
				motelBean.setMotel_num(rs.getInt(8));
				list.add(motelBean);
			}

		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			close(conn, psmt, rs);
		}
		return list;
	}

	@Override
	public boolean do_insert(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		Ya_MemberBean castBean = (Ya_MemberBean) bean;

		StringBuilder sql = new StringBuilder();
		sql.append("INSERT                \n");
		sql.append("INTO YA_MEMBER VALUES \n");
		sql.append("  (                   \n");
		sql.append("    ?,                \n");
		sql.append("    ?,                \n");
		sql.append("    ?,                \n");
		sql.append("    ?,                \n");
		sql.append("    0,                \n");
		sql.append("    ?                 \n");
		sql.append("  )                   \n");

		int count = 0;
		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());

			psmt.setString(1, castBean.getEmail());
			psmt.setString(2, castBean.getPassword());
			psmt.setString(3, castBean.getNickname());
			psmt.setInt(4, castBean.getAuth());
			psmt.setInt(5, castBean.getIs_ok());

			count = psmt.executeUpdate();
		} catch (SQLException e) {
			log("회원가입 오류!", e);
		} catch (ClassNotFoundException e) {
			log("회원가입 오류!", e);
		} finally {
			this.close(conn, psmt);
		}

		return count > 0 ? true : false;
	}

	@Override
	public boolean do_delete(Object bean) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean do_upsert(Object bean) {
		// TODO Auto-generated method stub
		return false;
	}

	public ArrayList<Object> do_detail(Object bean) {
		// TODO Auto-generated method stub
		return null;
	}

	public Object do_detail(int seq) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		Object obj = new Object();
		try {
			conn = connectionMaker.makeConnection();
			StringBuilder sql = new StringBuilder();
			sql.append(
					"  SELECT *									                                                 \n");
			sql.append(
					"  FROM(                                                                                           \n");
			sql.append(
					" SELECT *						                                                                  \n");
			sql.append(
					"  FROM YA_MOTEL A INNER JOIN YA_IMG B                                                             \n");
			sql.append(
					"  ON A.MOTEL_NUM=B.MOTEL_NUM												                       \n");
			sql.append(
					"  WHERE B.MOTEL_NUM = ?) C JOIN YA_MEMBER D                                                        \n");
			sql.append(
					"  ON C.EMAIL = D.EMAIL										                                 \n");

			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());

			psmt.setInt(1, seq);

			rs = psmt.executeQuery();
			int count = 0;
			Ya_MotelBean motelBean = new Ya_MotelBean();
			ArrayList<Ya_ImgBean> imglist = new ArrayList<Ya_ImgBean>();

			while (rs.next()) {
				if (count == 0) {
					motelBean.setEmail(rs.getString("email"));
					motelBean.setName(rs.getString("name"));
					motelBean.setPhone(rs.getString("phone"));
					motelBean.setAddress(rs.getString("address"));
					motelBean.setNormal_cnt(rs.getInt("normal_cnt"));
					motelBean.setPremium_cnt(rs.getInt("premium_cnt"));
					motelBean.setNormal_pri(rs.getInt("normal_pri"));
					motelBean.setPremium_pri(rs.getInt("premium_pri"));
					motelBean.setCheck_in(rs.getString("check_in"));
					motelBean.setCheck_out(rs.getString("check_out"));
					Ya_ImgBean imgBean = new Ya_ImgBean();
					imgBean.setImg_auth(rs.getInt(14));
					imgBean.setImg_name(rs.getString(13));
					imglist.add(imgBean);
					++count;
				} else {
					Ya_ImgBean imgBean = new Ya_ImgBean();
					imgBean.setImg_auth(rs.getInt(14));
					imgBean.setImg_name(rs.getString(13));
					imglist.add(imgBean);
				}
			}
			motelBean.setImgs(imglist);
			obj = motelBean;
		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			close(conn, psmt, rs);
		}

		return obj;
	}

	public boolean do_admin_access(String email) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int count1 = 0;
		int count2 = 0;

		try {
			StringBuilder sql1 = new StringBuilder();

			sql1.append(" UPDATE YA_MOTEL SET IS_OK=1               \n ");
			sql1.append(" WHERE EMAIL=?								\n ");

			conn = connectionMaker.makeConnection();
			conn.setAutoCommit(false);
			log("2/6 Success do_admin_access");

			System.out.println("0 sql1" + sql1.toString());
			psmt = conn.prepareStatement(sql1.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_admin_access");

			psmt.setString(1, email);

			count1 = psmt.executeUpdate();
			psmt.clearParameters();
			log("4/6 Success do_admin_access");

			StringBuilder sql2 = new StringBuilder();

			sql2.append(" UPDATE YA_MEMBER SET IS_OK=1          \n");
			sql2.append(" WHERE EMAIL=? 						\n");

			System.out.println("0 sql2" + sql2.toString());
			psmt = conn.prepareStatement(sql2.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("5/6 Success do_admin_access");

			psmt.setString(1, email);

			count2 = psmt.executeUpdate();
			conn.commit();
			log("6/6 Success do_admin_access");
		} catch (Exception e) {
			try {
				conn.rollback();
				conn.setAutoCommit(true);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			log("Fail do_admin_access", e);
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			close(conn, psmt, null);
			log("7/6 Success do_admin_access");
		}
		return ((count1 > 0) && (count2 > 0)) ? true : false;
	}

	public int search_motelNum(String email) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		String Motel_num = "";

		try {
			conn = connectionMaker.makeConnection();

			StringBuilder sql = new StringBuilder();

			sql.append(" select motel_num from YA_MOTEL where email = ?                 \n");

			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 pstmt" + psmt.toString());

			psmt.setString(1, email);

			rs = psmt.executeQuery();

			while (rs.next()) {
				Motel_num = rs.getString("motel_num");

			}

		} catch (SQLException e) {
			log("Fail search", e);
		} catch (ClassNotFoundException e) {
			log("Fail search", e);
		}finally {
			close(conn, psmt, rs);
		}

		return Integer.parseInt(Motel_num);
	}
	public int do_search_point(String email){
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int point=0;
		
		try {
			conn = connectionMaker.makeConnection();

			StringBuilder sql = new StringBuilder();

			sql.append(" select point from YA_MEMBER where email = ?                 \n");

			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 pstmt" + psmt.toString());

			psmt.setString(1, email);

			rs = psmt.executeQuery();

			while (rs.next()) {
				point = rs.getInt("POINT");

			}

		} catch (SQLException e) {
			log("Fail search", e);
		} catch (ClassNotFoundException e) {
			log("Fail search", e);
		} finally {
			close(conn, psmt, rs);
		}

		return point;
	}
	
	// 승인 사진 뿌리기 
	public List<Ya_ImgBean> do_detail_photo(int motel_num) {
		Connection conn = null;
	    PreparedStatement psmt = null;
	    ResultSet rs = null;
	    
	    List<Ya_ImgBean> list = new ArrayList<>();
	       
	    try{
	    	conn = connectionMaker.makeConnection();
	    	log("1/6 Success detail");
			StringBuilder sql = new StringBuilder();
			sql.append(" select * from YA_IMG                                                         \n");
			sql.append(" where MOTEL_NUM = ?                                                                  \n");
			log("2/6 Success detail");
			System.out.println("0 sql"+sql.toString()); 
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 pstmt"+psmt.toString());
	                 
			psmt.setInt(1, motel_num);
			
	        rs = psmt.executeQuery();
	        log("4/6 Success search");
	       	         
	        while(rs.next()){
	        	
	        	Ya_ImgBean dto = new Ya_ImgBean(rs.getInt(1),
	        							rs.getInt(2),
	        							rs.getString(3),
	        							rs.getInt(4)
	        			);
	        	list.add(dto);
	        	
	        	
	         }
	        
	      }catch(SQLException e){
	         log("Fail search",e);
	      }catch(ClassNotFoundException e){
		         log("Fail search",e);
		      }finally{
	         close(conn, psmt, rs);
	      }
		
		return list;
	}
}
