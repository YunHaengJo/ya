package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.Beans.Ya_QnaBean;

public class QnaDao implements WorkArea {

	private boolean isS = true;
	private ConnectionMaker connectionMaker;
	
	private QnaDao() {}
	
	public QnaDao(ConnectionMaker connectionMaker){
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

	public ArrayList<Object> do_search(String email, int pageNum, int pageSize, String search_div, String search_word) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		StringBuilder sql = new StringBuilder();

		StringBuilder sqlParamA = new StringBuilder();
		StringBuilder sqlParamC = new StringBuilder();

		if (search_div.toUpperCase().equals("TITLE")) {
			sqlParamA.append("AND a.TITLE like '%" + search_word + "%' \n");
		} else if (search_div.toUpperCase().equals("EMAIL")) {
			sqlParamA.append("AND a.EMAIL like'%" + search_word + "%' \n");
		}

		if (search_div.toUpperCase().equals("TITLE")) {
			sqlParamC.append("AND c.TITLE like '%" + search_word + "%' \n");
		} else if (search_div.toUpperCase().equals("EMAIL")) {
			sqlParamC.append("AND c.EMAIL like '%" + search_word + "%' \n");
		}

		sql.append(
				"SELECT X.*                                                                                                                          \n");
		sql.append(
				"FROM                                                                                                                                \n");
		sql.append(
				"  (SELECT ROWNUM AS RNUM, A.*, B.*                                                                                                  \n");
		sql.append(
				"  FROM (SELECT *                                                                                                                    \n");
		sql.append(
				"           FROM ya_QNA a WHERE EXISTS (SELECT 1                                                                                     \n");
		sql.append(
				"      			FROM YA_QNA b                                                                                                       \n");
		sql.append(
				"		      WHERE EMAIL=?                                                                             \n");
		sql.append(
				"		      AND a.refer=b.refer                                                                                                   \n");
		sql.append(
				"             )                                                                                                                      \n");
		sql.append("	AND a.DEL=0 \n");
		sql.append(sqlParamA.toString());
		sql.append(
				"    ORDER BY a.REFER DESC,                                                                                                          \n");
		sql.append(
				"      STEP ASC                                                                                                                      \n");
		sql.append(
				"    ) A NATURAL                                                                                                                     \n");
		sql.append(
				"  JOIN                                                                                                                              \n");
		sql.append(
				"    (SELECT COUNT(*) AS TOT_CNT                                                                                                     \n");
		sql.append(
				"    FROM YA_QNA c                                                                                                                   \n");
		sql.append(
				"    WHERE EXISTS                                                                                                                    \n");
		sql.append(
				"      (SELECT 1                                                                                                                     \n");
		sql.append(
				"      FROM YA_QNA b                                                                                                                 \n");
		sql.append("	WHERE c.DEL=0 \n");
		sql.append(sqlParamC.toString());
		sql.append(
				"      AND EMAIL=?                                                                                         \n");
		sql.append(
				"      AND c.refer=b.refer                                                                                                           \n");
		sql.append(
				"      )                                                                                                                             \n");
		sql.append(
				"    ) B                                                                                                                             \n");
		sql.append(
				"  ) X                                                                                                                               \n");
		sql.append("WHERE RNUM BETWEEN (" + pageSize + " * (" + pageNum + " -1)+1) AND (( " + pageSize + " * ("
				+ pageNum + " -1))+ " + pageSize + " ) \n");

		ArrayList<Object> list = new ArrayList<Object>();

		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());
			psmt.setString(1, email);
			psmt.setString(2, email);

			rs = psmt.executeQuery();
			System.out.println(sql.toString());
			while (rs.next()) {
				Ya_QnaBean bean = new Ya_QnaBean();

				bean.setSeq(rs.getInt("seq"));
				bean.setEmail(rs.getString("email"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				bean.setUpload_dt(rs.getString("upload_dt"));
				bean.setRefer(rs.getInt("refer"));
				bean.setStep(rs.getInt("step"));
				bean.setDepth(rs.getInt("depth"));
				bean.setDel(rs.getInt("del"));
				bean.setIs_ans(rs.getInt("is_ans"));
				bean.setTot_cnt(rs.getInt("tot_cnt"));
				list.add(bean);
			}
		} catch (SQLException e) {
			log("큐엔에이 써치 실패", e);
			list = null;
		} catch (ClassNotFoundException e) {
			log("큐엔에이 써치 실패", e);
			list = null;
		} finally {
			this.close(conn, psmt, rs);
		}

		return list;
	}

