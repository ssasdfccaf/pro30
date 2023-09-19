<!-- 동적으로 폼 태그를 구성 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%-- 다중 이미지의 상세 보기 시에 사용 
<c:set var="article"  value="${articleMap.article}"  />
<c:set var="imageFileList"  value="${articleMap.imageFileList}"  />

 --%>
 
<%
request.setCharacterEncoding("UTF-8");
%>

<head>

<meta charset="UTF-8">

<title>글보기</title>

<style>
#tr_file_upload {
	display: none;
}

#tr_btn_modify {
	display: none;
}
</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
   
   /* 목록 보기 함수 */
     function backToList(obj){
	    obj.action="${contextPath}/board/listArticles.do";
	    obj.submit();
     }
     
   /* 해당 아이디 요소(속성)를 한꺼번에 지정, 변경하는 함수 */ 
	 function fn_enable(obj){
		 document.getElementById("i_title").disabled=false; //true
		 document.getElementById("i_content").disabled=false;
		 document.getElementById("i_imageFileName").disabled=false;
		
		 document.getElementById("tr_btn_modify").style.display="block";
		 document.getElementById("tr_file_upload").style.display="block";
		 document.getElementById("tr_btn").style.display="none";
	 }
	 
	 /* 수정폼으로 이동하는 함수 */
	 function fn_modify_article(obj){
		 obj.action="${contextPath}/board/modArticle.do";
		 obj.submit();
	 }
	 
	 /* 삭제 시에 사용하는 함수 */
	 function fn_remove_article(url,articleNO){
		 // 1) 삭제할 게시글 번호 2) 삭제를 처리하는 서버의 맵핑 주소 전달
		
		 /* 작성 완료된 기존 폼 형식과 달리 inner HTML 동적으로 개발작, 폼 요소, 속성 임의로 만들어 html 문서에 주입하는 형식 */	
		 var form = document.createElement("form"); // 동적으로 form 태그 생성
		
		 /* form 요소에 속성으로 전달 방식 post, action 
		 	: 전송 폼에서 submit 클릭하면 서버로 데이터를 모두 전달하는 위치 */
		 form.setAttribute("method", "get");
		 form.setAttribute("action", url);
		
		 // 로직 = 동적으로 input 태그 생성 + 속성 추가
	     var articleNOInput = document.createElement("input");
	     articleNOInput.setAttribute("type","hidden"); // (url, articleNO)
	     articleNOInput.setAttribute("name","articleNO");
	     articleNOInput.setAttribute("value", articleNO);
		 
	     /* form 태그 및 하위 요소 추가한 부분 적용 */
	     form.appendChild(articleNOInput); // input 속성 추가
	     document.body.appendChild(form); // form 태그를 html body 태그에 추가
	     form.submit();
	 
	 }
	 
	 // 답장하는 용도 : 동적으로 구성
	 function fn_reply_form(url, parentNO){
		 var form = document.createElement("form");
		 form.setAttribute("method", "post");
		 form.setAttribute("action", url);
	     var parentNOInput = document.createElement("input");
	     parentNOInput.setAttribute("type","hidden");
	     parentNOInput.setAttribute("name","parentNO");
	     parentNOInput.setAttribute("value", parentNO);
		 
	     form.appendChild(parentNOInput);
	     document.body.appendChild(form);
		 form.submit();
	 }
	 
	 function readURL(input) {
		 // 이미지의 뷰에 출력하기 위한 함수
	     if (input.files && input.files[0]) {
	    		// 파일 이름 존재 -> FileReader
	         var reader = new FileReader();
	         // 읽은 이미지 파일 출력
	         reader.onload = function (e) {
	        	 // #preview div 태그 아이디로 사용
	             $('#preview').attr('src', e.target.result); // 속성 src < img src = 에 값으로 전달
	         }
	         reader.readAsDataURL(input.files[0]);
	     }
	 }  
 </script>
</head>

