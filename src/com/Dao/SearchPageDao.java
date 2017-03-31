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

public class SearchPageDao implements WorkArea {

   private boolean isS = true;
   private ConnectionMaker connectionMaker;
	
	private SearchPageDao() {}
	
	public SearchPageDao(ConnectionMaker connectionMaker){
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
   
   
   @Override // 
   public ArrayList<Object> do_search(int pageNum, int pageSize, String search_div, String search_word) {
      Connection conn = null;
       PreparedStatement psmt = null;
       ResultSet rs = null;
         
       List<Object> list = new ArrayList<Object>();
       
       StringBuilder sqlWhere = new StringBuilder();
       StringBuilder sqlOrder = new StringBuilder();
       
                            // 가격별 정열
       if(search_div.equals("PAY")){
          
          sqlWhere.append("NAME like '%"+search_word + "%' \n");
          sqlOrder.append("ORDER BY NORMAL_PRI ASC \n");
                         // 리뷰많은순 정열
      }else if(search_div.equals("REVIEW")){
         
         sqlOrder.append("order by reCnt desc  \n");
         sqlWhere.append("NAME like '%"+search_word + "%' \n");
                        // 별점 높은순 정열
      }else if(search_div.equals("STAR")){
          
          sqlOrder.append("order by starAvg desc \n");
          sqlWhere.append("NAME like '%"+search_word + "%' \n");
                         // 기본 등록순 배열 
      }else if(search_div.equals("BASIC")){
         
         sqlOrder.append("order by A.MOTEL_NUM asc \n");
         sqlWhere.append("NAME like '%"+search_word + "%' \n");
         
      }
       
       try{
    	   conn = connectionMaker.makeConnection();
          
         StringBuilder sql = new StringBuilder();
         sql.append("SELECT X.*                                                                            \n");
         sql.append("FROM                                                                                  \n");
         sql.append("(SELECT ROWNUM AS RNUM,                                                               \n");
         sql.append(" T1.*, T2.* FROM                                                                      \n");
         
         sql.append("(SELECT B.IMG_NAME, A.*, \n");
         sql.append("NVL(round((select sum(FACILITY+clean+service) from YA_REVIEW  where motel_num=a.MOTEL_NUM GROUP BY MOTEL_NUM)/ \n");
         sql.append("((SELECT COUNT(SEQ) FROM YA_REVIEW where motel_num=a.MOTEL_NUM GROUP BY MOTEL_NUM )*3)),0) as starAvg, \n");
         sql.append(" NVL((SELECT COUNT(SEQ) FROM YA_REVIEW where motel_num=A.MOTEL_NUM GROUP BY MOTEL_NUM ),0) reCnt \n");
         sql.append(" FROM YA_MOTEL A INNER JOIN YA_IMG B                                                  \n");
         sql.append(" ON A.MOTEL_NUM=B.MOTEL_NUM WHERE IS_OK=1 and                                                    \n");
         
         sql.append(sqlWhere.toString());
         
         sql.append(" AND B.IMG_AUTH = 0                                                                   \n");
         
         sql.append(sqlOrder.toString());
         
         sql.append(" )T1 NATURAL JOIN                                                                     \n");
         sql.append(" (SELECT COUNT(*) TOT_CNT FROM YA_MOTEL WHERE IS_OK=1 and                                                 \n");
         
         sql.append(sqlWhere.toString());
         
         sql.append(" ) T2                                                                                  \n");
         sql.append("  ) X                                                                                  \n");
         sql.append("WHERE RNUM BETWEEN ((? * (?-1))+1) AND (( ? * (?-1))+? ) \n");
         
         System.out.println("0 sql"+sql.toString()); 
         psmt = conn.prepareStatement(sql.toString());
         System.out.println("1 pstmt"+psmt.toString());
                     
         psmt.setInt(1, pageSize);
         psmt.setInt(2, pageNum);
         psmt.setInt(3, pageSize);
         psmt.setInt(4, pageNum);
         psmt.setInt(5, pageSize);
                    
            rs = psmt.executeQuery();
            log("4/6 Success search");
            
            while(rs.next()){
               
                ArrayList<Ya_ImgBean> img_list = new ArrayList<Ya_ImgBean>();
                             
                Ya_ImgBean imgBean = new Ya_ImgBean();
                imgBean.setImg_name(rs.getString("IMG_NAME"));
                
                img_list.add(imgBean);
              
               Ya_MotelBean dto = new Ya_MotelBean(rs.getInt("MOTEL_NUM"), 
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
               
               dto.setImgs(img_list);
               dto.setTOT_CNT(rs.getInt("TOT_CNT"));
               dto.setStarAVG(rs.getInt("starAvg"));
               dto.setReCnt(rs.getInt("reCnt"));
               list.add(dto);
               
            }
         }catch(SQLException e){
            log("Fail search",e);
         }catch(ClassNotFoundException e){
             log("Fail search",e);
          }finally{
            close(conn, psmt, rs);
         }
      return (ArrayList<Object>) list;
   }
   public ArrayList<Object> do_address_search(int pageNum, int pageSize, String search_div, String search_word) {
	      Connection conn = null;
	       PreparedStatement psmt = null;
	       ResultSet rs = null;
	         
	       List<Object> list = new ArrayList<Object>();
	       
	       StringBuilder sqlWhere = new StringBuilder();
	       StringBuilder sqlOrder = new StringBuilder();

	        
	        if(search_div.equals("PAY")){
	            
	        	sqlWhere.append("ADDRESS like '"+search_word + "%' \n");
	            sqlOrder.append("ORDER BY NORMAL_PRI ASC \n");
	                           // 리뷰많은순 정열
	        }else if(search_div.equals("REVIEW")){
	           
	           sqlOrder.append("order by reCnt desc  \n");
	           sqlWhere.append("ADDRESS like '"+search_word + "%' \n");
	                          // 별점 높은순 정열
	        }else if(search_div.equals("STAR")){
	            
	            sqlOrder.append("order by starAvg desc \n");
	            sqlWhere.append("ADDRESS like '"+search_word + "%' \n");
	                           // 기본 등록순 배열 
	        }else if(search_div.equals("BASIC")){
	           
	           sqlOrder.append("order by A.MOTEL_NUM asc \n");
	           sqlWhere.append("ADDRESS like '"+search_word + "%' \n");	           
	        }
	        
	       try{
	    	   conn = connectionMaker.makeConnection();
	          
	         StringBuilder sql = new StringBuilder();
	         sql.append("SELECT X.*                                                                            \n");
	         sql.append("FROM                                                                                  \n");
	         sql.append("(SELECT ROWNUM AS RNUM,                                                               \n");
	         sql.append(" T1.*, T2.* FROM                                                                      \n");
	         
	         sql.append("(SELECT B.IMG_NAME, A.*, \n");
	         sql.append("NVL(round((select sum(FACILITY+clean+service) from YA_REVIEW  where motel_num=a.MOTEL_NUM GROUP BY MOTEL_NUM)/ \n");
	         sql.append("((SELECT COUNT(SEQ) FROM YA_REVIEW where motel_num=a.MOTEL_NUM GROUP BY MOTEL_NUM )*3)),0) as starAvg, \n");
	         sql.append(" NVL((SELECT COUNT(SEQ) FROM YA_REVIEW where motel_num=A.MOTEL_NUM GROUP BY MOTEL_NUM ),0) reCnt \n");
	         sql.append(" FROM YA_MOTEL A INNER JOIN YA_IMG B                                                  \n");
	         sql.append(" ON A.MOTEL_NUM=B.MOTEL_NUM WHERE                                                     \n");
	         
	         sql.append(sqlWhere.toString());
	         
	         sql.append(" AND B.IMG_AUTH = 0                                                                   \n");
	         
	         sql.append(sqlOrder.toString());
	         
	         sql.append(" )T1 NATURAL JOIN                                                                     \n");
	         sql.append(" (SELECT COUNT(*) TOT_CNT FROM YA_MOTEL WHERE                                                 \n");
	         
	         sql.append(sqlWhere.toString());
	         
	         sql.append(" ) T2                                                                                  \n");
	         sql.append("  ) X                                                                                  \n");
	         sql.append("WHERE RNUM BETWEEN ((? * (?-1))+1) AND (( ? * (?-1))+? ) \n");
	         
	         System.out.println("0 sql"+sql.toString()); 
	         psmt = conn.prepareStatement(sql.toString());
	         System.out.println("1 pstmt"+psmt.toString());
	                     
	         psmt.setInt(1, pageSize);
	         psmt.setInt(2, pageNum);
	         psmt.setInt(3, pageSize);
	         psmt.setInt(4, pageNum);
	         psmt.setInt(5, pageSize);
	                    
	            rs = psmt.executeQuery();
	            log("4/6 Success search");
	            
	            while(rs.next()){
	               
	                ArrayList<Ya_ImgBean> img_list = new ArrayList<Ya_ImgBean>();
	                             
	                Ya_ImgBean imgBean = new Ya_ImgBean();
	                imgBean.setImg_name(rs.getString("IMG_NAME"));
	                
	                img_list.add(imgBean);
	              
	               Ya_MotelBean dto = new Ya_MotelBean(rs.getInt("MOTEL_NUM"), 
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
	               
	               dto.setImgs(img_list);
	               dto.setTOT_CNT(rs.getInt("TOT_CNT"));
	               dto.setStarAVG(rs.getInt("starAvg"));
	               dto.setReCnt(rs.getInt("reCnt"));
	               list.add(dto);
	               
	            }
	         }catch(SQLException e){
	            log("Fail search",e);
	         }catch(ClassNotFoundException e){
		            log("Fail search",e);
		         }finally{
	            close(conn, psmt, rs);
	         }
	      return (ArrayList<Object>) list;
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