package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daoimpl.UserDaoImpl;
import pojo.User;

@WebServlet("/EditProfileServlet")
public class EditProfileServlett extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp?msg=Please login to edit your profile");
            return;
        }
        
        // Get form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String gender = request.getParameter("gender");
        String heightStr = request.getParameter("height");
        String weightStr = request.getParameter("weight");
        
        
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setDateOfBirth(dateOfBirth);
        user.setGender(gender);
        
        if (heightStr != null && !heightStr.isEmpty()) {
            user.setHeight(Double.parseDouble(heightStr));
        }
        
        if (weightStr != null && !weightStr.isEmpty()) {
            user.setWeight(Double.parseDouble(weightStr));
        }
        
        
        UserDaoImpl userDao = new UserDaoImpl();
        String target = "";
        if (userDao.updateUser(user)) {
           
            session.setAttribute("user", user);
            target = "/userProfile.jsp";
            request.setAttribute("msg", "Profile updated successfully!");
        } else {
            target = "/editProfile.jsp";
            request.setAttribute("msg", "Failed to update profile. Please try again.");
        }
        
        RequestDispatcher rd = getServletContext().getRequestDispatcher(target);
        rd.forward(request, response);
    }
}