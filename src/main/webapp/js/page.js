$('input').attr('autocomplete','off');

 
function pageInfo1(id, page) {

	$("#"+id).empty();

	let prevNo = page.firstPageNoOnPageList - page.pageSize;
	let nextNo = page.firstPageNoOnPageList + page.pageSize;
	let lastNo = page.totalPageCount;
	
	let pageFirst = "<a class='sbtnStr' href='javascript:" + pageFnNm(id, 1) + "'>처음 페이지</a>";//10개 이상일때
	let pagePrev = "<a class='sbtnPrevT' href='javascript:" + pageFnNm(id, prevNo) + "'>이전 10페이지</a>";//10개 이상일때
	let pageList = "";
	for(let i=page.firstPageNoOnPageList; i <= page.lastPageNoOnPageList; i++){
		if(i == page.currentPageNo){
			pageList += "<strong>" + i + "</strong>";
		}else{
			pageList += "<span><a href='javascript:" + pageFnNm(id, i) + "'>" + i + "</a></span>";
		}
	}
	let pageNext = "<a class='sbtnNextT' href='javascript:" + pageFnNm(id, nextNo) + "'>다음 10페이지</a>";//10개 이상일때
	let pageLast = "<a class='sbtnEnd' href='javascript:" + pageFnNm(id, lastNo) + "'>마지막 페이지</a>";//10개 이상일때

	//if(page.totalPageCount <= page.pageSize){
	//	pageFirst = "";
	//	pagePrev = "";
	//	pageNext = "";
	//	pageLast = "";
	//}

	if(page.currentPageNo < 10){
		pageFirst = "";
		pagePrev = "";
	}

	if(page.lastPageNoOnPageList == page.totalPageCount){
		pageNext = "";
		pageLast = "";
	}
		
	let pageView = "";
	pageView += pageFirst;
	pageView += pagePrev;
	pageView += pageList;
	pageView += pageNext;
	pageView += pageLast;

	$("#"+id).append(pageView);

}

function pageInfo(id, page) {

	$("#"+id).empty();

	let prevNo = page.firstPageNoOnPageList - page.pageSize;
	let nextNo = page.firstPageNoOnPageList + page.pageSize;
	let lastNo = page.totalPageCount;
	
	let pageFirst = "<a class='btnStr' href='javascript:" + pageFnNm(id, 1) + "'>처음 페이지</a>";//10개 이상일때
	let pagePrev = "<a class='btnPrevT' href='javascript:" + pageFnNm(id, prevNo) + "'>이전 10페이지</a>";//10개 이상일때
	let pageList = "";
	for(let i=page.firstPageNoOnPageList; i <= page.lastPageNoOnPageList; i++){
		if(i == page.currentPageNo){
			pageList += "<strong>" + i + "</strong>";
		}else{
			pageList += "<span><a href='javascript:" + pageFnNm(id, i) + "'>" + i + "</a></span>";
		}
	}
	let pageNext = "<a class='btnNextT' href='javascript:" + pageFnNm(id, nextNo) + "'>다음 10페이지</a>";//10개 이상일때
	let pageLast = "<a class='btnEnd' href='javascript:" + pageFnNm(id, lastNo) + "'>마지막 페이지</a>";//10개 이상일때

	//if(page.totalPageCount <= page.pageSize){
	//	pageFirst = "";
	//	pagePrev = "";
	//	pageNext = "";
	//	pageLast = "";
	//}

	if(page.currentPageNo < 10){
		pageFirst = "";
		pagePrev = "";
	}

	if(page.lastPageNoOnPageList == page.totalPageCount){
		pageNext = "";
		pageLast = "";
	}
		
	let pageView = "";
	pageView += pageFirst;
	pageView += pagePrev;
	pageView += pageList;
	pageView += pageNext;
	pageView += pageLast;

	$("#"+id).append(pageView);

}

function pageFnNm(id, n){
	let fnNm = "fn_" + id;
	return fnNm + "(" + n + ")";
}

