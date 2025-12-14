package controller;

import java.io.IOException;

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
import pojo.User;


@WebServlet("/SubscribeServlett")
public class SubscribeServlett extends HttpServlet {
	 @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        HttpSession session = request.getSession(false);
	        User user = (User) session.getAttribute("user");

	        
	        if (user == null) {
	            response.sendRedirect("login.jsp?msg=Please login first");
	            return;
	        }

	       
	        String planIdStr = request.getParameter("planId");
	        if (planIdStr == null || planIdStr.isEmpty()) {
	            response.sendRedirect("userhome.jsp?msg=Invalid plan selection");
	            return;
	        }

	        int planId = Integer.parseInt(planIdStr);

	        
	        SubscriptionDaoImpl subscriptionDao = new SubscriptionDaoImpl();
	        if (subscriptionDao.isUserSubscribedToPlan(user.getId(), planId)) {
	            response.sendRedirect("userhome.jsp?msg=Already subscribed to this plan");
	            return;
	        }

	        
	        FitnessPlanDaoImpl planDao = new FitnessPlanDaoImpl();
	        FitnessPlan plan = planDao.searchFitnessPlan(planId);

	        if (plan == null) {
	            response.sendRedirect("userhome.jsp?msg=Plan not found");
	            return;
	        }

	        
	        request.setAttribute("plan", plan);
	        RequestDispatcher rd = request.getRequestDispatcher("payment.jsp");
	        rd.forward(request, response);
	    }
	}


