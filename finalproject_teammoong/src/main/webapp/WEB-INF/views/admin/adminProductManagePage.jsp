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
    .material-symbols-outlined{
        font-size: 150px;
    }
    .mainContent{
        float: left;
        width: 300px;
        height: 400px;
        text-align: center;
    }
    .table>tbody>tr>th{
    	border: 1px solid black;
    }
    .table>tbody>tr>td{
    	border: 1px solid black;
    }
    .searchForm{
    	display: none;
    }
    .tbl-box th:nth-child(1),
	.tbl-box th:nth-child(2),
	.tbl-box th:nth-child(10),
	.tbl-box th:nth-child(11){
		width: 45px;
	}
	.tbl-box th:nth-child(3),
	.tbl-box th:nth-child(4){
		width: 100px;
	}
	.tbl-box th:nth-child(5){
		width: 200px;
	}
	.tbl-box th:nth-child(8),
	.tbl-box th:nth-child(9){
		width: 60px;
	}
	.tbl-box th:nth-child(7),
	.tbl-box th:nth-child(6){
		width: 50px;
	}
	.tbl-box th:nth-child(12),
	.tbl-box th:nth-child(13){
		width: 80px;
	}
    .tbl-box th:nth-child(14){
		width: 100px;
	}
	.tbl-box tr{
		height: 40px;
	}
    
	img {
 		 width: 100px;
 		 height: 50px;
 		 transition: transform 0.2s;
	}
	img:hover {
	 	 transform: scale(1.5);
	}
	
	.adminPage-search {
		  display: flex;
		  align-items: center;
		  margin-bottom: 15px;
	}
	
	.adminPage-result{
		width: 98%;
	}
	
	.search-select,
	.search-input,
	.area-btn {
	  margin-right: 10px;
	}

	.btn {
	  margin-right: 5px;
	}
	#searchOption{
		width: 400px;
	}
	#productSearchSelect{
		min-height: 32px;
	    padding: 8px 10px;
	    border-radius: 4px;
	    height: 37px;
	}
	[name=allChangeProductStatus]{
		margin-top: 20px;
	}
	[name=changeProductStatusBtn]{
		margin: auto;
	}


