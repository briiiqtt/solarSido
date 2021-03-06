<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<div class="row">
			<div data-role="fieldcontain" class="col-7">
				<label for="defandroid">날짜 선택</label> <input name="startT2"
					id="startT2" type="text" data-role="datebox" class="dtp"
					data-options='{"mode": "calbox"}'> 
			</div>
			<div data-role="fieldcontain" class="col-5">
				<label>업체명</label> 
				<select name="nowCo">
					
					<option value="제품잘사는집">제품잘사는집</option>
					<option value="제품싸게잘사는집">제품싸게잘사는집</option>
				</select>
			</div>
</div>
<button type="button" id="btnSlNm">조회</button>
<div id="gridSl"></div>
<script type="text/javascript">
/* var d2 = new Date();
var nd2 = new Date(d.getFullYear(), d.getMonth(), d.getDate() - 7);
document.getElementById('startT2').value = nd2.toISOString().slice(0, 10);
document.getElementById('endT2').value = d2.toISOString().slice(0, 10); */

		function slList(){
		 	
			var nowCo = $("select[name='nowCo']");
			nowCo.empty();
			$.ajax({
				url:"${pageContext.request.contextPath}/ajax/coNmList2",
				dataType: 'json',
				contentType: 'application/json; charset=utf-8',
			}).done((res)=>{
				for(let i=0;i<res.co.length;i++){
					nowCo.append(`<option value="`+res.co[i].coNm+`">`+res.co[i].coNm+`</option>`);
				}
			})

			//미니 그리드(전표명단) 기본적으로 전체전표명단이 나옴
			const gridSl = new tui.Grid({
				el : document.getElementById('gridSl'), // 컨테이너 엘리먼트
				data : {api : {
					readData : {
						url : '${pageContext.request.contextPath}/grid/slipList.do',
						method : 'GET'
					}
					
				},
				initialRequest: false,
				contentType : 'application/json'
			},
				bodyHeight : 500,
				columns : [ 
					{
					header : '전표번호',
					name : 'slipNo',
					align : 'center',
				}, {
					header : '출고일자',
					name : 'prdtDt',
					align : 'center'
				}, {
					header : '업체명',
					name : 'coNm',
					align : 'center',
					
				}, {
					header : '상세전표수',
					name : 'slNm',
					align : 'center',
					
				}
				],

			});
			
			//찾기버튼눌렀을때
			$('#btnSlNm').on('click',function(){
				
				var startT2 = $("#startT2").val().substring(0,10);
				var endT2 = $("#startT2").val().substring(13,23);
				var coNm2 = $("[name=nowCo] option:selected").val();
				var slParams = {
					'startT' : startT2,
					'endT' : endT2,
					'coNm' : coNm2
				}
				
				$.ajax({
					url:'${pageContext.request.contextPath}/grid/slipList.do',
					data: slParams,
					contentType: 'application/json; charset=utf-8',
					
					
				}).done(function(res){
					
					var sres = JSON.parse(res);
					gridSl.resetData(sres["data"]["contents"]);
				})
				
			 });
			
			//그리드 내부 더블클릭시
			gridSl
			.on(
					'dblclick',
					function(ev) {
						$('#slipNm2').val(gridSl.getValue(ev["rowKey"], "slipNo"));
						
						$('#showDt').val(gridSl.getValue(ev["rowKey"], "prdtDt"));
						$('#showCoNm').val(gridSl.getValue(ev["rowKey"], "coNm"));
						var sendParams={
								'slipNo' : gridSl.getValue(ev["rowKey"], "slipNo")
						}
						
						$('#C').css('display','none');
						$('#noC').css('display','block');
						outGrid2.readData(1,sendParams,true);
						
						dialog3.dialog("close");
						 
					});
			
			
			
			
			
			
			gridSl.on('onGridUpdated', function() {
				gridSl.refreshLayout();
			});
			
			$(function() {
				
				  $('input[name="startT2"]').daterangepicker({
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
				  },
				  
				  );
				});
			
			
			
		}
	</script>
</body>
</html>