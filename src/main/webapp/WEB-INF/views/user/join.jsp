<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#submit").on("click", function() {
			
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			$j.ajax({
				url : "/user/joinAction.do",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data, textStatus, jqXHR) {
					alert("가입완료");

					alert("메세지:" + data.success);

					location.href = "/board/boardList.do?pageNo=1";
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("가입실패");
				}
			});
		})
		
		$j("#checkId").on("click", function() {
			var param = {
					"userId" : $j("#userId").val()
			}
			$j.ajax({
				url : "/user/checkId.do",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data, textStatus, jqXHR) {
					if(data.success=="Y"){
						alert("가입가능한 아이디 입니다.")
					}else{
						alert("중복된 아이디 입니다.")
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			});
		})
		
		
	});
	
	

</script>
<body>
<form class="userInfo">
		<table align="center">
			<tr>
				<td align="left"><a href="/board/boardList.do">List</a></td>
			</tr>
			<tr>
				<td>
					<table border="1">
						<tr>
							<td width="120" align="center">id</td>
							<td><input type="text" name="userId" id="userId"/></td>
							<td><input type="button" id="checkId" value="중복확인" /></td>
						</tr>
						<tr>
							<td width="120" align="center">pw</td>
							<td><input type="password" name="userPw" id="userPw"/></td>
						</tr>
						<tr>
							<td width="120" align="center">pw check</td>
							<td><input type="password" id="userPwcheck" /></td>
						</tr>
						<tr>
							<td width="120" align="center">name</td>
							<td><input type="text" name="userName"/></td>
						</tr>
						<tr>
							<td width="120" align="center">phone</td>
							<td width="30"><select name="userPhone1">
									<c:forEach var="phone" items="${phoneList}">
										<option value="${phone.codeId }">${phone.codeName }</option>
									</c:forEach>
								</select>-<input type="text" name="userPhone2"/>-<input type="text" name="userPhone3"/></td>
						</tr>
						<tr>
							<td width="120" align="center">postNo</td>
							<td><input type="text" name="userAddr1"/></td>
						</tr>
						<tr>
							<td width="120" align="center">address</td>
							<td><input type="text" name="userAddr2"/></td>
						</tr>
						<tr>
							<td width="120" align="center">company</td>
							<td><input type="text" name="userCompany"/></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><button id="submit">join</button></td>
			</tr>
		</table>
	</form>
</body>
</html>