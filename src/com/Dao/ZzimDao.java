package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.Beans.Ya_ZzimBean;

public class ZzimDao implements WorkArea {

	private boolean isS = true;
	private ConnectionMaker connectionMaker;
	
	private ZzimDao() {}
	
	public ZzimDao(ConnectionMaker connectionMaker){
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
	//////////////////////////////////////////////////////////////////////////
	

	@Override
	public boolean do_insert(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		Ya_ZzimBean dto = (Ya_ZzimBean)bean;
		
		try{
			conn = connectionMaker.makeConnection();
			StringBuilder sql = new StringBuilder();
			
			sql.append(" INSERT INTO YA_ZZIM     \n ");
			sql.append(" (SEQ, MOTEL_NUM, EMAIL)  \n ");
			sql.append(" VALUES(SEQ_YA_ZZIM.NEXTVAL,?,?)   \n ");
							// seq 설정후 SEQ.NEXTVAL
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_update");
			
			psmt.setInt(1, dto.getMotel_num());
			psmt.setString(2, dto.getEmail());
						
			count = psmt.executeUpdate();
			log("4/6 Success do_update");
		}catch(SQLException e){
			log("Fail do_update", e);
		}catch(ClassNotFoundException e){
			log("Fail do_update", e);
		}finally {
			close(conn, psmt, rs);
			log("5/6 Success do_update");
		}
		return count>0?true:false;
	}

	@Override
	public ArrayList<Object> do_search(int pageNum, int pageSize, String search_div, String search_word) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public boolean do_update(Object bean) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean do_delete(Object bean) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		Ya_ZzimBean dto = (Ya_ZzimBean)bean;
		
		try{
			conn = connectionMaker.makeConnection();
			StringBuilder sql = new StringBuilder();
			
			sql.append(" DELETE FROM YA_ZZIM     \n ");
			sql.append(" WHERE MOTEL_NUM=? and EMAIL=? \n ");
			
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_update");
			
			psmt.setInt(1, dto.getMotel_num());
			psmt.setString(2, dto.getEmail());
						
			count = psmt.executeUpdate();
			log("4/6 Success do_update");
		}catch(SQLException e){
			log("Fail do_update", e);
		}catch(ClassNotFoundException e){
			log("Fail do_update", e);
		}finally {
			close(conn, psmt, rs);
			log("5/6 Success do_update");
		}
		return count>0?true:false;
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
	
	public ArrayList<Ya_ZzimBean> do_getzzimlist(int pageNum, int pageSize, String search_div, String search_word) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		ArrayList<Ya_ZzimBean> bean_list = new ArrayList<Ya_ZzimBean>();
		
		try {
			conn = connectionMaker.makeConnection();
			log("2/6 Success do_getlist");
			StringBuilder sql = new StringBuilder();
			
			sql.append("SELECT X.*                                                                  							\n ");
			sql.append("FROM(                                                                      		 						\n ");
			sql.append("SELECT ROWNUM AS RNUM, TT1.*,TT2.*                                          							\n ");
			sql.append("  FROM(                                                                     							\n ");
			sql.append("SELECT T1.MOTEL_NUM, T1.NAME, T2.IMG_NAME, T2.SEQ, T1.ADDRESS, T1.NORMAL_PRI, T1.PREMIUM_PRI, T2.EMAIL	\n ");
			sql.append("FROM YA_MOTEL T1 JOIN (                                                     							\n ");
			sql.append("  SELECT A.MOTEL_NUM, B.IMG_NAME, A.SEQ, A.EMAIL                                     					\n ");
			sql.append("  FROM YA_ZZIM A JOIN YA_IMG B                                              							\n ");
			sql.append("  ON (A.MOTEL_NUM = B.MOTEL_NUM)                                            							\n ");
			sql.append("  AND B.IMG_AUTH = 0                                                        							\n ");
			sql.append("where email = ? 																						\n ");
			sql.append("  ORDER BY A.SEQ DESC                                                       							\n ");
			sql.append(")T2                                                                         							\n ");
			sql.append("ON T1.MOTEL_NUM = T2.MOTEL_NUM) TT1                                         							\n ");
			sql.append("NATURAL join                                                                							\n ");
			sql.append("(                                                                           							\n ");
			sql.append(" select count(seq) TOT_CNT from YA_ZZIM  																		\n ");
			sql.append("where email = ? 																						\n ");
			sql.append(" GROUP BY email 																						\n ");
			sql.append(") TT2                                                                       							\n ");
			sql.append(" ) X                                                                        							\n ");
			
			sql.append("WHERE RNUM BETWEEN (? * (?-1)+1) AND (( ? * (?-1))+? ) \n");
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_getlist");

			psmt.setString(1, search_word);
			psmt.setString(2, search_word);
			psmt.setInt(3, pageSize);
			psmt.setInt(4, pageNum);
			psmt.setInt(5, pageSize);
			psmt.setInt(6, pageNum);
			psmt.setInt(7, pageSize);

			rs = psmt.executeQuery();
			log("4/6 Success do_getlist");
			
			while (rs.next()) {
				Ya_ZzimBean bean = new Ya_ZzimBean(rs.getInt("SEQ"), rs.getString("email"), 
						rs.getInt("motel_num"), rs.getString("address"), rs.getInt("normal_pri"), 
						rs.getInt("premium_pri"), rs.getString("img_name"), rs.getString("name"));
				bean.setTot_cnt(rs.getInt("TOT_CNT"));
				bean_list.add(bean);
			}
			log("5/6 Success do_getlist");
		} catch (SQLException e) {
			log("Fail do_getlist", e);
		} catch (ClassNotFoundException e) {
			log("Fail do_getlist", e);
		} finally {
			for(int i = 0; i < bean_list.size(); ++i){
				System.out.println(i + "번쨰 찜다오");
			}
			System.out.println(bean_list);
			close(conn, psmt, rs);
			log("6/6 Success do_getlist");
		}
		return bean_list;
	}

	// 로그인시 찜 체크 
	public ArrayList<Ya_ZzimBean> logZzim(String email){
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		Ya_ZzimBean dto = null;
		ArrayList<Ya_ZzimBean> list = new ArrayList<>();
		
		try{
			conn = connectionMaker.makeConnection();
			StringBuilder sql = new StringBuilder();
			
			sql.append(" SELECT MOTEL_NUM FROM YA_ZZIM    \n ");
			sql.append(" WHERE EMAIL = ?  \n ");
			
			System.out.println("0 sql" + sql.toString());
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 psmt" + psmt.toString());
			log("3/6 Success do_update");
			
			psmt.setString(1, email);
									
			rs = psmt.executeQuery();
			while (rs.next()) {
				dto = new Ya_ZzimBean();
				dto.setMotel_num(rs.getInt("MOTEL_NUM"));
				list.add(dto);
			}
			log("4/6 Success do_update");
		}catch(SQLException e){
			log("Fail do_update", e);
		}catch(ClassNotFoundException e){
			log("Fail do_update", e);
		}finally {
			close(conn, psmt, rs);
			log("5/6 Success do_update");
		}
		return list;
	}
}
