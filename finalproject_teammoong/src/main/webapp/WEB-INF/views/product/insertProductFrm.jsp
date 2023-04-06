<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
<style>
	.note-editable{
		text-align: left;
		background-color: #fff;
	}
	 input[type=radio],input[type=checkbox]{
        width: auto;
        display: inline-block;
        min-height: auto;
        margin-left : 30px;
        
    }
   	label{
   		margin-right : 130px;
   	}
    
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<div class="content-wrap">
    <form action="/insertProduct.do" method="post" enctype="multipart/form-data">
    <table border="3">
        <tr>
            <th>카테고리</th>
            <td>
                <select name="category">
                    <!--아작스로 카테고리 추가  -->
                </select>
            </td>
            <td>
                <select name="dCategoryNo">
                	<!--아작스로 세부 카테고리 추가  -->
                </select>
            </td>
        </tr>
        <tr>
            <th>상품이름</th>
            <td colspan="2"><input type="text" name="productName"></td>
        </tr>
        <tr>
            <th>상품수량</th>
            <td colspan="2"><input type="text" name="productEa"></td>
        </tr>
        <tr>
            <th>상품가격</th>
            <td colspan="2"><input type="text" name="productPrice"></td>
        </tr>
        <tr>
            <th>할인률</th>
            <td colspan="2"><input type="text" name="productDiscount"></td>
        </tr>
            <input type="hidden" name="productStatus" value="1">
        <tr>
            <th>원가격</th>
            <td colspan="2"><input type="text" name="productCost"></td>
        </tr>
        <tr>
            <th>공동구매인원수</th>
            <td  colspan="2">
<!--                 <select name="gongguNumber"> -->
<!--                     <option value="2">2</option> -->
<!--                     <option value="3">3</option> -->
<!--                     <option value="4">4</option> -->
<!--                     <option value="5">5</option> -->
<!--                 </select> -->
				<div style="text-align : left;"> 
                <input type="radio" id="two" name="gongguNumber" value="1">
                <label for="two">2</label>
                <input type="radio" id="three" name="gongguNumber" value="1">
                <label for="three">3</label>
                <input type="radio" id="four" name="gongguNumber" value="1">
                <label for="four">4</label>
                <input type="radio" id="five" name="gongguNumber" value="1">
                <label for="five">5</label>
                </div>
            </td>
        </tr>
        <tr>
            <th>썸네일</th>
            <td colspan="2"><input type="file" name="productFile" multiple></td>
        </tr>
        <tr>
            <th>상품내용</th>
            <td colspan="2"><textarea name="productContent"></textarea></td>
        </tr>
        <tr>
        <th colspan="3"><div class="area-btn full"><button class="btn btn-pri size01" type="submit">등록</button></div></th>
        </tr>
        <tr>
        <th colspan="3"><div class="area-btn full"><button class="btn btn-sec size01" type="button">취소</button></div></th>
        </tr>
    </table>
	</form>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script src="/resources/summernote/summernote-lite.js"></script>
	<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<script>
	$( function() {
		$( "[name=category]" ).selectmenu();
		$( "[name=dCategoryNo]" ).selectmenu();
		$("[name=gonggu-number]").selectmenu();
	});
		$("[name=productContent]").summernote({
			height : 550,
			lang : "ko-KR",
			callbacks : {
				onImageUpload : function(files) {
					uploadImage(files[0], this)
				}
				
			}
		});
		window.onload = function(){
			var categoryNo = $("[name=category]").val();
			$("[name=category]").empty();
            $("[name=category]").append("<option>카테고리</option>");
            $("[name=dCategoryNo]").append("<option>세부카테고리</option>");
		    $.ajax({
		    	url : "/selectAllCategory.do",
		    	type : "POST",
		    	dataType : "JSON",
		    	success : function(values){
		    		console.log(values)
		    		for(var i=0; i<values.length; i++){
		    		$("[name=category]").append("<option value="+[i+1]+">"+values[i].categoryName+"</option>");
		    		}
		    	},
		    });
	    }
		$("[name=category]").on("selectmenuchange",function(){
		    $("[name=dCategoryNo]").empty();
		    $("[name=dCategoryNo]").append("<option>세부카테고리</option>");
		    $.ajax({
		    	url : "/selectDetailCategory.do",
		    	type : "POST",
		    	dataType : "JSON",
		    	data : {categoryNo : $("[name=category]").val()},
		    	success : function(data){
		    		console.log(data)
		    		for(var i=0; i<data.length; i++){
			    		$("[name=dCategoryNo]").append("<option value="+data[i].dcategoryNo+">"+data[i].dcategoryName+"</option>");
			    		}
		    		
	    		},
		    });
		});
		$("[name=dCategoryNo]").on("selectmenuchange",function(){
			console.log($(this).val());
		})
		
	</script>
</body>
</html>