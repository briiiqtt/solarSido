<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

 <!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet"
	href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script
	src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"/>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

</head>
<body>
<div>
<tiles:insertAttribute name="body"></tiles:insertAttribute>
</div>


<script type="text/javascript">
$(function(){

	$("div:contains('dialog-') button:contains('๐')").html("<i class='fas fa-search-plus'> </i>&nbsp;");
	$("div:contains('dialog-') button:contains('๊ฒ์')").html("์กฐํ");
	$("div:contains('dialog-') button:contains('์กฐํ')").prepend("<i class='fas fa-search-plus'> </i>&nbsp;");
	 	$("div:contains('dialog-') button:contains('์กฐํ')").css("width","80");
		$("div:contains('dialog-') button:contains('์กฐํ')").css("height","33");
		$("div:contains('dialog-') button:contains('์กฐํ')").css("borderRadius",5);
		$("div:contains('dialog-') button:contains('์กฐํ')").css("padding","6 1 6 3"); 	
		$("div:contains('dialog-') button:contains('์กฐํ')").css("boxShadow","2px 2px 2px #74a3b0"); 	
	$("div:contains('dialog-') button:contains('์?์ฅ')").prepend("<i class='far fa-save'> </i> &nbsp;");
	$("div:contains('dialog-') button:contains('์?์ฅ')").css("height","33");
	$("div:contains('dialog-') button:contains('์?์ฅ')").css("width","80");
	$("div:contains('dialog-') button:contains('์?์ฅ')").css("borderRadius",5);
	$("div:contains('dialog-') button:contains('์?์ฅ')").css("padding","6 1 6 3"); 
	$("div:contains('dialog-') button:contains('์?์ฅ')").css("boxShadow","2px 2px 2px #74a3b0"); 
	$("div:contains('dialog-') button:contains('์ด๊ธฐํ')").prepend("<i class='far fa-sticky-note'> </i>&nbsp; ");
	$("div:contains('dialog-') button:contains('์ด๊ธฐํ')").css("height","33");
	$("div:contains('dialog-') button:contains('์ด๊ธฐํ')").css("width","100");	
	$("div:contains('dialog-') button:contains('์ด๊ธฐํ')").css("borderRadius",5);
	$("div:contains('dialog-') button:contains('์ด๊ธฐํ')").css("padding","6 1 6 3"); 
	$("div:contains('dialog-') button:contains('์ด๊ธฐํ')").css("boxShadow","2px 2px 2px #74a3b0"); 
	$("div:contains('dialog-') button:contains('์?ํ์๋ฃ')").html("<i class='fas fa-stamp'></i>&nbsp;์๋ฃ");
	$("div:contains('dialog-') button:contains('์๋ฃ')").css("height","40");
	$("div:contains('dialog-') button:contains('์๋ฃ')").css("width","100");
	$("div:contains('dialog-') button:contains('์๋ฃ')").css("fontSize",20);
	$("div:contains('dialog-') button:contains('์๋ฃ')").css("boxShadow","2px 2px 2px #74a3b0");
	$("div:contains('dialog-') button:contains('์๋ฃ')").css("borderRadius",5);
	$("div:contains('dialog-') button:contains('์๋ฃ')").css("padding","6 1 6 3"); 
	$('th').css('border-bottom','5px solid #fc7a45');
	}
)

</script>

</body>
</html>
