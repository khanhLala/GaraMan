package servlet;

import dao.CustomerDAO;
import dao.ManagerDAO;
import dao.MemberDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Customer;
import model.Manager;
import model.Member;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Member loginMember = new Member(username, password);

        MemberDAO memberDAO = new MemberDAO();
        Member member = memberDAO.login(loginMember);

        if (member == null) {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("LoginView.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            CustomerDAO cDao = new CustomerDAO();
            Customer customer = cDao.getById(member.getId());
            ManagerDAO mnDao = new ManagerDAO();
            Manager manager = mnDao.getById(member.getId());
            if (manager != null) {
                session.setAttribute("account", manager);
                response.sendRedirect("ManagerView.jsp");
            } else if (customer != null) {
                session.setAttribute("account", customer);
                response.sendRedirect("CustomerView.jsp");
            } else {
                request.setAttribute("error", "Chưa có chức năng cho người dùng này!");
                request.getRequestDispatcher("LoginView.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("account") != null) {
            Object account = session.getAttribute("account");
            if (account instanceof Manager) {
                response.sendRedirect("ManagerView.jsp");
            } else if (account instanceof Customer) {
                response.sendRedirect("CustomerView.jsp");
            } else {
                response.sendRedirect("LoginView.jsp");
            }
        } else {
            request.getRequestDispatcher("LoginView.jsp").forward(request, response);
        }
    }
}