<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pojo.User" %>
<%@ page import="pojo.FitnessPlan" %>
<%@ page import="pojo.Trainer" %>
<%@ page import="daoimpl.UserDaoImpl" %>
<%@ page import="daoimpl.SubscriptionDaoImpl" %>
<%@ page import="daoimpl.FitnessPlanDaoImpl" %>
<%@ page import="daoimpl.TrainerDaoImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Check if user is logged in
    User currentUser = (User) session.getAttribute("user");
    Trainer trainer = (Trainer) session.getAttribute("trainer");
    
    if (currentUser == null && trainer == null) {
        response.sendRedirect("login.jsp?msg=Please login to view profile");
        return;
    }
    
    // Get user ID from request (for trainers viewing user profiles)
    User user = currentUser;
    String userIdStr = request.getParameter("id");
    
    if (userIdStr != null && !userIdStr.isEmpty()) {
        // If a specific user ID is provided and current user is a trainer
        if (trainer != null) {
            int userId = Integer.parseInt(userIdStr);
            UserDaoImpl userDao = new UserDaoImpl();
            user = userDao.searchUser(userId);
            
            if (user == null) {
                response.sendRedirect("trainerhome.jsp?msg=User not found");
                return;
            }
        } else {
            // Regular users can only view their own profile
            response.sendRedirect("userProfile.jsp");
            return;
        }
    }
    
    // Get user's subscriptions
    SubscriptionDaoImpl subscriptionDao = new SubscriptionDaoImpl();
    List<pojo.Subscription> subscriptions = new ArrayList<>();
    
    if (user != null) {
        subscriptions = subscriptionDao.getSubscriptionsByUser(user.getId());
    }
    
    // Get plan details for subscriptions
    FitnessPlanDaoImpl planDao = new FitnessPlanDaoImpl();
    TrainerDaoImpl trainerDao = new TrainerDaoImpl();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="FitPlanHub - User Profile">
    <meta name="keywords" content="FitPlanHub, fitness, user profile">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title><%= user.getFirstName() %> <%= user.getLastName() %> - FitPlanHub</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,300i,400,500,700,900" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="css/barfiller.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
    
    <!-- Header Section Begin -->
    <header class="header-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="main-menu">
                        <div class="logo">
                            <a href="./IndexMain.jsp">
                                <img src="img/logo.png" alt="FitPlanHub">
                            </a>
                        </div>
                        <nav class="mobile-menu">
                            <ul>
                                <li><a href="./IndexMain.jsp">Home</a></li>
                                <% if (currentUser != null) { %>
                                    <li><a href="./userhome.jsp">Dashboard</a></li>
                                    <li><a href="./feed.jsp">My Feed</a></li>
                                <% } else if (trainer != null) { %>
                                    <li><a href="./trainerhome.jsp">Dashboard</a></li>
                                <% } %>
                                <li><a href="./logout.jsp">Logout</a></li>
                                <li class="search-btn search-trigger"><i class="fa fa-search"></i></li>
                            </ul>
                        </nav>
                        <div id="mobile-menu-wrap"></div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- Header End -->
    
    <!-- Search Bar Begin -->
    <section class="search-bar-wrap">
        <span class="search-close"><i class="fa fa-close"></i></span>
        <div class="search-bar-table">
            <div class="search-bar-tablecell">
                <div class="search-bar-inner">
                    <h2>Search</h2>
                    <form action="#">
                        <input type="search" placeholder="Type Keywords">
                        <button type="submit">Search</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <!-- Search Bar End -->
    
    <!-- Profile Section Begin -->
