<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>프로젝트명</th>
                <th>TaskNo</th>
                <th>작업내역</th>
                <th>path</th>
                <thPM진행</th>
                <th>백담당자</th>
                <th>백진행</th>
                <th>백시작일</th>
                <th>백종료일</th>
                <th>프담당자</th>
                <th>프진행</th>
                <th>프시작일</th>
                <th>프종료일</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </tbody>
    </table>
</body>
<script>
function fn_pageInfo(n){
	$("#npage").val(n);
	fn_Search();
};

$(document).ready(function(){

	var $mainForm = $("#form1");

	// 조회항목에서 엔터키, SELECT 선택시 자동 엔터적용
	$("[data-id='search']").on("keydown change", "input, select", function(e) {
	    const $el = $(this);

		$("#npage").val(1);

	    // 1. text에서 엔터키 입력
	    if ($el.is("input[type='text']") && e.type === "keydown" && e.key === "Enter") {
	        e.preventDefault();
			fn_Search();
	    }

// 	    // 2. date 변경 시
// 	    if ($el.is("input[type='date']") && e.type === "change") {
// 			fn_Search();
// 	    }

// 	    // 3. select 변경 시
// 	    if ($el.is("select") && e.type === "change") {
// 			fn_Search();
// 	    }
	});

	//공통코드 그룹목록 조회
	$("#btn_Search").on("click", function(){
		$("#npage").val(1);
		fn_Search();
	});

	//공통코드 그룹명 등록
	$("#btn_Write").on("click", function(){

		let $dialog = $("#dialog01");
 		$dialog.dialog({
 			title:"코드 그룹 등록",
 			modal:true,
  			width:440,
  			resizable:false,
 		});

		$("#setCodeId").val("");
		$("#setCodeSeq").val("");
		$("#setCodePreId").val("");
		$("#setCodeNm").val("");
		$dialog.find("input[name='codeNm']").val("");
		$dialog.find("input[name='codeUseYn'][value='Y']").prop("checked",true);
		$dialog.find("input[name='codeSort']").val("");
		$('#btn_Insert').css('display','');
		$('#btn_Update').css('display','none');
	});

	//공통코드 그룹명 저장
	$("#btn_Insert,#btn_Update").on("click", function(){
		$thisId = $(this).attr("id");
 		fn_Save($thisId);
	});

	//공통코드 그룹명 클릭
	$("#dataList").on("click", ".btn_SubList, .btn_Modify, .btn_Delete", function(){

		let val = $(this).data('val');
		let setCodeId = val.split("_")[0];
		let setCodeSeq = val.split("_")[1];
		let setCodePreId = val.split("_")[2];
		let setCodeNm = val.split("_")[3];
		$("#setCodeId").val(setCodeId);
		$("#setCodeSeq").val(setCodeSeq);
		$("#setCodePreId").val(setCodePreId);
		$("#setCodeNm").val(setCodeNm);

		if($(this).hasClass("btn_Modify")){
			fn_Modify();
		}else if($(this).hasClass("btn_Delete")){
			fn_Delete();
		}else if($(this).hasClass("btn_SubList")){
 			$("#btn_SubWrite").show();
 			fn_SubList();
		};
	});

	//공통코드 그룹의 하위코드명 등록
	$("#btn_SubWrite").on("click", function(){
		let $dialog = $("#dialog02");
		$dialog.dialog({
			title:"코드 등록",
			modal:true,
			width:540,
			resizable:false,
		});

		$dialog.find("input[name='codePreNm']").val($("#setCodeNm").val());
		$dialog.find("input[name='codeNm']").val("");
		$dialog.find("input[name='codeValue']").val("");
		$dialog.find("input[name='codeUseYn'][value='Y']").prop("checked",true);
		$dialog.find("input[name='codeSort']").val("");
		$('#btn_SubInsert').css('display','');
		$('#btn_SubUpdate').css('display','none');

	});


	//공통코드 그룹의 하위 코드 저장
	$("#btn_SubInsert,#btn_SubUpdate").on("click", function(){
		$thisId = $(this).attr("id");
 		fn_SubSave($thisId);
	});

	//공통코드 그룹 하위 클릭
	$("#dataSubList").on("click", ".btn_SubModify, .btn_SubDelete", function(){

		let val = $(this).data('val');
		let setCodeSubId = val.split("_")[0];
		let setCodeSubSeq = val.split("_")[1];

		$("#setCodeSubId").val(setCodeSubId);
		$("#setCodeSubSeq").val(setCodeSubSeq);

		if($(this).hasClass("btn_SubModify")){
			fn_SubModify();
		}else if($(this).hasClass("btn_SubDelete")){
			fn_SubDelete();
		};
	});

	fn_Search = function(){

	    $("#dataList").empty();

	    var frm = $('#form1')[0];
	    var data = new FormData(frm);

	    ajaxPostForm("/sys/selectPROG00100Lst.do", data, function(d){
	        if(d){
	            let lst = d.dataList;
	            if(lst.length > 0){

					const totalRecordCount = d.page.totalRecordCount;
					const currentPageNo = d.page.currentPageNo;
					const recordCount = d.page.recordCountPerPage;

					lst.forEach(function(el, index){

						let rowno = totalRecordCount - ((currentPageNo-1) * recordCount + index);

						let tr = "";
						let val = el.codeId + "_" + el.codeSeq + "_" + el.codePreId + "_" + el.codeNm;
						tr = "<tr>";
						tr += "<td>"+rowno+"</td>";
						tr += "<td data-val='"+val+"' class='btn_SubList' style='text-decoration: underline; cursor: pointer;'>"+el.codeId+"</td>";
						tr += "<td>"+el.codeNm+"</td>";
						tr += "<td>"+el.codeUseYn+"</td>";
						tr += "<td>"+el.codeSort+"</td>";
						tr += "<td><button type='button' data-val='"+val+"' class='btn_Modify sbtn'>수정</button></td>";
						tr += "<td><button type='button' data-val='"+val+"' class='btn_Delete sbtn'>삭제</button></td>";
						tr += "</tr>";
						$("#dataList").append(tr);
	                });

	                pageInfo("pageInfo", d.page);

	            }else{
	                tr = "<tr><td colspan='7'>정보가 없습니다.</td></tr>";
	                $("#dataList").append(tr);
	            };
	        };
	    });
	};
	fn_Search();

	//공통 코드 그룹 저장 및 수정
	function fn_Save(thisId){
		let $dialog = $("#dialog01");
		let codeNm = $dialog.find("input[name='codeNm']").val();
		let codeUseYn = $dialog.find("input[name='codeUseYn']:checked").val();
		let codeSort = $dialog.find("input[name='codeSort']").val();

		if(!codeNm){
			alert("코드명을 입력하세요");
			return false;
		};
		if(!codeUseYn){
			alert("사용여부를 선택하세요");
			return false;
		};
		if(!codeSort){
			alert("정렬순서를 입력하세요");
			return false;
		};

		let setCodeId = $("#setCodeId").val();
		let setCodeSeq = $("#setCodeSeq").val();

		let param={
				"codeNm":codeNm,
				"codeUseYn":codeUseYn,
				"codeSort":codeSort,
		};

		if(thisId == "btn_Insert"){
// 		if(setCodeId =="" && setCodeSeq == ""){
			ajaxPostJson("/sys/insertPROG00100Dtl.do", param, function(d){
				if(d == 1){
					$dialog.dialog("close");
					fn_Search();
				};
			});
		}else{
			param.codeId = setCodeId;
			param.codeSeq = setCodeSeq;
			ajaxPostJson("/sys/updatePROG00100Dtl.do", param, function(d){
				if(d == 1){
					$("#setCodeId").val("");
					$("#setCodeSeq").val("");
					$("#setCodeNm").val("");
					$dialog.dialog("close");
					fn_Search();
				};
			});
		};
	};

	//공통코드 그룹명 수정
	fn_Modify = function(){

		let param={
				"codeId":$("#setCodeId").val(),
				"codeSeq":$("#setCodeSeq").val(),
		};

		ajaxPostJson("/sys/selectPROG00100Dtl.do", param, function(d){
			if(d){
 				let $dialog01 = $("#dialog01");
				$dialog01.dialog({
					title:"코드 그룹 수정",
					modal:true,
					width:440,
					resizable:false,
				});

				$dialog01.find("input[name='codeNm']").val(d.codeNm);
				$dialog01.find("input[name='codeUseYn'][value='" + d.codeUseYn + "']").prop("checked",true);
				$dialog01.find("input[name='codeSort']").val(d.codeSort);
				$('#btn_Insert').css('display','none');
				$('#btn_Update').css('display','');
			};
		});
	};

	//코드 그룹 삭제
	fn_Delete = function(){
		if(confirm("코드그룹을 삭제하시겠습니까?\n삭제할 경우\n - 하위 코드도 삭제됩니다.\n - 삭제한 ID정보는 사용할 수 없습니다.") == true){
			let param={
					"codePreId":$("#setCodePreId").val(),
			};
  			ajaxPostJson("/sys/deletePROG00100Dtl.do", param, function(d){
				if(d == 1){
					$("#setCodeId").val("");
					$("#setCodeSeq").val("");
					$("#setCodeNm").val("");
  					fn_Search();
  					$("#dataSubList").empty();
   				};
  			});
		};
	};

	//공통 코드 그룹의 하위 코드 목록 조회
	fn_SubList = function(){

		let param = {"codePreId":$("#setCodePreId").val()};

		ajaxPostJson("/sys/selectPROG00100SubLst.do", param, function(d){

			if(d){

				$("#dataSubList").empty();

				let lst = d.dataList;

				if(lst.length > 0){

					lst.forEach(function(el, index){

						let tr = "";
						let val = el.codeId + "_" + el.codeSeq;
						tr = "<tr>";
						tr += "<td>"+(index+1)+"</td>";
						tr += "<td>"+el.codeNm+"</td>";
						tr += "<td>"+el.codeValue+"</td>";
						tr += "<td>"+el.codeUseYn+"</td>";
						tr += "<td>"+el.codeSort+"</td>";
						tr += "<td><button type='button' data-val='"+val+"' class='btn_SubModify sbtn'>수정</button></td>";
						tr += "<td><button type='button' data-val='"+val+"' class='btn_SubDelete sbtn'>삭제</button></td>";
						tr += "</tr>";
						$("#dataSubList").append(tr);
					});
				};
			};
		});
	};

	//공통 코드 그룹의 하위 코드 저장
	function fn_SubSave(thisId){

		let $dialog = $("#dialog02");

		let codeNm = $dialog.find("input[name='codeNm']").val();
		let codeValue = $dialog.find("input[name='codeValue']").val();
		let codeUseYn = $dialog.find("input[name='codeUseYn']:checked").val();
		let codeSort = $dialog.find("input[name='codeSort']").val();

		if (!codeNm || !codeUseYn || !codeSort || !codeValue) {
			alert("필수입력사항을 모두 입력하세요");
			return;
		};

		let setCodeSubId = $("#setCodeSubId").val();
		let setCodeSubSeq = $("#setCodeSubSeq").val();

		let param={
				"codePreId":$("#setCodePreId").val(),
				"codeNm":codeNm,
				"codeValue":codeValue,
				"codeUseYn":codeUseYn,
				"codeSort":codeSort,
		};

		if(thisId == "btn_SubInsert"){
// 		if(setCodeSubId =="" && setCodeSubSeq == ""){
			ajaxPostJson("/sys/insertPROG00100SubDtl.do", param, function(d){
				if(d == 1){
					$dialog.dialog("close");
					fn_SubList();
				};
			});
		}else{
			param.codeId = setCodeSubId;
			param.codeSeq = setCodeSubSeq;
			ajaxPostJson("/sys/updatePROG00100Dtl.do", param, function(d){
				if(d == 1){
					$("#setCodeSubId").val("");
					$("#setCodeSubSeq").val("");
					$dialog.dialog("close");
					fn_SubList();
				};
			});
		};
	};

	//공통 코드 그룹의 하위 코드 수정
	fn_SubModify = function(){

		let $dialog = $("#dialog02");

		$dialog.dialog({
			title:"코드 수정",
			modal:true,
			width:540,
			resizable:false,
		});

		let param={
				"codeId":$("#setCodeSubId").val(),
				"codeSeq":$("#setCodeSubSeq").val(),
		};
		ajaxPostJson("/sys/selectPROG00100Dtl.do", param, function(d){
			if(d){
				$dialog.find("input[name='codePreNm']").val($("#setCodeNm").val());
				$dialog.find("input[name='codeNm']").val(d.codeNm);
				$dialog.find("input[name='codeValue']").val(d.codeValue);
				$dialog.find("input[name='codeUseYn'][value='" + d.codeUseYn + "']").prop("checked",true);
				$dialog.find("input[name='codeSort']").val(d.codeSort);
				$('#btn_SubInsert').css('display','none');
				$('#btn_SubUpdate').css('display','');
			};
		});
	};

	fn_SubDelete = function(){
		if(confirm("코드를 삭제하시겠습니까?\n삭제할 경우\n - 삭제한 ID는 사용할 수 없습니다.") == true){

			let param={
					"codeId":$("#setCodeSubId").val(),
					"codeSeq":$("#setCodeSubSeq").val(),
			};

  			ajaxPostJson("/sys/deletePROG00100Dtl.do", param, function(d){
				if(d == 1){
					$("#setCodeSubId").val("");
					$("#setCodeSubSeq").val("");
					fn_SubList();
   				};
  			});
		};
	};

});
</script>
</html>