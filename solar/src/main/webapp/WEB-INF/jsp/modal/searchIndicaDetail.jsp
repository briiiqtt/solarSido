<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html></html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<div>
	<form id="prscIndicaSearch" name="prscIndicaSearch">
	μ§μμΌ<input type="date" id="sDate" name="sDate">
	<button type="button" id="sDateSearchBtn">π</button><br />
	</form>
	<div id="indicaGrid" style="width: 900px"></div>
</div>
</body>
<script>
	
	sDate = document.getElementById('sDate').value;
	sDate = new Date().toISOString().substring(0,10);
	document.getElementById('sDate').value = new Date().toISOString().substring(0,10);
	

	indicaDataSource = {
			api: {
				readData : {
					url : "${pageContext.request.contextPath}/modal/searchIndicaDetail/indica",
					method : 'GET',
					initParams: { sDate: sDate}
				}
			}
	}
	

	indicaGrid = new tui.Grid({
	    el: document.getElementById('indicaGrid'),
	    data : indicaDataSource,
	    scrollX: false,
	    scrollY: true,
	    columns: [{
	        header: 'μμ°μ§μλ²νΈ',
	        name: 'indicaNo',
			align : 'center'
	      },
	      {
	        header: 'μμ°μ§μμμΈλ²νΈ',
	        name: 'indicaDetaNo',
			align : 'center'
	      },
	      {
	        header: 'μμ°μ§μλͺ',
	        name: 'indicaNm',
			align : 'center', 
	      },
	      {
	        header: 'μ νμ½λ',
	        name: 'prdtCd',
			align : 'center', 
	      },
	      {
	        header: 'μμ°κ΅¬λΆ',
	        name: 'prodFg',
			align : 'center', 
	      },
	      {
	        header: 'μ§μλ',
	        name: 'indicaQty',
			align : 'center',
	      },
	      {
	        header: 'μμμμ',
	        name: 'wkOrd',
			align : 'center', 
	      },
	      {
	        header: 'μμμΌμ',
	        name: 'wkDt',
			align : 'center', 
	      },    
	    ]
	  });
	 
 
	indicaGrid.on('response',function(){
		indicaGrid.refreshLayout();
	});
	  
	indicaGrid.on('dblclick', (ev)=>{
		
		var rk = ev.rowKey; 
		
		var indicaDetaNo = indicaGrid.getValue(rk,"indicaDetaNo");
		var indicaDt = indicaGrid.getValue(rk, "indicaDt");
		var indicaNo = indicaGrid.getValue(rk,"indicaNo");
		var indicaQty = indicaGrid.getValue(rk,"indicaQty");
		var prd = indicaGrid.getValue(rk,"prdtCd");
		var	prdf = indicaGrid.getValue(rk,"prodFg");	
		
		var prdNm = indicaGrid.getValue(rk,"prdtNm");
		var inddd = indicaNo + "-" + indicaDetaNo;
		selectedPrdtCd = indicaGrid.getValue(ev.rowKey,'prdtCd');
		
		// λλΈν΄λ¦­νμ¬ μ νλ rowμ μ§μλ²νΈκ° nullμ΄ μλλ κ³΅μ νμ΄μ§μ μ λ³΄λμ΄κ°λ©΄μ μ΄λ²€νΈλ°μ
		if(inddd!=="null-null"){
			innIndica(inddd, prd, prdNm, prdf, indicaDetaNo, indicaNo, indicaDt, indicaQty);
		}
		
	});

	sDateSearchBtn = document.getElementById("sDateSearchBtn");
	sDateSearchBtn.addEventListener("click", function(){
		
		sDate = document.getElementById('sDate').value;
		
 		var readParams = {
				'sDate':sDate
		}
		
		indicaGrid.readData(1,readParams,true);
		indicaGrid.refreshLayout();
		 
	});
	

	
</script>