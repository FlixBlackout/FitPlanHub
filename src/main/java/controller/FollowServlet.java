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

import daoimpl.FollowingDaoImpl;
import pojo.Following;
import pojo.User;

@WebServlet("/FollowServlet")
public class FollowServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?msg=Please login as user first");
            return;
        }
        
        String trainerIdStr = request.getParameter("trainerId");
        String action = request.getParameter("action"); // "follow" or "unfollow"
        
        if (trainerIdStr == null || trainerIdStr.isEmpty() || action == null || action.isEmpty()) {
            response.sendRedirect("userhome.jsp?msg=Invalid request!");
            return;
        }
        
        int trainerId = Integer.parseInt(trainerIdStr);
        int userId = user.getId();
        
        FollowingDaoImpl followingDao = new FollowingDaoImpl();
        String target = "/userhome.jsp";
        
        if ("follow".equalsIgnoreCase(action)) {
           
            if (followingDao.isFollowing(userId, trainerId)) {
                request.setAttribute("msg", "You are already following this trainer!");
            } else {
                Following following = new Following();
                following.setUserId(userId);
                following.setTrainerId(trainerId);
                following.setFollowedAt(new Timestamp(System.currentTimeMillis()).toString());
                
                if (followingDao.followTrainer(following)) {
                    request.setAttribute("msg", "Successfully followed the trainer!");
                } else {
                    request.setAttribute("msg", "Failed to follow the trainer!");
                }
            }
        } else if ("unfollow".equalsIgnoreCase(action)) {
            if (followingDao.unfollowTrainer(userId, trainerId)) {
                request.setAttribute("msg", "Successfully unfollowed the trainer!");
            } else {
                request.setAttribute("msg", "Failed to unfollow the trainer!");
            }
        } else {
            request.setAttribute("msg", "Invalid action!");
        }

        RequestDispatcher rd = getServletContext().getRequestDispatcher(target);
        rd.forward(request, response);
    }
}