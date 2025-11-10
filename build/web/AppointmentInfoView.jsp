<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("LoginView.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Điền thông tin</title>
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
            padding-top: 50px; /* Giảm nữa để đẩy lên cao hơn */
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
            padding-top: 20px; /* Giảm nữa để đẩy lên cao hơn */
            overflow-y: auto; /* Add scrollbar internally if content overflows */
            display: flex;
            flex-direction: column;
        }
        .main-content h1 {
            color: #333;
            margin-bottom: 20px;
        }
        .selected-time-info {
            background-color: #e7f3ff;
            border-left: 5px solid #1877f2;
            padding: 15px;
            margin-bottom: 25px;
            font-size: 16px;
            color: #333;
        }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-weight: bold;
            text-align: center;
        }
        .message.success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .message.failure { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        /* Styling for form elements */
        .form-row {
            display: flex;
            gap: 20px; /* Khoảng cách giữa hai ô nhập */
        }
        .form-row .form-group {
            flex: 1; /* Mỗi nhóm chiếm không gian bằng nhau */
        }
        .form-group {
            margin-bottom: 12px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="tel"],
        .form-group textarea {
            width: 100%; /* Full width */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box; /* Đảm bảo padding không làm tăng kích thước */
        }
        .form-group textarea {
            resize: vertical; /* Allow vertical resizing */
            min-height: 80px;
        }
        /* Styling for the submit button */
        .submit-btn {
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
        .submit-btn:hover {
            background-color: #166fe5;
        }
    </style>
</head>
<body>
    <!-- Header section for the brand name/logo -->
    <div class="header">
        <a href="login">GARAMAN</a>
    </div>
    <%@page import="model.ScheduleTime, java.time.format.DateTimeFormatter"%>

    <div class="container">
        <nav class="sidebar">
            <a href="addAppointment" class="active">Tạo lịch hẹn</a>
            <a href="logout" class="logout-link">Đăng xuất</a>
        </nav>

        <main class="main-content">
            <h1>ĐIỀN THÔNG TIN</h1>
            <%
                String successMsg = (String) request.getAttribute("addSuccess");
                String failureMsg = (String) request.getAttribute("addFailure");
                if (successMsg != null) {
            %>
                <div class="message success"><%= successMsg %></div>
            <% } else if (failureMsg != null) { %>
                <div class="message failure"><%= failureMsg %></div>
            <% 
                }
            %>
            <%
                ScheduleTime selectedTime = (ScheduleTime) request.getAttribute("selectedTime");
                String displayTime = "Chưa chọn";
                if (selectedTime != null) {
                    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
                    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    displayTime = "<b>" + selectedTime.getStart().format(timeFormatter) + " - " + selectedTime.getEnd().format(timeFormatter) + "</b> ngày <b>" + selectedTime.getDate().format(dateFormatter) + "</b>";
                }
            %>
            <div class="selected-time-info">
                <strong>Lịch hẹn đã chọn:</strong> <%= displayTime %>
            </div>
            <form action="appointmentInfo" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName">Họ tên:</label>
                        <input type="text" id="fullName" name="fullname" required>
                    </div>

                    <div class="form-group">
                        <label for="phoneNumber">Số điện thoại:</label>
                        <input type="tel" id="phoneNumber" name="phoneNumber" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div class="form-group">
                    <label for="address">Địa chỉ:</label>
                    <input type="text" id="address" name="address">
                </div>

                <div class="form-group">
                    <label for="problemDescription">Mô tả vấn đề:</label>
                    <textarea id="problemDescription" name="description" rows="5"></textarea>
                </div>

                <button type="submit" class="submit-btn">ĐẶT LỊCH HẸN</button>
            </form>
        </main>
    </div>
</body>
</html>