	@Override
	public ArrayList<Object> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		StringBuilder sqlParam = new StringBuilder();

		StringBuilder sql = new StringBuilder();

		if (search_div.toUpperCase().equals("TITLE")) {
			sqlParam.append("AND TITLE like '%" + search_word + "%' \n");
		} else if (search_div.toUpperCase().equals("EMAIL")) {
			sqlParam.append("AND EMAIL like '%" + search_word + "%' \n");
		}

		sql.append(
				"SELECT X.*                                                                                                                         \n");
		sql.append("FROM(SELECT ROWNUM AS RNUM, A.*, B.*                                    \n");
		sql.append(
				"  FROM(                                                                                                                            \n");
		sql.append("    SELECT *                                                                     \n");
		sql.append(
				"     FROM YA_QNA                                                                                                                   \n");
		sql.append("WHERE DEL=0 \n");
		sql.append(sqlParam.toString());
		sql.append(
				"    ORDER BY REFER DESC, STEP ASC) A                                                                                               \n");
		sql.append(
				"NATURAL JOIN                                                                                                                       \n");
		sql.append(
				"( SELECT COUNT(*) AS TOT_CNT                                                                                                                 \n");
		sql.append(
				"FROM YA_QNA                                                                                                                        \n");
		sql.append("WHERE DEL=0 \n");
		sql.append(sqlParam.toString());
		sql.append(
				") B                                                                                                                                \n");
		sql.append(
				") X                                                                                                                               \n");
		sql.append("WHERE RNUM BETWEEN (" + pageSize + " * (" + pageNum + " -1)+1) AND (( " + pageSize + " * ("
				+ pageNum + " -1))+ " + pageSize + " ) \n");

