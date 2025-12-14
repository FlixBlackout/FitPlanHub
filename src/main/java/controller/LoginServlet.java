package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daoimpl.TrainerDaoImpl;
import daoimpl.UserDaoImpl;
import pojo.Trainer;
import pojo.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String target = "";
        boolean valid = false;

        UserDaoImpl userDao = new UserDaoImpl();
        TrainerDaoImpl trainerDao = new TrainerDaoImpl();

        if ("user".equalsIgnoreCase(role)) {
            valid = userDao.validateUser(email, password);
            if (valid) {
                User user = userDao.getUserAfterValidation(email, password);
                // Store user object in session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                target = "/userhome.jsp";
                request.setAttribute("msg", "Welcome, " + user.getFirstName() + "!");
            }
        } else if ("trainer".equalsIgnoreCase(role)) {
            valid = trainerDao.validateTrainer(email, password);
            if (valid) {
                Trainer trainer = trainerDao.getTrainerAfterValidation(email, password);
                // Store trainer object in session
                HttpSession session = request.getSession();
                session.setAttribute("trainer", trainer);
                target = "/trainerhome.jsp";
                request.setAttribute("msg", "Welcome, Trainer " + trainer.getFirstName() + "!");
            }
        }

       
        if (!valid) {
            target = "/login.jsp";
            request.setAttribute("msg", "Invalid email or password!");
        }

        RequestDispatcher rd = getServletContext().getRequestDispatcher(target);
        rd.forward(request, response);
    }
}