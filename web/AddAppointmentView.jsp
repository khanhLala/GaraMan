<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đặt lịch hẹn</title>
    <style>
        /* General body styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f9f9f9;
        }
        /* Header/Logo styling */
        .header {
            position: absolute;
            top: 20px;
            left: 25px;
            font-size: 24px;
            font-weight: bold;
            color: #1877f2;
        }
        .header a, .header a:visited {
            color: inherit;
            text-decoration: none;
        }
        /* Main container for the layout using Flexbox */
        .container {
            display: flex;
            height: 100vh; /* Full viewport height */
        }
        /* Sidebar navigation panel styling */
        .sidebar {
            width: 240px;
            background-color: #fff;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            padding-top: 80px; /* Make space for the header/logo */
            display: flex;
            flex-direction: column;
        }
        /* Styling for links within the sidebar */
        .sidebar a {
            padding: 18px 25px;
            text-decoration: none;
            font-size: 17px;
            color: #333;
            display: block;
            border-left: 3px solid transparent; /* For hover effect */
        }
        /* Hover effect for sidebar links */
        .sidebar a:hover, .sidebar a.active {
            background-color: #f0f2f5;
            border-left: 3px solid #1877f2;
        }
        .sidebar .logout-link {
            margin-top: auto; /* Đẩy nút xuống cuối */
            border-top: 1px solid #eee; /* Thêm đường kẻ phân cách */
        }
        /* Main content area styling */
        .main-content {
            flex-grow: 1; /* Takes up the remaining space */
            padding: 20px;
            padding-top: 80px; /* Align content with sidebar content start */
        }
        .main-content h1 {
            color: #333;
        }
        .instruction-text {
            color: #555;
            margin-bottom: 20px;
        }
        /* Styling for the appointment table */
        .appointment-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .appointment-table th, .appointment-table td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: center; /* Căn giữa toàn bộ nội dung bảng */
        }
        .appointment-table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        .appointment-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .appointment-table tr:hover {
            background-color: #f1f1f1;
        }
        .appointment-table input[type="radio"] {
            cursor: pointer;
        }
        /* Styling for the confirmation button */
        .confirm-btn {
            background-color: #1877f2;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            margin-top: 20px;
            float: right;
        }
        .confirm-btn:hover {
            background-color: #166fe5;
        }
    </style>
</head>
<%@page import="java.util.List, model.ScheduleTime, java.time.format.DateTimeFormatter"%>
<body>
    <!-- Header section for the brand name/logo -->
    <div class="header">
        <a href="login">GARAMAN</a>
    </div>

    <!-- Main layout container -->
    <div class="container">
        <!-- Sidebar navigation -->
        <nav class="sidebar">
            <a href="addAppointment" class="active">Tạo lịch hẹn</a>
            <a href="logout" class="logout-link">Đăng xuất</a>
            <!-- Các mục menu khác sẽ được thêm vào đây -->
        </nav>

        <main class="main-content">
            <h1>ĐẶT LỊCH HẸN</h1>
            <p class="instruction-text">Chọn một trong các lịch hẹn trống dưới đây:</p>
            <%
                List<ScheduleTime> freeTimes = (List<ScheduleTime>) request.getAttribute("freeTimes");
                DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
                DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            %>
            <form action="addAppointment" method="post">
                <table class="appointment-table">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Ngày hẹn</th>
                            <th>Giờ hẹn</th>
                            <th>Chọn</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (freeTimes != null && !freeTimes.isEmpty()) {
                                int stt = 1;
                                for (ScheduleTime time : freeTimes) {
                        %>
                                    <tr>
                                        <td><%= stt++ %></td>
                                        <td><%= time.getDate().format(dateFormatter) %></td>
                                        <td><%= time.getStart().format(timeFormatter) %> - <%= time.getEnd().format(timeFormatter) %></td>
                                        <td><input type="radio" name="appointmentSlot" value="<%= time.getId()%>" required></td>
                                    </tr>
                        <%
                                }
                            } else {
                        %>
                                <tr>
                                    <td colspan="4" style="text-align: center;">Hiện không có lịch hẹn trống. Vui lòng quay lại sau.</td>
                                </tr>
                        <% } %>
                    </tbody>
                </table>
                <button type="submit" class="confirm-btn">XÁC NHẬN</button>
            </form>
        </main>
    </div>
</body>
</html>