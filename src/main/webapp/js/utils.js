// 현재날짜 : yyyy-mm-dd
function toDate(){

	let today = new Date();

	let year = today.getFullYear();
	let month = ('0' + (today.getMonth() + 1)).slice(-2);
	let day = ('0' + today.getDate()).slice(-2);
	let dateString = year + '-' + month + '-' + day;

	return dateString;
}

// 현재날짜에 입력한 날짜를 더해서 출력한다.
function getCalcDate(days){

	let today = new Date();
	
	today.setDate(today.getDate() + days);
	
	let year = today.getFullYear();
	let month = ('0' + (today.getMonth() + 1)).slice(-2);
	let day = ('0' + today.getDate()).slice(-2);
	let dateString = year + '-' + month + '-' + day;
	
	return dateString;
}

// yyyy-mm-dd 정규식 (0000-01-01 ~ 9999-12-31)
function isValidDateFormat(strVal) {

    var regex = /^\d{4}-\d{2}-\d{2}$/;
    return regex.test(strVal);
}

// 월/일이 실제 값과 일치하는지 확인
function isValidDate(strVal) {

    if (!isValidDateFormat(strVal)) return false;

    let arrStr = strVal.split("-");
    let year = parseInt(arrStr[0], 10);
    let month = parseInt(arrStr[1], 10);
    let day = parseInt(arrStr[2], 10);

    let date = new Date(year, month - 1, day);

    return (date.getFullYear() === year &&
            date.getMonth() === month - 1 &&
            date.getDate() === day);
}

// 특정날짜에 입력한 날짜 더하기
function getCalcDate(strVal, days){

    if (!isValidDate(strVal)) return false;

	let setDay = new Date(strVal);
	
	setDay.setDate(setDay.getDate() + days);

	let year = setDay.getFullYear();
	let month = ('0' + (setDay.getMonth() + 1)).slice(-2);
	let day = ('0' + setDay.getDate()).slice(-2);
	let dateString = year + '-' + month + '-' + day;
	
	return dateString;
}

// 두 날짜 사이 구하기, 입력날짜 : yyyy-mm-dd
function getDateDiff(stDt, edDt){

    if (!isValidDate(stDt)) return false;
    if (!isValidDate(edDt)) return false;
    
	let date1 = new Date(stDt);
	let date2 = new Date(edDt);

	let diffMs = date2.getTime() - date1.getTime();  // 밀리초 차이
	let diffDays = diffMs / (1000 * 60 * 60 * 24);   // 일수로 변환
	
	return diffDays;
}

function isMobile() {
    return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i
        .test(navigator.userAgent);
}

function escapeHtml(str) {
    if (!str) return "";
    return str
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}
function uncomma(str){
	if(!str) return "";
	return str.toString().replace(/,/gi, "");
}
function comma(str){
	var reg = /\B(?=(\d{3})+(?!\d))/g;
	if(typeof str != "string" && typeof str != "number"){
		return "";
	}
	if(typeof str == "number"){
		str = str.toString();
	}
	str = this.uncomma(str);
	var strs = str.split(".");
	var str1 = strs[0];
	var n = str1.replace(reg, ",");
	if(strs.length > 1){
		n = n + "." + strs[1];
	}
	return n;
}

$(document).on("keyup", ".comma", function(){
	let val = $(this).val();
	val = val.replace(/[^0-9]/g,'');
	$(this).val(comma(val));
});

$(document).on("keyup", ".numberOnly", function(){
	let val = $(this).val();
	$(this).val(val.replace(/[^0-9]/g,''));
});



/*
	var param = {"col01":"val01", "col02":"val02"};
*/

