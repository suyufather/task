/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package pjt.prog01000.web;

import comm.PageInfo;
import comm.ParameterInfo;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import pjt.prog01000.service.PROG01000Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
public class PROG01000Controller {

	@Autowired
	PROG01000Service service;

	@GetMapping("/viewPROG01000Lst.do")
	public String viewProg01000Lst() {

		return "prog01000/prog01000Lst";
	}

	@ResponseBody
	@PostMapping("/selectPROG01000Lst.do")
	public Map<String, Object> selectProg01000Lst(HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		Map<String, Object> param = new HashMap<String, Object>();
		ParameterInfo.getParameterInfo(request, param);

		// page
		PageInfo page = new PageInfo();
		int listCount = service.selectPROG01000LstCnt(param);
		param.put("totalRecordCount", listCount);
		page.setPage(param);

		List<Map<String, Object>> list = service.selectPROG01000Lst(param);
		resultMap.put("dataList", list);
		resultMap.put("page", page);

		return resultMap;
	}

}