<body>
	<form name="frmArticle" method="post" action="${contextPath}"
	
		enctype="multipart/form-data">
		
		<table border=0 align="center">
			
			<tr>
				<td width=150 align="center" bgcolor=#FF9933>글번호</td>
				<td><input type="text" value="${article.articleNO }" disabled />
					<input type="hidden" name="articleNO" value="${article.articleNO}" />
				</td>
			</tr>
			
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">작성자 아이디</td>
				<td><input type=text value="${article.id }" name="writer"
					disabled /></td>
			</tr>
			
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">제목</td>
				<td><input type=text value="${article.title }" name="title"
					id="i_title" disabled /></td>
			</tr>
			
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">내용</td>
				<td><textarea rows="20" cols="60" name="content" id="i_content"
						disabled />${article.content }</textarea></td>
						
			</tr>
			<%-- 
 <c:if test="${not empty imageFileList && imageFileList!='null' }">
	  <c:forEach var="item" items="${imageFileList}" varStatus="status" >
		    <tr>
			    <td width="150" align="center" bgcolor="#FF9933"  rowspan="2">
			      이미지${status.count }
			   </td>
			   <td>
			     <input  type= "hidden"   name="originalFileName" value="${item.imageFileName }" />
			    <img src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${item.imageFileName}" id="preview"  /><br>
			   </td>   
			  </tr>  
			  <tr>
			    <td>
			       <input  type="file"  name="imageFileName " id="i_imageFileName"   disabled   onchange="readURL(this);"   />
			    </td>
			 </tr>
		</c:forEach>
 </c:if>
 	 --%>

			<c:choose>
			
				<c:when
					test="${not empty article.imageFileName && article.imageFileName!='null' }">
					
					<tr>
						<td width="150" align="center" bgcolor="#FF9933" rowspan="2">
							이미지</td>
						<td>
						<input type="hidden" name="originalFileName" value="${article.imageFileName }" /> 
							<img src="${contextPath}/download.do?articleNO=${article.articleNO}&imageFileName=${article.imageFileName}" id="preview" /><br></td>
					</tr>
					
					<tr>
						<td></td>
						<td><input type="file" name="imageFileName "
							id="i_imageFileName" disabled onchange="readURL(this);" /></td>
					</tr>
					
				</c:when>
				
				<c:otherwise>
					
					<tr id="tr_file_upload">
						<td width="150" align="center" bgcolor="#FF9933" rowspan="2">
							이미지</td>
						<td><input type="hidden" name="originalFileName"
							value="${article.imageFileName }" /></td>
					</tr>
					
					<tr>
						<td></td>
						<td><img id="preview" /><br> <input type="file"
							name="imageFileName " id="i_imageFileName" disabled
							onchange="readURL(this);" /></td>
					</tr>
					
				</c:otherwise>
			</c:choose>
			
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">등록일자</td>
				
				<td>
				<input type=text value="<fmt:formatDate value="${article.writeDate}" />" disabled />
				</td>
			</tr>
			
			<tr id="tr_btn_modify" align="center">
				<td colspan="2"><input type=button value="수정반영하기"
					onClick="fn_modify_article(frmArticle)"> <input
					type=button value="취소" onClick="backToList(frmArticle)"></td>
			</tr>

			<tr id="tr_btn">
			
				<td colspan="2" align="center">
				
				<c:if test="${member.id == article.id }">
						
						<input type=button value="수정하기" onClick="fn_enable(this.form)">
						<input type=button value="삭제하기" onClick="fn_remove_article('${contextPath}/board/removeArticle.do', ${article.articleNO})">
					
					</c:if>
					<input type=button value="리스트로 돌아가기" onClick="backToList(this.form)"> 
					<input type=button value="답글쓰기" onClick="fn_reply_form('${contextPath}/board/replyForm.do', ${article.articleNO})">
				</td>
			</tr>
		</table>
	</form>
</body>

</html>