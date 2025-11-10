<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%-- BƯỚC 1: Import các lớp Java cần thiết --%>
<%@page import="java.util.List"%>
<%@page import="model.ItemStatistic"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>

<%
    List<? extends ItemStatistic> statList = (List<? extends ItemStatistic>) request.getAttribute("statList");
    if (statList == null) {
        statList = new ArrayList<>();
    }

    Double totalRev = (Double) request.getAttribute("total");
    if (totalRev == null) {
        totalRev = 0.0;
    }

    String selectedType = (String) request.getAttribute("selectedType");
    String selectedStart = (String) request.getAttribute("selectedStart");
    String selectedEnd = (String) request.getAttribute("selectedEnd");

    if (selectedType == null) {
        selectedType = "service"; 
    }
    if (selectedStart == null) {
        selectedStart = "";
    }
    if (selectedEnd == null) {
        selectedEnd = "";
    }

    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html>
    <head>
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
                padding-top: 70px; 
                display: flex;
                flex-direction: column;
            }
            .sidebar a {
                padding: 18px 25px;
                text-decoration: none;
                font-size: 17px;
                color: #333;
                display: block;
                border-left: 3px solid #1877f2; 
            }
            .sidebar a:hover {
                background-color: #f0f2f5;
            }
            .sidebar .logout-link {
                margin-top: auto; /* Đẩy nút xuống cuối */
                border-top: 1px solid #eee; /* Thêm đường kẻ phân cách */
            }
            .main-content {
                flex-grow: 1;
                padding: 20px;
                padding-top: 70px; /* Reduced padding to move content up */
                overflow-y: auto; /* Add internal scrollbar if content overflows */
            }
            .main-content h1 {
                margin-top: 0; /* Remove default top margin of h1 */
            }
            .filter-form {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                display: flex;
                gap: 20px;
                align-items: center;
                margin-bottom: 20px;
            }
            .filter-form label {
                font-weight: bold;
            }
            .filter-form select, .filter-form input[type='date'] {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .filter-form button {
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                background-color: #1877f2;
                color: white;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
            }
            .results-table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .results-table th, .results-table td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }
            /* Căn giữa tiêu đề các cột */
            .results-table thead th {
                background-color: #f0f2f5;
                text-align: center;
            }
            /* Căn chỉnh nội dung từng cột */
            .results-table tbody td:nth-child(1) {
                text-align: center;
            } /* STT */
            .results-table tbody td:nth-child(2) {
                text-align: left;
            }   /* Tên dịch vụ/phụ tùng */
            .results-table tbody td:nth-child(3) {
                text-align: right;
            }  /* Số lượng */
            .results-table tbody td:nth-child(4) {
                text-align: right;
            }  /* Thành tiền */
            .results-table tfoot {
                font-weight: bold;
            }
            .results-table tfoot td {
                text-align: right;
            }
            /* Styling for links within the table */
            .results-table a, .results-table a:visited {
                text-decoration: none;
                color: inherit; /* Kế thừa màu từ văn bản thường */
                font-weight: 500;
            }
            .results-table a:hover {
                text-decoration: none; /* Bỏ gạch chân khi di chuột */
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xem Thống Kê</title>
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
                <h1>Thống kê dịch vụ và phụ tùng</h1>

                <form class="filter-form" action="revenueStat" method="get">

                    <label for="stat-type">Loại thống kê:</label>
                    <select id="stat-type" name="type">
                        <option value="service" <% if (selectedType.equals("service")) {
                                out.print("selected");
                            } %> >
                            Dịch vụ
                        </option>
                        <option value="product" <% if (selectedType.equals("product"))
                                out.print("selected");%> >
                            Phụ tùng
                        </option>
                    </select>

                    <label for="start-date">Từ ngày:</label>
                    <input type="date" id="start-date" name="start" value="<%= selectedStart%>">

                    <label for="end-date">Đến ngày:</label>
                    <input type="date" id="end-date" name="end" value="<%= selectedEnd%>">

                    <button type="submit">Xem thống kê</button>

                </form>

                <table class="results-table">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên dịch vụ / phụ tùng</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (statList.isEmpty()) { %>
                        <tr>
                            <td colspan="4" style="text-align: center;">Không có dữ liệu cho lựa chọn này.</td>
                        </tr>
                        <% } else { %>
                        <%
                            int stt = 1;
                            for (ItemStatistic item : statList) {
                        %>
                        <tr>
                            <td><%= stt++%></td>
                            <td>
                                <a href="revenueDetailStat?itemId=<%= item.getItemId()%>">
                                    <%= item.getItemName()%>
                                </a>
                            </td>
                            <td><%= item.getSoldCount()%></td>
                            <td><%= currencyFormatter.format(item.getTotal())%></td>
                        </tr>
                        <%
                                    }
                                } 
%>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3">Tổng cộng</td>
                            <td><%= currencyFormatter.format(totalRev)%></td>
                        </tr>
                    </tfoot>
                </table>
            </main>
        </div>
    </body>
</html>