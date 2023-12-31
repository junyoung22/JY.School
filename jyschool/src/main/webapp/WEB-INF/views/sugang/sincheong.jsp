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
	max-width: 1200px;
}
.table-vo{
	width: 500px;
	height: 190px;
	float: right;
	margin-right: 30px;
}
.table-content{
	width: 1070px;
	height: 150px;
	padding: 0px;
	margin-left: 20px;
	margin-top: 330px;
}
.table-list th{ background: #f8f8f8;}
.table-list td {text-align: center;}
.table-list .left { text-align: left; padding-left: 5px; }

.table-list .num { width: 60px;}
.table-list .name { width: 100px;}
.table-list .date { width: 100px; }
.table-list .content{width: 100px;}
.box{margin: 30px; left: 200px; top: 250px;}
.img{width: 500px; max-height: 300px; margin-left: 15px; object-fit: cover;}

}
</style>
<script type="text/javascript">

</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</header>
	
<main>
	<div class="container body-container">
	    <div class="body-title">
			<h2><i class="fas fa-chalkboard-teacher"></i>${dto.className}</h2>
	    </div>
	    
	    <div class="body-main mx-auto">
			<table class="table box">
				<tr>
	    			 <td class="img box" style="width: 500px; height: 500px; position: absolute; margin-left: 200px;">
	    			 	<c:choose>
	    			 		<c:when test="${dto.imageFilename1 != null}">
                				<img style="width: 500px; max-height: 300px; margin-left: 15px;" src="${pageContext.request.contextPath}/uploads/lecturephoto/${dto.imageFilename1}">
               				</c:when>
               				<c:when test="${dto.imageFilename1 == null}"><td>${text}</td></c:when>
               			</c:choose>
               		</td>
               		<td align="left">&nbsp;</td>
            	</tr>
         </table>

			
			<table class="table table-border table-list table-vo" style="border-top: 2px solid gray;">
					<tr>
						<th class="subject">강의제목</th>
						<td>${dto.className}</td>
					</tr>
					<tr>
						<th class="name">강사이름</th>
						<td>${dto.username}</td>
					</tr>
					<tr>
						<th class="rank">난이도</th>
						<td>${dto.classDegree}</td>
					</tr>
					<tr>
						<th class="date">등록일</th>
						<td>${dto.c_reg_date}</td>
					</tr>
					<tr>
						<th class="price">가격</th>
						<td>${dto.price}</td>
						<input type="hidden" name="classNum" value="${dto.classNum}">
						<input type="hidden" name="classNum2" value="${dto2.classNum2}">
					</tr>
				
			</table>
			
			<table class="table table-border table-list table-content">
				<tr>
					<th class="content" style="border-top: 2px solid gray;"> 상세 설명 </th>
					<th style="border-top: 2px solid gray; background: white;">${dto.classComment}</th>
				</tr>
				<tr>
					<c:choose>
						<c:when test="${dto.imageFilename2 != null}">
							<td colspan="2" style="text-align: center;">
								<img src="<c:url value='/uploads/lecturephoto/${dto.imageFilename2}'/>">
							</td>
						</c:when>
						<c:when test="${dto.imageFilename2 == null}"><td colspan="2" style="text-align: center;">${text2}</td></c:when>
					</c:choose>

				</tr>
			</table>
			
			<table class="table">
				<tr>
					<td width="100">
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/sugang/list.do';" title="이전으로">강좌목록 <i class="fa-solid fa-arrow-rotate-right"></i></button>
					</td>
					<td width="100">
						<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/beforeqna/list.do?classNum2=${dto.classNum}';" title="QNA">QNA</button>
					</td>
						<td width="100" style="float: right; margin-right: -85px;">
								<c:if test="${sessionScope.member.userId==dto.userId}">
									<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/sugang/update.do?classNum=${dto.classNum}&page=${page}';" title="수정">수정하기</button>
									<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/sugang/delete.do?classNum=${dto.classNum}&page=${page}';" title="삭제">삭제하기</button>
								</c:if>
								
								<c:if test="${info.userId != name}">
									<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/sugang/sincheong.do?classNum=${dto.classNum}&page=${page}';" title="신청">신청하기</button>
								</c:if>
						</td>
					<td align="right" width="100">
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