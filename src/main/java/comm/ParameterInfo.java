package comm;

import java.util.Arrays;
import java.util.Enumeration;
import java.util.Map;


import jakarta.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.ui.ModelMap;

public class ParameterInfo {

	@SuppressWarnings("rawtypes")
	public static void chkParameter(HttpServletRequest request){
		 Enumeration enumeration = request.getParameterNames();
		 while (enumeration.hasMoreElements()) {
			 String parameterName = (String) enumeration.nextElement();
//			 System.out.println("parameterName : [" + parameterName + "]   value : [" + request.getParameter(parameterName) + "]");
		 }
	}

	public static void chkParameter(Map<String, Object> paramMap){
		for (String key: paramMap.keySet()) {
			String val = (String) paramMap.get(key);
//	    	System.out.print(key + " : " + val + "     "); 
		}
	}

	@SuppressWarnings("rawtypes")
	public static Map<String, Object> getParameterInfo(HttpServletRequest request, Map<String, Object> param, ModelMap model){
		Enumeration enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements()) {
			String parameterName = (String) enumeration.nextElement();
			param.put(parameterName, StringUtils.defaultIfBlank(request.getParameter(parameterName), ""));
			model.addAttribute(parameterName, StringUtils.defaultIfBlank(request.getParameter(parameterName), ""));
//			 System.out.println("====>"+parameterName + ":" + StringUtils.defaultIfBlank(request.getParameter(parameterName), ""));
		}

		return param;
	}

	@SuppressWarnings("rawtypes")
	public static Map<String, Object> getParameterInfo(HttpServletRequest request, Map<String, Object> param){

		Enumeration enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements()) {
			String parameterName = (String) enumeration.nextElement();
			param.put(parameterName, StringUtils.defaultIfBlank(request.getParameter(parameterName), "") );
//			System.out.println("====>"+parameterName + ":" + StringUtils.defaultIfBlank(request.getParameter(parameterName), ""));
		}

		return param;
	}

	public static Map<String, Object> getParameterValueInfo(HttpServletRequest request, Map<String, Object> param) {
		
	    Enumeration<?> enumeration = request.getParameterNames();

	    while (enumeration.hasMoreElements()) {
	        String parameterName = (String) enumeration.nextElement();
	        String[] values = request.getParameterValues(parameterName);

	        if (values == null) {
	            param.put(parameterName, "");
	        } else if (values.length == 1) {
	            param.put(parameterName, StringUtils.defaultIfBlank(values[0], ""));
	        } else {
	            // 여러 개 값이면 배열 또는 List로 저장
	            param.put(parameterName, Arrays.asList(values)); // 또는 그대로 values
	        }

//	        System.out.println("====> " + parameterName + ": " + Arrays.toString(values));
	    }

	    return param;
	}

	@SuppressWarnings("rawtypes")
	public static void getParameterInfo(HttpServletRequest request, ModelMap model){
		Enumeration enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements()) {
			String parameterName = (String) enumeration.nextElement();
			model.addAttribute(parameterName, StringUtils.defaultIfBlank(request.getParameter(parameterName), ""));
			 System.out.println("====>"+parameterName + ":" + StringUtils.defaultIfBlank(request.getParameter(parameterName), ""));
		}
	}


	public static void getParamMap(Map<String, Object> map, ModelMap model){
		for(String key : map.keySet()) {
			model.addAttribute(key, map.get(key));
		}
	}

}
