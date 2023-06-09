<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<!-- google icon -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<!-- css -->
	<link rel="stylesheet" href="/resources/css/common/default.css" />
	<link rel="stylesheet" href="/resources/css/admin/admin.css" />
</head>
<style>
	.adminPage-main{
    	overflow: hidden;
    	margin-top: 35px;
    	margin-left: 350px;
    }
    .adminPage-back{
        overflow: hidden;
    }
    .adminPage-content{
        overflow: hidden;
    }
    .adminPage-result{
    	width: 98%;
    }
    .material-symbols-outlined{
        font-size: 150px;
        
    }
    .mainContent{
        float: left;
        width: 300px;
        height: 400px;
        text-align: center;
    }
    #orderStatusSelect{
    	display: none;
    }
    .changeOrderStatusBtn{
    	cursor: pointer;
    }
    [name=orderSearchBox]{
		width: 500px;
	}
    img {
 		 width: 100px;
 		 height: 50px;
 		 transition: transform 0.2s;
	}

	img:hover {
	 	 transform: scale(1.5);
	}
	
	.tbl-box tr:hover {
	  background-color: #e1e4e5;
	}
	
	.select-custom{
		min-height: 32px;
	    padding: 8px 10px;
	    border-radius: 4px;
	    height: 37px;
	}
	
	.adminPage-search {
		  display: flex;
		  align-items: center;
		  margin-bottom: 15px;
	}

	.search-select,
	.search-input,
	.area-btn {
	  	margin-right: 10px;
	}

	.btn {
	  	margin-right: 5px;
	}
	



