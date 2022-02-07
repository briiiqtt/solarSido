<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 불량코드 관리</title>

</head>
<body>
<h1>제품 불량코드 관리</h1>
<div>
	<button type="button" id="btnAdd">추가</button>
	<button type="button" id="btnDel">삭제</button>
	<button type="button" id="btnSave">저장</button><br>
	<label>불량명 입력</label>
	<input type = "text" id="prdtinferNminfo">
	<div><button type="button" id="btnfind">검색</button></div>
</div>
	<div id="grid">	</div>
	<div id="dialog-form" title="공정명단"></div>
<script>
let dialog = $("#dialog-form").dialog({
	autoOpen : false,
	modal : true,
	width : 700,
	height : 700
});


toastr.options = {
		  "closeButton": false,
		  "debug": false,
		  "newestOnTop": false,
		  "progressBar": true,
		  "positionClass": "toast-top-right",
		  "preventDuplicates": false,
		  "onclick": null,
		  "showDuration": "100",
		  "hideDuration": "1000",
		  "timeOut": "2000",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		}

function SaveComplete(){
	toastr.success('데이터가 수정되었습니다.');
}	
function SaveFail(){
	toastr.error('저장실패');
}
function DeleteComplete(){
	toastr.success('해당 데이터가 삭제되었습니다, 저장을 해주세요.');
}
function DeleteFail(){
	toastr.error('삭제실패');
}
function ResetComplete(){
	toastr.info('상세 데이터 리셋 완료 데이터를 입력해주세요');
}
function insertComplete(){
	toastr.success('등록완료');
}
function insertFail(){
	toastr.error('등록실패 빈 값이 있는지 확인해주세요.');
}
function updateFail(){
	toastr.error('수정실패, 값을 확인해주세요.');
}
function updateComplete(){
	toastr.success('수정완료');
}
function datawarning(){
	toastr.warning('데이터 입력오류 정확한 값을 입력해주세요');
}


var dataSource = {
		  api: {
		    	readData: { url: '${pageContext.request.contextPath}/grid/prdtList.do', 
					    	method: 'GET' 
					   },
				modifyData: { url: '${pageContext.request.contextPath}/grid/prdtinferModify.do', 
							method: 'POST' }
				},
/*				initialRequest : false, // 조회버튼 누르면 값을 불러오겠다 */
				contentType: 'application/json'
		};


var grid = new tui.Grid({
	  el: document.getElementById('grid'),
	  data:dataSource, 
	  scrollY : true,
	  rowHeaders : [ 'rowNum','checkbox' ],
	  bodyHeight : 700,
	  columns : 
		  [
			{
				header : '불량코드',
				name : 'prdtInferCd',
				editor : 'text',
			    sortable: true
			},
			{
				header : '불량명',
				name : 'prdtInferNm',
				editor : 'text'
			},
			{
				header : '공정코드',
				name : 'prcsCd'
			},
			{
				header : '공정명',
				name : 'prcsNm'
			},
			{
				header : '불량내역',
				name : 'prdtInferDesct',
				editor : 'text'
			}
		]
	  });
	  
grid.on('onGridUpdated', function() {
	grid.refreshLayout(); 
	});
	
grid.on('response', function(ev) { 
		console.log(ev);
		let res = JSON.parse(ev.xhr.response);
		if(res.mode=='upd'){
			grid.resetOriginData();
		}
		else {
			grid.refreshLayout()
			}
	});
	
grid.on('click', function(ev){

	if(ev["columnName"] == "prcsCd") {
		dialog.dialog("open");
		$("#dialog-form").load(
				"${pageContext.request.contextPath}/modal/prcsinfoList",
							function(){
								prcsinfoList(ev["rowKey"]);
								grid.refreshLayout();
		})
	}
});		
	
$('#btnAdd').on('click', function appendRow(index){
	grid.appendRow( {}, {
		extendPrevRowSpan : true,
		focus : true,
		at : 0
	});
});
$('#btnSave').on('click', function appendRow(index){
	grid.blur();
	grid.request('modifyData');
	SaveComplete();
});
$('#btnDel').on('click', function appendRow(index){
	grid.blur();
	grid.removeCheckedRows(true);
	DeleteComplete();
});

$('#btnfind').on('click', function(){
	var prdtInferNm = $("#prdtinferNminfo").val();
	var parameter = {
			'prdtInferNm' : prdtInferNm
	}
	$.ajax({
		url : '${pageContext.request.contextPath}/grid/prdtinferdataFind',
		data : parameter,
		contentType: 'application/json; charset=utf-8'
	}).done(function(res){
		var info = JSON.parse(res);
		grid.resetData(info["data"]["contents"]);
	})
	
});
</script>
</body>
</html>