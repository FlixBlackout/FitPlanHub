package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daoimpl.TrainerDaoImpl;
import daoimpl.UserDaoImpl;
import pojo.Trainer;
import pojo.User;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String selectedRole = request.getParameter("role");
        String target = "";
        
        UserDaoImpl userDao = new UserDaoImpl();
        TrainerDaoImpl trainerDao = new TrainerDaoImpl();
        
        if ("user".equalsIgnoreCase(selectedRole)) {
            User u = new User();
            u.setUsername(request.getParameter("username"));
            u.setEmail(request.getParameter("email"));
            u.setPasswordHash(request.getParameter("password")); // In real app, this should be hashed
            u.setFirstName(request.getParameter("firstName"));
            u.setLastName(request.getParameter("lastName"));
            u.setDateOfBirth(request.getParameter("dateOfBirth"));
            u.setGender(request.getParameter("gender"));
            
            String heightStr = request.getParameter("height");
            String weightStr = request.getParameter("weight");
            
            if (heightStr != null && !heightStr.isEmpty()) {
                u.setHeight(Double.parseDouble(heightStr));
            }
            
            if (weightStr != null && !weightStr.isEmpty()) {
                u.setWeight(Double.parseDouble(weightStr));
            }

            if (userDao.addUser(u)) {
                target = "/login.jsp";
                request.setAttribute("msg", "User registered successfully!");
            } else {
                target = "/register.jsp";
                request.setAttribute("msg", "Failed to register user!");
            }

        } else if ("trainer".equalsIgnoreCase(selectedRole)) {
            Trainer t = new Trainer();
            t.setUsername(request.getParameter("username"));
            t.setEmail(request.getParameter("email"));
            t.setPasswordHash(request.getParameter("password")); // In real app, this should be hashed
            t.setFirstName(request.getParameter("firstName"));
            t.setLastName(request.getParameter("lastName"));
            t.setCertification(request.getParameter("certification"));
            
            String expStr = request.getParameter("experienceYears");
            if (expStr != null && !expStr.isEmpty()) {
                t.setExperienceYears(Integer.parseInt(expStr));
            }
            
            t.setSpecialization(request.getParameter("specialization"));
            t.setBio(request.getParameter("bio"));

            if (trainerDao.addTrainer(t)) {
                target = "/login.jsp";
                request.setAttribute("msg", "Trainer registered successfully!");
            } else {
                target = "/register.jsp";
                request.setAttribute("msg", "Failed to register trainer!");
            }
        }

        RequestDispatcher rd = request.getRequestDispatcher(target);
        rd.forward(request, response);
    }
}