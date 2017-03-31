package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.Beans.Ya_ReserveBean;

public class PointDao implements WorkArea {
	private boolean isS = true;
	private ConnectionMaker connectionMaker;
	
	private PointDao() {}
	
	public PointDao(ConnectionMaker connectionMaker){
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

	//////////////////////////////////////////////////////////////////////////////////////////////////////
	@Override
	public ArrayList<Object> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean do_insert(Object bean) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean do_update(Object bean) {
		// TODO Auto-generated method stub
		return false;
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


  public boolean do_add_point(int seq, int point, String div){ 
	  Connection conn = null;
	  PreparedStatement psmt = null;
	  ResultSet rs = null;
	  
	  int count = 0;
	  try {
		  	conn = connectionMaker.makeConnection();

			StringBuilder sql = new StringBuilder();
			StringBuilder sqldiv = new StringBuilder();
			if(div.equals("승인")){ // 포인트 적립, 취소
				sqldiv.append("(point+?) \n");
			}else if(div.equals("사용")){ // 포인트 사용 
				sqldiv.append("(point-?) \n");
			}

			sql.append("update ya_member set point=                      \n");
			 sql.append(sqldiv.toString());
			sql.append("where email=(select email from ya_reserve where seq=?)		\n");

			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 pstmt" + psmt.toString());

			psmt.setInt(1, point);
			psmt.setInt(2, seq);

			count = psmt.executeUpdate();

		} catch (SQLException e) {
			log("Fail search", e);
		}catch (ClassNotFoundException e) {
			log("Fail search", e);
		} finally {
			close(conn, psmt, rs);
		}

		return count>0 ? true : false;
  }
	  
	public ArrayList<Ya_ReserveBean> do_getpointlist(int pageNum, int pageSize, String email) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		Ya_ReserveBean bean = null;
		ArrayList<Ya_ReserveBean> bean_list = new ArrayList<Ya_ReserveBean>();

		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success do_getpointlist");
			StringBuilder sql = new StringBuilder();

			sql.append(
					"SELECT X.*                                                                                                                   \n");
			sql.append(
					"FROM(                                                                                                                        \n");
			sql.append(
					"SELECT ROWNUM AS RNUM, T1.*,T2.*                                                                                             \n");
			sql.append(
					"  FROM(                                                                                                                      \n");
			sql.append(
					"  SELECT A.USE_DT, B.NAME as mt_name, A.ROOM_TYPE, A.POINT, A.SEQ, B.MOTEL_NUM, a.name, A.PAY_DT, A.PRICE, A.STATE, A.EMAIL  \n");
			sql.append(
					"FROM YA_RESERVE A INNER JOIN YA_MOTEL B ON A.MOTEL_NUM = B.MOTEL_NUM                                                         \n");
			sql.append(
					"WHERE A.EMAIL = ?                                                                                    						 \n");
			sql.append(
					"ORDER BY A.USE_DT DESC) T1                                                                                                      \n");
			sql.append(
					"NATURAL join                                                                                                                 \n");
			sql.append(
					"(select count(seq) TOT_CNT from YA_RESERVE where EMAIL = ? group by email) T2                                 						 \n");
			sql.append(
					"  ) X                                                                                                                        \n");

			sql.append(" WHERE RNUM BETWEEN (? * (?-1)+1) AND (( ? * (?-1))+? ) \n");
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_getpointlist");

			psmt.setString(1, email);
			psmt.setString(2, email);
			psmt.setInt(3, pageSize);
			psmt.setInt(4, pageNum);
			psmt.setInt(5, pageSize);
			psmt.setInt(6, pageNum);
			psmt.setInt(7, pageSize);

			rs = psmt.executeQuery();
			log("4/6 Success do_getpointlist");

			while (rs.next()) {
				bean = new Ya_ReserveBean(rs.getInt("seq"), rs.getInt("motel_num"), rs.getString("email"),
						rs.getString("name"), rs.getString("room_type"), rs.getString("pay_dt"), rs.getString("use_dt"),
						rs.getInt("price"), rs.getInt("state"), rs.getInt("point"), rs.getString("mt_name"));
				bean.setTot_cnt(rs.getInt("TOT_CNT"));
				bean_list.add(bean);
			}
			log("5/6 Success do_getpointlist");
		} catch (SQLException e) {
			log("Fail do_getlist", e);
		}catch (ClassNotFoundException e) {
			log("Fail do_getlist", e);
		} finally {
			System.out.println(bean_list);
			close(conn, psmt, rs);
			log("6/6 Success do_getpointlist");
		}
		return bean_list;
	}
}
