package comm;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import java.util.Map;

public class PageInfo  extends PaginationInfo {

	public void setPage(Map<String, Object> param) {

		int npage = param.get("npage") == null || "".equals(param.get("npage")) ? 1 : Integer.parseInt(param.get("npage").toString());
		setCurrentPageNo(npage);
		
		int recordCount = param.get("recordCount") == null ? 10 : (int)param.get("recordCount");
		setRecordCountPerPage(recordCount);
		
		int pageSize = param.get("pageSize") == null ? 10 : (int)param.get("pageSize");
		setPageSize(pageSize);

		int totalRecordCount = param.get("totalRecordCount") == null ? 0 : (int)param.get("totalRecordCount");
		setTotalRecordCount(totalRecordCount);

		param.put("offset", getFirstRecordIndex());
		param.put("limit", recordCount);
	}
	
}
