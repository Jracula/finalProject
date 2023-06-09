<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 기본 css -->
<link rel="stylesheet" href="/resources/css/common/default.css" />
<!-- 이 페이지에서만 쓰이는 커스텀 모달 css -->
<link rel="stylesheet" href="/resources/css/common/modal.css" />


<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
<!--jquery ui .js-->
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<!--jquery modal-->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css">

</head>
<body>
	<input id="loc" type="hidden" value="${msg.loc }">
	<div id="modalSec" class="modal modal-pri">
		<div class="modal-content">
			<div class="modal-header" style="text-align: center;">
				<h5>${msg.title }</h5>
			</div>
			<div class="modal-body" style="text-align: center;">
				<p>
					${msg.msg }
				</p>
			</div>
			<div class="area-btn full">
				<button id="ok" class="btn btn-sec size01">확인</button>
			</div>
		</div>
	</div>

	<script>
		const loc = $("#loc").val();
	
		$(function () {
			$("#modalSec").modal({
				showClose: false,
				fadeDuration: 100
			});
			return false;
		});
		$("#ok").on('click',function(){
			location.href = loc;
		})
	</script>
</body>
</html>