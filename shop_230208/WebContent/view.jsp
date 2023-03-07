<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
int num = ((Integer)request.getAttribute("num")).intValue();
int nowPage = ((Integer)request.getAttribute("page")).intValue();
%>
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
			<h1 class="display-3">게시판 세부내용 보기</h1>
		</div>
	</div>

	<div class="container">
		<form name="viewDetail" class="form-horizontal" action="./BoardUpdateAction.do?num=${dto.num}&pageNum=<%=nowPage%>" method="post">

			<div class="form-group row">
				<label for="name" class="col-sm-2">성 명</label> 
				<div class="col-sm-3"> 
					<input type="text" class="form-control" name="name" id="name" value="${dto.name}" readonly>
				</div>
			</div>
			<div class="form-group row">
				<label for="subject" class="col-sm-2">제 목</label>
				<div class="col-sm-5">  
					<input type="text" class="form-control" name="subject" id="subject" value="${dto.subject}">
				</div>
			</div>
			<div class="form-group row">
				<label for="content" class="col-sm-2">내 용</label>
				<div class="col-sm-7" style="word-break: break-all;"> 
					<textarea rows="5" cols="50" name="content" id="content" class="form-control">${dto.content}</textarea>
				</div>
			</div>
			<div class="form-group row">
				<label for="regist_day" class="col-sm-2">등록일자</label> 
				<div class="col-sm-5"> 
					<input type="text" class="form-control" name="regist_day" id="regist_day" value="${dto.regist_day}" readonly>
				</div>
			</div>
			<div class="form-group row">
				<label for="hit" class="col-sm-2">조회수</label> 
				<div class="col-sm-5"> 
					<input type="text" class="form-control" name="hit" id="hit" value="${dto.hit}" readonly>
				</div>
			</div>
			<div class="form-group row">
				<label for="ip" class="col-sm-2">IP주소</label> 
				<div class="col-sm-5"> 
					<input type="text" class="form-control" name="ip" id="ip" value="${dto.ip}" readonly>
				</div>
			</div>
			<div class="form-group row" align="center">
				<div class="col-sm-offset-2 col-sm-10">
				<c:if test="${sessionId==dto.id}">
					<a href="./BoardDeleteAction.do?num=${dto.num}&pageNum=<%=nowPage%>" class="btn btn-danger">삭제</a>
					<input type="submit" class="btn btn-success" value="수정">
				</c:if>
					<a href="./BoardListAction.do?pageNum=<%=nowPage%>" class="btn btn-primary">현재 목록</a>
					<button type="button" class="btn btn-primary" onclick="location.href='BoardListAction.do';">처음으로</button>
				</div>				
			</div>
			</form>
	</div>

</body>
</html>