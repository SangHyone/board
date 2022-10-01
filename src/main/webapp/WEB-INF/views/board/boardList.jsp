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
		
		$j("#cbx_chkAll").click(function() {
			if($j("#cbx_chkAll").is(":checked")) $j("input[name=chk]").prop("checked", true);
			else $j("input[name=chk]").prop("checked", false);
		});

		$j("input[name=chk]").click(function() {
			var total = $j("input[name=chk]").length;
			var checked = $j("input[name=chk]:checked").length;

			if(total != checked) $j("#cbx_chkAll").prop("checked", false);
			else $j("#cbx_chkAll").prop("checked", true); 
		});
		
		$j("#submit").on("click", function() {
			var arr = [];
			
			 $j('input[name="chk"]:checked').each(function(i){
                 arr.push($j(this).val());
             });
			 
			 var param = {
                     "checkedList" : arr       
             };
			 
			 $j.ajax({
					url : "/board/sortBoardList.do",
					dataType : "json",
					type : "POST",
					data : param,
					success : function(data, textStatus, jqXHR) {
						alert("검색완료");

						alert("메세지:" + data.success);
						
						$j("#result").empty();
						$j("#totalCnt").empty();
						var boardList = data['boardList'];
						var pageNo = data['pageNo'];
						$j("#totalCnt").append("<td align='right'>total : "+data['totalCnt']+"</td>");
						for(vo of boardList){
							$j("#result").append(function(){
								var board = "<tr>";
								board += "<td align='center'>"+vo.boardType+"</td>"
								board += "<td>"+vo.boardNum+"</td>"
								board += "<td><a href = '/board/"+vo.boardType+"/"+vo.boardNum+"/boardView.do?pageNo="+pageNo+"'>"+vo.boardTitle+"</a></td>"
								board += "</tr>"
								return board;
							})
						}
						
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
					}
			});
		});
	});

</script>
<body>
<table  align="center">
	<tr>
		<td align="left"><a href="/user/login.do">login</a></td>
		<td align="left"><a href="/user/join.do">join</a></td>
	</tr>
	<tr id="totalCnt">
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<tbody id="result">
					<c:forEach items="${boardList}" var="list">
						<tr>
							<td align="center">
								${list.boardType}
							</td>
							<td>
								${list.boardNum}
							</td>
							<td>
								<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
							</td>
						</tr>	
					</c:forEach>
				</tbody>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
	<tr>
		<td align="left">
			<label><input type="checkbox" id="cbx_chkAll">전체</label>
			<c:forEach var="menu" items="${codeList}">
				<label><input type="checkbox" name="chk" value="${menu.codeId }">${menu.codeName}</label>
			</c:forEach>
			<input type="submit" id="submit" value="submit" />
		</td>
	</tr>
</table>	
</body>
</html>