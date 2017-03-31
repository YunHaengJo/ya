package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.Beans.Ya_NoticeBean;

public class NoticeDao implements WorkArea {
	private boolean isS = true;
	private ConnectionMaker connectionMaker;
	
	private NoticeDao() {}
	
	public NoticeDao(ConnectionMaker connectionMaker){
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

	@Override
	public ArrayList<Object> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		StringBuilder sql = new StringBuilder();

		StringBuilder sqlParam = new StringBuilder();

		if (search_div.toUpperCase().equals("TITLE")) {
			sqlParam.append("WHERE TITLE like '%" + search_word + "%' \n");
		} else if (search_div.toUpperCase().equals("EMAIL")) {
			sqlParam.append("WHERE EMAIL like '%" + search_word + "%' \n");
		}

		sql.append(
				"SELECT X.*                                                                                                                         \n");
		sql.append(
				"FROM(                                                                                                                              \n");
		sql.append(
				"	SELECT ROWNUM AS RNUM, A.SEQ, A.TITLE, A.CONTENT, A.UPLOAD_DT,B.*                                                              \n");
		sql.append(
				"	FROM  (                                                                                                                        \n");
		sql.append(
				"		SELECT SEQ, TITLE, CONTENT, UPLOAD_DT                                                                                      \n");
		sql.append(
				"		FROM YA_NOTICE                                                                                                             \n");
		sql.append(sqlParam.toString());
		sql.append(
				"                                                                                                                                   \n");
		sql.append(
				"		ORDER BY UPLOAD_DT                                                                                                         \n");
		sql.append(
				"			) A                                                                                                                    \n");
		sql.append(
				"		NATURAL JOIN                                                                                                               \n");
		sql.append(
				"		(                                                                                                                          \n");
		sql.append(
				"			SELECT COUNT(*) TOT_CNT                                                                                                \n");
		sql.append(
				"			FROM YA_NOTICE                                                                                                         \n");
		sql.append(sqlParam.toString());
		sql.append(
				"                                                                                                                                   \n");
		sql.append(
				"		) B                                                                                                                        \n");
		sql.append(
				"	) X                                                                                                                            \n");
		sql.append("WHERE RNUM BETWEEN (" + pageSize + " * (" + pageNum + " -1)+1) AND (( " + pageSize + " * ("
				+ pageNum + " -1))+ " + pageSize + " ) \n");

		ArrayList<Object> list = new ArrayList<Object>();

		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());

			System.out.println("0 sql" + sql.toString());
			rs = psmt.executeQuery();

			while (rs.next()) {
				Ya_NoticeBean bean = new Ya_NoticeBean();

				bean.setContent(rs.getString("content"));
				bean.setSeq(rs.getInt("seq"));
				bean.setTitle(rs.getString("title"));
				bean.setUpload_dt(rs.getString("upload_dt"));
				bean.setTot_cnt(rs.getInt("tot_cnt"));

				list.add(bean);
			}
		} catch (SQLException e) {
			log("공지사항 써치 실패", e);
			list = null;
		} catch (ClassNotFoundException e) {
			log("공지사항 써치 실패", e);
			list = null;
		} 
		finally {
			this.close(conn, psmt, rs);
		}

		return list;
	}

	@Override
	public boolean do_insert(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;

		StringBuilder sql = new StringBuilder();
		Ya_NoticeBean castbean = (Ya_NoticeBean) bean;

		sql.append("INSERT INTO YA_NOTICE VALUES             \n");
		sql.append("  (seq_ya_notice.nextval, ?, ?, SYSDATE  \n");
		sql.append("  )                                      \n");
		int count = 0;
		try {
			conn = connectionMaker.makeConnection();
			psmt = conn.prepareStatement(sql.toString());

			psmt.setString(1, castbean.getTitle());
			psmt.setString(2, castbean.getContent());

			count = psmt.executeUpdate();

			System.out.println(sql.toString());
		} catch (SQLException e) {
			log("공지사항 인서트 실패!", e);
		}catch (ClassNotFoundException e) {
			log("공지사항 인서트 실패!", e);
		}
		return count > 0 ? true : false;
	}

	@Override
	public boolean do_update(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		Ya_NoticeBean castbean = (Ya_NoticeBean) bean;

		StringBuilder sql = new StringBuilder();

		sql.append("UPDATE YA_NOTICE      \n");
		sql.append("SET TITLE  =?,        \n");
		sql.append("  CONTENT  =?,        \n");
		sql.append("  UPLOAD_DT=SYSDATE   \n");
		sql.append("WHERE SEQ  =?         \n");

		int count = 0;
		try {
			conn = connectionMaker.makeConnection();
			psmt = conn.prepareStatement(sql.toString());

			psmt.setString(1, castbean.getTitle());
			psmt.setString(2, castbean.getContent());
			psmt.setInt(3, castbean.getSeq());

			count = psmt.executeUpdate();

		} catch (SQLException e) {
			log("공지사항 업데이트 실패!", e);
		}catch (ClassNotFoundException e) {
			log("공지사항 업데이트 실패!", e);
		}
		return count > 0 ? true : false;
	}

	@Override
	public boolean do_delete(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;

		StringBuilder sql = new StringBuilder();

		sql.append("DELETE FROM YA_NOTICE\n");
		sql.append("WHERE SEQ=?          \n");

		int count = 0;
		try {
			conn = connectionMaker.makeConnection();
			psmt = conn.prepareStatement(sql.toString());

			psmt.setInt(1, ((Ya_NoticeBean) bean).getSeq());

			count = psmt.executeUpdate();

			System.out.println(sql.toString());
		} catch (SQLException e) {
			log("공지사항 삭제 실패!", e);
		}catch (ClassNotFoundException e) {
			log("공지사항 삭제 실패!", e);
		}
		return count > 0 ? true : false;
	}

	@Override
	public boolean do_upsert(Object bean) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Object do_detail(int seq) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		Ya_NoticeBean bean = null;
		StringBuilder sql = new StringBuilder();

		sql.append("SELECT SEQ, TITLE, CONTENT, UPLOAD_DT \n");
		sql.append("FROM YA_NOTICE                   \n");
		sql.append("WHERE SEQ=?                      \n");

		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());

			psmt.setInt(1, seq);

			rs = psmt.executeQuery();

			while (rs.next()) {
				bean = new Ya_NoticeBean();

				bean.setSeq(rs.getInt("seq"));
				bean.setContent(rs.getString("content"));
				bean.setTitle(rs.getString("title"));
				bean.setUpload_dt(rs.getString("upload_dt"));

			}
		} catch (SQLException e) {
			log("공지사항 디테일 실패", e);
			bean = null;
		}catch (ClassNotFoundException e) {
			log("공지사항 디테일 실패", e);
			bean = null;
		} finally {
			this.close(conn, psmt, rs);
		}

		return bean;
	}

}
