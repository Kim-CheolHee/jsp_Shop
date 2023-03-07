<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">글쓰기</h1>
		</div>
	</div>

	<div class="container">
		<form name="login" class="form-horizontal" action="./BoardWriteAction.do" method="post">

			<div class="form-group row">
				<label for="inputUserId" class="col-sm-2">아이디</label>
				<div class="col-sm-2"> 
					<input type="text" class="form-control" placeholder="아이디" name="id" id="inputUserId" value="${sessionId}" readonly autofocus>
				</div>
			</div>
			<div class="form-group row">
				<label for="inputName" class="col-sm-2">성명</label> 
				<div class="col-sm-2"> 
					<input type="text" class="form-control" placeholder="성명" name="name" id="inputName" value="${sessionName}" readonly>
				</div>
			</div>
			<div class="form-group row">
				<label for="inputSubject" class="col-sm-2">제목</label>
				<div class="col-sm-4">  
					<input type="text" class="form-control" placeholder="제목" name="subject" id="inputSubject" required>
				</div>
			</div>
			<div class="form-group row">
				<label for="inputContent" class="col-sm-2">내용</label>
				<div class="col-sm-6"> 
					<textarea rows="5" cols="50" placeholder="내용" name="content" id="inputContent" class="form-control" required></textarea>
				</div>
			</div>
			<div class="form-group row" align="center">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="submit" class="btn btn-success" value="글쓰기">
					<button type="reset" class="btn btn-danger">RESET</button>
					<button type="button" class="btn btn-secondary" onclick="location.href='BoardListAction.do';">목록 바로가기</button>
				</div>				
			</div>
			</form>
	</div>

</body>
</html>