package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.Beans.Ya_ReviewBean;

public class ReviewDao implements WorkArea {

	private boolean isS = true;
	private ConnectionMaker connectionMaker;
	
	private ReviewDao() {}
	
	public ReviewDao(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}

	public void log(String msg){
		if(isS){
			System.out.println(getClass() + ":" + msg);
		}
	}
	public void log(String msg, Exception e){
		if(isS){
			System.out.println(e + " : " +getClass() + " : " + msg);
		}
	}
	
	public void close(Connection conn, Statement psmt, ResultSet rs){
		if(conn!=null){
			try{
				conn.close();
			}catch (SQLException e){}
		}
		if(psmt!=null){
			try{
				psmt.close();
			}catch (SQLException e){}
		}
		if(rs!=null){
			try{
				rs.close();
			}catch (SQLException e){}
		}
	}
	public boolean needAnswer(int seq){
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success checkAnswer");
			StringBuilder sql = new StringBuilder();
			
			sql.append("select count(reference) as cnt from YA_REVIEW                       \n");
			sql.append("where reference=(select reference from YA_REVIEW where seq=?)\n");                                    
			
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success checkAnswer");

			psmt.setInt(1, seq);

			rs = psmt.executeQuery();
			int count= 0;
			while(rs.next()){
				count = rs.getInt("cnt");
			}
			log("4/6 Success checkAnswer");
			System.out.println("제일 중요 포인트!!!!!!!!!!! :카운트 숫자 는 :" + count);
			if(count == 1){
				return true;
			}else{
				return false;
			}
			
		} catch (SQLException e) {
			log("Fail checkAnswer", e);
			return false;
		} catch (ClassNotFoundException e) {
			log("Fail checkAnswer", e);
			return false;
		}finally {
			System.out.println("success");
			close(conn, psmt, rs);
			log("5/6 Success checkAnswer");
		}		
	}
	
	public Ya_ReviewBean get_answer(int reference){
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success get_answer");
			StringBuilder sql = new StringBuilder();
			
			sql.append("SELECT * FROM YA_REVIEW WHERE REFERENCE = ? AND STEP = 1 \n");
			Ya_ReviewBean bean = new Ya_ReviewBean();
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success get_answer");

			psmt.setInt(1, reference);

			rs = psmt.executeQuery();
			
			while(rs.next()){
				bean.setMotel_num(rs.getInt("motel_num"));
				bean.setNickname(rs.getString("nickname"));
				bean.setContent(rs.getString("content"));
				bean.setUpload_dt(rs.getString("upload_dt"));
			}
			log("4/6 Success get_answer");
			return bean;
		} catch (SQLException e) {
			log("Fail do_insert", e);
			return null;
		} catch (ClassNotFoundException e) {
			log("Fail do_insert", e);
			return null;
		}finally {
			System.out.println("success");
			close(conn, psmt, rs);
			log("5/6 Success get_answer");
		}		
		
	}
	
	
	public ArrayList<Ya_ReviewBean> do_search(int pageNum, int pageSize, int motelNum) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		ArrayList<Ya_ReviewBean> list = new ArrayList<Ya_ReviewBean>();
		
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
					"      SELECT NICKNAME, UPLOAD_DT, FACILITY, SERVICE, CLEAN, CONTENT, SEQ, STEP, REFERENCE, MOTEL_NUM          \n");
			sql.append(
					"      FROM YA_REVIEW                                                                             \n");
			sql.append(
					"      WHERE MOTEL_NUM = ?	AND STEP = 0						                                 \n");
			
			sql.append(
					"      ORDER BY REFERENCE DESC, STEP ASC) T1	                                                        \n");
			sql.append(
					"      NATURAL JOIN (					                   						                   \n");
			sql.append(
					"       SELECT COUNT(SEQ) TOT_CNT FROM YA_REVIEW WHERE MOTEL_NUM = ? AND STEP = 0  				   \n");
			sql.append(
					"          ) 	T2				                                                                    \n");
			sql.append(
					"          ) X					                                                                    \n");
			sql.append(
					"      WHERE RNUM BETWEEN 			                                                               \n");
			sql.append(
					"      (? * (?-1)+1) AND (?*( ? - 1)+? )              												\n");
			
			
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			
			psmt.setInt(1, motelNum);
			psmt.setInt(2, motelNum);
			psmt.setInt(3, pageSize);
			psmt.setInt(4, pageNum);
			psmt.setInt(5, pageSize);
			psmt.setInt(6, pageNum);
			psmt.setInt(7, pageSize);
			
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				Ya_ReviewBean reviewBean = new Ya_ReviewBean();
				
				reviewBean.setMotel_num(rs.getInt("MOTEL_NUM"));
				reviewBean.setSeq(rs.getInt("seq"));
				reviewBean.setNickname(rs.getString(2));
				reviewBean.setUpload_dt(rs.getString(3));
				reviewBean.setContent(rs.getString(7));
				reviewBean.setTot_cnt(rs.getInt("TOT_CNT"));
				reviewBean.setStep(rs.getInt("STEP"));
				reviewBean.setReference(rs.getInt("REFERENCE"));
				reviewBean.setClean(rs.getInt("CLEAN"));
				reviewBean.setFacility(rs.getInt("FACILITY"));
				reviewBean.setService(rs.getInt("SERVICE"));
				list.add(reviewBean);
			}   

		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			close(conn, psmt, rs);
		}
		return list;
	}
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	@Override
	public ArrayList<Object> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		return null;
	}

	@Override
	public boolean do_insert(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		Ya_ReviewBean reviewBean = (Ya_ReviewBean)bean;
		
		int count = 0;
		
		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success do_insert");
			StringBuilder sql = new StringBuilder();
			
			sql.append(" INSERT INTO YA_REVIEW                                     \n");
			sql.append(" VALUES (SEQ_YA_REVIEW.NEXTVAL,?,?,sysdate,?,?,?,?,      					   \n");	//SEQ.NEXTVAL
			sql.append(" (SELECT NVL(MAX(REFERENCE),0)+1 FROM YA_REVIEW)           \n");
			sql.append(" ,0,0,0)	                                               \n");
			
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_insert");

			psmt.setInt(1, reviewBean.getMotel_num());
			psmt.setString(2, reviewBean.getNickname());
			psmt.setInt(3, reviewBean.getFacility());
			psmt.setInt(4, reviewBean.getService());
			psmt.setInt(5, reviewBean.getClean());
			psmt.setString(6, reviewBean.getContent());

			count = psmt.executeUpdate();
			log("4/6 Success do_insert");
		} catch (SQLException e) {
			log("Fail do_insert", e);
		} catch (ClassNotFoundException e) {
			log("Fail do_insert", e);
		} finally {
			System.out.println("success");
			close(conn, psmt, rs);
			log("5/6 Success do_insert");
		}		
		return count>0?true:false;
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
	
	
	/**
	 * 리뷰 답글
	 * */
	@Override
	public boolean do_upsert(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		
		Ya_ReviewBean reviewBean = (Ya_ReviewBean)bean;
		int count1 = 0;
		int count2 = 0;
		try {
			StringBuilder sql1 = new StringBuilder();
			sql1.append(
					"  UPDATE YA_REVIEW								                                                 \n");
			sql1.append(
					"  SET STEP=STEP+1                                                                               \n");
			sql1.append(
					" WHERE REFERENCE=(SELECT REFERENCE FROM YA_REVIEW WHERE SEQ=?)                                   \n");
			sql1.append(
					"  AND STEP>(SELECT STEP FROM YA_REVIEW WHERE SEQ=?)                                              \n");			
			
			conn = connectionMaker.makeConnection();
			conn.setAutoCommit(false);
			System.out.println("0 sql1" + sql1.toString());
			psmt = conn.prepareStatement(sql1.toString());
			System.out.println("1 psmt" + psmt.toString());
			
			psmt.setInt(1, reviewBean.getSeq());
			psmt.setInt(2, reviewBean.getSeq());
			
			count1 = psmt.executeUpdate();
			psmt.clearParameters();
	
			StringBuilder sql2 = new StringBuilder();
			sql2.append(
					"  INSERT INTO YA_REVIEW						                                                 \n");
			sql2.append(
					"  (SEQ, MOTEL_NUM, NICKNAME, UPLOAD_DT, FACILITY, SERVICE, CLEAN,CONTENT, REFERENCE,             \n");
			sql2.append(
					" STEP, DEPTH,DEL) 												                                   \n");
			sql2.append(
					"  VALUES(SEQ_YA_REVIEW.NEXTVAL, ?, ?, SYSDATE, ?, ?, ?, ?,			                     \n");
			sql2.append(
					"  (SELECT REFERENCE FROM YA_REVIEW WHERE SEQ=?),                      								 \n");
			sql2.append(
					"  (SELECT STEP FROM YA_REVIEW WHERE SEQ=?)+1,									                     \n");
			sql2.append(
					"  (SELECT DEPTH FROM YA_REVIEW WHERE SEQ=?)+1,									                     \n");
			sql2.append(
					"   0)                                               							                     \n");
			psmt = conn.prepareStatement(sql2.toString());
			
			psmt.setInt(1, reviewBean.getMotel_num());
			psmt.setString(2, reviewBean.getNickname());
			psmt.setInt(3, reviewBean.getFacility());
			psmt.setInt(4, reviewBean.getService());
			psmt.setInt(5, reviewBean.getClean());
			psmt.setString(6, reviewBean.getContent());
			psmt.setInt(7, reviewBean.getSeq());
			psmt.setInt(8, reviewBean.getSeq());
			psmt.setInt(9, reviewBean.getSeq());
			
			count2 = psmt.executeUpdate();
			conn.commit();

		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			close(conn, psmt, null);
		}
		return count1>0 && count2>0 ?true:false;
	}

	@Override
	public Object do_detail(int seq) {
		// TODO Auto-generated method stub
		return null;
	}
}
