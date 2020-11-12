<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javax.naming.*" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="*"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 데이터 처리</title>
</head>
<body>
<%
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserId(), user.getUserPassword());
	userDAO.connClose();
	PrintWriter pw = response.getWriter();
	userDAO.connClose();
	if(result==-1){
		pw.println("alert('이미 존재하는 아이디입니다.')");
		pw.println("history.back()");
		pw.println("</script>");
	} else {
		session.setAttribute("userId", user.getUserId());
		pw.println("<script>");
		pw.println("location.href='main.jsp'");
		pw.println("</script>");
	}
%>
</body>
</html>