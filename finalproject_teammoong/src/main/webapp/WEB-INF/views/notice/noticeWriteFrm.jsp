<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<form action="/noticeWrite.do" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th>
					<label for="title">����</label>
					<select size="1" name="status" class="input-form-short">
						<option value="1">����</option>
						<option value="0">�Ϲ�</option>
					</select>
					<input type="text" name="noticeTitle" class="input-form">
				</th>
			</tr>
			<tr>
				<th>
					<label for="file">����÷��</label>
					<input type="file" name="noticeFile" multiple><button type=button>����</button>
				</th>
			</tr>
			<tr>
				<th>
					<label for="noticeWriter">�ۼ���</label>
				</th>
				<td>
					${sessionScope.m.memberId }
					<input type="hidden" name="noticeWriter" value="${sessionScope.m.memberId }" readonly>
				<td>
			</tr>
			<tr>
				<th>����</th>
			</tr>
			<tr>
				<td>
					<textarea name="noticeContent"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="����">
					<button type="button">���</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>