</style>
<body>
<c:choose>
    <c:when test="${not empty sessionScope.m and sessionScope.m.memberStatus == 0}">
    <div class="adminPage-wrapper" id="adminOrderTable">
        <div class="adminPage-header">
            <div class="adminPage-title"><a href="/#">Moong's Admin</a></div>
        </div>
        <div class="adminPage-back">
            <jsp:include page="/WEB-INF/views/admin/adminSideNavi.jsp"/>
            <div class="adminPage-main">
                <div class="adminPage-content">
                    <div class="adminPage-search">
                    	<div class="search-select">
	                        <select id="orderSearchSelect" class="select-custom">
	                            <option id="searchOrderNo" value="orderNo">주문번호 검색</option>
	                            <option id="searchMemberNo" value="memberNo">회원번호 검색</option>
	                            <option id="searchOrderStatus" value="orderStatus">주문 상태 검색</option>
	                        </select>
                    	</div>
                    	<div class="search-select">
	                        <select id="orderStatusSelect" class="select-custom">
	                        	<option value="1">결제완료</option>
	                        	<option value="2">배송준비중</option>
	                        	<option value="3">배송중</option>
	                        	<option value="4">배송완료</option>
	                        	<option value="5">결제취소</option>
	                        	<option value="6">환불완료</option>
	                        	<option value="7">구매확정</option>
	                        </select>
                    	</div>
                    	<div class="search-input">
	                        <input type="text" name="orderSearchBox" id="searchOption">
                    	</div>
                        <div class="area-btn right">
	                        <button type="button" name="searchSubmitBtn" class="btn btn-pri size01">검색</button>
	                        <button type="button" name="goList" class="btn btn-pri size01">목록</button>
                        </div>
                    </div>
                    <div class="adminPage-result">
                        <table class="table tbl-box">
                            <tr>
                            	<th>구분</th>
                            	<th>상품사진</th>
                                <th>주문번호</th>
                                <th>상품번호</th>
                                <th>회원번호</th>
                                <th>주문일자</th>
                                <th>상품원가</th>
                                <th>수량</th> 
                                <th>가격</th>
                                <th>배송주소</th> 
                                <th>결제상태</th> <!-- choose -->
                                <th>주문상태</th> <!-- choose -->
                                <th>상품상태변경</th>
                            </tr>
                            <c:forEach items="${orderList }" var="o">
                                <tr>
                                	<td><input type="checkBox" id="checkBox"></td>
                                	<td><img src="/resources/upload/product/${o.thumbnail }"></td>
                                    <td>${o.orderNo }</td>
                                    <td>${o.productNo }</td>
                                    <td>${o.memberNo }</td>
                                    <td>${o.orderDate }</td>
                                    <td><fmt:formatNumber value="${o.orderDetailCost }"/></td>
                                    <td>${o.orderDetailCnt }</td>
                                    <td><fmt:formatNumber value="${o.orderDetailPrice }"/></td>
                                    <td>${o.deliAddr }</td>
                                    <c:choose>
                                    	<c:when test="${o.orderStatus == 1 }">
                                    		<td>결제완료</td>
                                    	</c:when>
                                    	<c:when test="${o.orderStatus == 2 }">
                                    		<td>배송준비중</td>
                                    	</c:when>
                                    	<c:when test="${o.orderStatus == 3 }">
                                    		<td>배송중</td>
                                    	</c:when>
                                    	<c:when test="${o.orderStatus == 4 }">
                                    		<td>배송완료</td>
                                    	</c:when>
                                    	<c:when test="${o.orderStatus == 5 }">
                                    		<td>결제취소</td>
                                    	</c:when>
                                    	<c:when test="${o.orderStatus == 6 }">
                                    		<td>환불완료</td>
                                    	</c:when>
                                    	<c:when test="${o.orderStatus == 7 }">
                                    		<td>구매확정</td>
                                    	</c:when>
                                    </c:choose>
                                    <td>
                                    	<c:choose>
                                    		<c:when test="${o.orderStatus == 1 }">
                                    			<select name="orderStatusList" class="orderStatusList">
		                                            <option value="1" selected>결제완료</option>
		                                            <option value="2">배송준비중</option>
		                                            <option value="3">배송중</option>
		                                            <option value="4">배송완료</option>
		                                            <option value="5">결제취소</option>
		                                            <option value="6">환불완료</option>
		                                            <option value="7">구매확정</option>
		                                        </select>
                                    		</c:when>
                                    	</c:choose>
                                    	<c:choose>
                                    		<c:when test="${o.orderStatus == 2 }">
                                    			<select name="orderStatusList" class="orderStatusList">
		                                            <option value="1">결제완료</option>
		                                            <option value="2" selected>배송준비중</option>
		                                            <option value="3">배송중</option>
		                                            <option value="4">배송완료</option>
		                                            <option value="5">결제취소</option>
		                                            <option value="6">환불완료</option>
		                                            <option value="7">구매확정</option>
		                                        </select>
                                    		</c:when>
                                    	</c:choose>
                                    	<c:choose>
                                    		<c:when test="${o.orderStatus == 3 }">
                                    			<select name="orderStatusList" class="orderStatusList">
		                                            <option value="1">결제완료</option>
		                                            <option value="2">배송준비중</option>
		                                            <option value="3" selected>배송중</option>
		                                            <option value="4">배송완료</option>
		                                            <option value="5">결제취소</option>
		                                            <option value="6">환불완료</option>
		                                            <option value="7">구매확정</option>
		                                        </select>
                                    		</c:when>
                                    	</c:choose>
                                    	<c:choose>
                                    		<c:when test="${o.orderStatus == 4 }">
                                    			<select name="orderStatusList" class="orderStatusList">
		                                            <option value="1">결제완료</option>
		                                            <option value="2">배송준비중</option>
		                                            <option value="3">배송중</option>
		                                            <option value="4" selected>배송완료</option>
		                                            <option value="5">결제취소</option>
		                                            <option value="6">환불완료</option>
		                                            <option value="7">구매확정</option>
		                                        </select>
                                    		</c:when>
                                    	</c:choose>
                                    	<c:choose>
                                    		<c:when test="${o.orderStatus == 5 }">
                                    			<select name="orderStatusList" class="orderStatusList">
		                                            <option value="1">결제완료</option>
		                                            <option value="2">배송준비중</option>
		                                            <option value="3">배송중</option>
		                                            <option value="4">배송완료</option>
		                                            <option value="5" selected>결제취소</option>
		                                            <option value="6">환불완료</option>
		                                            <option value="7">구매확정</option>
		                                        </select>
                                    		</c:when>
                                    	</c:choose>
                                    	<c:choose>
                                    		<c:when test="${o.orderStatus == 6 }">
                                    			<select name="orderStatusList" class="orderStatusList">
		                                            <option value="1">결제완료</option>
		                                            <option value="2">배송준비중</option>
		                                            <option value="3">배송중</option>
		                                            <option value="4">배송완료</option>
		                                            <option value="5">결제취소</option>
		                                            <option value="6" selected>환불완료</option>
		                                            <option value="7">구매확정</option>
		                                        </select>
                                    		</c:when>
                                    	</c:choose>
                                    	<c:choose>
                                    		<c:when test="${o.orderStatus == 7 }">
                                    			<select name="orderStatusList" class="orderStatusList">
		                                            <option value="1">결제완료</option>
		                                            <option value="2">배송준비중</option>
		                                            <option value="3">배송중</option>
		                                            <option value="4">배송완료</option>
		                                            <option value="5">결제취소</option>
		                                            <option value="6">환불완료</option>
		                                            <option value="7" selected>구매확정</option>
		                                        </select>
                                    		</c:when>
                                    	</c:choose>
                                    </td> 
                                    <td>
                                    	<input type="hidden" class="orderNo" value="${o.orderNo }">
                                    	<div name="changeOrderStatusBtn"class="area-btn center"><button type="button" class="btn btn-pri size02">상태 변경</button></div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                        <div class="pagination">${pageNavi }</div>
                    </div>
                    <div id="ajaxResult" class="table"></div>
                </div>
            </div>
        </div>
    </div>
