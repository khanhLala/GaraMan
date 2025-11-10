<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.NumberFormat, java.time.format.DateTimeFormatter, java.util.Locale, java.util.ArrayList, java.util.List, model.*"%>

<%
    Invoice invoice = (Invoice) request.getAttribute("invoice");
    Double totalAmount = (Double) request.getAttribute("totalAmount");
    String errorMessage = (String) request.getAttribute("errorMessage");

    Customer customer = null;
    List<ServiceInvoiceDetail> serviceDetails = new ArrayList<>();
    List<ProductInvoiceDetail> productDetails = new ArrayList<>();

    if (invoice != null) {
        customer = invoice.getCustomer();
        serviceDetails = invoice.getServiceDetail();
        productDetails = invoice.getProductDetail();
    }
    
    if (serviceDetails == null) {
        serviceDetails = new ArrayList<>();
    }
    if (productDetails == null) {
        productDetails = new ArrayList<>();
    }
    if (totalAmount == null) {
        totalAmount = 0.0;
    }

    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết Hóa đơn</title>
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
                padding-top: 60px;
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
                margin-top: auto;
                border-top: 1px solid #eee;
            }
            .main-content {
                flex-grow: 1;
                padding: 20px;
                padding-top: 20px;
                overflow-y: auto;
            }
            .main-content h1 {
                margin-top: 0;
                font-size: 28px;
                color: #333;
            }

            .invoice-box {
                background: #fff;
                padding: 30px;
                border: 1px solid #eee;
                box-shadow: 0 0 10px rgba(0, 0, 0, .15);
                font-size: 16px;
                line-height: 24px;
                color: #555;
            }
            .invoice-header {
                display: flex;
                justify-content: space-between;
                padding-bottom: 20px;
                border-bottom: 1px solid #eee;
                margin-bottom: 20px;
            }
            .invoice-details {
                text-align: right;
            }
            .customer-info {
                text-align: left;
            }
            .items-table {
                width: 100%;
                border-collapse: collapse;
                text-align: left;
            }
            .items-table th {
                background: #eee;
                border-bottom: 1px solid #ddd;
                font-weight: bold;
                padding: 8px;
            }
            .items-table td {
                padding: 8px;
                border-bottom: 1px solid #eee;
            }
            .items-table .heading th {
                text-align: center;
            }
            .items-table .item td {
                text-align: left;
            }
            .items-table .item td:nth-child(1) { text-align: center; }
            .items-table .item td:nth-child(3),
            .items-table .item td:nth-child(4),
            .items-table .item td:nth-child(5) { text-align: right; }

            .items-table .sub-heading td {
                background-color: #f9f9f9;
                font-weight: bold;
                color: #333;
                text-align: left;
            }

            .totals {
                margin-top: 20px;
                text-align: right;
            }
            .totals .total-row {
                font-size: 16px;
                line-height: 28px;
            }
            .totals .total-row.grand-total {
                font-weight: bold;
                font-size: 18px;
                color: #333;
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
                <h1>CHI TIẾT HÓA ĐƠN</h1>

                <% if (errorMessage != null) { %>
                    <div style="color: red; padding: 20px; background: #ffeeee; border: 1px solid red; border-radius: 8px;">
                        <%= errorMessage %>
                    </div>
                <% } else if (invoice != null && customer != null) { %>
                
                    <div class="invoice-box">
                        <div class="invoice-header">
                            <div class="customer-info">
                                <b>ID khách hàng:</b> <%= customer.getId() %><br>
                                <b>Tên khách hàng:</b> <%= customer.getName() %><br>
                                <b>SĐT:</b> <%= customer.getPhone() %><br>
                                <b>Email:</b> <%= customer.getEmail() %><br>
                                <b>Địa chỉ:</b> <%= customer.getAddress() %>
                            </div>
                            <div class="invoice-details">
                                <b>Số hóa đơn:</b>&nbsp;<%= invoice.getId() %><br>
                                <b>Ngày tạo:</b>&nbsp;<%= invoice.getCreateAt().toLocalDate().format(dateFormatter) %><br>
                            </div>
                        </div>

                        <table class="items-table">
                            <tr class="heading">
                                <th>STT</th>
                                <th>Mô tả</th>
                                <th>Số lượng</th>
                                <th>Đơn giá</th>
                                <th>Thành tiền</th>
                            </tr>
                            
                            <% if (!serviceDetails.isEmpty()) { %>
                                <tr class="sub-heading">
                                    <td colspan="5">Dịch vụ</td>
                                </tr>
                                <%
                                    int stt = 1;
                                    for (ServiceInvoiceDetail detail : serviceDetails) {
                                        double lineTotal = (double) detail.getQuantity() * detail.getSellprice();
                                %>
                                <tr class="item">
                                    <td><%= stt++ %></td>
                                    <td><%= detail.getService().getName() %></td>
                                    <td><%= detail.getQuantity() %></td>
                                    <td><%= currencyFormatter.format(detail.getSellprice()) %></td>
                                    <td><%= currencyFormatter.format(lineTotal) %></td>
                                </tr>
                                <% } %>
                            <% } %>
                            
                            <% if (!productDetails.isEmpty()) { %>
                                <tr class="sub-heading">
                                    <td colspan="5">Phụ tùng</td>
                                </tr>
                                <%
                                    int stt;
                                    if(serviceDetails.isEmpty()){
                                        stt = 1;
                                    } else {
                                        stt = serviceDetails.size() + 1;
                                    }
                                
                                    for (ProductInvoiceDetail detail : productDetails) {
                                        double lineTotal = (double) detail.getQuantity() * detail.getSellprice();
                                %>
                                <tr class="item">
                                    <td><%= stt++ %></td>
                                    <td><%= detail.getProduct().getName() %></td>
                                    <td><%= detail.getQuantity() %></td>
                                    <td><%= currencyFormatter.format(detail.getSellprice()) %></td>
                                    <td><%= currencyFormatter.format(lineTotal) %></td>
                                </tr>
                                <% } %>
                            <% } %>
                        </table>
                        
                        <div class="totals">
                            <div class="total-row grand-total">Tổng cộng: <%= currencyFormatter.format(totalAmount) %></div>
                        </div>
                    </div>
                    
                <% } else if (errorMessage == null) { %>
                     <div style="color: #555; padding: 20px; background: #f0f2f5; border: 1px solid #ddd; border-radius: 8px;">
                        Không có dữ liệu hóa đơn.
                    </div>
                <% } %>
            </main>
        </div>
    </body>
</html>