</style>
<body>
<c:choose>
<c:when test="${not empty sessionScope.m and sessionScope.m.memberStatus == 0}">
    <div class="adminPage-wrapper" id="adminProductTable">
        <div class="adminPage-header">
            <div class="adminPage-title"><a href="/#">Moong's Admin</a></div>
        </div>
        <div class="adminPage-back">
            <jsp:include page="/WEB-INF/views/admin/adminSideNavi.jsp"/>
            <div class="adminPage-main">
                <div class="adminPage-content">
                    <div class="adminPage-search">
	                    <div class="search-select">
	                        <select id="productSearchSelect" class="select-custom">
	                            <option id="searchProductNo" value="productNo">상품 번호 검색</option>
	                            <option id="searchProductName" value="productName">상품 이름</option>
	                            <option id="searchProductStatus" value="productStatus">상품 상태 검색</option>
	                        </select>
	                    </div>
                        <div class="search-input"><input type="text" name="productSearchBox" id="searchOption" placeholder="상태 검색시 [대기/등록/보류/만료]"></div>
                        <div class="area-btn right">
	                        <button type="button" name="searchSubmitBtn" class="btn btn-pri size01">검색</button>
	                        <button type="button" name="goList" class="btn btn-pri size01">목록</button>
                        </div>
                    </div>
                    <div class="adminPage-result">
                        <table class="table tbl-box">
                            <tr>
                            	<th>구분</th>
                                <th>상품번호</th>
                            	<th>제품사진</th>
                                <th>카테고리명</th>
                                <th>상품이름</th>
                                <th>상품수량</th>
                                <th>남은수량</th><!-- 추가 -->
                                <th>상품가격</th>
                                <th>원가</th>
                                <th>인원수</th>
                                <th>할인율</th>
                                <th>상품상태</th> 
                                <th>상품상태변경</th>
                                <th>확정버튼</th>
                            </tr>
                            <c:forEach items="${productList }" var="p">
                                <tr>
                                	<td><input type="checkBox" class="checkBox"></td>
                                    <td>${p.productNo }<input type="hidden" name="productNo" class="productNo" value="${p.productNo }"></td>
                                	<td><img src="/resources/upload/product/${p.thumbnail }"></td>
                                    <td>${p.categoryName }</td>
                                    <td>${p.productName }<input type="hidden" class="productName" value="${p.productName }"></td>
                                    <td>${p.productEa }</td>
                                    <td>${p.presentCnt }</td>
                                    <td><fmt:formatNumber value="${p.productPrice }"/></td>
                                    <td><fmt:formatNumber value="${p.productCost }"/></td>
                                    <td>${p.gongguNumber }</td>
                                    <td>${p.productDiscount }%</td>
                                   	<c:choose>
                                   		<c:when test="${p.productStatus == 1 }">
                                   			<td>대기</td>
                                   		</c:when>
                                   		<c:when test="${p.productStatus == 2 }">
                                   			<td>등록</td>
                                   		</c:when>
                                   		<c:when test="${p.productStatus == 3 }">
                                   			<td>보류</td>
                                   		</c:when>
                                   		<c:when test="${p.productStatus == 4 }">
                                   			<td>만료</td>
                                   		</c:when>
                                   	</c:choose>
                                    <td>
	                                    <c:choose>
	                                    	<c:when test="${p.productStatus == 1 }">
		                                    	<select class="productStatusList" id="productStatusList">
		                                            <option value="1" selected>대기</option>
		                                            <option value="2">등록</option>
		                                            <option value="3">보류</option>
		                                            <option value="4">만료</option>
		                                        </select>
	                                    	</c:when>
	                                    	<c:when test="${p.productStatus == 2 }">
		                                    	<select class="productStatusList" id="productStatusList">
		                                            <option value="1">대기</option>
		                                            <option value="2" selected>등록</option>
		                                            <option value="3">보류</option>
		                                            <option value="4">만료</option>
		                                        </select>
	                                    	</c:when>
	                                    	<c:when test="${p.productStatus == 3 }">
		                                    	<select class="productStatusList" id="productStatusList">
		                                            <option value="1">대기</option>
		                                            <option value="2">등록</option>
		                                            <option value="3" selected>보류</option>
		                                            <option value="4">만료</option>
		                                        </select>
	                                    	</c:when>
	                                    	<c:when test="${p.productStatus == 4 }">
		                                    	<select class="productStatusList" id="productStatusList">
		                                            <option value="1">대기</option>
		                                            <option value="2">등록</option>
		                                            <option value="3">보류</option>
		                                            <option value="4" selected>만료</option>
		                                        </select>
	                                    	</c:when>
	                                    </c:choose>
	                                </td>
                                    <td>
                                    	<div name="changeProductStatusBtn" class="area-btn center"><button type="button" class="btn btn-pri size02">상태 변경</button></div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                        <div class="area-btn left size02"><button type="button" name="allChangeProductStatus" class="btn btn-pri size02">일괄 변경</button></div>
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
    /* 상태 변경 */
	$("[name=changeProductStatusBtn]").on("click",function(){
		var productNo = $(this).parent().parent().children().eq(1).text();
		var productStatus = $(this).parent().prev().children().val();

		console.log(productStatus);
		console.log(productNo);
		
        $.ajax({
            url: "/ajaxChangeProductStatus.do",
            type: "POST",
            data: {productStatus : productStatus, productNo : productNo},
            success: function(data) {
            	if(data == "ok"){
            		$("#adminProductTable").load(location.href+ '#adminProductTable');
            	}else{
    				console.log("다시 시도");
            		
            	}
            }
        })
		
	});
	
	 
    /* 일괄 변경 */
    
    $("[name=allChangeProductStatus]").on("click",function(){
    	const check = $(".checkBox:checked");
		if(check.length == 0){
			alert("선택된 회원이 없습니다.");
			return;
		}
			const no = new Array();
			//체크된 회원의 등급을 저장할 배열
			const level = new Array();
			//체크된 체크박스 기준으로 회원번호, 등급을 찾아서 배열에 넣는 작업
			
			check.each(function(index, item){
				const productNo = $(item).parent().next().text();
				no.push(productNo);
				//check기준으로 td -> tr -> 후손중에 select찾기
				const productStatus = $(item).parent().parent().find("select").val();
				level.push(productStatus);
			});
			
			location.href="/checkedChangeProductStatus.do?no="+no.join("/")+"&level="+level.join("/");
	});
            
        
        
        /* 검색기능 */
        $("[name=searchSubmitBtn]").on("click",function(){
       	 var productSearchOption = $("#productSearchSelect option:selected").val();
         var productNo = $("#searchProductNo").val();
       	 var productName = $("#searchProductName").val();
       	 var productStatus = $("#searchProductStatus").val();
       	 var productSearchBox = $("[name=productSearchBox]").val();
       	 
       	 if(productSearchOption == 'productNo'){
       		productNo = productSearchBox;
       		productName = '';
       		productStatus = 0;
       	 }else if(productSearchOption == 'productName'){
       		productName = productSearchBox;
       		productStatus = 0;
       		productNo = 0;
       	 }else if(productSearchOption == 'productStatus'){
       		 if(productSearchBox == '대기'){
	       		productStatus = 1;
       		 }else if(productSearchBox == '등록'){
       			productStatus = 2; 
       		 }else if(productSearchBox == '보류'){
       			productStatus = 3; 
       		 }else if(productSearchBox == '만료'){
       			productStatus = 4; 
       		 }
	       		productName = '';
	       		productNo = 0;
       	 }
       	 
        	 $.ajax({
                url: "/ajaxAdminSearchProduct.do",
                type: "POST",
                data: {productNo : productNo, productName : productName, productStatus : productStatus},
                success: function(data) {
                	if(data){
                		$("#ajaxResult").empty();
                			$(".adminPage-result").hide();
							const table =$("<table class='tbl-box'>");
							const titleTr = $("<tr>");
							const td = $("<td></td>");
							titleTr.html("<th>구분</th><th>제품사진</th><th>상품번호</th><th>카테고리명</th><th>상품이름</th><th>상품수량</th><th>남은수량</th><th>상품가격</th><th>원가</th><th>공동구매인원수</th><th>상품할인율</th><th>상품상태</th><th>상품상태변경</th><th>확정버튼</th>");
							table.append(titleTr);
							for(let i=0;i<data.length;i++){
								const tr = $("<tr>");
								tr.append("<td>"+"</td>")
								tr.append("<td>"+data[i].productNo+"</td>");
								tr.append("<td><img src='/resources/upload/product/"+data[i].thumbnail+"'></td>")
								tr.append("<td>"+data[i].categoryName+"</td>");
								tr.append("<td>"+data[i].productName+"</td>");
								tr.append("<td>"+data[i].productEa+"</td>");
								tr.append("<td>"+data[i].presentCnt+"</td>");
								tr.append("<td>"+data[i].productPrice+"</td>");
								tr.append("<td>"+data[i].productCost+"</td>");
								tr.append("<td>"+data[i].gongguNumber+"</td>");
								tr.append("<td>"+data[i].productDiscount+"</td>");
								
								if(data[i].productStatus == 1){
									tr.append("<td>대기</td>");
								}else if(data[i].productStatus == 2){
									tr.append("<td>등록</td>");
								}else if(data[i].productStatus == 3){
									tr.append("<td>보류</td>");
								}else if(data[i].productStatus == 4){
									tr.append("<td>만료</td>");
								}
								
								var select = $("<select name='productStatusList' class='productStatusList' style='margin: 24px 35px;'></select>");
								tr.append(select.append(
							                $("<option value='1'" + (data[i].productStatus == 1 ? " selected" : "") + ">대기</option>"),
							                $("<option value='2'" + (data[i].productStatus == 2 ? " selected" : "") + ">등록</option>"),
							                $("<option value='3'" + (data[i].productStatus == 3 ? " selected" : "") + ">보류</option>"),
							                $("<option value='4'" + (data[i].productStatus == 4 ? " selected" : "") + ">만료</option>")
							     ));
								tr.append("<td><div name='changeProductStatusBtn' class='area-btn center'><button type='button' class='btn btn-pri size02'>상태 변경</button></div></td>"); // 확정버튼으로
								table.append(tr);
						}
						$("#ajaxResult").append(table);
                		
                	}else{
	    				console.log("다시 시도");
                	}
                	
                	// 상태변경
                	$("[name=changeProductStatusBtn]").on("click",function(){
                		var productNo = $(this).parent().parent().children().eq(1).text();
                		var productStatus = $(this).parent().prev().val();
                		
                		console.log(productNo);
                		console.log(productStatus);
                		
                		
                        $.ajax({
                            url: "/ajaxChangeProductStatus.do",
                            type: "POST",
                            data: {productStatus : productStatus, productNo : productNo},
                            success: function(data) {
                            	if(data == "ok"){
                            		$("#adminProductTable").load(location.href+ '#adminProductTable');
                            	}else{
                    				console.log("다시 시도");
                            		
                            	}
                            }
                        })
                		
                	});
                	
                	/* 페이지 연결 */
                    $(".tbl-box").on("click",'td:nth-child(n+2):nth-child(-n+11)',function(){
                    	var productNo = $(this).parent().children().eq(1).text();
                    	
                    	console.log("productNo : "+productNo);
                    	
               			window.open('http://192.168.10.143/productView.do?productNo='+productNo);
                	});
                	
                }
            })
       		 
        });
        
        /* 페이지 연결 */
        $(".tbl-box").on("click", 'td:nth-child(n+2):nth-child(-n+11)',function(){
        	var productNo = $(this).parent().children().eq(1).text();
        	console.log(productNo);
   			window.open('http://192.168.10.143/productView.do?productNo='+productNo);
    	});
        
        /*목록으로*/
        $("[name=goList]").on("click",function(){
        	location.reload();
        })
   	
   	
        
    </script>
</body>
</html>