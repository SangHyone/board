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
		add();
	});
	
	function add() {
		$j("#write")
			.append(
				$j(".template")[0].innerHTML
			);
	}
	
	function remove() {
		if ($j("#write > .board").length == 1) {
			alert("더 이상 삭제할 수 없습니다.");
			return;
		}
		
		$j("#write > .board:last").remove();
	}
	
	function json() {
		var tags = ["select", "input", "textarea"]
		
		var output = [];
		
		$j("#write > .board").each((i, e) => {
			var obj = {};
			
			$j(e).find(tags.join(",")).each((i, e2) => {
				var t = $j(e2);
			
				obj[t.prop("name")] = t.prop("value");
			});
			
			output.push(obj);
		});
		
		return output;
	}
	
	function complete() {
		$j.ajax({
			url : "/board/boardWriteAction.do",
			dataType : "json",
			contentType: "application/json; charset=utf-8",
			type : "POST",
			data : JSON.stringify(json()),
			success : function(data, status, xhr) {
				location.href = "/board/boardList.do?pageNo=1";
			},
			error : function(xhr, status, error) {
				alert("실패");
			}
		});
	}
</script>
<body>
	<div class="template" style="display:none">
		<table class="board" border="1">
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
				<td width="400">
					<input name="boardTitle" type="text" size="50" value="${board.boardTitle}" />
				</td>
			</tr>
			<tr>
				<td height="300" align="center">Comment</td>
				<td valign="top">
					<textarea name="boardComment" rows="20" cols="55">${board.boardComment}</textarea>
				</td>
			</tr>
			<tr>
				<td align="center">Writer</td>
				<td width="400">
					<input type="text" name="creator" value="${user.userId}" readonly="readonly" />
				</td>
			</tr>
		</table>
	</div>
	<form class="form">
		<table align="center">
			<tr>
				<td align="right"><input onclick="add()" type="button" value="행추가"></td>
				<td align="right"><input onclick="remove()" type="button" value="행삭제"></td>
				<td align="right"><input onclick="complete()" type="button" value="작성"></td>
			</tr>
			<tr>
				<td id="write"></td>
			</tr>
			<tr>
				<td align="right"><a href="/board/boardList.do">List</a></td>
			</tr>
		</table>
	</form>
	<input type="hidden" id="codeList" value="${codeList}" />
</body>
</html>