		ArrayList<Object> list = new ArrayList<Object>();
		System.out.println(sql.toString());
		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());

			rs = psmt.executeQuery();

			while (rs.next()) {
				Ya_QnaBean bean = new Ya_QnaBean();

				bean.setSeq(rs.getInt("seq"));
				bean.setEmail(rs.getString("email"));
				bean.setTitle(rs.getString("title"));
				bean.setUpload_dt(rs.getString("upload_dt"));
				bean.setRefer(rs.getInt("refer"));
				bean.setStep(rs.getInt("step"));
				bean.setDepth(rs.getInt("depth"));
				bean.setDel(rs.getInt("del"));
				bean.setTot_cnt(rs.getInt("tot_cnt"));
				list.add(bean);
			}
		} catch (SQLException e) {
			log("큐엔에이 관리자 전체 써치 실패", e);
			list = null;
		}catch (ClassNotFoundException e) {
			log("큐엔에이 관리자 전체 써치 실패", e);
			list = null;
		} finally {
			this.close(conn, psmt, rs);
		}

		return list;
	}

	public ArrayList<Object> do_search_notAnswer(int pageNum, int pageSize, String search_div, String search_word) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		StringBuilder sqlParam = new StringBuilder();

		StringBuilder sql = new StringBuilder();

		if (search_div.toUpperCase().equals("TITLE")) {
			sqlParam.append("AND TITLE like '%" + search_word + "%' \n");
		} else if (search_div.toUpperCase().equals("EMAIL")) {
			sqlParam.append("AND EMAIL like '%" + search_word + "%' \n");
		}

		sql.append(
				"SELECT X.*                                                                                                                          \n");
		sql.append(
				"FROM(SELECT ROWNUM AS RNUM, A.*, B.*                                     															\n");
		sql.append(
				"  FROM(                                                                                                                             \n");
		sql.append(
				"    SELECT *                                                                         												\n");
		sql.append(
				"     FROM YA_QNA                                                                                                                    \n");
		sql.append(
				"    WHERE IS_ANS=0                                                                                                                  \n");
		sql.append(sqlParam.toString());
		sql.append(
				"AND DEL=0 																															\n");
		sql.append(
				"    ORDER BY REFER DESC, STEP ASC) A                                                                                                \n");
		sql.append(
				"NATURAL JOIN                                                                                                                        \n");
		sql.append(
				"( SELECT COUNT(*) AS TOT_CNT                                                                                                                  \n");
		sql.append(
				"FROM YA_QNA                                                                                                                         \n");
		sql.append(
				"WHERE IS_ANS=0                                                                                                                      \n");
		sql.append(sqlParam.toString());
		sql.append(
				"AND DEL=0 																															\n");
		sql.append(
				") B                                                                                                                                 \n");
		sql.append(
				"  ) X                                                                                                                				\n");
		sql.append("WHERE RNUM BETWEEN (" + pageSize + " * (" + pageNum + " -1)+1) AND (( " + pageSize + " * ("
				+ pageNum + " -1))+ " + pageSize + " ) \n");

		ArrayList<Object> list = new ArrayList<Object>();
		System.out.println(sql.toString());
		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());

			rs = psmt.executeQuery();

			while (rs.next()) {
				Ya_QnaBean bean = new Ya_QnaBean();

				bean.setSeq(rs.getInt("seq"));
				bean.setEmail(rs.getString("email"));
				bean.setTitle(rs.getString("title"));
				bean.setUpload_dt(rs.getString("upload_dt"));
				bean.setRefer(rs.getInt("refer"));
				bean.setStep(rs.getInt("step"));
				bean.setDepth(rs.getInt("depth"));
				bean.setDel(rs.getInt("del"));
				bean.setTot_cnt(rs.getInt("tot_cnt"));
				list.add(bean);
			}
		} catch (SQLException e) {
			log("큐엔에이 관리자 답변미처리내역 실패", e);
			list = null;
		} catch (ClassNotFoundException e) {
			log("큐엔에이 관리자 답변미처리내역 실패", e);
			list = null;
		} finally {
			this.close(conn, psmt, rs);
		}

		return list;
	}

	@Override
	public boolean do_insert(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;

		StringBuilder sql = new StringBuilder();
		Ya_QnaBean castbean = (Ya_QnaBean) bean;

		sql.append("INSERT                                                \n");
		sql.append("INTO YA_QNA VALUES                                    \n");
		sql.append("  (                                                   \n");
		sql.append("    seq_ya_qna.nextval,                               \n");
		sql.append("    ?,						                          \n");
		sql.append("    ?,                         			              \n");
		sql.append("    ?,                                  		      \n");
		sql.append("    SYSDATE,                                          \n");
		sql.append("    (SELECT NVL(MAX(REFER),0)+1 FROM YA_QNA),0,0,0,0  \n");
		sql.append("  )                                                   \n");
		int count = 0;
		try {
			conn = connectionMaker.makeConnection();
			psmt = conn.prepareStatement(sql.toString());

			psmt.setString(1, castbean.getEmail());
			psmt.setString(2, castbean.getTitle());
			psmt.setString(3, castbean.getContent());

			count = psmt.executeUpdate();

		} catch (SQLException e) {
			log("큐앤에이 인서트 실패!", e);
		} catch (ClassNotFoundException e) {
			log("큐앤에이 인서트 실패!", e);
		} finally {
			this.close(conn, psmt);
		}
		return count > 0 ? true : false;
	}

	@Override
	public boolean do_update(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		Ya_QnaBean castbean = (Ya_QnaBean) bean;

		StringBuilder sql = new StringBuilder();

		sql.append("UPDATE YA_QNA         \n");
		sql.append("SET TITLE  =?,        \n");
		sql.append("  CONTENT  =?,        \n");
		sql.append("  UPLOAD_DT=SYSDATE   \n");
		sql.append("WHERE SEQ=?           \n");

		int count = 0;
		try {
			conn = connectionMaker.makeConnection();
			psmt = conn.prepareStatement(sql.toString());

			psmt.setString(1, castbean.getTitle());
			psmt.setString(2, castbean.getContent());
			psmt.setInt(3, castbean.getSeq());

			count = psmt.executeUpdate();

		} catch (SQLException e) {
			log("큐앤에이 업데이트 실패!", e);
		}catch (ClassNotFoundException e) {
			log("큐앤에이 업데이트 실패!", e);
		}
		return count > 0 ? true : false;
	}

	@Override
	public boolean do_delete(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;

		StringBuilder sql = new StringBuilder();

		sql.append("UPDATE YA_QNA                                       \n");
		sql.append("SET DEL=1                                           \n");
		sql.append("where REFER = (select refer from YA_QNA where seq=?)\n");
		sql.append("and STEP >= (select STEP from YA_QNA where seq=?)   \n");

		int count = 0;
		try {
			conn = connectionMaker.makeConnection();
			psmt = conn.prepareStatement(sql.toString());

			psmt.setInt(1, ((Ya_QnaBean) bean).getSeq());
			psmt.setInt(2, ((Ya_QnaBean) bean).getSeq());

			count = psmt.executeUpdate();
			System.out.println(sql.toString());
		} catch (SQLException e) {
			log("QNA 삭제 실패!", e);
		}catch (ClassNotFoundException e) {
			log("QNA 삭제 실패!", e);
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

		Ya_QnaBean bean = null;
		StringBuilder sql = new StringBuilder();

		sql.append("SELECT SEQ, EMAIL, TITLE, CONTENT, UPLOAD_DT, REFER, STEP, DEPTH, IS_ANS\n");
		sql.append("FROM YA_QNA                                                     \n");
		sql.append(" WHERE SEQ=?										            \n");
		sql.append("ORDER BY REFER DESC, STEP ASC                                   \n");

		try {
			conn = connectionMaker.makeConnection();

			psmt = conn.prepareStatement(sql.toString());

			psmt.setInt(1, seq);

			rs = psmt.executeQuery();
			System.out.println(sql.toString());
			while (rs.next()) {
				bean = new Ya_QnaBean();

				bean.setSeq(rs.getInt("seq"));
				bean.setContent(rs.getString("content"));
				bean.setTitle(rs.getString("title"));
				bean.setUpload_dt(rs.getString("upload_dt"));
				bean.setIs_ans(rs.getInt("is_ans"));
				bean.setDepth(rs.getInt("depth"));

			}
		} catch (SQLException e) {
			log("QNA 디테일 실패", e);
			bean = null;
		} catch (ClassNotFoundException e) {
			log("QNA 디테일 실패", e);
			bean = null;
		} finally {
			this.close(conn, psmt, rs);
		}

		return bean;
	}

	public boolean do_answer(int seq, Ya_QnaBean bean) {
		Connection conn = null;
		PreparedStatement psmt = null;

		StringBuilder sql = new StringBuilder();
		StringBuilder sql2 = new StringBuilder();

		// 문의당 답변 하나일때는 필요가 없다
		/*
		 * //한칸씩 밀기위해서
		 * sql1.append("UPDATE YA_QNA SET                                \n");
		 * sql1.append("STEP=STEP+1,                                     \n");
		 * sql1.append("IS_ANS=1                                         \n");
		 * sql1.append("WHERE REFER=(SELECT REF FROM YA_QNA WHERE SEQ=? )\n");
		 * //1.같은 GROUP 번호일 때
		 * sql1.append("AND STEP > (SELECT STEP FROM YA_QNA WHERE SEQ=?)\n"
		 * );//2.같은 GROUP안에서 스텝이 더큰애들 밑으로 내리기
		 */
		sql.append("INSERT INTO YA_QNA                               \n");
		sql.append("(SEQ, EMAIL, TITLE, CONTENT, UPLOAD_DT,          \n");
		sql.append("REFER, STEP, DEPTH, DEL, IS_ANS)                 \n");
		sql.append("VALUES(SEQ_YA_QNA.NEXTVAL, ?, ?, ?, SYSDATE,     \n");
		sql.append("(SELECT REFER FROM YA_QNA WHERE SEQ=?),             \n");
		sql.append("(SELECT STEP FROM YA_QNA WHERE SEQ=?)+1,            \n");
		sql.append("(SELECT DEPTH FROM YA_QNA WHERE SEQ=?)+1,           \n");
		sql.append("0, 1)                                            \n");

		sql2.append("UPDATE YA_QNA  \n");
		sql2.append("SET IS_ANS=1      \n");
		sql2.append("WHERE SEQ=?    \n");

		int count = 0;
		try {
			conn = connectionMaker.makeConnection();
			psmt = conn.prepareStatement(sql.toString());
			conn.setAutoCommit(false); // 데이터베이스가 중간에 꺼졋을때 무결성 제약조건을 지켜주기위해
										// 오토커밋을 끈다

			System.out.println(sql.toString());

			psmt.setString(1, bean.getEmail());
			psmt.setString(2, bean.getTitle());
			psmt.setString(3, bean.getContent());
			psmt.setInt(4, seq);
			psmt.setInt(5, seq);
			psmt.setInt(6, seq);

			count = psmt.executeUpdate();
			psmt.clearParameters();

			psmt = conn.prepareStatement(sql2.toString());

			psmt.setInt(1, seq);
			count = psmt.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			log("큐앤에이 answer 실패!", e);
			try {
				conn.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}finally {

			try {
				conn.setAutoCommit(true);
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			this.close(conn, psmt);
		}
		return count > 0 ? true : false;
	}
}
