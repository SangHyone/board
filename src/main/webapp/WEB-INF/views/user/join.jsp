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
						alert("���ԿϷ�");

						alert("�޼���:" + data.success);

						location.href = "/board/boardList.do?pageNo=1";
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("���Խ���");
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
						alert("���԰����� ���̵� �Դϴ�.")
						$j("#userIdCheck").val($j("#userId").val());
					}else if(data.success=="N"){
						alert("�ߺ��� ���̵� �Դϴ�.")
						$j("#userId").focus();
					}else{
						alert("���̵� �Է����ּ���")
						$j("#userId").focus();
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("����");
				}
			});
		});
		
		$j("#name").keyup(function (event) {
            regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
            v = $j(this).val();
            if(v.length>5){
            	alert("�̸��� �ִ���ڼ��� 5�����Դϴ�.")
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
				alert("4�ڸ����� �Է°����մϴ�.")
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
				alert("�����ȣ�� 6�ڸ��Դϴ�.")
				$j(this).val(v.substr(0,7));
			}
		})
		
	});
	
	function phoneLengthCheck(object){
		if(object.value.length<4){
			alert("�ڵ�����ȣ�� 4�ڸ��� �Է��ϼž��մϴ�.");
			object.focus();
		}
	}
	
	function idPatternCheck(object){
		var pattern = /^[a-zA-Z0-9]*$/;
		var id = object.value;
		if(!id.match(pattern)){
			alert("����� ���ڷ� �Է°����մϴ�.")
			
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
			alert("���̵� �Է��ϼ���");
			uid.focus();
			return false;
		}
		if(pw.value == ""){
			alert("��й�ȣ�� �Է��ϼ���");
			pw.focus();
			return false;
		}
		if(pwc.value == ""){
			alert("��й�ȣ Ȯ���� �ϼ���");
			pwc.focus();
			return false;
		}
		if(name.value == ""){
			alert("�̸��� �Է��ϼ���");
			name.focus();
			return false;
		}
		if(phone.value == ""){
			alert("�ڵ�����ȣ�� �Է��ϼ���");
			phone.focus();
			return false;
		}
		if(phone1.value == ""){
			alert("�ڵ�����ȣ�� �Է��ϼ���");
			phone1.focus();
			return false;
		}
		var pwdCheck = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{6,12}$/;

		if (!pwdCheck.test(pw.value)) {
		    alert("��й�ȣ�� ������+���� �������� 6~12�ڸ� ����ؾ� �մϴ�.");
		    pw.focus();
		    return false;
		};

		if (pwc.value !== pw.value) {
		    alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�..");
		    pwc.focus();
		    return false;
		};
		
		if(uid.value !== uidc.value){
			alert("�ƾƵ� �ߺ�üũ���ּ���");
			uid.focus();
			return false;
		}
		
		if(phone.value.length!=4){
			alert("�ڵ��� �߰��ڸ��� 4�ڸ��� �ƴմϴ�.");
			phone.focus();
			return false;
		}
		if(phone1.value.length!=4){
			alert("�ڵ��� �߰��ڸ��� 4�ڸ��� �ƴմϴ�.");
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
							<td><input type="button" id="checkId" value="�ߺ�Ȯ��" /></td>
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