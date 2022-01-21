<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	margin: 0;
	padding: 0;
}

ul {
	list-style: none;
}

a {
	text-decoration: none;
	color: #333;
}

.wrap {
	padding: 15px;
	letter-spacing: -0.5px;
}

.tab_menu .list {
	overflow: hidden;
}

.tab_menu .list li {
	float: left;
	margin-right: 14px;
}

.tab_menu .list .btn {
	font-size: 13px;
}

.tab_menu .list li.is_on .btn {
	font-weight: bold;
	color: green;
}

.tab_menu .list li.is_on .cont {
	display: block;
}

#oG {
	display: none;
}
</style>
</head>
<body>
	<h2>제품 입/출고조회</h2>
	<div class="row">
		<div data-role="fieldcontain" class="col-4">
			<label for="defandroid">날짜 선택</label> <input name="startT"
				class="dtp" id="startT" type="text" data-role="datebox"
				data-options='{"mode": "calbox"}'> ~ <input name="endT"
				id="endT" type="date" data-role="datebox"
				data-options='{"mode": "calbox"}'>
		</div>
		<div data-role="fieldcontain" class="col-2">
			<label>제품구분</label> <label><input type="checkbox" name="ref"
				value="I">입고</label> <label><input type="checkbox"
				name="ref" value="O">출고</label>
		</div>
		<div data-role="fieldcontain" class="col-2">
			<label>제품명</label> <input type="text" id="prdNm">
		</div>
		<div data-role="fieldcontain" class="col-2" style="display: none">
			<label>회사명</label> <input type="text" id="coNm">
		</div>
	</div>
	<button type="button" id="findgrid">조회</button>


	<div id="Grid"></div>





	<div id="dialog-form" title="제품명단"></div>

	<script type="text/javascript">

/* 	
	var d = new Date();
	var nd = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
	document.getElementById('startT').value = nd.toISOString().slice(0, 10);
	document.getElementById('endT').value = d.toISOString().slice(0, 10); */
	
	$(function() {
		
		  $('input[name="startT"]').daterangepicker({
			  showDropdowns: true,
		    opens: 'right',
		    startDate: moment().startOf('hour').add(-7, 'day'),
			  endDate: moment().startOf('hour'),
			  minYear: 1990,
			    maxYear: 2025,
			  autoApply: true,
			    locale: {
			      format: 'YYYY-MM-DD',
			    	  separator: " ~ ",
			          applyLabel: "적용",
			          cancelLabel: "닫기",
			          prevText: '이전 달',
			          nextText: '다음 달',
			          monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			          daysOfWeek: ['일', '월', '화', '수', '목', '금', '토'],
			          showMonthAfterYear: true,
			          yearSuffix: '년'
			    }
		  }, function(start, end, label) {
		    console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
		  },
		  
		  );
		});
	
	let dialog = $("#dialog-form").dialog({
		autoOpen : false,
		modal : true,
		width : 700,
		height : 700
	});
	
	//제품이름검색시
	$('#prdNm')
	.on(
			'click',
			function() {
				dialog.dialog("open");
				$("#dialog-form")
						.load(
								"${pageContext.request.contextPath}/modal/prdtNmList",
								function() {
									NmList()
								})
			});
	
	const Grid = new tui.Grid(
			{
				el : document.getElementById('Grid'), // 컨테이너 엘리먼트
				data : {
					api : {
						readData : {
							url : '${pageContext.request.contextPath}/grid/prdtInput.do',
							method : 'GET'
						}
					},
					initialRequest : false,
					contentType : 'application/json'
				},

				bodyHeight : 700,
				rowHeaders : [ {
					type : 'rowNum',
					width : 100,
					align : 'left',
					valign : 'bottom'
				}, {
					type : 'checkbox'
				} ],
				columns : [ {
					header : 'index',
					name : 'prdtInx',
					hidden : true
				},
				{
					header : '입출고구분',
					name : 'prdtFg'
				}, {
					header : '입출고일자',
					name : 'prdtDt'
				}, {
					header : '제품LOT',
					name : 'prdtLot',
					editor : 'text'
				}, {
					header : '제품코드',
					name : 'prdtCd'
				}, {
					header : '제품명',
					name : 'prdtNm',
				}, {
					header : '규격',
					name : 'prdtSpec'
				}, {
					header : '생산지시번호',
					name : 'indicaNo'
				}

				],
				

			});
	
	$('#findgrid').on('click', function() {

		var startT = $("#startT").val().substring(0,10);
		var endT = $("#startT").val().substring(13,23);
		console.log($("#endT").val())
		console.log(startT);
		console.log(endT);

	})
	
	
	</script>
</body>
</html>