<%@ page contentType="text/html; charset=UTF-8" %>
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
			<h2><i class="fa-solid fa-person-circle-question"></i> 질문과 답변 </h2>
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
						<th class="subject">제목</th>
						<th class="name">작성자</th>
						<th class="date">질문일자</th>
						<th class="hit">처리결과</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="dto" items="${list}" varStatus="status">
						<tr>
							<td>${dataCount - (page-1) * size - status.index}</td>
							<td class="left">
								<c:choose>
									<c:when test="${dto.secret==1}"><!-- 비밀글인경우: 관리자 -->
										<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
											<a href="${articleUrl}&writeNum=${dto.writeNum}">${dto.title}</a>
										</c:if>						<!-- 비밀글인경우: 사용자 -->
										<c:if test="${sessionScope.member.userId!=dto.userId && sessionScope.member.userId!='admin'}">
											비밀글 입니다.
										</c:if>
										<i class="fa-solid fa-key"></i>
									</c:when>
									<c:otherwise>		<!-- 비밀글 아닌경우 -->
										<a href="${articleUrl}&writeNum=${dto.writeNum}">${dto.title}</a>
									</c:otherwise>
								</c:choose>								
								
							</td>
							<td>${dto.userId}</td>
							<td>${dto.reg_date}</td>
							<td>${not empty dto.answerId?"답변완료":"답변대기"}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div class="page-navigation">
				${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>
			
			<table class="table">
				<tr>
					<td width="100">
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/q_bbs/list.do';" title="새로고침"><i class="fa-solid fa-arrow-rotate-right"></i></button>
					</td>
					<td align="center">
						<form name="searchForm" action="${pageContext.request.contextPath}/q_bbs/list.do" method="post">
							<input type="text" name="kwd" value="${kwd}" class="form-control"
									style="width: 200px;" 
									placeholder="검색 키워드를 입력하세요">
							<button type="button" class="btn" onclick="searchList();">검색</button>	<!-- 키워드검색? -->
						</form>
					</td>
					<td align="right" width="100">
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/q_bbs/write.do';">질문등록</button>
					</td>
				</tr>
			</table>

	    </div>
	</div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</footer>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>