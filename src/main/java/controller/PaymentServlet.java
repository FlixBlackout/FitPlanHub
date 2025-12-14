package controller;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daoimpl.FitnessPlanDaoImpl;
import daoimpl.SubscriptionDaoImpl;
import pojo.FitnessPlan;
import pojo.Subscription;
import pojo.User;

/**
 * Servlet implementation class PaymentServlet
 */
@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int planId = Integer.parseInt(request.getParameter("planId"));
        double amount = Double.parseDouble(request.getParameter("amount"));

        FitnessPlanDaoImpl planDao = new FitnessPlanDaoImpl();
        FitnessPlan plan = planDao.searchFitnessPlan(planId);

        if (plan == null) {
            response.sendRedirect("userhome.jsp?msg=Invalid plan");
            return;
        }

        
        Subscription subscription = new Subscription();
        subscription.setUserId(user.getId());
        subscription.setPlanId(planId);
        subscription.setSubscriptionDate(new Timestamp(System.currentTimeMillis()).toString());

        long expiryMillis = System.currentTimeMillis()
                + plan.getDurationDays() * 24L * 60 * 60 * 1000;
        subscription.setExpiryDate(new Timestamp(expiryMillis).toString());

        subscription.setActive(true);
        subscription.setPaymentStatus("Completed");
        subscription.setAmountPaid(amount);

        SubscriptionDaoImpl dao = new SubscriptionDaoImpl();

        if (dao.addSubscription(subscription)) {
            request.setAttribute("msg", "Payment successful! Subscription activated.");
        } else {
            request.setAttribute("msg", "Payment failed. Try again.");
        }

        RequestDispatcher rd = request.getRequestDispatcher("userhome.jsp");
        rd.forward(request, response);
    }
}