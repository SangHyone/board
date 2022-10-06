<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list1</title>
</head>

<script type="text/javascript">
	var cnt = 0;
	$j(document).ready(function(){
		
		$j("#submit").on("click", function() {
			if(formCheck()){
				var $frm = $j('.userInfo :input');
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
			}
			
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
						$j("#userIdCheck").val($j("#userId").val());
					}else if(data.success=="N"){
						alert("중복된 아이디 입니다.")
						$j("#userId").focus();
					}else{
						alert("아이디를 입력해주세요")
						$j("#userId").focus();
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			});
		});
		
		$j("#name").keyup(function (event) {
            regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
            v = $j(this).val();
            if(v.length>5){
            	alert("이름의 최대글자수는 5글자입니다.")
            	$j(this).val(v.substr(0,5));
            }else{
	            if (regexp.test(v)) {
	                $j(this).val(v.replace(regexp, ''));
	            }
            }
        });
		
		$j("input[name=userId]").keyup(function(event){ 
			if (!(event.keyCode >=37 && event.keyCode<=40)) { 
				var inputVal = $j(this).val();  
				$j(this).val(inputVal.replace(/[^a-z0-9]/gi,'')); 
			} 
		});
		
		$j("input:text[numberOnly]").on("keyup", function(){
			$j(this).val($j(this).val().replace(/[^0-9]/g,""));
			if($j(this).val().length>4){
				alert("4자리까지 입력가능합니다.")
				$j(this).val($j(this).val().substr(0, 4));
			}
		});
		
		$j('#postNo').keyup(function (event){
			var v = $j(this).val();
			if(v.length<6){
				$j(this).val($j(this).val().replace(/[^0-9]/g,""));
			}
			if(v.length==6){
				this.value = autoHypen(v.trim());
			}
			if(v.length>6){
				alert("우편번호는 6자리입니다.")
				$j(this).val(v.substr(0,7));
			}
		})
		
	});
	
	function phoneLengthCheck(object){
		if(object.value.length<4){
			alert("핸드폰번호는 4자리씩 입력하셔야합니다.");
			object.focus();
		}
	}
	
	function idPatternCheck(object){
		var pattern = /^[a-zA-Z0-9]*$/;
		var id = object.value;
		if(!id.match(pattern)){
			alert("영어와 숫자로 입력가능합니다.")
			
		}
	}
	
	function autoHypen(str){
		var str = str.replace(/[^0-9]/g, '')
		var temp = '';
		
		temp += str.substr(0, 3);
		temp += '-';
		temp += str.substr(3);
		
		return temp;
	}
	
	function formCheck(){
		var uid = document.getElementById("userId");
		var uidc = document.getElementById("userIdCheck");
		var pw = document.getElementById("userPw");
		var pwc = document.getElementById("userPwCheck");
		var name = document.getElementById("name");
		var phone = document.getElementById("phone1");
		var phone1 = document.getElementById("phone2");
		
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
		if(pwc.value == ""){
			alert("비밀번호 확인을 하세요");
			pwc.focus();
			return false;
		}
		if(name.value == ""){
			alert("이름을 입력하세요");
			name.focus();
			return false;
		}
		if(phone.value == ""){
			alert("핸드폰번호를 입력하세요");
			phone.focus();
			return false;
		}
		if(phone1.value == ""){
			alert("핸드폰번호를 입력하세요");
			phone1.focus();
			return false;
		}
		var pwdCheck = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{6,12}$/;

		if (!pwdCheck.test(pw.value)) {
		    alert("비밀번호는 영문자+숫자 조합으로 6~12자리 사용해야 합니다.");
		    pw.focus();
		    return false;
		};

		if (pwc.value !== pw.value) {
		    alert("비밀번호가 일치하지 않습니다..");
		    pwc.focus();
		    return false;
		};
		
		if(uid.value !== uidc.value){
			alert("아아디 중복체크해주세요");
			uid.focus();
			return false;
		}
		
		if(phone.value.length!=4){
			alert("핸드폰 중간자리가 4자리가 아닙니다.");
			phone.focus();
			return false;
		}
		if(phone1.value.length!=4){
			alert("핸드폰 중간자리가 4자리가 아닙니다.");
			phone.focus();
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
							<td><input type="text" name="userId" id="userId"/></td>
							<td style="display: none;"><input type="hidden" id="userIdCheck"/></td>
							<td><input type="button" id="checkId" value="중복확인" /></td>
						</tr>
						<tr>
							<td width="120" align="center">pw</td>
							<td><input type="password" name="userPw" id="userPw"/></td>
						</tr>
						<tr>
							<td width="120" align="center">pw check</td>
							<td><input type="password" id="userPwCheck" /></td>
						</tr>
						<tr>
							<td width="120" align="center">name</td>
							<td><input type="text" id="name" name="userName"/></td>
						</tr>
						<tr>
							<td width="120" align="center">phone</td>
							<td width="30"><select name="userPhone1">
									<c:forEach var="phone" items="${phoneList}">
										<option value="${phone.codeId }">${phone.codeName }</option>
									</c:forEach>
								</select>-<input type="text" id="phone1" name="userPhone2" onchange="phoneLengthCheck(this)" numberonly/>-<input type="text" id="phone2" name="userPhone3" onchange="phoneLengthCheck(this)" numberonly/></td>
						</tr>
						<tr>
							<td width="120" align="center">postNo</td>
							<td><input type="text" id="postNo" name="userAddr1"/></td>
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
				<td align="right"><input type="button" id="submit" value="join" ></td>
			</tr>
		</table>
	</form>
</body>
</html>