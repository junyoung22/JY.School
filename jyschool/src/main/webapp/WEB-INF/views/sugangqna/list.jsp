﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css">
.body-main {
	max-width: 700px;
}

.table-list thead > tr:first-child{ background: #f8f8f8; }
.table-list th, .table-list td { text-align: center; }
.table-list .left { text-align: left; padding-left: 5px; }

.table-list .num { width: 60px; color: #787878; }
.table-list .subject { color: #787878; }
.table-list .name { width: 100px; color: #787878; }
.table-list .date { width: 100px; color: #787878; }
.table-list .hit { width: 70px; color: #787878; }
</style>
<script type="text/javascript">
function searchList() {
	const f = document.searchForm;
	f.submit();
}
</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
	    <div class="body-title">
			<h2><i class="fa-regular fa-square"></i> 수강신청 강좌 목록 </h2>
	    </div>
	    
	    <div class="body-main mx-auto">
			<table class="table">
				<tr>
					<td width="50%">
						${dataCount}개(${page}/${total_page} 페이지)
					</td>
					<td align="right">&nbsp;</td>
				</tr>
			</table>
			
			<table class="table table-border table-list">
				<thead>
					<tr>
						<th class="num">번호</th>
						<th class="subject">강좌이름</th>
						<th class="name">강사</th>
						<th class="date1">시작날짜</th>
						<th class="date2">종료날짜</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="dto" items="${list}" varStatus="status">
						<tr>
							<td>${dataCount - (page-1) * size - status.index}</td>
							<td class="left">
								<a href="${pageContext.request.contextPath}/sugangqna/list_ok.do?classNum=${dto.classNum}">${dto.className}</a>
							</td>
							<td>${dto.teacherName}</td>
							<td>${dto.startDate}</td>
							<td>${dto.endDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div class="page-navigation">
				${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>
	    </div>
	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>