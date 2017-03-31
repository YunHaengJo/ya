package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.Beans.Ya_ImgBean;
import com.Beans.Ya_MotelBean;

public class ImgDao implements WorkArea {

	private boolean isS = true;
	private ConnectionMaker connectionMaker;
	
	private ImgDao() {}
	
	public ImgDao(ConnectionMaker connectionMaker){
		this.connectionMaker = connectionMaker;
	}
	
	public void close(Connection conn, Statement stmt, ResultSet rs){
		if(rs != null){
			try{
				rs.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
			
		}
		if(stmt != null){
			try{
				stmt.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
			
		}
		if(conn != null){
			try{
				conn.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
			
		}
	}
	
	public void close(Connection conn, Statement stmt){
		if(stmt != null){
			try{
				stmt.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
			
		}
		if(conn != null){
			try{
				conn.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
			
		}
	}
	
	public void log(String msg){
		if(isS){
			System.out.println(getClass() + ": " + msg);
		}
	}
	
	public void log(String msg, Exception e){
		if(isS){
			System.out.println(e + " : " + getClass() + " : " + msg);
		}
	}
	
	@Override
	public ArrayList<Object> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean do_insert(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		Ya_ImgBean castBean = (Ya_ImgBean)bean;
		
		StringBuilder sql = new StringBuilder();
		
		sql.append("INSERT INTO YA_IMG VALUES                 \n");
		sql.append("  (SEQ_YA_IMG.NEXTVAL, ?, ?, ? 			  \n");
		sql.append("  )                                       \n");
		
		int count = 0;
		try{
			conn = connectionMaker.makeConnection();
			
			psmt = conn.prepareStatement(sql.toString());
			
			psmt.setInt(1, castBean.getMotel_num());
			psmt.setString(2, castBean.getImg_name());
			psmt.setInt(3, castBean.getImg_auth());
			
			count = psmt.executeUpdate();
		}catch(SQLException e){
			log("회원가입 오류!", e);
		}catch(ClassNotFoundException e){
			log("회원가입 오류!", e);
		}finally {
			this.close(conn, psmt);
		}
		
		return count>0 ? true : false;
	}

	@Override
	public boolean do_update(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		Ya_ImgBean castBean = (Ya_ImgBean)bean;
		
		StringBuilder sql = new StringBuilder();
		
		sql.append("	UPDATE YA_IMG                 \n");
		sql.append("	SET IMG_NAME= ?				  \n");
		sql.append("	WHERE MOTEL_NUM= ? AND IMG_AUTH=0 \n");
		
		int count = 0;
		try{
			conn = connectionMaker.makeConnection();
			
			psmt = conn.prepareStatement(sql.toString());
			
			psmt.setString(1, castBean.getImg_name());
			psmt.setInt(2, castBean.getMotel_num());

			
			count = psmt.executeUpdate();
		}catch(SQLException e){
			log("회원가입 오류!", e);
		}catch(ClassNotFoundException e){
			log("회원가입 오류!", e);
		}finally {
			this.close(conn, psmt);
		}
		
		return count>0 ? true : false;
	}

	@Override
	public boolean do_delete(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		Ya_MotelBean castBean = (Ya_MotelBean)bean;
		
		StringBuilder sql = new StringBuilder();
		
		sql.append("DELETE FROM YA_IMG                 \n");
		sql.append("WHERE MOTEL_NUM=? 			  \n");
		
		
		int count = 0;
		try{
			conn = connectionMaker.makeConnection();
			
			psmt = conn.prepareStatement(sql.toString());
			
			psmt.setInt(1, castBean.getMotel_num());
			
			
			count = psmt.executeUpdate();
		}catch(SQLException e){
			log("회원가입 오류!", e);
		}catch(ClassNotFoundException e){
			log("회원가입 오류!", e);
		}finally {
			this.close(conn, psmt);
		}
		
		return count>0 ? true : false;
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

	

}
