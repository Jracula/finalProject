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
	<!-- data tables -->
	<link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css"/> 
	<!-- data tables 버튼 관련 -->
<!-- 	<script src="https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script> 
	<script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script> 
	<script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js"></script> -->
	<!-- Bootstrap JavaScript 모달 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<!-- css -->
	<link rel="stylesheet" href="/resources/css/admin/admin.css" />
	<link rel="stylesheet" href="/resources/css/common/default.css" />
	
</head>
<style>
	.adminPage-main{
    	overflow: hidden;
    	margin-top: 35px;
    	margin-left: 350px;
    	
    }
    .adminPage-content{
        background-color: #fff;
        overflow: hidden;
    }
    .mainContent{
        float: left;
        width: 300px;
        height: 400px;
        text-align: center;
    }
    .searchForm{
    	display: none;
    }
   /*  #categorySelect{
    	display: none;
    }
    #searchOption{
    	width: 300px !important;
    }
    
    #boardSearchSelect{
		min-height: 32px;
	    padding: 8px 10px;
	    border-radius: 4px;
	    height: 37px;
	}
	#categorySelect{
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
	.size02{
		font-size: 15px !important;
	} */
	
	.adminPage-result{
		width: 98%;
	}



</style>
<body>
<c:choose>
<c:when test="${not empty sessionScope.m and sessionScope.m.memberStatus == 0}">
    <div class="adminPage-wrapper">
        <div class="adminPage-header">
            <div class="adminPage-title"><a href="/#">Moong's Admin</a></div>
        </div>
        <div class="adminPage-back">
            <jsp:include page="/WEB-INF/views/admin/adminSideNavi.jsp"/>
            <script src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
            <div class="adminPage-main">
                <div class="adminPage-content">
                    <div class="adminPage-search">
                    <div class="adminPage-result">
                        <table id="dataTables" class="table-bordered">
	                        <thead>
	                            <tr>
	                            	<th>게시글 번호</th>
	                                <th>카테고리 번호</th>
	                            	<th>작성자</th>
	                                <th>게시일자</th>
	                                <th>공구 시작일</th>
	                                <th>공구 마감일</th>
	                                <th>공구 진행여부</th>
	                            	<th>상품명</th>
	                                <th>상품가격</th>
	                            </tr>
	                        </thead>
	                        <tbody>
                            <c:forEach items="${boardList }" var="b">
                            	<c:forEach items="${b.boardOptionList }" var="bo">
                                <tr>
                                    <td>${b.boardNo }<input type="hidden" class="boardNo" value="${b.boardNo }"></td>
                                    <td>${b.categoryName }</td>
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
		                             <td>${bo.detailName }</td>
		                             <td><fmt:formatNumber value="${bo.detailPrice }"/>원</td>
		                             </c:forEach>
                            	</c:forEach>
                            </tbody>
                       	</table>
                    </div>
                    <div id="ajaxResult" class="table"></div>
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


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<!-- 스크립트를 넣어봅시다 -->
<script type="text/javascript">

    $(document).ready(function() {
	    $('#dataTables').DataTable({
	        dom : 'lfrtip',
	        searching: true, // 검색 input 세팅
	        fixedHeader: true, // 헤더 설정
	        columns: [
	        	{ searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true },
	            { searchable: true },
	        ], // 검색 조건 설정, 컬럼에 true 값을 주면 해당 컬럼적용
	        "lengthMenu": [ [10, 25, 50, -1], [10, 25, 50, "All"] ], // 조회 개수 설정
	        buttons: ['copy', 'excel', 'pdf', 'print'],
	        
	    });	
    });
    
</script>
    
    
    
	    
    
    
        
    
</body>
</html>