</c:when>
<c:otherwise>
<script type="text/javascript">
	location.href = "/main.do";
</script>
</c:otherwise>
</c:choose>
<!-- 스크립트를 넣어봅시다 -->
    <script>
    /* status 변경 */
    $(document).ready(function(){
    	$(".tbl-box td:contains('구매확정')").each(function() {
    	    var td = $(this);
    	    var tr = td.parent();
    	    td.css('color', 'red').css('font-weight','bold');
    	    var originalFontSize = td.css('font-size');
    	    td.css('font-size', '20px').animate({fontSize: originalFontSize}, 1500);
    	  });
    	
    })
    
    	/* 주문상태 변경 */
    	$("[name=changeOrderStatusBtn]").on("click",function(){
    		var orderStatus = $(this).parent().prev().children().val();
    		var orderNo = $(this).prev().val();
    		
            $.ajax({
                url: "/ajaxChangeDeliveryStatus.do",
                type: "POST",
                data: {orderStatus : orderStatus, orderNo : orderNo},
                success: function(data) {
                	if(data == "ok"){
                		$("#adminOrderTable").load(location.href+ '#adminOrderTable');
                	}else{
	    				console.log("다시 시도");
                		
                	}
                }
            })
            
            });
            
            
            // 결제 상태로 검색시 input 사라지고 select 등장
            $("#orderSearchSelect").on("change",function(){
            	var orderSearchOption = $("#orderSearchSelect option:selected").val();
            	var orderStatusSelect = $("#orderStatusSelect");
            	var orderSearchBox = $("[name=orderSearchBox]");
            	
            	if(orderSearchOption == 'orderStatus'){
            		orderSearchBox.hide();
            		orderStatusSelect.show();
            	}else{
            		orderSearchBox.show();
            		orderStatusSelect.hide();
            	}
            	
            })
            
            
            //검색기능
            $("[name=searchSubmitBtn]").on("click",function(){
            	
           	 var orderSearchOption = $("#orderSearchSelect option:selected").val(); // 검색조건
           	 
           	 var orderNo = $("#searchOrderNo").val();
           	 var memberNo = $("#searchMemberNo").val();
           	 var orderStatus = $("#searchOrderStatus").val();
           	 
           	 var orderStatusSelect = $("#orderStatusSelect"); // 두번째 검색조건
           	 
           	 var orderSearchBox = $("[name=orderSearchBox]").val(); // input
           	 var orderStatusSelectVal = $("#orderStatusSelect option:selected").val(); // 검색조건 val
           	 
           	 if(orderSearchOption == 'orderNo'){
           		orderNo = orderSearchBox;
           		memberNo = 0;
           		orderStatus = 0;
           		 
           	 }else if(orderSearchOption == 'memberNo'){
           		memberNo = orderSearchBox;
           		orderNo = 0;
           		orderStatus = 0;
           		 
           	 }else if(orderSearchOption == 'orderStatus'){
           		orderStatus = orderStatusSelectVal;
           		orderNo = 0;
           		memberNo = 0;
           		
           	 }
           	 
           	 $.ajax({
                   url: "/ajaxAdminSearchDelivery.do",
                   type: "POST",
                   data: {orderNo : orderNo, memberNo : memberNo, orderStatus : orderStatus},
                   success: function(data) {
                   	if(data){
                   		$("#ajaxResult").empty();
                   			$(".adminPage-result").hide();
  							const table =$("<table class='table tbl-box' style='width:98%'>");
  							const titleTr = $("<tr>");
  							const td = $("<td></td>");
  							titleTr.html("<th>구분</th><th>상품사진</th><th>주문번호</th><th>상품번호</th><th>회원번호</th><th>주문일자</th><th>상품원가</th><th>수량</th><th>가격</th><th>배송주소</th><th>결제상태</th><th>주문상태</th><th>주문상태 변경</th>");
  							table.append(titleTr);
  							for(let i=0;i<data.length;i++){
  								const tr = $("<tr>");
  								tr.append("<td>"+"</td>")
  								tr.append("<td><img src='/resources/upload/product/"+data[i].thumbnail+"'></td>")
  								tr.append("<td>"+data[i].orderNo+"</td>");
  								tr.append("<td>"+data[i].productNo+"</td>");
  								tr.append("<td>"+data[i].memberNo+"</td>");
  								tr.append("<td>"+data[i].orderDate+"</td>");
  								tr.append("<td>"+data[i].orderDetailCost+"</td>");
  								tr.append("<td>"+data[i].orderDetailCnt+"</td>");
  								tr.append("<td>"+data[i].orderDetailPrice+"</td>");
  								tr.append("<td>"+data[i].deliAddr+"</td>");
  								
  								if(data[i].orderStatus == 1){
  									tr.append("<td>결제완료</td>");
  								}else if(data[i].orderStatus == 2){
  									tr.append("<td>배송준비중</td>");
  								}else if(data[i].orderStatus == 3){
  									tr.append("<td>배송중</td>");
  								}else if(data[i].orderStatus == 4){
  									tr.append("<td>배송완료</td>");
  								}else if(data[i].orderStatus == 5){
  									tr.append("<td>결제취소</td>");
  								}else if(data[i].orderStatus == 6){
  									tr.append("<td>환불완료</td>");
  								}else if(data[i].orderStatus == 7){
  									tr.append("<td>구매확정</td>");
  								}
  								
  								var select = $("<select name='orderStatusList' class='orderStatusList' style='margin: 32px 15px;'></select>");
								tr.append(select.append(
							                $("<option value='1'" + (data[i].orderStatus == 1 ? " selected" : "") + ">결제완료</option>"),
							                $("<option value='2'" + (data[i].orderStatus == 2 ? " selected" : "") + ">배송준비중</option>"),
							                $("<option value='3'" + (data[i].orderStatus == 3 ? " selected" : "") + ">배송중</option>"),
							                $("<option value='4'" + (data[i].orderStatus == 4 ? " selected" : "") + ">배송완료</option>"),
							                $("<option value='5'" + (data[i].orderStatus == 5 ? " selected" : "") + ">결제취소</option>"),
							                $("<option value='6'" + (data[i].orderStatus == 6 ? " selected" : "") + ">환불완료</option>"),
							                $("<option value='7'" + (data[i].orderStatus == 7 ? " selected" : "") + ">구매확정</option>")
							     ));
								
								tr.append("<td><div name='changeOrderStatusBtn' class='area-btn center'><button type='button' class='btn btn-pri size02'>상태 변경</button></div></td>"); // 확정버튼으로
								table.append(tr);
  						}
  						$("#ajaxResult").append(table);
                   		
                   	}else{
   	    				console.log("다시 시도");
                   	}
                   	
	                 // 상태변경
                	$("[name=changeOrderStatusBtn]").on("click",function(){
                		var orderNo = $(this).parent().parent().children().eq(2).text();
                		var orderStatus = $(this).parent().prev().val();
                		
                		console.log(orderNo);
                		console.log(orderStatus);
                		
                        $.ajax({
                            url: "/ajaxChangeDeliveryStatus.do",
                            type: "POST",
                            data: {orderStatus : orderStatus, orderNo : orderNo},
                            success: function(data) {
                            	console.log(data);
                            	
                            	if(data == "ok"){
                            		$("#adminOrderTable").load(location.href+ '#adminOrderTable');
                            	}else{
                    				console.log("다시 시도");
                            		
                            	}
                            }
                        })
                		
               		})
               	}
                  
         	  })
           
           });
       		 
         
            /*목록으로*/
            $("[name=List]").on("click",function(){
            	location.reload();
            })

            
            /* 이미지 css */
            $("img").hover(function () {
            	$(this).css("transform", "scale(1.5)"); //이미지 크기를 1.5배로 늘립니다.
            	},
            	function () {
            	$(this).css("transform", "scale(1)"); //이미지 크기를 원래 크기로 돌립니다.
            	}
			);
            
            //상태변경
            $("[name=changeOrderStatusBtn]").on("click",function(){
        		var orderNo = $(this).parent().parent().children().eq(1).text();
        		var orderStatus = $(this).parent().prev().children().val();
        		
        		
                $.ajax({
                    url: "/ajaxChangeDeliveryStatus.do",
                    type: "POST",
                    data: {orderStatus : orderStatus, orderNo : orderNo},
                    success: function(data) {
                    	if(data == "ok"){
                    		$("#adminOrderTable").load(location.href+ '#adminOrderTable');
                    	}else{
            				console.log("다시 시도");
                    		
                    	}
                    }
                })
        		
        	});
           
            
        
    </script>
    
</body>
</html>