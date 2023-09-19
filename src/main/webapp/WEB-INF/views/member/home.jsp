<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<h1>Hello world!</h1>

	<P>
		<%-- ${ } 기법으로 해당 변수 사용  --%>
		The time on the server is ${serverTime}.
		
	</P>
</body>
</html>
