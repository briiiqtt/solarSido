<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산지시 관리</title>
</head>
<style>
.card-outline2 {
	border-top: 3px solid #FECEBB;
}
</style>
<body>
	<h2>생산지시 관리</h2>
	<hr />

	<!-- 모달 -->
	<div id="planModal" title="미지시 계획 조회"></div>
	<div id="indicaModal" title="생산지시서 조회"></div>

	<!-- 생산지시 테이블 -->
	<div class="card card-pricing card-primary card-white card-outline"
		style="margin-left: 30px; margin-right: 30px; padding-left: 40px; margin-bottom: 30px;">
		<div class="card-body">
			<div class="row">
				<div class="col-9">
					<form name="indicaMngFrm">
						<div>
							<label>지시일자<span style="color: red">*</span></label> <input
								type="date" id="indicaDt" name="indicaDt" required> <label>생산지시명<span
								style="color: red">*</span></label> <input type="text" id="indicaNm"
								name="indicaNm" required>
						</div>
						<div>
							<button type="button" id="btnReset" style="margin-top: 5px">초기화</button>
							<button type="button" id="btnSave" style="margin-top: 5px">저장</button>
							<!-- <button type="button" id="btnDel">삭제</button> -->
						</div>
					</form>
				</div>
				<div class="col-3">
					<label>생산지시서 조회</label>
					<button type="button" id="btnFind">🔍</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 생산지시 상세 그리드-->
	<div class="card card-pricing card-primary card-white card-outline2"
		style="margin-left: 30px; margin-right: 30px; padding-left: 40px; margin-bottom: 30px;">
		<div class="card-body">
			<div id="indicaDgrid" class="row">
				<div class="col-7">
					<label>지시번호</label> <input type="text" id="indicaNo"
						name="indicaNo" readonly>
				</div>
				<div id="btnMng" class="col-5" style="margin-top: -10px">
					<!-- <button type="button" id="planSearch">미지시계획</button>
			<button type="button" id="indicaSearch">지시수정</button> -->
					<button type="button" id="rowAdd">추가</button>
					<button type="button" id="rowDel">삭제</button>
				</div>
			</div>
		</div>
	</div>


	<div class="row">
		<!-- 소요자재 그리드 -->
		<div
			class="card card-pricing card-primary card-white card-outline2 col-5"
			style="margin-left: 50px; margin-right: 30px; padding-left: 40px; margin-bottom: 30px;">
			<div class="card-body">
				<div id="rscGrid">

					<form name="rscFrm">
						<label>지시상세번호</label> <input type="text" id="idcDno" name="idcDno"
							readonly> <br> <label>제품코드</label> <input
							type="text" id="prdtCd" name="prdtCd" readonly>
						<!-- <label>제품명</label>  -->
						<input type="hidden" id="prdtNm" name="prdtNm" readonly>
					</form>
				</div>
			</div>
		</div>

		<!-- 자재별 lot 선택 그리드 -->
		<div
			class="card card-pricing card-primary card-white card-outline2 col-6"
			style=" margin-right: 30px; padding-left: 40px; margin-bottom: 30px;">
			<div class="card-body">
				<div id="rscLotGrid">

					<form name="rscLotFrm">
						<label>자재코드</label> <input type="text" id="rscCd" name="rscCd"
							readonly>
						<!-- <label>자재명</label>  -->
						<input type="hidden" id="rscNm" name="rscNm" readonly> <br>
						<label>총 소요량</label> <input type="text" id="totalUseQty"
							name="totalUseQty" readonly>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="card card-pricing card-primary card-white card-outline2 "
		style="margin-left: 30px; margin-right: 30px; padding-left: 40px; margin-bottom: 30px;">
		<div class="card-body">
			<div style="margin-top:-10px">
				<button type="button" id="rscReset" style="margin-bottom:10px">초기화</button>
			</div>

			<!-- 소요자재 히든그리드 -->
			<div id="hdRscConGrid"></div>
			<!-- 제품lot별 자재lot 부여 히든그리드 -->
			<div id="hdPrdtRscGrid" style="display: none"></div>
		</div>
	</div>
</body>

