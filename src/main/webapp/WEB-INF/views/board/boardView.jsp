<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {

		$j("#submit").on("click", function() {
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();

			$j.ajax({
				url : "/board/boardWriteAction.do",
				dataType : "json",
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
	
	function change(){
	
		var param = {
				"boardType" : "${boardType}",
				"boardNum" : "${boardNum}",
				"boardTitle" : $j('#boardTitle').text(),
				"boardComment" : $j('#boardComment').text()
		}
		$j.ajax({
			url : "/board/boardViewChangeAction.do",
			dataType : "json",
			type : "POST",
			data : param,
			success : function(data, textStatus, jqXHR) {
				$j("#boardTitle").empty();
				$j("#boardComment").empty();
				$j("#update").empty();
				if(data!=null){
					$j("#boardTitle").append("<input id='title' name='boardTitle' type='text' size='50' value='${board.boardTitle}'>")
					$j("#boardComment").append("<textarea id='comment' name='boardComment'  rows='20' cols='55'>${board.boardComment}</textarea>")
					$j("#update").append("<button onclick='update()'>Edit</button>")
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("실패");
			}
		})
		
	}
	
	function update(){
		var boardNum = '${boardNum}';
		var boardTitle = $j('#title').val();
		var boardComment = $j('#comment').val();
		var param = {
				"boardTitle" : boardTitle,
				"boardComment" : boardComment,
				"boardNum" : boardNum,
		}
		$j.ajax({
		    url : "/board/boardUpdateAction.do",
		    dataType: "json",
		    type: "POST",
		    data : param,
		    success: function(data, textStatus, jqXHR)
		    {
				alert("수정완료");
				
				alert("메세지:"+data.success);
				
				location.href = "/board/boardList.do?pageNo=1";
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    }
		});
	}
	function del(){
		var boardNum = '${boardNum}';
		var param = {
				"boardNum" : boardNum
		}
		$j.ajax({
		    url : "/board/boardDeleteAction.do",
		    dataType: "json",
		    type: "POST",
		    data : param,
		    success: function(data, textStatus, jqXHR)
		    {
				alert("삭제완료");
				
				alert("메세지:"+data.success);
				
				location.href = "/board/boardList.do?pageNo=1";
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    }
		});
	}
</script>
<body>
	<table align="center">
		<tr>
			<td>
				<table border="1">
					<tr>
						<td width="120" align="center">Title</td>
						<td width="400" id="boardTitle">${board.boardTitle}</td>
					</tr>
					<tr>
						<td height="300" align="center">Comment</td>
						<td id="boardComment">${board.boardComment}</td>
					</tr>
					<tr>
						<td align="center">Writer</td>
						<td>${board.creator }</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td id="update" align="right">
				<button onclick='change()'>Edit</button>
			</td>
			<td id="delete" align="right" >
				<button onclick='del()'>Delete</button>
			</td>
			<td align="right"><a href="/board/boardList.do">List</a></td>
		</tr>
	</table>
</body>
</html>