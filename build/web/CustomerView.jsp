<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Kiểm tra xem người dùng đã đăng nhập chưa.
    // Nếu không có thuộc tính "account" trong session, chuyển hướng về trang đăng nhập.
    if (session.getAttribute("account") == null) {
        response.sendRedirect("LoginView.jsp");
        return; // Dừng việc xử lý trang hiện tại
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@page import="model.Customer"%>
    <title>Trang người dùng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f9f9f9;
        }
        .header {
            position: absolute;
            top: 20px;
            left: 25px;
            font-size: 24px;
            font-weight: bold;
            color: #1877f2;
        }
        .header a, .header a:visited {
            color: inherit; /* Kế thừa màu từ .header */
            text-decoration: none; /* Bỏ gạch chân */
        }
        .container {
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 240px;
            background-color: #fff;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            padding-top: 80px; /* Make space for the logo */
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
            padding-top: 80px; /* Align content with sidebar */
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="login">GARAMAN</a>
    </div>

    <div class="container">
        <nav class="sidebar">
            <a href="addAppointment">Tạo lịch hẹn</a>
            <a href="logout" class="logout-link">Đăng xuất</a>
        </nav>

        <main class="main-content">
            <%
                Customer customer = (Customer) session.getAttribute("account");
                System.out.println(customer);
                String customerName = (customer != null) ? customer.getName() : "Tên khách hàng";
            %>
            <h1>Xin chào <%= customerName %>,</h1>
            <p>Đây là trang chủ dành cho khách hàng của hệ thống Garaman.</p>
        </main>
    </div>
</body>
</html>
