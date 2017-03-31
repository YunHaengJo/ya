package com.Dao;

import java.util.ArrayList;
import java.util.HashMap;

public interface WorkArea {
	/**
     * 조회
     * @param pageNum
     * @param pageSize
     * @param search_div
     * @param search_word
     * @return ArrayList<HashMap>
     */
	public ArrayList<Object> do_search(int pageNum,int pageSize
			,String search_div,String search_word);
	
    /**
     * 등록
     * @return boolean
     */
    public boolean do_insert(Object bean);
    
    /**
     * 수정
     * @return boolean
     */
    public boolean do_update(Object bean);    
    
    /**
     * 삭제
     * @return boolean
     */
    public boolean do_delete(Object bean);
    
    /**
     * 등록/수정
     * ex) merge into
     * @return boolean
     */
    public boolean do_upsert(Object bean);    
    
    /**
     * 상세
     * @return boolean
     */
    public Object do_detail(int seq);      
}
