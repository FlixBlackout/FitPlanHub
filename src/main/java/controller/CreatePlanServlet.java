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
import pojo.FitnessPlan;
import pojo.Trainer;

@WebServlet("/CreatePlanServlet")
public class CreatePlanServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Trainer trainer = (Trainer) session.getAttribute("trainer");

        if (trainer == null) {
            response.sendRedirect("login.jsp?msg=Please login as trainer first");
            return;
        }
        
        FitnessPlan fp = new FitnessPlan();
        fp.setTrainerId(trainer.getId());
        fp.setTitle(request.getParameter("title"));
        fp.setDescription(request.getParameter("description"));
        
        String priceStr = request.getParameter("price");
        if (priceStr != null && !priceStr.isEmpty()) {
            fp.setPrice(Double.parseDouble(priceStr));
        }
        
        String durationStr = request.getParameter("durationDays");
        if (durationStr != null && !durationStr.isEmpty()) {
            fp.setDurationDays(Integer.parseInt(durationStr));
        }
        
        fp.setDifficultyLevel(request.getParameter("difficultyLevel"));
        fp.setCategory(request.getParameter("category"));
        fp.setActive(true); // New plans are active by default

        FitnessPlanDaoImpl planDao = new FitnessPlanDaoImpl();
        
        String target = "";
        if (planDao.addFitnessPlan(fp)) {
            target = "/trainerhome.jsp";
            request.setAttribute("msg", "Fitness plan created successfully!");
        } else {
            target = "/createplan.jsp";
            request.setAttribute("msg", "Failed to create fitness plan!");
        }

        RequestDispatcher rd = getServletContext().getRequestDispatcher(target);
        rd.forward(request, response);
    }
}