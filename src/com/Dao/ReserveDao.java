package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.Beans.Ya_ReserveBean;

public class ReserveDao implements WorkArea {
	private boolean isS = true;
	private ConnectionMaker connectionMaker;
	
	private ReserveDao() {}
	
	public ReserveDao(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}

	public void log(String msg) {
		if (isS) {
			System.out.println(getClass() + ":" + msg);
		}
	}

	public void log(String msg, Exception e) {
		if (isS) {
			System.out.println(e + " : " + getClass() + " : " + msg);
		}
	}

	public void close(Connection conn, Statement psmt, ResultSet rs) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
			}
		}
		if (psmt != null) {
			try {
				psmt.close();
			} catch (SQLException e) {
			}
		}
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
			}
		}
	}

	@Override
	public ArrayList<Object> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		return null;
	}

	@Override
	public boolean do_insert(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int count = 0;

		Ya_ReserveBean dto = (Ya_ReserveBean) bean;

		try {
			conn = connectionMaker.makeConnection();
			StringBuilder sql = new StringBuilder();

			sql.append(" INSERT INTO YA_RESERVE     \n ");
			sql.append(" (SEQ, MOTEL_NUM, EMAIL, NAME, ROOM_TYPE,PAY_DT, USE_DT, PRICE,STATE, POINT)  \n ");
			sql.append(" VALUES(SEQ_YA_RESERVE.NEXTVAL,?,?,?,?,SYSDATE,?,?,0,?)   \n ");
			// seq 설정후 SEQ.NEXTVAL
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_update");

			psmt.setInt(1, dto.getMotel_num());
			psmt.setString(2, dto.getEmail());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getRoom_type());
			psmt.setString(5, dto.getUse_dt());
			psmt.setInt(6, dto.getPrice());
			psmt.setInt(7, dto.getPoint());

			count = psmt.executeUpdate();
			log("4/6 Success do_update");
		} catch (SQLException e) {
			log("Fail do_update", e);
		} catch (ClassNotFoundException e) {
			log("Fail do_update", e);
		} finally {
			close(conn, psmt, rs);
			log("5/6 Success do_update");
		}
		return count > 0 ? true : false;
	}

	@Override
	public boolean do_update(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		Ya_ReserveBean dto = (Ya_ReserveBean) bean;

		int count = 0;

		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success do_update");
			StringBuilder sql = new StringBuilder();

			sql.append(" UPDATE YA_RESERVE     \n ");
			sql.append(" SET STATE = 2         \n ");
			sql.append(" WHERE SEQ = ?         \n ");

			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_update");

			psmt.setInt(1, dto.getSeq());

			count = psmt.executeUpdate();
			log("4/6 Success do_update");
		} catch (SQLException e) {
			log("Fail do_update", e);
		} catch (ClassNotFoundException e) {
			log("Fail do_update", e);
		} finally {
			close(conn, psmt, rs);
			log("5/6 Success do_update");
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

	@Override
	public Object do_detail(int seq) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<Ya_ReserveBean> do_guest_getlist(int pageNum, int pageSize, String email, String date1,
			String date2) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		ArrayList<Ya_ReserveBean> data_list = new ArrayList<Ya_ReserveBean>();

		// 제목 검색

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
					"      SELECT A.SEQ, to_date(A.PAY_DT,'YYYY-MM-DD') PAY_DT, A.USE_DT, A.ROOM_TYPE, B.NAME, A.MOTEL_NUM,                                      \n");
			sql.append(
					"      A.PRICE, A.STATE                                                                            \n");
			sql.append(
					"          FROM YA_RESERVE A INNER JOIN YA_MOTEL B ON A.MOTEL_NUM                                  \n");
			// search
			// search end
			sql.append(
					"       = B.MOTEL_NUM			                                                                  \n");
			sql.append(
					"      WHERE A.EMAIL = ? and                     						                   \n");
			sql.append(
					"      pay_dt BETWEEN to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD')+1                                                  				   \n");
			sql.append(
					"      ORDER BY A.SEQ DESC) T1                                                                     \n");
			sql.append(
					"      NATURAL join								                                                   \n");
			sql.append(
					"     (select count(seq) TOT_CNT from YA_RESERVE where EMAIL =                                             \n");
			sql.append("      ? AND                                                                \n");

			sql.append(
					"      pay_dt BETWEEN to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD')+1   group by email                                     					\n");
			sql.append(
					"      ) T2				                                                                           \n");
			sql.append(
					"      ) X							                                                               \n");
			sql.append(
					"      WHERE RNUM BETWEEN 			                                                               \n");
			sql.append(
					"      (? * (?-1)+1) AND (?*( ? - 1)+? )              												\n");

			// sql.append("WHERE RNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND
			// (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE ) \n");

			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());

			psmt.setString(1, email);
			psmt.setString(2, date1);
			psmt.setString(3, date2);
			psmt.setString(4, email);
			psmt.setString(5, date1);
			psmt.setString(6, date2);

			psmt.setInt(7, pageSize);
			psmt.setInt(8, pageNum);
			psmt.setInt(9, pageSize);
			psmt.setInt(10, pageNum);
			psmt.setInt(11, pageSize);

			rs = psmt.executeQuery();

			while (rs.next()) {
				Ya_ReserveBean reserveBean = new Ya_ReserveBean();
				reserveBean.setSeq(rs.getInt("seq"));
				reserveBean.setPay_dt(rs.getString(3));
				reserveBean.setUse_dt(rs.getString(4));
				reserveBean.setRoom_type(rs.getString("room_type"));
				reserveBean.setName(rs.getString(6));
				reserveBean.setTot_cnt(rs.getInt("TOT_CNT"));
				reserveBean.setState(rs.getInt("state"));
				reserveBean.setMotel_num(rs.getInt("motel_num"));
				reserveBean.setPrice(rs.getInt("price"));
				data_list.add(reserveBean);
			}

		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			System.out.println(data_list);
			close(conn, psmt, rs);
		}
		return data_list;
	}

	public ArrayList<Ya_ReserveBean> do_host_getlist(int pageNum, int pageSize, int motel_num, String date1,
			String date2) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		ArrayList<Ya_ReserveBean> data_list = new ArrayList<Ya_ReserveBean>();

		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success do_host_getlist");
			StringBuilder sql = new StringBuilder();

			sql.append(" SELECT X.*                                                             \n");
			sql.append(" FROM(                                                                  \n");
			sql.append(" SELECT ROWNUM AS RNUM, T1.*,T2.*                                       \n");
			sql.append("   FROM(                                                                \n");
			sql.append(" SELECT to_date(PAY_DT,'YYYY-MM-DD'), USE_DT, NAME, ROOM_TYPE, PRICE, STATE, SEQ, POINT       \n");
			sql.append(" FROM YA_RESERVE                                                        \n");
			sql.append(" WHERE MOTEL_NUM=? AND pay_dt BETWEEN to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD')+1 					    \n");
			sql.append(" ORDER BY SEQ DESC) T1                                                  \n");
			sql.append(" NATURAL JOIN (                                                         \n");
			sql.append("   select count(seq) TOT_CNT from YA_RESERVE WHERE MOTEL_NUM=?                  \n");
			sql.append(
					"   and pay_dt BETWEEN to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD')+1 ) T2                                                                 \n");
			sql.append("   ) X                                                                  \n");

			sql.append("WHERE RNUM BETWEEN (? * (?-1)+1) AND (( ? * (?-1))+? ) 					\n");
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_host_getlist");

			psmt.setInt(1, motel_num);
			psmt.setString(2, date1);
			psmt.setString(3, date2);
			psmt.setInt(4, motel_num);
			psmt.setString(5, date1);
			psmt.setString(6, date2);

			psmt.setInt(7, pageSize);
			psmt.setInt(8, pageNum);
			psmt.setInt(9, pageSize);
			psmt.setInt(10, pageNum);
			psmt.setInt(11, pageSize);

			rs = psmt.executeQuery();
			log("4/6 Success do_host_getlist");

			while (rs.next()) {
				Ya_ReserveBean reserveBean = new Ya_ReserveBean();

				reserveBean.setPay_dt(rs.getString(2));
				reserveBean.setUse_dt(rs.getString(3));
				reserveBean.setRoom_type(rs.getString(5));
				reserveBean.setName(rs.getString(4));
				reserveBean.setPrice(rs.getInt(6));
				reserveBean.setState(rs.getInt(7));
				reserveBean.setSeq(rs.getInt(8));
				reserveBean.setTot_cnt(rs.getInt("TOT_CNT"));
				reserveBean.setPoint(rs.getInt("point"));
				data_list.add(reserveBean);
			}
			log("5/6 Success do_host_getlist");
		} catch (SQLException e) {
			log("Fail do_host_getlist", e);
		} catch (ClassNotFoundException e) {
			log("Fail do_host_getlist", e);
		} finally {
			System.out.println(data_list);
			close(conn, psmt, rs);
			log("6/6 Success do_host_getlist");
		}
		return data_list;
	}

	public boolean do_access_reserve(int seq) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int count = 0;

		try {
				conn = connectionMaker.makeConnection();
				log("4/6 Success do_access_reserve");

				StringBuilder sql2 = new StringBuilder();

				sql2.append(" UPDATE YA_RESERVE \n ");
				sql2.append(" SET STATE = 1     \n ");
				sql2.append(" WHERE SEQ = ?     \n ");
				sql2.append(" AND STATE = 0     \n ");

				System.out.println("0 sql2" + sql2.toString());
				psmt = conn.prepareStatement(sql2.toString());
				System.out.println("1 psmt" + psmt.toString());
				log("5/6 Success do_access_reserve");

				psmt.setInt(1, seq);

				count = psmt.executeUpdate();
				log("6/6 Success do_access_reserve");
		} catch (Exception e) {
			log("Fail do_admin_access", e);
		} finally {
			close(conn, psmt, rs);
			log("7/6 Success do_access_reserve");
		}
		return count > 0  ? true : false;
	}

	public boolean do_update(int seq) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int count = 0;

		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success do_update");
			StringBuilder sql = new StringBuilder();

			sql.append(" UPDATE YA_RESERVE     \n ");
			sql.append(" SET STATE = 2         \n ");
			sql.append(" WHERE SEQ = ?         \n ");

			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_update");

			psmt.setInt(1, seq);

			count = psmt.executeUpdate();
			log("4/6 Success do_update");
		} catch (SQLException e) {
			log("Fail do_update", e);
		}catch (ClassNotFoundException e) {
			log("Fail do_update", e);
		} finally {
			close(conn, psmt, rs);
			log("5/6 Success do_update");
		}
		return count > 0 ? true : false;
	}
	public int do_search_seq(String date, String email){
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		int seq = 0 ;
		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success do_update");
			StringBuilder sql = new StringBuilder();

			sql.append(" SELECT SEQ FROM YA_RESERVE    \n ");
			sql.append(" WHERE USE_DT = ? AND EMAIL = ?      \n ");

			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_update");

			psmt.setString(1, date);
			psmt.setString(2, email);

			rs = psmt.executeQuery();
			
			while(rs.next()){
			seq = rs.getInt("seq");
			}
			log("4/6 Success do_update");
		} catch (SQLException e) {
			log("Fail do_update", e);
		}catch (ClassNotFoundException e) {
			log("Fail do_update", e);
		} finally {
			close(conn, psmt, rs);
			log("5/6 Success do_update");
		}
		return seq;
	}
	
	public int do_searchPointCancle(int seq){
		int point=0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success do_update");
			StringBuilder sql = new StringBuilder();

			sql.append(" SELECT POINT FROM YA_RESERVE    \n ");
			sql.append(" WHERE SEQ = ?      \n ");

			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_update");

			psmt.setInt(1, seq);

			rs = psmt.executeQuery();
			
			while(rs.next()){
				point = rs.getInt("point");
			}
			log("4/6 Success do_update");
		} catch (SQLException e) {
			log("Fail do_update", e);
		}catch (ClassNotFoundException e) {
			log("Fail do_update", e);
		} finally {
			close(conn, psmt, rs);
			log("5/6 Success do_update");
		}
		
		return  point;
	}
}
