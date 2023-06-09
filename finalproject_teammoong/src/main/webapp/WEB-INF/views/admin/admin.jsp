<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
  	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <!-- google icon -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<!-- data tables -->
	<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/> 
	<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
	<!-- css -->
	<link rel="stylesheet" href="/resources/css/admin/admin.css" />
	<!-- Chart.js -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	<!-- Bootstrap JavaScript 모달 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	
</head>
<style>
	.adminPage-title{
		margin-bottom: 20px;
	}
	.adminPage-title>a{
		text-decoration: none;
	}
    .adminPage-main{
    	overflow: hidden;
    	margin-top: 35px;
    	margin-left: 350px;
    }
    .adminPage-content{
        background-color: #fff;
        overflow: hidden;
    }
    
    .mainContent-row-1{
    	float: left;
    	margin: 10px 15px;
    }
    
    .mainContent-row-2{
    	float: left;
    	margin: 10px 15px;
    }
    .mainContent-row-3{
    	float: left;
    	margin: 10px 15px;
    }
    .material-symbols-outlined{
        font-size: 50px !important;
        
        
    }
    .mainContent{
        width: 600px;
        height: 250px;
        text-align: center;
        border: 1px solid #ffa220;
       	box-sizing: border-box;
       	border-radius: 15px;
       	margin-bottom: 10px;
       	margin-left: 10px;
       	margin-right: 10px;
       	margin-top: 10px;
		overflow: hidden;
		float: left;       	
		background: var(--bg-color, white);
		box-shadow: var(--box-shadow, 0 0 10px #ffa220); /* 뒤에 색상만 바꿔주면 됨 */
    }
    .mainContent>div>h4{
    	margin: 0;
    }
    .mainContent>div>h5{
    	margin-bottom: 0;
    }
    
    .adminPage-content :hover{
    	color: black;
    	background-color: white;
    }
    .adminPage-summary{
    	width : 100%;
    	overflow: hidden;
    	margin-top: 50px;
    }
    .summary-row-1{
    	float: left;
    	overflow : hidden;
    	width: 100%;
    	margin-bottom: 50px;
    	height: 350px;
    	margin-left: 25px;
    	
    }
    .summary-row-2{
   		float: left;
    	overflow : hidden;
    	width: 100%;
    	margin-bottom: 50px;
    	height: 350px;
    	margin-left: 25px;
    }
    .summary-row-3{
   		float: left;
    	overflow : hidden;
    	width: 100%;
    	height: 350px;
    	margin-left: 25px;
    }
    
    .summary-member{
    	float: left;
    	width: 600px;
    	height: 100%;
    }
    .summary-product{
    	float: left;
    	width: 600px;
    	height: 100%;
    	margin-left: 20px;
    }
    .summary-askitem{
       	float: left;
       	width: 600px;
       	height: 100%;
    }
    .summary-board{
       	float: left;
       	width: 600px;
       	height: 100%;
       	margin-left: 20px;
    }
    .summary-sales{
    	float: left;
    	width: 600px;
    	height: 100%;
    }
    #summaryChart{
    	height: 280px !important;

    }
    
    
    img {
 		 width: 100px;
 		 height: 50px;
 		 transition: transform 0.2s;
	}
	img:hover {
	 	 transform: scale(1.5);
	}
	
	.highlight {
	   background-color: #ffa220;
	   transition: transform 0.2s ease-in-out;
	}

	.highlight:hover {
	   transform: translateY(-2px);
	}
	
	.lowlight{
		background-color: #cc3d50;
	  	transition: transform 0.2s ease-in-out;
	}
	.lowlight:hover {
	   transform: translateY(-2px);
	}
	.subtitle{
		font-size: 20px;
	    font-weight: bold;
	    border-bottom: 5px solid #ffa220;
	    margin-bottom: 20px;
	    padding-left: 30px;
	    padding-bottom: 15px;
	    
	}
	#memberTable tbody tr{
		border: 1px soild #ffa220;
	}
	table.dataTable tr {
  		border-bottom: 1px solid #ccc;
	}

