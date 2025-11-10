<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="model.Manager"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Quản lý</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f9f9f9;
        }
        .header {
            position: absolute;
            top: 10px; /* Reduced from 20px */
            left: 25px;
            font-size: 24px;
            font-weight: bold;
            color: #1877f2;
        }
        .header a, .header a:visited {
            color: inherit;
            text-decoration: none;
        }
        .container {
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 240px;
            background-color: #fff;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            padding-top: 40px; /* Reduced from 80px */
            display: flex;
            flex-direction: column;
        }
        .sidebar a {
            padding: 18px 25px;
            text-decoration: none;
            font-size: 17px;
            color: #333;
            display: block;
            border-left: 3px solid transparent;
        }
        .sidebar a:hover {
            background-color: #f0f2f5;
            border-left: 3px solid #1877f2;
        }
        .sidebar .logout-link {
            margin-top: auto; /* Đẩy nút xuống cuối */
            border-top: 1px solid #eee; /* Thêm đường kẻ phân cách */
        }
        .main-content {
            flex-grow: 1;
            padding: 20px;
            padding-top: 40px; /* Reduced from 80px */
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="login">GARAMAN</a>
    </div>

    <div class="container">
        <nav class="sidebar">
            <a href="revenueStat">Xem thống kê dịch vụ và phụ tùng</a>
            <a href="logout" class="logout-link">Đăng xuất</a>
        </nav>

        <main class="main-content">
            <%
                Manager manager = (Manager) session.getAttribute("account");
                String managerName = (manager != null) ? manager.getName() : "Quản lý";
            %>
            <h1>Xin chào <%= managerName %>,</h1>
            <p>Đây là trang chủ dành cho nhân viên quản lý của hệ thống Garaman.</p>
        </main>
    </div>
</body>
</html>
