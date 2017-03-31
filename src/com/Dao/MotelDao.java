package com.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.Beans.Ya_ImgBean;
import com.Beans.Ya_MotelBean;
import com.Beans.Ya_ReserveBean;
import com.Beans.Ya_ReviewBean;

public class MotelDao implements WorkArea {
	private boolean isS = true;
	private ConnectionMaker connectionMaker;
	
	private MotelDao() {}
	
	public MotelDao(ConnectionMaker connectionMaker){
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
		Ya_MotelBean castBean = (Ya_MotelBean)bean;
		
		StringBuilder sql = new StringBuilder();
		
		sql.append("INSERT                    \n");
		sql.append("INTO YA_MOTEL VALUES      \n");
		sql.append("  (                       \n");
		sql.append("    SEQ_YA_MOTEL.NEXTVAL, \n");
		sql.append("    ?,                    \n");
		sql.append("    ?,                    \n");
		sql.append("    ?,                    \n");
		sql.append("    ?,                    \n");
		sql.append("    ?,                    \n");
		sql.append("    ?,                    \n");
		sql.append("    ?,                    \n");
		sql.append("    ?,                    \n");
		sql.append("    ?,                    \n");
		sql.append("    ?,                    \n");
		sql.append("    ?                     \n");
		sql.append("  )                       \n");
		
		int count = 0;
		try{
			conn = connectionMaker.makeConnection();
			
			psmt = conn.prepareStatement(sql.toString());
			
			psmt.setString(1, castBean.getEmail());
			psmt.setString(2, castBean.getName());
			psmt.setString(3, castBean.getPhone());
			psmt.setString(4, castBean.getAddress());
			psmt.setInt(5, castBean.getNormal_cnt());
			psmt.setInt(6, castBean.getPremium_cnt());
			psmt.setInt(7, castBean.getNormal_pri());
			psmt.setInt(8, castBean.getPremium_pri());
			psmt.setInt(9, castBean.getIs_ok());
			psmt.setString(10, castBean.getCheck_in());
			psmt.setString(11, castBean.getCheck_out());
			
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
	    ResultSet rs = null;
		
	    Ya_MotelBean dto = (Ya_MotelBean)bean;
	   
	    int count = 0;
	    
	    try{
	    	conn = connectionMaker.makeConnection();
	    	
			StringBuilder sql = new StringBuilder();
			sql.append(" UPDATE YA_MOTEL SET                                                \n");
			sql.append(" NAME= ?, PHONE= ?, NORMAL_CNT= ?, PREMIUM_CNT= ?,     				\n");
			sql.append(" NORMAL_PRI= ?, PREMIUM_PRI= ?, CHECK_IN= ?, CHECK_OUT= ?           \n");
			sql.append(" WHERE EMAIL= ?                                                     \n");
			
			System.out.println("0 sql"+sql.toString()); 
			psmt = conn.prepareStatement(sql.toString());
			//System.out.println("1 pstmt"+psmt.toString());
			//System.out.println("2 dto"+dto.toString());
	    	
	    	
	    	System.out.println("1XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
			psmt.setString(1, dto.getName().trim());
			psmt.setString(2, dto.getPhone().trim());
			psmt.setInt(3, dto.getNormal_cnt());
			psmt.setInt(4, dto.getPremium_cnt());
			psmt.setInt(5, dto.getNormal_pri());
			psmt.setInt(6, dto.getPremium_pri());
			psmt.setString(7, dto.getCheck_in().trim());
			psmt.setString(8, dto.getCheck_out().trim());
			//System.out.println("1-2");
			psmt.setString(9, dto.getEmail());
			//System.out.println("1-3");
			
			//System.out.println("2XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"+psmt.executeUpdate());
			count = psmt.executeUpdate();
			
			System.out.println("3XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
	      
	      }catch(SQLException e){
	    	  System.out.println("eXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"+e.toString()); 
	         log("Fail search",e);
	         e.printStackTrace();
	      }catch(ClassNotFoundException e){
	    	  System.out.println("eXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"+e.toString()); 
		         log("Fail search",e);
		         e.printStackTrace();
		      }finally{
	         close(conn, psmt, rs);
	      }
		
		
		return count>0?true:false;
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
		Connection conn = null;
	    PreparedStatement psmt = null;
	    ResultSet rs = null;
	    
	    Ya_MotelBean dto = null;
	    Ya_ImgBean imgBean =null;
	    ArrayList<Ya_ImgBean> img_list = new ArrayList<Ya_ImgBean>();
	    
	    
	    try{
	    	conn = connectionMaker.makeConnection();
	    	log("1/6 Success detail");
			StringBuilder sql = new StringBuilder();
			sql.append(" select a.*, b.IMG_NAME, b.IMG_AUTH                                                              \n");
			sql.append("FROM YA_MOTEL a inner join ya_img b                                                              \n");
			sql.append(" on a.MOTEL_NUM=b.MOTEL_NUM                                                                      \n");
			sql.append(" where a.motel_num = ?                                        \n");
			log("2/6 Success detail");
			System.out.println("0 sql"+sql.toString()); 
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 pstmt"+psmt.toString());
	                 
			psmt.setInt(1, seq);
			
	        rs = psmt.executeQuery();
	        log("4/6 Success search");
	       	         
	        while(rs.next()){
	        	
	        	dto = new Ya_MotelBean(rs.getInt("MOTEL_NUM"), 
						rs.getString("EMAIL"),
						rs.getString("NAME"), 
						rs.getString("PHONE"), 
						rs.getString("ADDRESS"), 
						rs.getInt("NORMAL_CNT"), 
						rs.getInt("PREMIUM_CNT"), 
						rs.getInt("NORMAL_PRI"), 
						rs.getInt("PREMIUM_PRI"), 
						rs.getInt("IS_OK"), 
						rs.getString("CHECK_IN"),
						rs.getString("CHECK_OUT"));
	        		             	
	             imgBean = new Ya_ImgBean();
		         imgBean.setImg_name(rs.getString("IMG_NAME"));
		         imgBean.setImg_auth(rs.getInt("IMG_AUTH"));
		         img_list.add(imgBean);
		            
	             
	         }
	        
	        
	        dto.setImgs(img_list);
	        
	      }catch(SQLException e){
	         log("Fail search",e);
	      }catch(ClassNotFoundException e){
		         log("Fail search",e);
		      }finally{
	         close(conn, psmt, rs);
	      }
		return dto;

	}
	public int getMotelNum(String email){
		Connection conn = null;
	    PreparedStatement psmt = null;
	    ResultSet rs = null;
	    
	    int num = 0;
	    
	    try{
	    	conn = connectionMaker.makeConnection();
	    	log("1/6 Success detail");
			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT MOTEL_NUM                                                           \n");
			sql.append(" FROM YA_MOTEL                                                              \n");
			sql.append(" WHERE EMAIL = ?                                                            \n");

			log("2/6 Success detail");
			System.out.println("0 sql"+sql.toString()); 
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 pstmt"+psmt.toString());
	                 
			psmt.setString(1, email);
			
	        rs = psmt.executeQuery();
	        log("4/6 Success search");
	       	         
	        while(rs.next()){
	        	  num = rs.getInt(1);
	         }
	        
	      }catch(SQLException e){
	         log("Fail search",e);
	      }catch(ClassNotFoundException e){
		         log("Fail search",e);
		      }finally{
	         close(conn, psmt, rs);
	      }
	    
		return num;
	}
	public Object do_detail_time(int seq) {
		Connection conn = null;
	    PreparedStatement psmt = null;
	    ResultSet rs = null;
	    
	    Ya_MotelBean dto = new Ya_MotelBean();
	       
	    try{
	    	conn = connectionMaker.makeConnection();
	    	log("1/6 Success detail");
			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT NORMAL_PRI, PREMIUM_PRI, CHECK_IN, CHECK_OUT                                                             \n");
			sql.append(" FROM YA_MOTEL                                                           \n");
			sql.append(" WHERE MOTEL_NUM = ?                                                                   \n");
			log("2/6 Success detail");
			System.out.println("0 sql"+sql.toString()); 
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 pstmt"+psmt.toString());
	                 
			psmt.setInt(1, seq);
			
	        rs = psmt.executeQuery();
	        log("4/6 Success search");
	       	         
	        while(rs.next()){
	        	
	        	dto.setNormal_pri(rs.getShort("NORMAL_PRI"));
	        	dto.setPremium_pri(rs.getInt("PREMIUM_PRI"));
	        	dto.setCheck_in(rs.getString("CHECK_IN"));
	        	dto.setCheck_out(rs.getString("CHECK_OUT"));
	        
	         }
	        
	      }catch(SQLException e){
	         log("Fail search",e);
	      }catch(ClassNotFoundException e){
		         log("Fail search",e);
		      }finally{
	         close(conn, psmt, rs);
	      }
		
		return dto;
	}

	public List<Ya_ReviewBean> do_detail_review(int pageNum, int pageSize, int MOTEL_NUM) {
		Connection conn = null;
	    PreparedStatement psmt = null;
	    ResultSet rs = null;
	    
	    Ya_ReviewBean dto = null;
	    List<Ya_ReviewBean> list = new ArrayList<>();
	    
	    try{
	    	conn = connectionMaker.makeConnection();
	    	log("1/6 Success detail");
			StringBuilder sql = new StringBuilder();
			sql.append(" SELECT X.* FROM (SELECT ROWNUM AS RNUM, T1.*, t2.* FROM( \n");
			sql.append(" SELECT * FROM YA_REVIEW                                                         \n");
			sql.append(" WHERE del=0 and MOTEL_NUM = ?                                                                  \n");
			sql.append(" ORDER BY REFERENCE DESC, STEP ASC                                                                 \n");
			sql.append("   ) T1 NATURAL JOIN ( SELECT COUNT(*) TOT_CNT FROM YA_REVIEW WHERE MOTEL_NUM = ? ) T2 ) X \n");
			sql.append(" WHERE RNUM BETWEEN ((? * (?-1))+1) AND (( ? * (?-1))+? ) \n");
			
			log("2/6 Success detail");
			System.out.println("0 sql"+sql.toString()); 
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 pstmt"+psmt.toString());
	                 
			psmt.setInt(1, MOTEL_NUM);
			psmt.setInt(2, MOTEL_NUM);
			psmt.setInt(3, pageSize);
	        psmt.setInt(4, pageNum);
	        psmt.setInt(5, pageSize);
	        psmt.setInt(6, pageNum);
	        psmt.setInt(7, pageSize);
	         
	        rs = psmt.executeQuery();
	        log("4/6 Success search");
	       	         
	        while(rs.next()){
	        	
	        	dto = new Ya_ReviewBean(rs.getInt(2),
	        							rs.getInt(3),
	        							rs.getString(4),
	        							rs.getString(5),
	        							rs.getInt(6),
	        							rs.getInt(7),
	        							rs.getInt(8),
	        							rs.getString(9),
	        							rs.getInt(10),
	        							rs.getInt(11),
	        							rs.getInt(12),
	        							rs.getInt(13)
	        			);
	        	dto.setTot_cnt(rs.getInt("TOT_CNT"));
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
			sql.append(" where MOTEL_NUM = ? and IMG_AUTH !=0                                                                  \n");
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
		public Ya_ReserveBean roomCnt(int motelNum, String useDt){
		
		Connection conn = null;
	    PreparedStatement psmt = null;
	    ResultSet rs = null;
	    
	    Ya_ReserveBean dto = null;
	    
	    try{
	    	
	    	conn = connectionMaker.makeConnection();
	    	log("1/6 Success detail");
			StringBuilder sql = new StringBuilder();
			sql.append(" select                                                         \n");
			sql.append(" NVL((select count(seq) from YA_RESERVE                                                                  \n");
			sql.append(" where MOTEL_NUM = ? and use_dt = ? and room_type='일반실' and state != 2 group by motel_num),0) as noroomCnt, \n ");
			sql.append(" NVL((select count(seq) from YA_RESERVE   \n");
			sql.append(" where MOTEL_NUM = ? and use_dt = ? and room_type='특실' and state != 2 group by motel_num),0) as preroomCnt  \n");
			sql.append(" from YA_RESERVE   \n");
			sql.append(" where motel_num = ? and use_dt = ?  \n");
			
			System.out.println("0 sql"+sql.toString()); 
			psmt = conn.prepareStatement(sql.toString());
			System.out.println("1 pstmt"+psmt.toString());
	                 
			psmt.setInt(1, motelNum);
			psmt.setString(2, useDt);
			psmt.setInt(3, motelNum);
			psmt.setString(4, useDt);
			psmt.setInt(5, motelNum);
			psmt.setString(6, useDt);
			
	        rs = psmt.executeQuery();
	        log("4/6 Success search");
	       	         
	        while(rs.next()){
	        	dto = new Ya_ReserveBean();
	        	dto.setNoroomCnt(rs.getInt("noroomCnt")); 
	        	dto.setPreroomCnt(rs.getInt("preroomCnt"));
	        	
	         }
	        
	      }catch(SQLException e){
	         log("Fail search",e);
	      }catch(ClassNotFoundException e){
		         log("Fail search",e);
		      }finally{
	         close(conn, psmt, rs);
	      }
		
		return dto;
	}
}
