<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- jquery -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<!-- Chart.js -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    <!-- google icon -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <!-- css -->
	<link rel="stylesheet" href="/resources/css/admin/admin.css" />
	<link rel="stylesheet" href="/resources/css/common/default.css" />
	
	
    
</head>
<style>
    .adminPage-back{
        overflow: hidden;
    }
    .adminPage-back>ul>li{
        text-decoration: none;
    }
    .adminPage-main{
    	overflow: hidden;
    	margin-top: 35px;
    	margin-left: 350px;
    }
    .adminPage-content{
        overflow: hidden;
    }
    .material-symbols-outlined{
        font-size: 100px !important;
    }

    .adminPage-sales{
    	overflow: hidden;
    }
    .totalSales{
    	float: left;
    	width: 600px;
    	height: 170px;
    	border: 1px solid #ffa220;
    	box-sizing : border-box;
    	border-radius: 15px;
    	margin: 10px 100px;
    	text-align: center;
    }
    .monthSales{
    	float: left;
    	width: 600px;
    	height: 170px;
    	border: 1px solid #ffa220;
    	box-sizing : border-box;
    	border-radius: 15px;
    	margin: 10px 20px;
    	text-align: center;
    }
    
    .salesContent span{
    	font-size: 20px;
    	font-weight: bold;
    }    
    
    /* 차트 css */
	.totalChart-wrapper{
		width: 300px;
	}
	.selectCategoryChart{
		margin: 0;
		padding: 0;
	}
	.chartDiv{
		float: left;
	}
	.chart{
		width: 600px;
		height: 450px;
		margin: 0;
		padding: 0;
	}
	.totalSalesChart{
		margin-right: 0;
	}
	.chartLow-1{
		display: flex;
		margin-left: 100px;
		margin-top: 100px;
	}	
	.chartLow-2{
		display: flex;
		margin-left: 100px;
		margin-top: 50px;
	}
	.monthSalesChart{
		margin-left: 120px;
	}
	.selectCategoryChart{
		margin-left: 120px;
	}
	#genderChart{
		height: 400px !important;
	}
	#salesChart{
		height: 380px !important;
	}
	#monthSelect{
		width: 600px;
	    height: 400px;
	    border: 1px solid #ffa220;
	    box-sizing: border-box;
	    font-size: 50px;
   	    text-align: center;
	}
	#monthChart{
		height: 395px !important;
	}
	.title{
		font-size: 20px;
	    font-weight: bold;
	    border-bottom: 5px solid #ffa220;
	}
	.full{
		margin: 30px 106px;
		width: 1300px !important;
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
            <jsp:include page="/WEB-INF/views/admin/adminSideNavi.jsp"/>
	        <div class="adminPage-main">
	        	<div class="adminPage-sales">
	        	<div class="area-btn full"> <!-- ref 버튼 사용예정 -->
        			<button type="button" class="btn btn-pri size02" onclick="salesReportPrint();">매출보고서 출력</button>
        		</div>
	        		<div class="totalSales">
	        			<div class="sales icon"><span class="material-symbols-outlined">monitoring</span></div>
	        			<div class="salesContent">
	        				<span class="salesTitle">총 매출액</span>
	        				<span class="totalSalesCount"><fmt:formatNumber value="${monthSales }"/>원</span>
	        			</div>
	        		</div>
	        		<div class="monthSales">
	        			<div class="sales icon"><span class="material-symbols-outlined">trending_up</span></div>
	        			<div class="salesContent">
	        				<span class="salesTitle">월 매출액</span>
	        				<span class="monthSalesCount"><fmt:formatNumber value="${monthSales }"/>원</span>
	        			</div>
	        		</div>
	        	</div>
        		
	        	<div class="chartDiv">
	        		<div class="chartLow-1">
			        	<div class="totalSalesChart chart">
			        		<div class="totalChartTitle title"><span>Total Sales Chart</span></div>
			        		<canvas id="totalChart"></canvas>
			        	</div>
			        	<div class="monthSalesChart chart">
			        		<div class="monthChartTitle title"><span>Month Sales Chart</span></div>
			        		<canvas id="monthChart"></canvas>
			        	</div>
	        		</div>
		        	<div class="chartLow-2">
			        	<div class="genderSalesChart chart">
			        		<div class="genderChartTitle title"><span>Gender Sales Chart</span></div>
			        		<canvas id="genderChart"></canvas>
			        	</div>
			        	<div class="selectCategoryChart chart">
			        		<div class="categoryChartTitle title"><span>Select Month</span></div>
				        	<select id="monthSelect" class="monthSelect">
				        		<option value="1">선택해주세요.</option>
							    <option value="1">1월</option>
							    <option value="2">2월</option>
							    <option value="3">3월</option>
							    <option value="4">4월</option>
							    <option value="5">5월</option>
							    <option value="6">6월</option>
							    <option value="7">7월</option>
							    <option value="8">8월</option>
							    <option value="9">9월</option>
							    <option value="10">10월</option>
							    <option value="11">11월</option>
							    <option value="12">12월</option>
							</select>
							<canvas id="salesChart">Month Select Sales Chart</canvas>
			        	</div>
		        	</div>
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
<script>
	  
  const chartDataUrl = "https://example.com/data.json";
  
	$(document).ready(function() {
		
		var totalSalesCount = (".totalSalesCount");
		
				$.ajax({
					url: 'ajaxTotalSalesManage.do',
				    dataType: 'json',
				    success: function(data){
						var context = document.getElementById('totalChart').getContext('2d');
				    	var myChart = new Chart(context, {
							type : 'bar', // 차트의 형태
							data : { // 차트에 들어갈 데이터
								labels : [ //x 축
									'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
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
				}); // 매출 판매/원가
				
				
				// 카테고리별 매출 현황
				$.ajax({
					url : '/ajaxTotalCategorySalesManage.do',
					dataType: 'json',
					success: function(data){
						var context = document.getElementById('monthChart').getContext('2d');
			            var myChart = new Chart(context, {
			                type: 'bar', // 차트의 형태
			                data: { // 차트에 들어갈 데이터
			                    labels: [
			                        // 카테고리 명
			                        '패션','뷰티','식품','생활용품','가전/디지털','가구','침구','인테리어','공구','스포츠/레저/취미','출산/유아동','반려용품','명품관'
			                    ],
			                    datasets: [
			                        { //데이터
			                            label: '카테고리별 매출현황', //차트 제목
			                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
			                            data : //x축 label에 대응되는 데이터 값
											[ data[0].totalSales, data[1].totalSales, data[2].totalSales, data[3].totalSales, data[4].totalSales, data[5].totalSales,
												data[6].totalSales, data[7].totalSales, data[8].totalSales, data[9].totalSales, data[10].totalSales, data[11].totalSales,
												data[12].totalSales
										],
			                            backgroundColor: [
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
											'rgba(255, 159, 64, 0.2)',
											'rgba(255, 159, 64, 0.2)'
			                            ],
			                            borderColor: [
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
											'rgba(255, 159, 64, 1)',
											'rgba(255, 159, 64, 1)'
			                            ],
			                            borderWidth: 1 //경계선 굵기
			                        } ,
			                        {
			                        	 label: '원가',
						                  type: 'line',
						                  fill: false,
						                  data: [
						                      data[0].totalCost, data[1].totalCost, data[2].totalCost, data[3].totalCost, data[4].totalCost, data[5].totalCost,
						                      data[6].totalCost, data[7].totalCost, data[8].totalCost, data[9].totalCost, data[10].totalCost, data[11].totalCost,
						                      data[12].totalCost
						                  ],
						                  backgroundColor: 'rgb(157, 109, 12)', // 라인이니까 색상은 한개
						                  borderColor: 'rgb(157, 109, 12)' // 라인이니까 색상 한개
			                        } 
			                    ]
			                },
			                options: {
			                    scales: {
			                        yAxes: [{
			                                ticks: {
			                                    beginAtZero: true
			                                }
			                            }
			                        ]
			                    }
			                }
			            });
					} 
					
				})// 카테고리별 연도 매출
				
	            
	            // 월 select / 카테고리 매출
	            
	            $("#monthSelect").on("change",function(){
	            	
					$("#monthSelect").css("width","70px").css("height","30px").css("font-size","15px").css("text-align","left");
	            	var monthNo = $("#monthSelect option:selected").val(); // 입력확인
					
		            $.ajax({
		            	url : "ajaxSelectMonthSales.do",
		            	type : "post",
		            	data : {monthNo : monthNo},
						success : function(data){
							const category = ['패션','뷰티','식품','생활용품','가전/디지털','가구','침구','인테리어','공구','스포츠/레저/취미','출산/유아동','반려용품','명품관'];
				            
				            var ctx = document.getElementById('salesChart').getContext('2d');
				            var myChart = new Chart(ctx, {
				                type: 'doughnut', // 차트의 형태
				                data: { // 차트에 들어갈 데이터
				                    labels: category,
				                    datasets: [
				                        { //데이터
				                            label: '선택한 월의 매출액', //차트 제목
				                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
				                            data: [
				                            	data[0].totalSales, data[1].totalSales, data[2].totalSales, data[3].totalSales, data[4].totalSales, data[5].totalSales,
												data[6].totalSales, data[7].totalSales, data[8].totalSales, data[9].totalSales, data[10].totalSales, data[11].totalSales
												 // 그래프 각각의 값
				                            ],
				                            backgroundColor: [
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
				                            borderColor: [
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
				                            borderWidth: 1 //경계선 굵기
				                        }/* ,
				                        {
				                            label: 'test2',
				                            fill: false,
				                            data: [
				                                8, 34, 12, 24
				                            ],
				                            backgroundColor: 'rgb(157, 109, 12)',
				                            borderColor: 'rgb(157, 109, 12)'
				                        } */
				                    ]
				                },
				                options: {
		    	                	maintainAspectRatio: false,
		    	                    height: 420,
		    	                    scales: {
		    	                        yAxes: [{
		    	                                ticks: {
		    	                                    beginAtZero: true
		    	                                }
		    	                            }
		    	                        ]
		    	                    }
		    	                }
				            });
						}            	
		            })
	            }) // 월 select 차트
	            
	            
	            // 구매자 성별
	           
	            $.ajax({
	            	url : "/ajaxGenderSalesCount.do",
	            	type : "post",
	            	success : function(data){
	            		console.log(data);
	            		var context = document.getElementById('genderChart').getContext('2d');
	    	            var myChart = new Chart(context, {
	    	                type: 'bar', // 차트의 형태
	    	                data: { // 차트에 들어갈 데이터
	    	                    labels: ['남성','여성','성별없음'], // 카테고리 명
	    	                    datasets: [
	    	                        { //데이터
	    	                            label: '성별에 따른 매출분포', //차트 제목
	    	                            fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
	    	                            data: [ // 그래프의 값
	    	                               	data[0].totalSales, data[1].totalSales, data[2].totalSales
	    	                            ],
	    	                            backgroundColor: [
	    	                                //색상
	    	                            	'rgba(255, 99, 132, 0.2)',
			                                'rgba(54, 162, 235, 0.2)',
			                                'rgba(255, 206, 86, 0.2)'
	    	                            ],
	    	                            borderColor: [
	    	                                //경계선 색상
	    	                            	'rgba(255, 99, 132, 1)',
			                                'rgba(54, 162, 235, 1)',
			                                'rgba(255, 206, 86, 1)'
	    	                            ],
	    	                            borderWidth: 1 //경계선 굵기
	    	                        },
	    	                        
	    	                    ]
	    	                },
	    	                options: {
	    	                	maintainAspectRatio: false,
	    	                    scales: {
	    	                        yAxes: [{
	    	                                ticks: {
	    	                                    beginAtZero: true
	    	                                }
	    	                            }
	    	                        ]
	    	                    }
	    	                }
	    	            });
	            	}
	            }); // 성별에 따른 매출
	             
	          
	            
	            

			}); // function ready
			
		function salesReportPrint(){
			window.open('http://192.168.10.143/salesReportPrint.do','_blank', 'width=700px,height=800px,scrollbars=yes');
		
			
		}
			
		
			
			
			
			
</script>
	  
</body>
</html>