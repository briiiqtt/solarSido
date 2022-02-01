<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통자료관리</title>

</head>
<body>
	<h2>공통자료관리</h2>
	<div class="row">
	<div class="card card-pricing card-primary card-white col-11">
		<div class="card-body">
			<div class="row">

				<div class="col-sm-6">
					<div align="left">
						<label>공통코드ID </label><input type="text" id="cmmnNminfo">
						<div>
							<button type="button" id="btnfind">조회</button>
						</div>
					</div>
				</div>
			</div>

					<div align="right">
						<button type="button" id="btnAdd">추가</button>
						<button type="button" id="btnDel">삭제</button>
						<button type="button" id="btnSave">저장</button>
						<button type="butoon" id="btnReset">초기화</button>
					</div>

		</div>
	</div>
	</div>
	<div class=row>
		<div class=col-4>
			<div id="grid"></div>
			<br>
		</div>
		<div class=col-7>
			<div id ="tabs">
				<div class="card card-pricing card-primary card-white">	
					<ul>
						<li>
							<a href="#detailTabs1">상세 코드</a>
						</li>
						<li>
							<a href="#detailTabs2">코드 정보</a>
						</li>
					</ul>
					<div id="detailTabs1">
						<div id="detailgrid" >
						</div>
					</div>
					<form id ="codefrm" name="codefrm" method="post">
						<div id="detailTabs2">
							<table class="table">
								<tr>
									<th>코드ID</th>
									<td><input id="cmmnCdId" name="cmmnCdId" type="text" readonly="readonly"</td>
								</tr>
								<tr>
									<th>공통코드ID명</th>
									<td><input id="cmmnCdNm" name="cmmnCdNm" type="text"></td>
								</tr>
							</table>
						</div>
					</form>
				</div>
			
			</div>
		</div>
	</div>

	<script>
	 $( function() {
		    $( "#tabs" ).tabs();
		  } );
	
		var dataSource = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/cmmndataList.do',
					method : 'GET'
				}
			},
			contentType : 'application/json'
		};

		var grid = new tui.Grid({
			el : document.getElementById('grid'),
			data : dataSource,
			scrollY : true,
			rowHeaders : [ 'rowNum' ],
			bodyHeight : 400,

			columns : [ {
				header : '공통코드ID',
				name : 'cmmnCdId',
				sortable : true
			}, {
				header : '공통코드ID명',
				name : 'cmmnCdNm',
			} ]
		});

		grid.on('onGridUpdate', function() {
			grid.refreshLayout();
		});

		grid.on('response', function(ev) {
			console.log(ev);
			let res = JSON.parse(ev.xhr.response);
			if (res.mode == 'upd') {
				grid.resetOriginData();
			} else {
				grid.refreshLayout()
			}
		});

		grid.on('click', function(ev) {
			$('td').css('backgroundColor', '')
			let JsonData = grid.getRowAt(ev.rowKey);
			let key1 = Object.values(JsonData);
			$('div#grid').find('td[data-row-key$="' + ev.rowKey + '"]').css(
					'backgroundColor', '#81BEF7')
			$('cmmnCdId').val(key1[0]);

			var GridParams = {
				'cmmnCdId' : key1[0]
			};

			detailgrid.readData(1, GridParams, true);
		});

		$('#btnfind').on('click', function() {
			var cmmnCdNm = $("#cmmnNminfo").val();
			var parameter = {
				'cmmnCdNm' : cmmnCdNm
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/grid/cmmndataFind',
				data : parameter,
				contentType : 'application/json; charset=utf-8'
			}).done(function(res) {
				var info = JSON.parse(res);
				grid.resetData(info["data"]["contents"]);
			})

		});

		var detailgridinfo = {
			api : {
				readData : {
					url : '${pageContext.request.contextPath}/grid/cmmndataDetail.do',
					method : 'GET'
				},
				modifyData : {
					url : '${pageContext.request.contextPath}/modifyData',
					method : 'PUT'
				}
			},
			initialRequest : false, // 조회버튼 누르면 값을 불러오겠다
			contentType : 'application/json'
		};

		var detailgrid = new tui.Grid({
			el : document.getElementById('detailgrid'),
			data : detailgridinfo,
			scrollY : true,
			rowHeaders : [ 'rowNum', 'checkbox' ],
			bodyHeight : 400,
			columns : [ {
				header : '공통코드상세ID',
				name : 'cmmnCdDetaId',
				editor : 'text'
			}, {
				header : '공통코드ID',
				name : 'cmmnCdId',
				editor : 'text'
			}, {
				header : '코드명',
				name : 'cmmnCdNm',
				editor : 'text'
			}, {
				header : '설명',
				name : 'cmmnCdDesct',
				editor : 'text'
			} ]
		});

		detailgrid.on('onGridUpdated', function() {
			detailgrid.refreshLayout();
			grid.refreshLayout();
		});

		detailgrid.on('response', function(ev) {
			console.log(ev);
			let res = JSON.parse(ev.xhr.response);
			if (res.mode == 'upd') {
				detailgrid.resetOriginData();
			} else {
				detailgrid.refreshLayout()
			}
		});
		$('#btnAdd').on('click', function appendRow(index) {
			detailgrid.appendRow({}, {
				extendPrevRowSpan : true,
				focus : true,
				at : 0
			});
		});
		$('#btnSave').on('click', function appendRow(index) {
			detailgrid.blur();
			detailgrid.request('modifyData');
		});
		$('#btnDel').on('click', function appendRow(index) {
			detailgrid.blur();
			detailgrid.removeCheckedRows(true);
		});

		$('#btnReset').on('click', function appendRow(index) {
			$('#prdtCd').val();
			$('td').css('backgroundColor', '')
			detailgrid.clear();
		});
	</script>
</body>

</html>