<!-- 스크립트 -->
<script type="text/javascript">
	//------------------------------변수------------------------------------------------
	let iDt = new Date();
	let idcDt = iDt.toISOString().substring(0, 10);
	document.getElementById('indicaDt').value = idcDt;
	let idt = idcDt.replaceAll("-","");
	
	let idcQty;
	let totalQty;
	let idcNo;
	let orderNo;
	let totalUse;
	
	//제품-자재 lot 연결
	let lotArr = []; 	//list
	let lotData = {}; 	//obj
	let arr=[];
	let arrt=[];
	let prdtLotNum=0;
	
	//공통 - 제품코드 호출
	$.ajax({
		url: '${pageContext.request.contextPath}/ajax/cmmn/code',
		dataType: 'JSON',
		async: false,
	}).done(function (data) {
		//console.log(data)
		cmmnCodes = data;
	});
	
	$(function(){
		//cmmn_data_d Table에서 자재정보 호출
		$.ajax({
			url: '${pageContext.request.contextPath}/ajax/rscCnt.do',
			dataType: 'JSON',
			async: false,
		}).done(function (data) {
			//console.log(data)
			data.num
			for(let f of data.num){
				arr.push(f)
			}		
			console.log(arr)
		});
	})

	//------------------------------그리드생성------------------------------------------------
	//지시 조회 그리드
	let indicaDgrid = new tui.Grid({
		el: document.getElementById('indicaDgrid'),
		data: {
			  api: {
			    	readData: {
						url: '${pageContext.request.contextPath}/grid/indicaGrid.do', 
						method: 'GET'
			    				},
			    	/* modifyData: {
			    		url: '${pageContext.request.contextPath}/grid/indicaModify.do', 
						method: 'POST'
								} */
			  },
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		bodyHeight: 150,
		rowHeaders: [{
			type: 'checkbox',
			width: 40}],
		columns: [
					 {
					    header: '지시상세번호',
					    name: 'indicaDetaNo',
				        //hidden: true
					  },
					  {
					    header: '계획번호',
					    name: 'planNo',
					   	//hidden: true
					  },
					  {
					    header: '지시번호',
					    name: 'indicaNo',
					    hidden: true
					  },
					  {
					    header: '지시명',
					    name: 'indicaNm',
					    hidden: true
					  },
					  {
					    header: '지시일자',
					    name: 'indicaDt',
					    hidden: true
					  },
					  {
					    header: '주문번호',
					    name: 'orderNo',
					    hidden: true
					  },
					  {
					    header: '업체코드',
					    name: 'coCd',
				    	sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '제품코드',
					    name: 'prdtCd',    
					    formatter: 'listItemText',
				    	editor: {
				    		type:'select',
				    		options: {
				    			listItems: cmmnCodes.codes.prod
					    		}
					  		},
				    	sortingType: 'desc',
				        sortable: true,
				        validation: {
			    	        required: true
		    	      }
					  },		  
					  {
					    header: '제품명',
					    name: 'prdtNm'
					  },
					  {
					    header: '납기일자',
					    name: 'paprdDt',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '주문량',
					    name: 'orderQty',
					    sortingType: 'desc',
				        sortable: true
					  },
					  {
					    header: '계획상세번호',
					    name: 'planDetaNo',
					   	hidden: true
					  },
					  {
					    header: '계획일자',
					    name: 'planDt',
					   	hidden: true
					  },
					  {
					    header: '계획량',
					    name: 'planQty',
					   	//hidden: true
					  },
					  {
					    header: '지시량',
					    name: 'indicaQty',
					    editor : 'text',
					    validation: {
			    	        required: true
			    	      },
			    	       onAfterChange(e) {
				    			console.log("e.rowkey:"+e.rowKey+" & e.value:"+e.value);
				    			calProdDay( p, "planQty", "dayOutput" ); 
				    	    	for ( i=0; i< rscGrid.getRowCount(); i++){
				    	    		rscGrid.setValue(i, 'totalUseQty',
				    	    				e.value * rscGrid.getValue(i, 'rscUseQty'));
				    	    	}
				    	    }    	
					  },
					  {
					    header: '일생산량',
					    name: 'dayOutput',
					  },
					  {
					    header: '생산일수',
					    name: 'prodDay',
					  },
					  {
					    header: '생산구분',
					    name: 'prodFg',
					    formatter: 'listItemText',
				    	editor: {
				    		type:'select',
				    		options: {
				    			listItems: [
				    				{text:'정상', value:'정상'},
				    				{text:'재작업', value:'재작업'}
				    				]
					    		}
					  		}
					  },
					  {
					    header: '작업일자',
					    name: 'wkDt',
					    editor :'datePicker',
					    sortingType: 'desc',
				        sortable: true,
				        validation: {
			    	        required: true
			    	      }
					  },
					  {
					    header: '작업순서',
					    name: 'wkOrd',
					    editor: 'text',
					    hidden: true
					  }
			 		 ]
			});
	
	//제품별 소요 자재 목록 그리드
	let rscGrid = new tui.Grid({
		el: document.getElementById('rscGrid'),
		data: {
			  api: {
			    	readData: {
						url: '${pageContext.request.contextPath}/grid/rscGrid.do', 
						method: 'GET',
						initParams : { prdtCd: 'prdtCd'}
			    				}
			  },
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		rowHeaders : [ 'rowNum' ],
		selectionUnit : 'row',
		bodyHeight: 250,
		columns: [
					 {
					    header: '제품코드',
					    name: 'prdtCd',
					    //hidden: true
					  },
					  {
					    header: '주문번호',
					    name: 'orderNo',
					    hidden: true
					  },
					  {
					    header: '자재코드',
					    name: 'rscCd'
					  },
					  {
					    header: '자재명',
					    name: 'rscNm'
					  },
					  {
					    header: '소요량',
					    name: 'rscUseQty'
					  },
					  {
					    header: '총 소요량',
					    name: 'totalUseQty'
					  }
				],
		summary: {
	        position: 'bottom',
	        height: 50,
	        columnContent: {
	        	rscUseQty: {
	        		template: function(valueMap) {
	        			return '합계';
	        			},
	        		align:'center'
	        	},
	        	totalUseQty: {
					template: function(valueMap) {
						return valueMap.sum;
						}
				}
			}
	    }
	});
	
	//소요 자재 Lot 그리드
	let rscLotGrid = new tui.Grid({
		el: document.getElementById('rscLotGrid'),
		data:  {
			  api: {
			    	readData: {
						url: '${pageContext.request.contextPath}/grid/rscLotGrid.do', 
						method: 'GET',
						initParams : { rscCd: 'rscCd'}
			    				}
			  },
				contentType: 'application/json',
				initialRequest: false //초기에 안보이게 함
			},
		scrollX: false,
		scrollY: true,
		rowHeaders : [ 'checkbox', 'rowNum' ],
		bodyHeight: 250,
		columns: [
					 {
					    header: '자재코드',
					    name: 'rscCd',
					    //hidden: true
					  },
					  {
					    header: '소요량',
					    name: 'rscUseQty',
					  	hidden: true
					  },
					  {
					    header: '주문번호',
					    name: 'orderNo',
					    hidden: true
					  },
					  {
					    header: '생산지시상세번호',
					    name: 'indicaDetaNo',
					  },
					  {
					    header: '자재LOT_NO',
					    name: 'rscLot'
					  },
					  {
					    header: '재고량',
					    name: 'rscStc'
					  },
					  {
					    header: '투입량',
					    name: 'rscQty',
					    editor: 'text',
					    onAfterChange(e) {
			    	    	rscLotGrid.setValue(e.rowKey, 'rscStc',
			    	    					rscLotGrid.getValue(e.rowKey, 'rscStc') - e.value);
			    	    	}
			    	    }    
				],
		summary: {
	        position: 'bottom',
	        height: 50,
	        columnContent: {
	        	rscStc: {
	        		template: function(valueMap) {
	        			return '합계';
	        			},
	        		align:'center'
				},
				rscQty: {
					template: function(valueMap) {
						return valueMap.sum;
						}
				}
	        }
	    }
	});
	
	//------------------------------히든 그리드------------------------------------------------
	//소요 자재 목록 히든그리드 : 생산소요자재T
	let hdRscConGrid = new tui.Grid({
		el: document.getElementById('hdRscConGrid'),
		data: null,
		scrollX: false,
		scrollY: true,
		rowHeaders : [ 'rowNum' ],
		bodyHeight: 250,
		columns: [
					 {
					    header: '지시상세번호',
					    name: 'indicaDetaNo',
					   // hidden: true
					  },
					  {
					    header: '자재코드',
					    name: 'rscCd'
					  },
					  {
					    header: '자재LOT_NO',
					    name: 'rscLot'
					  },
					  {
					    header: '소요량',
					    name: 'rscUseQty'
					  },
					  {
					    header: '투입량',
					    name: 'rscQty'
					    
					    
					  }
				],
			summary: {
		        position: 'bottom',
		        height: 50,
		        columnContent: {
		        	rscUseQty: {
		        		template: function(valueMap) {
		        			return '합계';
		        			},
		        		align:'center'
		        	},
		        	rscQty: {
						template: function(valueMap) {
							return valueMap.sum;
							}
					}
				}
		    }
	});
	
	//자재사용현황T 히든그리드: 제품lot별 자재lot 연결
	 let hdPrdtRscGrid = new tui.Grid({
		el: document.getElementById('hdPrdtRscGrid'),
		data: null,
		scrollX: false,
		scrollY: true,
		rowHeaders : [ 'rowNum' ],
		bodyHeight: 250,
		columns: [
					 {
					    header: '지시상세번호',
					    name: 'indicaDetaNo',
					 	// hidden: true
					  },
					  {
					 	header: '제품코드',
					    name: 'prdtCd',
						// hidden: true
					  },
					  {
					 	header: '제품LOT_NO',
					    name: 'prdtLot',
					  },
					  {
					    header: '자재코드',
					    name: 'rscCd',
						// hidden: true
					  },
					  {
					    header: '자재LOT_NO',
					    name: 'rscLot'
					  },
					  {
					    header: '소요량',
					    name: 'rscUseQty'
					  }
				]
	});
	
	//------------------------------모달------------------------------------------------------
	//미지시 계획상세 모달
	let planDetailDialog = $("#planModal").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 600,
		buttons : {
			"확인" : function(){
				planDetailDialog.dialog("close");
			}
		}
	});
	
	//생산지시서 모달
	let indicaDialog = $("#indicaModal").dialog({
		autoOpen : false,
		modal : true,
		width : 900,
		height : 600,
		buttons : {
			'확인': function(){
				indicaDgrid.resetData([]);
				indicaDialog.dialog("close");
			}
		}
	});

	//------------------------------그리드이벤트------------------------------------------------
	//지시상세 그리드 이벤트
	indicaDgrid.on('click', function(ev){
		if( ev.columnName == "planNo" ){
			console.log("미지시 계획 검색")
			planDetailDialog.dialog("open");
			$("#planModal").load("${pageContext.request.contextPath}/modal/findPlanDlist", 
										function() { planDList() })
			}
	});
	
	indicaDgrid.on('onGridUpdated', function() {
		indicaDgrid.refreshLayout();
		rscGrid.clear();
		rscLotGrid.clear();
	});
	 
	indicaDgrid.on('editingFinish', function(ev) {
		idcQty = indicaDgrid.getValue(ev.rowKey, "indicaQty")
		idcNo =  indicaDgrid.getValue(ev.rowKey, "indicaDetaNo")
		orderNo = indicaDgrid.getValue(ev.rowKey, "orderNo")
		let prdtCd = indicaDgrid.getValue(ev.rowKey, "prdtCd")
		let prdtNm = indicaDgrid.getValue(ev.rowKey, "prdtNm")
		
		console.log(idcNo + "&" + prdtCd);
		$('#prdtCd').val(prdtCd);
		$('#prdtNm').val(prdtNm);
		$('#idcDno').val(idcNo);
		
		var rscGridParams = {
				'prdtCd' : prdtCd,
				'prdtNm' : prdtNm
		};
		rscGrid.readData(1, rscGridParams, true);
	});
	
	indicaDgrid.on('response', function(ev) { 
		console.log("응답완료");
		let res = JSON.parse(ev.xhr.response);
		console.log(res);
		if (res.mod =='upd'){
			indicaDgrid.clear();
		}
	})
	
	//자재목록 그리드 이벤트
	rscGrid.on('onGridUpdated', function() {
		rscGrid.refreshLayout(); 
		//rscLotGrid.refreshLayout();
		for ( i=0; i< rscGrid.getRowCount(); i++){
			rscGrid.setValue(i, 'totalUseQty',  1* idcQty * rscGrid.getValue(i, 'rscUseQty'));
		}
		rscLotGrid.refreshLayout(); 
	});
	
	rscGrid.on('dblclick', function(ev){
		let rscCd = rscGrid.getValue(ev.rowKey, "rscCd")
		let rscNm = rscGrid.getValue(ev.rowKey, "rscNm")
		let prdtCd = rscGrid.getValue(ev.rowKey, "prdtCd")
		let totalUseQty = rscGrid.getValue(ev.rowKey, "totalUseQty")
		
		$('#rscCd').val(rscCd);
		$('#rscNm').val(rscNm);
		$('#totalUseQty').val(totalUseQty);
		
		var lotGridParams = {
				'rscCd' : rscCd,
				'rscNm' : rscNm,
				'prdtCd' : prdtCd,
				'totalUseQty' : totalUseQty
		};
		rscLotGrid.readData(1, lotGridParams, true);
		console.log(rscLotGrid.getModifiedRows().updatedRows.length);	
	});
	
	//소요 자재 Lot 그리드 -> 소요 자재 목록 히든그리드
	rscLotGrid.on("editingFinish", (rscEv) => {
		totalUse = rscLotGrid.getValue(rscEv.rowKey, 'rscQty')
		rscLotGrid.check(rscEv.rowKey)
		totalQty = $('#totalUseQty').val();
		if ( totalQty <= rscLotGrid.getSummaryValues('rscQty').sum ) {
			for ( i=rscEv.rowKey+1 ; i<rscLotGrid.getRowCount(); i++){
				rscLotGrid.disableRow(i, true)
			}
		}
		rscLotGrid.blur()
	})
	
	rscLotGrid.on("check", (rscEv) => {
       	  if(hdRscConGrid.getColumnValues('rscLot').includes(rscLotGrid.getValue(rscEv.rowKey,'rscLot'))){
          var key = hdRscConGrid.findRows({'rscLot':rscLotGrid.getValue(rscEv.rowKey,'rscLot')})[0].rowKey;
          hdRscConGrid.setValue(key,'rscQty',rscLotGrid.getValue(rscEv.rowKey,'rscQty'));
	         }else{
	         hdRscConGrid.appendRow({'indicaDetaNo':rscLotGrid.getValue(rscEv.rowKey,'indicaDetaNo'),
	            'rscUseQty':rscLotGrid.getValue(rscEv.rowKey,'rscUseQty'),
	            'rscCd':rscLotGrid.getValue(rscEv.rowKey,'rscCd'),
	            'rscLot':rscLotGrid.getValue(rscEv.rowKey,'rscLot'),
	            'rscQty':rscLotGrid.getValue(rscEv.rowKey,'rscQty')},{
	            extendPrevRowSpan : true,
	            focus : true,
	            at : 0
	         });
       } 
   })
	
	rscLotGrid.on("click", (rscEv) => {
		for ( i=0 ; i<rscLotGrid.getRowCount(); i++){
			rscLotGrid.setValue(i, 'indicaDetaNo', idcNo)
			rscLotGrid.setValue(i, 'orderNo', orderNo)
		}
	})
	
	rscLotGrid.on("uncheck", (rscEv) => {
		hdRscConGrid.removeRow(rscEv.rowKey); //lot번호랑 비교해서 같은 lot 삭제하도록 수정
		rscLotGrid.setValue(rscEv.rowKey, 'rscQty', '');
		if ( totalQty >= rscLotGrid.getSummaryValues('rscQty').sum ) {
			for ( i=rscEv.rowKey+1 ; i<rscLotGrid.getRowCount(); i++){
				rscLotGrid.enableRow(i, true)
			}
		}
	})
	
	rscLotGrid.on('onGridUpdated', function() {
		rscLotGrid.refreshLayout(); 
	});
	
	//히든 그리드 이벤트
	hdRscConGrid.on('onGridUpdated', function() {
		hdRscConGrid.refreshLayout();
	});
	
	//------------------------------버튼------------------------------------------------
	//초기화 버튼: 지시폼, 지시상세 그리드 초기화
	$('#btnReset').click(function() {
		indicaMngFrm.reset();
		rscFrm.reset();
		rscLotFrm.reset();
		indicaDgrid.resetData([]);
		rscGrid.resetData([]);
		rscLotGrid.resetData([]);
		hdRscConGrid.resetData([]);
	})

	//저장 버튼: 계획 + 계획상세 그리드 저장(수정, 입력, 삭제)
	$('#btnSave').on("click", function(){
		console.log("lot부여");
	      //let prdtCnt = indicaDgrid.getValue(0, 'indicaQty'); //제품수
	      //let rscCnt = rscGrid.getRowCount(); //자재수
	      let list=[];
	      let pt=0;
	      let prdtLotNum;
	    //제품lot생성
			$.ajax({
				url:'${pageContext.request.contextPath}/ajax/makePrdtNo.do',
				dataType: 'json',
				contentType: 'application/json; charset=utf-8',
				async: false,
			}).done((res)=>{
				console.log(res)
				prdtLotNum = res.num
			})
			
	      for(let i of arr){ //자재 수
	            for(let k=0;k<hdRscConGrid.getRowCount();k++){ //소요 자재lot수
	               if(hdRscConGrid.getValue(k,'rscCd')==i){
	                  arrt.push({'indicaDetaNo':hdRscConGrid.getValue(k,'indicaDetaNo'),
	                     'rscCd':hdRscConGrid.getValue(k,'rscCd'),
	                     'rscLot':hdRscConGrid.getValue(k,'rscLot'),
	                     'rscQty':hdRscConGrid.getValue(k,'rscQty'),
	                     'rscUseQty':hdRscConGrid.getValue(k,'rscUseQty')})
	               }
	            }
	            list.push(arrt);
	            arrt=[];
	            pt++;
	         }
	      
	      for(let li of list){
		      if(li != null){
		         //var q = 0;
		         var q = 1*prdtLotNum -1;
		         lotData =  {'indicaDetaNo': idcNo,
		            'prdtCd': indicaDgrid.getValue(0, 'prdtCd'),
		            'prdtLot':'',
		            'rscCd':'',
		            'rscLot':'' ,
		            'rscUseQty':''
		            } 
	
			      for(let i =0 ; i< li.length ; i++){
			         lotData.rscCd = li[i].rscCd;
			         var useQty = li[i].rscUseQty;
			         var rscLot = li[i].rscLot;
			         var rscQty = li[i].rscQty;
			         var t =0;
			
			         if(lotData.rscUseQty !=li[i].rscUseQty && lotData.rscUseQty!=''){
			            //lotData push
			            lotData.rscLot= rscLot;
			            rscQty = rscQty-useQty+lotData.rscUseQty;
			            lotData.rscUseQty = useQty-lotData.rscUseQty;
			            lotArr.push(JSON.parse(JSON.stringify(lotData)));
			            q++;
			         }
			
			         
			         for(let k =1; k*useQty<rscQty ; k++){
			            lotData.prdtLot = 'PRD'+ idt + lpad((q+1).toString(), 3,'0')
			            lotData.rscLot = rscLot;
			            lotData.rscUseQty = useQty;
			            lotArr.push(JSON.parse(JSON.stringify(lotData)));
			            //console.log(lotData);
			            q++;
			            t++; 
			         }
			         
			         if(t*useQty==rscQty){
			        	 lotData.rscUseQty=''
			         } else {   
			        	lotData.prdtLot = 'PRD'+ idt + lpad((q+1).toString(), 3,'0');
			            lotData.rscLot = rscLot;   
			            lotData.rscUseQty = rscQty%(t*useQty);
			            lotArr.push(JSON.parse(JSON.stringify(lotData)));
			         }
		      		}
		      }   
		     }
	      console.log(lotArr);
		    
		//hdPrdtRscGrid.resetData(lotArr);
		hdPrdtRscGrid.appendRows(lotArr);
		//초기화
		arr.length = 0; 
		
		
		indicaNm = $('#indicaNm').val();
		indicaDt = $('#indicaDt').val();
		
		if (indicaNm == null || indicaNm == ""){
			alert('필수입력칸이 비어있습니다.');
			$('#indicaNm').focus();
		} else {
			for ( i =0 ; i <= indicaDgrid.getRowCount(); i++) {
				indicaDgrid.setValue(i,'indicaNm', indicaNm);
				indicaDgrid.setValue(i,'indicaDt', indicaDt);
			}
				if (confirm("지시를 저장하시겠습니까?")) { 
					indicaDgrid.blur();
					//각 그리드 데이터 담기
					let obj={};
					//등록
					obj.idcD = indicaDgrid.getModifiedRows().updatedRows;
					obj.rscCon = hdRscConGrid.getModifiedRows().createdRows;
					obj.prdtRsc = hdPrdtRscGrid.getData();
					//삭제
					obj.idcDel = indicaDgrid.getModifiedRows().deletedRows;
					fetch('${pageContext.request.contextPath}/ajax/modified.do',{
		                method:'POST',
		                headers:{
		                   "Content-Type": "application/json",
		                },
	                body:JSON.stringify(obj)
		             })
				}
			} 
		})
	
	//생산지시서 조회버튼
 	$('#btnFind').on('click', function(){
 		console.log("생산지시서 조회")
		indicaDialog.dialog("open");
		$("#indicaModal").load("${pageContext.request.contextPath}/modal/findIndica", 
									function() { indicaList() })
	});
	
 	//그리드 추가 버튼: 계획 없는 지시 등록
	rowAdd.addEventListener("click", function(idx){
		indicaDgrid.appendRow({},{
			extendPrevRowSpan : true,
			focus : true,
			at : 0
		});
		//지시상세번호 부여
		$.ajax({
				url:'${pageContext.request.contextPath}/ajax/makeDno.do',
				dataType: 'json',
				contentType: 'application/json; charset=utf-8',
				async: false,
			}).done((res)=>{
				console.log(res.num2)
				let idx = 0;
				for(i=0; i<indicaDgrid.getRowCount(); i++){
					if ( indicaDgrid.getValue (i, 'indicaNo') !=null ){
						console.log(idx)
					} else {
						indicaDgrid.setValue(i, 'indicaDetaNo', Number(res.num2)+1*idx)
						idx = Number(idx) +1
					}
				}
			})
	});
	
	//그리드 삭제 버튼
	//false면 확인 안하고 삭제함
	rowDel.addEventListener("click", function(){
		indicaDgrid.removeCheckedRows(true);
	});
	
	//히든 그리드 초기화버튼
	$('#rscReset').on('click', function(){
		hdRscConGrid.resetData([]);
		rscLotGrid.resetData([]);
	})
	
	 	
	//------------------------------함수------------------------------------------------
 	//lpad
	function lpad(s, padLength, padString){
	    while(s.length < padLength)
	        s = padString + s;
	    return s;
	}
	
	//생산일수 계산 함수
	function calProdDay( rowKey, a, b ) { // 생산일수계산
		a = Number(planDgrid.getValue( rowKey, a ));
		b = Number(planDgrid.getValue( rowKey, b ));
		result = (Number(a) / Number(b)).toFixed(1);
		planDgrid.setValue( rowKey, "prodDay" , result);
	} 
	
	//그리드 필수입력칸 함수
	function gridCheck(){
		/* for (let i = 0; i <planDgrid.getRowCount(); i++){
			console.log(planDgrid.getRowAt(i).prdtCd);
			if(planDgrid.getRowAt(i).orderNo == null || planDgrid.getRowAt(i).orderNo == ""){
				alert("주문번호가 비어있습니다.");
				return false;
			} else if(planDgrid.getRowAt(i).prdtCd == null || planDgrid.getRowAt(i).prdtCd == ""){
				alert("제품코드가 지정되지 않았습니다.");
				return false;
			} else if(planDgrid.getRowAt(i).planQty == null || planDgrid.getRowAt(i).planQty == ""){
				alert("작업량이 지정되지 않았습니다.");
				return false;
			} else { */
				return true;
			//}
		//}
	}
	
</script>
</html>