</style>
<body>
<%-- <jsp:include page="/WEB-INF/views/common/header.jsp" /> --%>
<c:choose>
 <c:when test="${not empty sessionScope.m and sessionScope.m.memberStatus == 0}">
    <div class="adminPage-wrapper">
        <div class="adminPage-header">
            <div class="adminPage-title"><a href="/#">Moong's Admin</a></div>
        </div>
        <div class="adminPage-back">
            <jsp:include page="/WEB-INF/views/admin/adminSideNavi.jsp" />
            
            
            <div class="adminPage-main">
                <div class="adminPage-content">
                	<div class="mainContent-row-1">
	                    <div class="mainContent c-1">
	                        <div class="member title"><h3>회원수 관리</h3></div>
	                        <div class="member icon"><span class="material-symbols-outlined">account_circle</span></div>
	                        <div class="member subTitle"><h4>총 회원수</h4></div>
	                        <div class="member totalCount"><span id="memberTotalCount"></span></div>
	                        <div class="member variationTitle"><h5 style="font-size: 20px">금일 회원가입</h5></div>
	                        <div class="member-variationCount" style="font-weight: bold"></div>
	                    </div>
	                    <div class="mainContent c-2">
	                        <div class="product title"><h3>상품 관리</h3></div>
	                        <div class="product icon"><span class="material-symbols-outlined">redeem</span></div>
	                        <div class="product subTitle"><h4>오늘 판매된 상품</h4></div>
	                        <div class="product totalCount"><span id="productTotalCount"></span></div>
	                        <div class="product variationTitle"><h5 style="font-size: 20px">금일 등록 상품</h5></div>
	                        <div class="product-variationCount" style="font-weight: bold"></div>
	                    </div>
                	</div>
                	<div class="mainContent-row-2">
	                    <div class="mainContent c-3">
	                        <div class="board title"><h3>여기여기붙어라 관리</h3></div>
	                        <div class="board icon"><span class="material-symbols-outlined">thumb_up</span></div>
	                        <div class="board subTitle"><h4>오늘 등록된 게시물</h4></div>
	                        <div class="board totalCount"><span id="boardTotalcount"></span></div>
	                        <div class="board variationTitle"><h5 style="font-size: 20px">금일 등록 게시글</h5></div>
	                        <div class="board-variationCount" style="font-weight: bold"></div>
	                    </div>
	                    <div class="mainContent c-4">
	                        <div class="order title"><h3>매출액 관리</h3></div>
	                        <div class="order icon"><span class="material-symbols-outlined">calculate</span></div>
	                        <div class="order subTitle"><h4>이번달 매출액</h4></div>
	                        <div class="order-totalCount"><span id="orderTotalcount"></span></div>
	                        <div class="order variationTitle"><h5 style="font-size: 20px">금일 판매금액</h5></div>
	                        <div class="order-variationCount" style="font-weight: bold"></div>
	                    </div>
                	</div>
                	<div class="mainContent-row-3">
	                    <div class="mainContent c-5">
	                        <div class="bestProduct title"><h3>베스트 상품 관리</h3></div>
	                        <div class="bestProduct icon"><span class="material-symbols-outlined">mode_heat</span></div>
	                        <div class="bestProduct subTitle"><h4>베스트 상품 매출액</h4></div>
	                        <div class="bestProduct totalCount"><span id="bestProductTotalCount"></span></div>
	                        <!-- <div class="bestProduct variationTitle"><h5 style="font-size: 20px"></h5></div>
	                        <div class="bestProduct variationCount" style="font-weight: bold"></div> -->
	                    </div>
	                    <div class="mainContent c-6">
	                        <div class="coupon title"><h3>쿠폰 관리</h3></div>
	                        <div class="coupon icon"><span class="material-symbols-outlined">festival</span></div>
	                        <div class="coupon subTitle"><h4>현지 진행중인 쿠폰 이벤트</h4></div>
	                        <div class="coupon totalCount"><span id="couponTotalCount"></span></div>
	                        <!-- <div class="coupon variationTitle"><h5 style="font-size: 20px">증감</h5></div>
	                        <div class="coupon variationCount" style="font-weight: bold"></div> -->
	                    </div>
                	</div>
                </div>
                <div class="adminPage-summary">
	                <div class="summary-row-1">
		                <div class="summary summary-member">
		                	<div class="summary-title subtitle">회원게시판</div>
		                	<table id="memberTable">
		                		<thead>
			                		<tr>
			                			<th>회원번호</th>
			                			<th>회원아이디</th>
			                			<th>이름</th>
			                			<th>가입일</th>
			                			<th>마케팅 동의 여부</th>
			                		</tr>
		                		</thead>
		                		<tbody>
			                		<c:forEach items="${memberList }" var="m">
			                			<tr>
			                				<td>${m.memberNo }</td>
			                				<td>${m.memberId }</td>
			                				<td>${m.memberName }</td>
			                				<td>${m.regDate }</td>
			                				<c:choose>
		                                        <c:when test="${m.memberAgree == 0}">
		                                            <td>동의안함</td>
		                                        </c:when>
		                                        <c:when test="${m.memberAgree == 1}">
		                                            <td>동의</td>
		                                        </c:when>
		                                    </c:choose>
			                			</tr>
			                		</c:forEach>
		                		</tbody>
		                	</table>
		                </div>
	                	<div class="summary summary-product"> <!-- 제품 등록 현황 5개만 -->
	                		<div class="summary-title subtitle">상품게시판</div>
	                		<table id="productTable">
	                			<thead>
		                			<tr>
		                				<th>상품번호</th>
		                				<th>섬네일</th>
		                				<th>카테고리</th>
		                				<th>상품명</th>
		                				<th>가격</th>
		                			</tr>
	                			</thead>
	                			<tbody>
		                			<c:forEach items="${productList }" var="p">
		                				<tr>
		                					<td>${p.productNo }</td>
		                					<td><img src="/resources/upload/product/${p.thumbnail }"></td>
		                					<c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 1}">
		                                    		<td>패션</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 2}">
		                                    		<td>뷰티</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 3}">
		                                    		<td>식품</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 4}">
		                                    		<td>생활용품</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 5}">
		                                    		<td>가전/디지털</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 6}">
		                                    		<td>가구</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 7}">
		                                    		<td>침구</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 8}">
		                                    		<td>인테리어</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 9}">
		                                    		<td>공구</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 10}">
		                                    		<td>스포츠/레저/취미</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 11}">
		                                    		<td>출산/유아동</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 12}">
		                                    		<td>반려용품</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo == 13}">
		                                    		<td>명품관</td>
		                                    	</c:when>
		                                    </c:choose>
		                                    <c:choose>
		                                    	<c:when test="${p.detailCategoryNo > 13}">
		                                    		<td>테스트용인듯</td>
		                                    	</c:when>
		                                    </c:choose>
		                					<td>${p.productName }</td>
		                					<td>${p.productPrice }</td>
		                				</tr>
		                			</c:forEach>
	                			</tbody>
	                		</table>
	                	</div>
                	</div>
	                <div class="summary-row-2">
	                	<div class="summary summary-askitem"> <!-- 입점 문의 5개 -->
	                		<div class="summary-title subtitle">입점문의</div>
	                		<table id="askitemTable">
	                			<thead>
		                			<tr>
		                				<th>사업자명</th>
		                				<th>담당자명</th>
		                                <th>담당자 연락처</th>
		                                <th>요청제목</th>
		                                <th>신청일</th>
		                			</tr>
	                			</thead>
	                			<tbody>
		                			<c:forEach items="${askItemList }" var="a">
		                				<tr>
		                					<td>${a.corpName }</td>
		                					<td>${a.contName }</td>
		                                    <td>${a.contPhone }</td>
		                                    <td>${a.askTitle }</td>
				                            <td>${a.askDate }</td>
		                				</tr>
		                			</c:forEach>
	                			</tbody>
	                		</table>
	                	</div>
	                	<div class="summary summary-board"> <!-- 여여붙 5개만 -->
	                		<div class="summary-title subtitle">여여붙게시판</div>
	                		<table id="boardTable">
	                			<thead>
		                			<tr>
		                				<th>작성자</th>
		                				<th>작성일</th>
		                				<th>공구시작일</th>
		                				<th>공구마감일</th>
		                				<th>공구상태</th>
		                			</tr>
	                			</thead>
	                			<tbody>
		                			<c:forEach items="${boardList }" var="b">
		                				<tr>
		                					<td>${b.boardWriter }</td>
		                                    <td>${b.boardDate }</td>
		                                    <td>${b.boardStart }</td>
		                                    <td>${b.boardEnd }</td>
		                                    <c:choose>
		                                    	<c:when test="${b.boardStatus == 1 }">
		                                    		<td>진행</td>
		                                    	</c:when>
		                                    	<c:when test="${b.boardStatus == 2 }">
		                                    		<td>마감</td>
		                                    	</c:when>
		                                   	</c:choose>
		                				</tr>
		                			</c:forEach>
	                			</tbody>
	                		</table>
	                	</div>
	                </div>
	                <div class="summary-row-3">
	                	<div class="summary summary-sales">
	                		<div class="subtitle"><span>연 매출 차트</span></div>
	                		<canvas id="summaryChart"></canvas>
	                	</div>
	                </div>
                </div>
            </div>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</c:when>
