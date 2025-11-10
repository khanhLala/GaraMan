<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="model.ItemStatistic"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
    List<? extends ItemStatistic> detailList = (List<? extends ItemStatistic>) request.getAttribute("detailList");
    if (detailList == null) {
        detailList = new ArrayList<>();
    }

    String itemName = (String) request.getAttribute("itemName");
    if (itemName == null) {
        itemName = "Không xác định";
    }

    Double detailTotal = (Double) request.getAttribute("detailTotal");
    if (detailTotal == null) {
        detailTotal = 0.0;
    }

    String selectedType = (String) session.getAttribute("selectedType");
    String selectedStart = (String) session.getAttribute("selectedStart");
    String selectedEnd = (String) session.getAttribute("selectedEnd");
    
    String start = "";
    String end = "";
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    if (selectedStart != null && !selectedStart.isEmpty()) {
        LocalDate startDate = LocalDate.parse(selectedStart); // Parse chuỗi "yyyy-MM-dd"
        start = dateFormatter.format(startDate); // Format thành chuỗi "dd/MM/yyyy"
    }
    if (selectedEnd != null && !selectedEnd.isEmpty()) {
        LocalDate endDate = LocalDate.parse(selectedEnd);
        end = dateFormatter.format(endDate);
    }
    
    String type = "";
    if (selectedType.equals("product")) {
        type = "phụ tùng";
    } else if (selectedType.equals("service")) {
        type = "dịch vụ";
    }

    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thống kê chi tiết</title>
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
                border-left: 3px solid #1877f2; /* Highlight active link */
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
                padding-top: 70px;
                overflow-y: auto;
            }
            .main-content h1 {
                margin-top: 0;
                font-size: 24px;
            }
            .item-name-header {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 20px;
                color: #333;
            }
            .detail-table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .detail-table th, .detail-table td {
                border: 1px solid #ddd;
                padding: 12px;
            }
            .detail-table thead th {
                background-color: #f0f2f5;
                text-align: center;
            }
            .detail-table tbody td {
                text-align: left;
            }
            .detail-table tbody td:nth-child(1),
            .detail-table tbody td:nth-child(2) {
                text-align: center;
            }

            .detail-table tbody td:nth-child(5),
            .detail-table tbody td:nth-child(6),
            .detail-table tbody td:nth-child(7) {
                text-align: right;
            }

            .detail-table tfoot {
                font-weight: bold;
            }
            .detail-table tfoot td {
                text-align: right;
            }
            .detail-table a, .detail-table a:visited {
                text-decoration: none;
                color: inherit;
                font-weight: 500;
            }
            .detail-table a:hover {
                text-decoration: none;
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
                <h1>Xem thống kê chi tiết các lần sử dụng</h1>
                <div class="item-name-header">
                    Tên <%= type%> : <%= itemName%>
                </div>
                <div class="date-range-header">
                    (Từ ngày: <%= start %> đến ngày: <%= end %>)
                    <br> <br>
                </div>
                <table class="detail-table">
                    <thead>
                        <tr>
                            <th>Mã hóa đơn</th>
                            <th>Mã KH</th>
                            <th>Tên KH</th>
                            <th>Thời gian</th>
                            <th>Số lượng</th>
                            <th>Đơn giá</th>
                            <th>Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (detailList.isEmpty()) { %>
                        <tr>
                            <td colspan="7" style="text-align: center;">Không có dữ liệu chi tiết.</td>
                        </tr>
                        <% } else { %>
                        <% for (ItemStatistic item : detailList) {

                                double unitPrice = 0;
                                if (item.getSoldCount() != 0) {
                                    unitPrice = item.getTotal() / item.getSoldCount();
                                }
                        %>
                        <tr>
                            <td><a href="invoice?invoiceId=<%= item.getInvoiceId()%>"> <%= item.getInvoiceId()%></a></td>
                            <td><%= item.getCustomerId()%></td>
                            <td><%= item.getCustomerName()%></td>
                            <td><%= timeFormatter.format(item.getCreateAt())%></td>
                            <td><%= item.getSoldCount()%></td>
                            <td><%= currencyFormatter.format(unitPrice)%></td>
                            <td><%= currencyFormatter.format(item.getTotal())%></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="6">Tổng cộng</td>
                            <td><%= currencyFormatter.format(detailTotal)%></td>
                        </tr>
                    </tfoot>
                </table>
            </main>
        </div>
    </body>
</html>