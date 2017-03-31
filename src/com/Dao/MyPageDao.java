package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class MyPageDao implements WorkArea {

	private boolean isS = true;
	private ConnectionMaker connectionMaker;
	
	private MyPageDao(){}
	
	public MyPageDao(ConnectionMaker connectionMaker){
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
	////////////////////////////////////////////////////////////////////////////////////////////////
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
	public HashMap<String, Integer> do_count_member_state(String email){
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		HashMap<String,Integer> map = new HashMap<>();
		
		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success do_count_member_state");
			StringBuilder sql = new StringBuilder();
			
			sql.append("SELECT POINT,                                                                       \n");
			sql.append("NVL((SELECT COUNT(seq) FROM YA_ZZIM WHERE EMAIL = ? GROUP BY EMAIL),0) IB_ZZIM,        	\n");
			sql.append("NVL((SELECT COUNT(seq) FROM YA_RESERVE WHERE EMAIL = ? GROUP BY EMAIL),0) IB_RESERVE  		\n");
			sql.append("from YA_MEMBER                                                                      \n");
			sql.append("where email = ?                                                     		   		\n");
			                                                                                                            
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_count_member_state");

			psmt.setString(1, email);
			psmt.setString(2, email);
			psmt.setString(3, email);

			rs = psmt.executeQuery();
			log("4/6 Success do_count_member_state");

            if(rs.next())
            {
	    		System.out.println("1 일때 :" + rs.getInt(1));
	    		int point = rs.getInt(1);
	    		map.put("point", point);
	    		
	    		System.out.println("2 일때 :" +rs.getInt(2));
	    		int zzim = rs.getInt(2);
	    		map.put("zzim", zzim);
	    			
	    		System.out.println("3 일때 :" +rs.getInt(3));
	    		int reserve = rs.getInt(3);
	    		map.put("reserve", reserve);
	    			
            }
			log("5/6 Success do_count_member_state");
		} catch (SQLException e) {
			log("Fail do_count_member_state", e);
		} catch (ClassNotFoundException e) {
			log("Fail do_count_member_state", e);
		}finally {
			System.out.println("이메일 : " + email);
			System.out.println("포인트 : " + map.get("point") + "찜 : " + map.get("zzim") + " 예약내역 : " + map.get("reserve"));
			close(conn, psmt, rs);
			log("6/6 Success do_count_member_state");
		}
		return map;
	}
	
	public int[] do_count_host_state(int motel_num){
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count[] = new int[2];
		
		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success do_count_host_state");
			StringBuilder sql = new StringBuilder();
			
			sql.append(" SELECT COUNT(SEQ) AS RESERVE_COUNT,                                                      \n");
			sql.append(" (SELECT COUNT(SEQ) FROM YA_REVIEW WHERE MOTEL_NUM=? GROUP BY MOTEL_NUM) AS REVIEW_COUNT  \n");
			sql.append(" FROM YA_RESERVE                                                                          \n");
			sql.append(" WHERE MOTEL_NUM=?                                                                        \n");
			sql.append(" GROUP BY MOTEL_NUM                                                                       \n");
			                                                                                                            
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_count_host_state");

			psmt.setInt(1, motel_num);
			psmt.setInt(2, motel_num);

			rs = psmt.executeQuery();
			log("4/6 Success do_count_host_state");
            if(rs.next())
            {
            	for(int i =0;i<count.length;i++){
    				count[i] = rs.getInt(i+1);
    			}
            }
			log("5/6 Success do_count_host_state");
		} catch (SQLException e) {
			log("Fail do_count_host_state", e);
		}catch (ClassNotFoundException e) {
			log("Fail do_count_host_state", e);
		} finally {
			System.out.println(count[0]+" "+count[1]);
			close(conn, psmt, rs);
			log("6/6 Success do_count_host_state");
		}
		return count;
	}
}
