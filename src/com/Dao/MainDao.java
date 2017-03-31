package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.Beans.Ya_ImgBean;
import com.Beans.Ya_MotelBean;

public class MainDao implements WorkArea{
	
	private boolean isS = true;
	private ConnectionMaker connectionMaker;
	
	public MainDao(ConnectionMaker connectionMaker){
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
	private MainDao(){}
	
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
	/**
	 * 이달의 Top5업소 로드
	 * */
	@Override
	public ArrayList<Object> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		
		ArrayList<Object> data_list = new ArrayList<Object>();
		
		// 제목 검색
		
		try {
			conn = connectionMaker.makeConnection();
			StringBuilder sql = new StringBuilder();
			sql.append(
					"  SELECT T3.MOTEL_NUM, T3.NAME, T3.IMG_NAME, T2.CNT                                                 \n");
			sql.append(
					"  FROM(                                                                                           \n");
			sql.append(
					" SELECT T1.MOTEL_NUM, T1.CNT                                                                      \n");
			sql.append(
					"  FROM(                                                                                           \n");
			sql.append(
					"      SELECT MOTEL_NUM, COUNT(*) CNT                                                              \n");
			sql.append(
					"        FROM YA_RESERVE                                                                           \n");
			sql.append(
					"          GROUP BY MOTEL_NUM                                                                      \n");
			// search
			// search end
			sql.append(
					"          ORDER BY COUNT(*) DESC                                                                  \n");
			sql.append(
					"      )T1                                                                                         \n");
			sql.append(
					"        WHERE ROWNUM<=5                                                                           \n");
			sql.append(
					"      ) T2 JOIN (                                                                                 \n");
			sql.append(
					"        SELECT A.MOTEL_NUM, A.NAME, B.IMG_NAME                                                    \n");
			sql.append(
					"        FROM YA_MOTEL A JOIN YA_IMG B                                                             \n");
			sql.append(
					"        ON (A.MOTEL_NUM = B.MOTEL_NUM)                                                            \n");
			// search
			// search end
			sql.append(
					"      AND B.IMG_AUTH = 0                                                                          \n");
			sql.append(
					"      ) T3				                                                                           \n");
			sql.append(
					"     ON T3.MOTEL_NUM = T2.MOTEL_NUM                                                               \n");
			sql.append(
					"      ORDER BY T2.CNT DESC                                                                         \n");
			
			// sql.append("WHERE RNUM BETWEEN (:PAGE_SIZE * (:PAGE_NUM-1)+1) AND
			// (( :PAGE_SIZE * (:PAGE_NUM-1))+:PAGE_SIZE ) \n");
			
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());

			rs = psmt.executeQuery();

			while (rs.next()) {
				Ya_MotelBean motelBean = new Ya_MotelBean();
				ArrayList<Ya_ImgBean> img_list = new ArrayList<Ya_ImgBean>();
				motelBean.setMotel_num(rs.getInt(1));
				motelBean.setName(rs.getString(2));
				
				Ya_ImgBean imgBean = new Ya_ImgBean();
				imgBean.setImg_name(rs.getString(3));
				
				img_list.add(imgBean);
				motelBean.setImgs(img_list);
				
				data_list.add(motelBean);
			}

		} catch (Exception e) {
			System.out.println("selectDBList() : " + e);
		} finally {
			close(conn, psmt, rs);
		}
		return data_list;
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
	
}