<section class="contact-section spad"
    style="background: linear-gradient(135deg, #111111, #1c1c1c);
           min-height:100vh; padding:80px 0;">

    <div class="container">

        <!-- Header -->
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="section-title">
                    <span style="color:#f36100; letter-spacing:2px; font-size:14px;">
                        User
                    </span>
                    <h2 style="color:#ffffff; font-weight:700; margin-top:10px;">
                        Profile
                    </h2>
                </div>
            </div>
        </div>

        <!-- Message -->
        <%
            String msg = (String) request.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="row">
            <div class="col-lg-12">
                <div class="alert alert-info text-center"
                     style="border-radius:6px; font-size:14px;">
                    <%= msg %>
                </div>
            </div>
        </div>
        <% } %>

        <div class="row">

            <!-- User Info -->
            <div class="col-lg-4" style="margin-bottom:30px;">
                <div style="background:#ffffff; padding:30px;
                            border-radius:12px;
                            box-shadow:0 10px 30px rgba(0,0,0,0.25);">

                    <h4 style="font-weight:700; margin-bottom:20px;">
                        User Profile
                    </h4>

                    <p style="font-size:14px; color:#555;">
                        <strong>Name:</strong> <%= user.getFirstName() %> <%= user.getLastName() %>
                    </p>
                    <p style="font-size:14px; color:#555;">
                        <strong>Email:</strong> <%= user.getEmail() %>
                    </p>
                    <p style="font-size:14px; color:#555;">
                        <strong>Date of Birth:</strong> <%= user.getDateOfBirth() %>
                    </p>
                    <p style="font-size:14px; color:#555;">
                        <strong>Gender:</strong> <%= user.getGender() %>
                    </p>
                    <p style="font-size:14px; color:#555;">
                        <strong>Height:</strong> <%= user.getHeight() %> cm
                    </p>
                    <p style="font-size:14px; color:#555;">
                        <strong>Weight:</strong> <%= user.getWeight() %> kg
                    </p>

                    <% if (currentUser != null && currentUser.getId() == user.getId()) { %>
                    <div class="text-center" style="margin-top:25px;">
                        <a href="editProfile.jsp"
                           style="display:inline-block; padding:10px 25px;
                                  border:2px solid #f36100;
                                  color:#f36100; font-weight:700;
                                  border-radius:6px;
                                  text-decoration:none;">
                            Edit Profile
                        </a>
                    </div>
                    <% } %>

                </div>
            </div>

            <!-- Subscriptions -->
            <div class="col-lg-8">
                <div style="background:#ffffff; padding:30px;
                            border-radius:12px;
                            box-shadow:0 10px 30px rgba(0,0,0,0.25);">

                    <h4 style="font-weight:700; margin-bottom:30px;">
                        Subscribed Plans
                    </h4>

                    <% if(subscriptions != null && !subscriptions.isEmpty()) { %>
                    <div class="row">

                        <% for(pojo.Subscription subscription : subscriptions) {
                            FitnessPlan plan = planDao.searchFitnessPlan(subscription.getPlanId());
                            if (plan != null) {
                                Trainer planTrainer = trainerDao.searchTrainer(plan.getTrainerId());
                        %>

                        <div class="col-lg-6" style="margin-bottom:25px;">
                            <div style="background:#f9f9f9; padding:25px;
                                        border-radius:10px;
                                        border:1px solid #eee;
                                        height:100%;">

                                <h5 style="font-weight:700; margin-bottom:15px;">
                                    <%= plan.getTitle() %>
                                </h5>

                                <p style="font-size:14px; color:#555; line-height:1.7;">
                                    <strong>Trainer:</strong>
                                    <%= planTrainer != null
                                        ? planTrainer.getFirstName() + " " + planTrainer.getLastName()
                                        : "Unknown" %><br>

                                    <strong>Price:</strong> $<%= subscription.getAmountPaid() %><br>
                                    <strong>Subscribed On:</strong> <%= subscription.getSubscriptionDate() %><br>
                                    <strong>Expiry:</strong> <%= subscription.getExpiryDate() %><br>
                                    <strong>Status:</strong>
                                    <span style="font-weight:700;
                                                 color:<%= subscription.isActive() ? "#28a745" : "#dc3545" %>;">
                                        <%= subscription.isActive() ? "Active" : "Expired" %>
                                    </span>
                                </p>

                                <a href="planDetails.jsp?id=<%= plan.getId() %>"
                                   style="display:inline-block; width:100%;
                                          text-align:center;
                                          padding:10px 0;
                                          background:#f36100;
                                          color:#fff;
                                          border-radius:6px;
                                          font-weight:700;
                                          text-decoration:none;">
                                    View Plan
                                </a>
                            </div>
                        </div>

                        <% } } %>
                    </div>

                    <% } else { %>
                        <p style="font-size:15px; color:#555;">
                            No subscriptions yet.
                        </p>
                    <% } %>

                </div>
            </div>

        </div>
    </div>
</section>
<!-- Profile Section End -->
    
    <!-- Footer Section Begin -->
    <footer class="footer-section set-bg" data-setbg="img/footer-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="footer-content">
                        <div class="footer-logo">
                            <a href="./IndexMain.jsp"><img src="img/logo.png" alt="FitPlanHub"></a>
                        </div>
                        <div class="footer-menu">
                            <ul>
                                <li><a href="./IndexMain.jsp">Home</a></li>
                                <li><a href="#">About Us</a></li>
                                <li><a href="#">Plans</a></li>
                                <li><a href="#">Trainers</a></li>
                                <li><a href="#">Blog</a></li>
                                <li><a href="#">Contact</a></li>
                            </ul>
                        </div>
                        <div class="subscribe-form">
                            <form action="#">
                                <input type="text" placeholder="Your Email">
                                <button type="submit">Sign Up</button>
                            </form>
                        </div>
                        <div class="social-links">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                            <a href="#"><i class="fa fa-youtube"></i></a>
                        </div>
                        <div class="footer-icon-img">
                            <img src="img/footer-icon.png" alt="">
                        </div>
                        <div class="copyright">
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | FitPlanHub - Fitness Plans Platform
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/circle-progress.min.js"></script>
    <script src="js/jquery.barfiller.js"></script>
    <script src="js/main.js"></script>
</body>

</html>