package service.impl;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import dao.prototype.ISearchRecordDao;

import entity.SearchRecord;

import service.prototype.ISeachRecordService;


/**
 * 搜索记录service实现类
 * 
 * @author 刘昱
 *
 */
@Service
public class SearchRecordServiceDaoImpl implements ISeachRecordService {

	@Autowired
	private ISearchRecordDao searchRecordDao;
	//--添加或更新搜索记录
	@Override
	public void addOrUpdateSearchRecord(int userId, String keyword) {
		SearchRecord searchRecord=new SearchRecord();
		searchRecord.setUserId(userId);
		searchRecord.setKeyword(keyword);
		if(searchRecordDao.findByUserIdAndKeyword(userId, keyword).size()==1) {
			searchRecord.setSearch_time(new Date());
			searchRecordDao.updateSearchRecord(searchRecord);
		}else {
			searchRecordDao.addSearchRecord(searchRecord);
		}
			
	
	}
	//--通过id删除搜索记录
	@Override
	public void deleteSearchRecordById(int id) {
		searchRecordDao.deleteSearchRecordById(id);
		
	}
	//--通过userId删除搜索记录
	@Override
	public void deleteSearchRecordByUserId(int userId) {
		searchRecordDao.deleteSearchRecordByUserId(userId);
		
	}
	//--查找所有搜索记录
	@Override
	public List<SearchRecord> findAll() {
		return searchRecordDao.findAll();
	}
	//--通过id查找搜索记录
	@Override
	public SearchRecord findById(int id) {
		return searchRecordDao.findById(id);
	}
	//--通过userId查找搜索记录
	@Override
	public List<SearchRecord> findByUserId(int userId) {
		return searchRecordDao.findByUserId(userId);
	}
	//--搜索关键词前十名
	@Override
	public List<String> keywordTopTen() {
		List<SearchRecord> searchRecords=searchRecordDao.findAll();
		  Map<String,Integer> map = new HashMap<String,Integer>();        
	         
	       for(int i = 0; i < searchRecords.size(); i++) {  
	           if(map.containsKey(searchRecords.get(i).getKeyword())) {  
	                 
	               Integer count = (Integer) map.get(searchRecords.get(i).getKeyword());  
	                 
	               count++;  
	                 
	               map.put(searchRecords.get(i).getKeyword(), count);  
	                 
	           } else {  
	               map.put(searchRecords.get(i).getKeyword(), 1);  
	           }  
	       }  
	       List<String> keys = sortMapByValue(map);
	      
		return keys;
	}
	//对map按value排序，结果为key的list
	private List<String> sortMapByValue(Map<String, Integer> map) {
	     int size = map.size();
	        List<Map.Entry<String, Integer>> list = new ArrayList<Map.Entry<String, Integer>>(size);
	        list.addAll(map.entrySet());
	        List<String> keys = list.stream()
	                .sorted(Comparator.comparing(Map.Entry<String, Integer>::getValue).reversed())
	                .map(Map.Entry<String, Integer>::getKey)
	                .collect(Collectors.toList());
	        List<String> keywords=new ArrayList<String>();
	        if(keys.size()>=10) {
	            for(int i=0;i<10;i++) {
		        	keywords.add(keys.get(i));
		        }
	        }else {
	        	   for(String key:keys) {
			        	keywords.add(key);
			        }
	        }
	    
	        return keywords;
	}
	
}
