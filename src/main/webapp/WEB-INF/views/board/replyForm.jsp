<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="passwordCheck2" value="${passwordCheck }" />

<%
request.setCharacterEncoding("UTF-8");
%>

<head>

<meta charset="UTF-8">

<script src="//code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">

var checkPwd = 0
   
/* $("#submitBtn").on("click", function(e){ */
	
	/* 기본 서밋 방지 */
	
	function checkSubmit() {
	if(checkPwd ==1){
		return = true;
		
//		document.getElementById('frmReply').submit();

//	} else if (checkPwd == 0) {
	} else {
		// e.preventDefault(); // 불일치
		alert("패스워드 확인 해주세요")
		checkPwd = 0
		document.getElementById('inputPassword').focus()
	}
	
	
}
	
}


/* 버튼 추가 : 비밀번호 확인 */
	function passwordConfirm(password){
		alert("password 전달 여부 확인 : " + password)
		alert("${member.pwd } 전달 여부 확인 : " + ${member.pwd })
//		alert("passwordCheck 전달 여부 확인 : " + password)
//		alert("passwordCheck jqeury 전달 여부 확인 : " + $("#inputPassword").val())
		if(password == ${member.pwd}){ 
			alert("password 일치합니다.")
							 // pwd - MemberVO 참고
			console.log("패스워드가 일치합니다.")
		}
		
	}
	
	function backToList(obj) {
		obj.action = "${contextPath}/board/listArticles.do";
		obj.submit();
	}

	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
</script>

<title>답글쓰기 페이지</title>

</head>

<body>

 <!-- 부모글 파악 위한 [답글폼] 주소 /parent~ -->
	<h1>답글쓰기</h1>
	
	<form name="frmReply" method="post" action="${contextPath}/board/addReply.do?parentNO=4" enctype="multipart/form-data">
		<table>
			<tr>
				<td align="right">작성자:&nbsp;</td>
				 <!-- 현재 세션에 로그인한 회원 정보에서 가져 온 member.id , readOnly 속성 : 로그인한 유저와 세션과의 정보 일치 여부에 따라 DB 전송 여부 정해짐 -->	
				<td><input type="text" size="20" maxlength="100" name="writer" value=${member.id  } readOnly></input></td>
			</tr>
			<tr>
				<td align="right">제목:&nbsp;</td>
				<td><input type="text" size="67" maxlength="500" name="title"></input></td>
			</tr>
			<tr>
				<td align="right" valign="top"><br>내용:&nbsp;</td>
				<td><textarea name="content" rows="10" cols="65" maxlength="4000"></textarea></td>
			</tr>
			<tr>
				<td align="right">비밀번호:&nbsp;</td>
				<td><input id = "inputPassword" type="password" size="10" maxlength="12" name="passwd"></input></td>
				<script>var passwordCheck = document.getElementById("inputPassword").value; </script>
				<!-- 	<script>var passwordCheck = ${#inputPassword}.val()</script> -->
				<td><input type=button value="비밀번호 확인" onClick="passwordConfirm(1234)" /></td>
				
			</tr>
			<tr>
				<td align="right">이미지파일 첨부:</td>
				<td><input type="file" name="imageFileName" onchange="readURL(this);" /></td>
				<td><img id="preview" src="#" width=200 height=200 /></td>
			</tr>
			<tr>
				<td align="right"></td>
		<!-- 		<td><input id="submitBtn" value="답글쓰기" onClick="checkSubmit()" />  -->
				<td><input id="submitBtn" value="답글쓰기" /> 
				<input type=button value="취소" onClick="backToList(this.form)" /></td>
			</tr>

		</table>

	</form>
</body>
</html>