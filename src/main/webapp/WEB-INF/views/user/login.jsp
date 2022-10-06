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
			if(formCheck()){
				var $frm = $j('.userInfo :input');
				var param = $frm.serialize();
				$j.ajax({
					url : "/user/loginAction.do",
					dataType : "json",
					type : "POST",
					data : param,
					success : function(data, textStatus, jqXHR) {
						if(data.idError=="Y"){
							if(data.pwError=="Y"){
								alert("아이디와 비밀번호 모두 틀렸습니다. 다시 확인해주세요.")
								$j("#userId").focus();
							}else{
								alert("아이디가 존재하지 않습니다.");
								$j("#userId").focus();
							}
						}else if(data.pwError=="Y"){
							alert("비밀번호가 틀렸습니다.");
							$j("#userPw").focus();
						}else{
							alert("로그인 성공");
							location.href = "/board/boardList.do?pageNo=1";
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("통신실패");
					}
				});
			}
		});
	});
	
	function formCheck(){
		var uid = document.getElementById("userId");
		var pw = document.getElementById("userPw");
		
		if(uid.value == ""){
			alert("아이디를 입력하세요");
			uid.focus();
			return false;
		}
		
		if(pw.value == ""){
			alert("비밀번호를 입력하세요");
			pw.focus();
			return false;
		}
		return true;
	}
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
							<td><input type="text" id="userId" name="userId" /></td>
						</tr>
						<tr>
							<td width="120" align="center">pw</td>
							<td><input type="password" id="userPw" name="userPw"/></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><input type="button" id="submit" value="login" ></td>
			</tr>
		</table>
	</form>
</body>
</html>