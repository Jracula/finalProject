<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
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
					<input type="file"><button type=button>����</button>
				</th>
			</tr>
			<tr>
				<th>
					����
				</th>
			</tr>
			<tr>
				<td>
					<textarea ></textarea>
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