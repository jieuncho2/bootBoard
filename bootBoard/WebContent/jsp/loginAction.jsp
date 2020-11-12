<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javax.naming.*" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userId"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 데이터 처리</title>
</head>
<body>
<%
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserId(), user.getUserPassword());
	userDAO.connClose();
	PrintWriter pw = response.getWriter();
	if(result==1){
		session.setAttribute("userId", user.getUserId());
		pw.println("<script>");
		pw.println("location.href='main.jsp'");
		pw.println("</script>");
	} else if(result==0){
		pw.println("<script>");
		pw.println("alert('비밀번호가 틀립니다.')");
		pw.println("history.back()");
		pw.println("</script>");
	}
	 else if(result==-1){
		pw.println("<script>");
		pw.println("alert('아이디가 존재하지 않습니다.')");
		pw.println("history.back()");
		pw.println("</script>");
	}
	 else if(result==-2){
		pw.println("<script>");
		pw.println("alert('데이터베이스 오류가 발생하였습니다.')");
		pw.println("history.back()");
		pw.println("</script>");
	}
%>
</body>
</html>