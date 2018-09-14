<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>hello.jsp</h2>

	<%
		// 1. 환경변수
		String driver = "com.mysql.jdbc.Driver";
		/* String url="jdbc:oracle:thin:@192.168.0.206:1521:orcl"; */
		String url = "jdbc:mysql://192.168.0.206:3306/testdb";
		String user = "scott";
		String password = "tiger";
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		StringBuffer sb = new StringBuffer();
		Connection conn = null;

		// 2. 드라이버 로딩
		try {
			Class.forName(driver);
			// 3. Connection
			try {
				conn = DriverManager.getConnection(url, user, password);
			} catch (SQLException e) {
				System.out.println("드라이버 실패");
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			System.out.println("접속 실패");
			e.printStackTrace();
		}

		// 4. sql문
		sb.append("SELECT * FROM dept");
		// 5. 문장 객체
		try {
			pstmt = conn.prepareStatement(sb.toString());
			// 6. 실행
			rs = pstmt.executeQuery();
			// 7. 레코드별 로직 처리
			while (rs.next()) {
				int deptno = rs.getInt("deptno");
				String dname = rs.getString("dname");
				String loc = rs.getString("loc");
				out.println(deptno + " : " + dname + " : " + loc + "<br />");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	%>

</body>
</html>