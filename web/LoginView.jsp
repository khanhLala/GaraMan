<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng nhập</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .header {
            position: absolute;
            top: 20px;
            left: 20px;
            font-size: 24px;
            font-weight: bold;
            color: #1877f2;
        }
        .login-container {
            background-color: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1), 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .login-container h1 {
            font-size: 28px;
            margin-bottom: 1.5rem;
            color: #333;
        }
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 1rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box; /* Important */
        }
        .login-container input[type="submit"] {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 6px;
            background-color: #1877f2;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }
        .login-container input[type="submit"]:hover {
            background-color: #166fe5;
        }
    </style>
</head>
<body>
    <div class="header">
        GARAMAN
    </div>

    <div class="login-container">
        <h1>ĐĂNG NHẬP</h1>
        <form action="login" method="post">
            <input type="text" name="username" placeholder="Tài khoản" required>
            <input type="password" name="password" placeholder="Mật khẩu" required>
            <input type="submit" value="Đăng nhập">
        </form>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <p style="color: red; margin-top: 15px;"><%= error %></p>
        <%
            }
        %>
    </div>
</body>
</html>
