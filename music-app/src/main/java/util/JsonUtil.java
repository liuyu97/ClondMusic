package util;

import net.sf.json.JSONObject;

public class JsonUtil {
	
	//字符串转换json
	public static JSONObject toJson(String json){
		JSONObject ss = JSONObject.fromObject(json);
		return ss;
	}
	
	//把字符串去掉  []
	
	public static String sub(String json){
		String str = json.substring(1,json.length()-1);
		
		return str;
		
	}
	

}
