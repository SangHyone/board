<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		
		$j("#submit").on("click", function() {
			changeName();
			var $frm = $j('.boardWrite :input');
			
			for (var i = 0; i < $frm.length; i++) {
				if ($frm.eq(i).val() != null) {
					while ($frm.eq(i).val().search(",") != -1) {
						$frm.eq(i).val($frm.eq(i).val().replace(",", "csh99"));
					}
				}
			}
			var param = $frm.serialize();
			console.log(param);
			alert(param)
			$j.ajax({
				url : "/board/boardWriteAction.do",
				dataType : "json",
	            contentType: 'application/json; charset=utf-8',
				type : "POST",
				data : param,
				success : function(data, textStatus, jqXHR) {
					alert("작성완료");

					alert("메세지:" + data.success);

					location.href = "/board/boardList.do?pageNo=1";
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			});
		});
	});
	
	function changeName(){
		/* $j('.boardWrite :input').each(function(index,item){
			$j(item).attr("name", "boardList["+index+"]."+$j(item).name)
		}) */
		
		$j("select[name=boardType]").each(function(index, item){
			$j(item).attr("name","boardList["+index+"].boardType");
    	});
		$j("input[name=boardTitle]").each(function(index, item){
			$j(item).attr("name","boardList["+index+"].boardTitle");
    	});
		$j("textarea[name=boardComment]").each(function(index, item){
			$j(item).attr("name","boardList["+index+"].boardComment");
    	});
	}
	
	[board,board,board]
	board = {
			type: 1,
			title :2,
			comment :3
	}
	function addRow() {
		var innerHtml = "";
		innerHtml += '<tr>';
		innerHtml += '<td width="120" align="center">Type</td>';
		innerHtml += '<td><select name="boardType">';
		innerHtml += '<c:forEach var="menu" items="${codeList}">'
		innerHtml += '<option value="${menu.codeId}">${menu.codeName}</option>'
		innerHtml += '</c:forEach>'
		innerHtml += '</select></td>';
		innerHtml += '<tr>';
		innerHtml += '<td width="120" align="center">Title</td>';
		innerHtml += '<td width="400"><input name="boardTitle" type="text" size="50" value="${board.boardTitle}"></td>';
		innerHtml += '</tr>';
		innerHtml += '<tr>';
		innerHtml += '<td height="300" align="center">Comment</td>';
		innerHtml += '<td valign="top"><textarea name="boardComment" rows="20" cols="55">${board.boardComment}</textarea></td>';
		innerHtml += '</tr>';
		$j('#write > tbody:first').append(innerHtml);
	}
	
	function deleteRow() {
		var trCnt = $j('#write tr').length;
		if (trCnt > 4) {
			$j('#write > tbody:first > tr:last').remove();
			$j('#write > tbody:first > tr:last').remove();
			$j('#write > tbody:first > tr:last').remove();
		} else {
			alert("더 이상 삭제할 수 없습니다.");
		}
	}
</script>
<body>
	<form class="boardWrite">
		<table align="center">
			<tr>
				<td align="right"><input onclick="addRow()" type="button"
					value="행추가"></td>
				<td align="right"><input onclick="deleteRow()" type="button"
					value="행삭제"></td>
				<td align="right"><input id="submit" type="button" value="작성">
				</td>
			</tr>
			<tr>
				<td>
					<table id="write" border="1">
						<tbody>
							<tr>
								<td width="120" align="center">Type</td>
								<td><select name="boardType">
									<c:forEach var="menu" items="${codeList}">
										<option value="${menu.codeId }">${menu.codeName }</option>
									</c:forEach>
								</select></td>
							</tr>
							<tr>
								<td width="120" align="center">Title</td>
								<td width="400"><input name="boardTitle" type="text"
									size="50" value="${board.boardTitle}"></td>
							</tr>
							<tr>
								<td height="300" align="center">Comment</td>
								<td valign="top"><textarea name="boardComment" rows="20"
										cols="55">${board.boardComment}</textarea></td>
							</tr>
						</tbody>
						<tr>
							<td align="center">Writer</td>
							<td></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><a href="/board/boardList.do">List</a></td>
			</tr>
		</table>
	</form>
	<input type="hidden" id="codeList" value="${codeList}" />
</body>
</html>