<c:otherwise>
<script type="text/javascript">
	location.href = "/main.do";
</script>
</c:otherwise>
</c:choose>

<script>
    $(document).ready(function(){
        var memberTotalCount = $("#memberTotalCount");
        var productTotalCount = $("#productTotalCount");
        var boardTotalCount = $("#boardTotalcount");
        var orderTotalCount = $("#orderTotalcount");
        var bestProductTotalCount = $("#bestProductTotalCount");
        var couponTotalCount = $("#couponTotalCount");
        
        var memberSpan = $(".member-variationCount");
        var productSpan = $(".product-variationCount");
        var boardSpan = $(".board-variationCount");
        var orderSpan = $(".order-variationCount");

        $.ajax({
            url : "/ajaxTotalCount.do",
            method : "get",
            dataType : "json",
            success : function(data){
            	console.log(data);
            	var memberTotal = parseInt(data[1]);
            	var productTotal = parseInt(data[3]);
            	var boardTotal = parseInt(data[5]);
            	var orderTotal = parseInt(data[7]);
            	
                memberTotalCount.text(data[0]+"명"); // 맴버수
                
                if(memberTotal > 0){
                	memberSpan.text("+"+memberTotal+"명");
                    memberSpan.css("color","blue");
                    $(".c-1").addClass('highlight');
                } else if(memberTotal == 0){
                    memberSpan.text(0);
                } else if(memberTotal < 0){
                    memberSpan.text("-"+memberTotal+"명");
                    memberSpan.css("color","red");
                    $(".c-1").addClass('lowlight');
                }
                productTotalCount.text(data[2]+"개"); // 판매 게시글
                
                if(productTotal > 0){
	                productSpan.text("+"+productTotal+"개");
	                productSpan.css("color","blue");
	                $(".c-2").addClass('highlight');
                }else if(productTotal == 0){
                	productSpan.text(0);
                }else if(productTotal < 0){
                	productSpan.text("-"+productTotal+"개");
                	productSpan.css("color","red");
                	$(".c-2").addClass('lowlight');
                }
                boardTotalCount.text(data[4]+"개"); // 여여붙 게시글
                
                if(boardTotal > 0){
	                boardSpan.text("+"+boardTotal+"원");
	                boardSpan.css("color","blue");
	                $(".c-3").addClass('highlight');
                }else if(boardTotal == 0){
                	boardSpan.text(0);
                }else if(boardTotal < 0){
                	boardSpan.text("-"+boardTotal+"원");
                	boardSpan.css("color","red");
                	$(".c-3").addClass('lowlight');
                }
                
                orderTotalCount.text(data[6]+"원"); // 주문 매출액
                
                if(orderTotal > 0){
	                orderSpan.text("+"+orderTotal+"원");
	                orderSpan.css("color","blue");
	                $(".c-4").addClass('highlight');
                }else if(orderTotal == 0){
                	orderSpan.text(0);
                }else if(orderTotal < 0){
                	orderSpan.text("-"+orderTotal+"원");
                	orderSpan.css("color","red");
                	$(".c-4").addClass('lowlight');
                }
                
                bestProductTotalCount.text(data[8]+"원"); // 베스트 상품 매출액
                
                /* couponTotalCount.text(data[5]);  */
            }
            
        }); // 대시보드 count
        
        $(".mainContent").on("click",function(){
        	$(this).removeClass("highlight");
        	$(this).removeClass("lowlight");
        	
        }) // 대시보드 하이라이트
        
	    const chartDataUrl = "https://example.com/data.json";
        
        $.ajax({
			url: 'ajaxTotalSalesManage.do',
		    dataType: 'json',
		    success: function(data){
				var context = document.getElementById('summaryChart').getContext('2d');
		    	var myChart = new Chart(context, {
					type : 'bar', // 차트의 형태
					data : { // 차트에 들어갈 데이터
						labels : [ //x 축
							'1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
						datasets : [ { //데이터
						label : '매출', //차트 제목
						fill : false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
						data : //x축 label에 대응되는 데이터 값
							[ data[0].totalSales,data[1].totalSales,data[2].totalSales,data[3].totalSales,data[4].totalSales,data[5].totalSales,
								data[6].totalSales,data[7].totalSales,data[8].totalSales,data[9].totalSales,data[10].totalSales,data[11].totalSales 
						],
						backgroundColor : [
								//색상
								'rgba(255, 99, 132, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(255, 206, 86, 0.2)',
								'rgba(75, 192, 192, 0.2)',
								'rgba(153, 102, 255, 0.2)',
								'rgba(255, 159, 64, 0.2)',
								'rgba(255, 99, 132, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(255, 206, 86, 0.2)',
								'rgba(75, 192, 192, 0.2)',
								'rgba(153, 102, 255, 0.2)',
								'rgba(255, 159, 64, 0.2)'
								],
						borderColor : [
								//경계선 색상
								'rgba(255, 99, 132, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(75, 192, 192, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(255, 159, 64, 1)',
								'rgba(255, 99, 132, 1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(75, 192, 192, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(255, 159, 64, 1)'
								],
						borderWidth : 1	//경계선 굵기
					} ,
		              {
		                  label: '원가',
		                  type: 'line',
		                  fill: false,
		                  data: [
		                      data[0].totalCost, data[1].totalCost, data[2].totalCost, data[3].totalCost, data[4].totalCost, data[5].totalCost,
		                      data[6].totalCost, data[7].totalCost, data[8].totalCost, data[9].totalCost, data[10].totalCost, data[11].totalCost
		                  ],
		                  backgroundColor: 'rgb(157, 109, 12)', // 라인이니까 색상은 한개
		                  borderColor: 'rgb(157, 109, 12)' // 라인이니까 색상 한개
		              }
					]
				},
				options : {
					scales : {
						yAxes : [ {
							ticks : {
								beginAtZero : true
							}
						} ]
					}
				}
			});
		    }
		});
        
        
        // 테이블
        $("#memberTable").DataTable({
	        dom : 'lfrtip',
	        searching: true, // 검색 input 세팅
	        fixedHeader: true, // 헤더 설정
	        columns: [
	        	{ searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true }
	        ], // 검색 조건 설정, 컬럼에 true 값을 주면 해당 컬럼적용
	        "lengthMenu": [ [3, 5, -1], [3, 5, "All"] ], // 조회 개수 설정
	        
	    });    
        
        
        // 상품테이블 
        $('#productTable').DataTable({
	        dom : 'lfrtip',
	        searching: true, // 검색 input 세팅
	        fixedHeader: true, // 헤더 설정
	        columns: [
	        	{ searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true }
	        ], // 검색 조건 설정, 컬럼에 true 값을 주면 해당 컬럼적용
	        "lengthMenu": [ [2, 3, 5, -1], [2, 3, 5, "All"] ], // 조회 개수 설정
	        
	    });
        
        $('#productTable tbody').on('click', 'tr', function() {
        	var productNo = $(this).children().eq(0).text();
        	console.log(productNo);
   			window.open('http://192.168.10.143/productView.do?productNo='+productNo); 
	    });
         
        $('#askitemTable').DataTable({
	        dom : 'lfrtip',
	        searching: true, // 검색 input 세팅
	        fixedHeader: true, // 헤더 설정
	        columns: [
	        	{ searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true }
	        ], // 검색 조건 설정, 컬럼에 true 값을 주면 해당 컬럼적용
	        "lengthMenu": [ [3, 5, -1], [3, 5, "All"] ], // 조회 개수 설정
	        
	    });
        
        $('#boardTable').DataTable({
	        dom : 'lfrtip',
	        searching: true, // 검색 input 세팅
	        fixedHeader: true, // 헤더 설정
	        columns: [
	        	{ searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true }
	        ], // 검색 조건 설정, 컬럼에 true 값을 주면 해당 컬럼적용
	        "lengthMenu": [ [3, 5, -1], [3, 5, "All"] ], // 조회 개수 설정
	        
	    });
        
        
        
        
    }) // ready 
    	/* 
    	
        $(".checkBtn").on("click",function(){
	        $.ajax({
	            url : "/ajaxTotalCount.do",
	            method : "get",
	            dataType : "json",
	            success : function(data){
	            	console.log("통신성공");
	            	console.log(data);
	                memberTotalCount.text(data[0]);
	                productTotalCount.text(data[1]);
	                boardTotalCount.text(data[2]);
	                orderTotalCount.text(data[3]);
	                bestProductTotalCount.text(data[4]);
	                couponTotalCount.text(data[5]); 
	            }
	            
	        })
        	
        }) */
        
   
        
        
        

    </script>
</body>
</html>