function ajaxPostJson(url, param, callback) {
	$.ajax({
		url: url,
		type: "POST",
		contentType:"application/json",
		data:JSON.stringify(param),
		dataType:"json",
		success: function(data, status, xr) {
			return callback(data);
		},
		error: function(xhr, status, error) {
			let msg = "알 수 없는 오류 발생";

    		if (xhr.status === 401 || xhr.status === 302) {
        		msg = xhr.responseText.message || "로그인이 필요합니다.";
        		location.href = "/login.do";
    		} else if (xhr.status === 200 && !xhr.responseText) {
        		msg = "데이터가 존재하지 않습니다.";
    		} else if (error === "SyntaxError") {
        		msg = "요청 정보가 올바르지 않습니다";
    		} else {
        		//msg = xhr.responseText || error;
        		//msg = "처리중 오류가 발생하였습니다.관리자에게 문의 바랍니다.";
        		msg = "요청 정보가 올바르지 않습니다.다시 이용해 주시기 바랍니다.";
        		location.href = "/";
    		}
    		alert(msg);    		    		

			//return callback(data)
		}
	});
}

/*
var frm = $('#form1')[0];
var data = new FormData(frm);
*/
function ajaxPostForm(url, data, callback) {
	$.ajax({
		url: url,
		type:"POST",
		contentType:false,
		processData:false,
		data: data,
		dataType:"json",
		success: function(data, status, xr) {
			return callback(data);
		},
		error: function(xhr, status, error) {
			let msg = "알 수 없는 오류 발생";

    		if (xhr.status === 401 || xhr.status === 302) {
        		msg = xhr.responseText.message || "로그인이 필요합니다.";
        		location.href = "/login.do";
    		} else if (xhr.status === 200 && !xhr.responseText) {
        		msg = "데이터가 존재하지 않습니다.";
    		} else if (error === "SyntaxError") {
        		msg = "요청 정보가 올바르지 않습니다";
    		} else {
        		//msg = xhr.responseText || error;
    			msg = "요청 정보가 올바르지 않습니다.다시 이용해 주시기 바랍니다.";
    			location.href = "/";
        		//msg = "처리중 오류가 발생하였습니다.관리자에게 문의 바랍니다.";
        		//location.href = "/";
    		}
    		alert(msg);    		

			//return callback(data)
		}
	});
}

/*
var data = new FormData($('#form1')[0]);
*/
function ajaxMultipartForm(url, data, callback) {
    $.ajax({
		url: url,
		type:"POST",
        enctype : "multipart/form-data",
        data: data,
        dataType:"json",
        contentType:false,
        processData:false,
		success: function(data, status, xr) {
			return callback(data);
		},
        error: function(request, error){
            console.log("Error code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}


//yyyy-mm-dd 리턴
function dateFormat(date) {
  const offset = date.getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
  const localDate = new Date(date.getTime() - offset);
  return localDate.toISOString().slice(0, 10);
};

// 현재날짜 리턴값 보내기 : yyyy-mm-dd형식
function getToday(){
	const today = new Date();
	let result = today;
	return result;
}


// 현재날짜부터 일자더해서 리턴값 보내기 : yyyy-mm-dd형식
function getDateAdd(n){
   let result = getToday() + (n);
   return result;
};


// 입력한날짜부터 일자더해서 리턴값 보내기 : yyyy-mm-dd형식
function addDate(aDate,n){
	const regex = /^\d{4}-\d{2}-\d{2}$/;
	const addDate = new Date();
	// 입력날짜 형식이 yyyy-mm-dd 인지 확인하기
	if(regex.test(aDate)){
		addDate.setDate(aDate.getDate() + (n));
		let result = addDate;
	}
	return result
};

function dateDiffInDays(date1, date2) {
  // 날짜 문자열을 Date 객체로 변환
	const d1 = new Date(date1);
	const d2 = new Date(date2);
	const regex = /^\d{4}-\d{2}-\d{2}$/;
	let diffTime = 0;
	let diffDays = 0; 
	if(regex.test(date1)&&regex.test(date2)){
	  // 두 날짜 간의 시간 차이 (밀리초 단위)
		diffTime = Math.abs(d2 - d1);
	  // 밀리초를 일수로 변환 (1000ms * 60s * 60min * 24h)
		diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));
	}else{
		return false;
	}
	return diffDays;
}

