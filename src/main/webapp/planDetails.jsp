<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pojo.FitnessPlan" %>
<%@ page import="pojo.Trainer" %>
<%@ page import="daoimpl.FitnessPlanDaoImpl" %>
<%@ page import="daoimpl.TrainerDaoImpl" %>
<%@ page import="daoimpl.SubscriptionDaoImpl" %>
<%@ page import="pojo.User" %>
<%@ page import="pojo.Trainer" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    Trainer trainer = (Trainer) session.getAttribute("trainer");
    
    if (user == null && trainer == null) {
        response.sendRedirect("login.jsp?msg=Please login to view plan details");
        return;
    }
    
    // Get plan ID from request
    String planIdStr = request.getParameter("id");
    if (planIdStr == null || planIdStr.isEmpty()) {
        response.sendRedirect("userhome.jsp?msg=Invalid plan selection");
        return;
    }
    
    int planId = Integer.parseInt(planIdStr);
    
    // Get plan details
    FitnessPlanDaoImpl planDao = new FitnessPlanDaoImpl();
    FitnessPlan plan = planDao.searchFitnessPlan(planId);
    
    if (plan == null) {
        response.sendRedirect("userhome.jsp?msg=Plan not found");
        return;
    }
    
    // Get trainer details
    TrainerDaoImpl trainerDao = new TrainerDaoImpl();
    Trainer planTrainer = trainerDao.searchTrainer(plan.getTrainerId());
    
    // Check if user is subscribed to this plan (if user is logged in)
    boolean isSubscribed = false;
    if (user != null) {
        SubscriptionDaoImpl subscriptionDao = new SubscriptionDaoImpl();
        isSubscribed = subscriptionDao.isUserSubscribedToPlan(user.getId(), planId);
    }
    
    // If trainer is viewing, check if they own this plan
    boolean isOwner = false;
    if (trainer != null) {
        isOwner = (trainer.getId() == plan.getTrainerId());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="FitPlanHub - Plan Details">
    <meta name="keywords" content="FitPlanHub, fitness, plan details">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title><%= plan.getTitle() %> - FitPlanHub</title>

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
                                <h2>FitHub</h2>
                            </a>
                        </div>
                        <nav class="mobile-menu">
                            <ul>
                                <li><a href="./IndexMain.jsp">Home</a></li>
                                <% if (user != null) { %>
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
                    <h2>Search Fitness Plans</h2>
                    <form action="#">
                        <input type="search" placeholder="Search for fitness plans, trainers...">
                        <button type="submit">Search</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <!-- Search Bar End -->
    
    <!-- Plan Details Section Begin -->
<section class="contact-section spad"
    style="background: linear-gradient(135deg, #111111, #1c1c1c);
           padding:80px 0; min-height:100vh;">

    <div class="container">

        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="section-title">
                    <span style="color:#f36100; letter-spacing:2px; font-size:14px;">
                        Fitness Plan
                    </span>
                    <h2 style="color:#ffffff; font-weight:700; margin-top:10px;">
                        <%= plan.getTitle() %>
                    </h2>
                </div>
            </div>
        </div>

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

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="contact-form"
                     style="background:#ffffff;
                            padding:40px 35px;
                            border-radius:12px;
                            box-shadow:0 10px 30px rgba(0,0,0,0.35);">

                    <div class="row">

                        <!-- LEFT: Plan Info -->
                        <div class="col-lg-6">
                            <h4 style="font-weight:700; margin-bottom:20px;">
                                Plan Information
                            </h4>

                            <p><strong>Trainer:</strong>
                                <%= planTrainer != null ? planTrainer.getFirstName() + " " + planTrainer.getLastName() : "Unknown" %>
                            </p>
                            <p><strong>Price:</strong> $<%= plan.getPrice() %></p>
                            <p><strong>Duration:</strong> <%= plan.getDurationDays() %> days</p>
                            <p><strong>Difficulty:</strong> <%= plan.getDifficultyLevel() %></p>
                            <p><strong>Category:</strong> <%= plan.getCategory() %></p>
                        </div>

                        <!-- RIGHT: Actions / Description -->
                        <div class="col-lg-6">

                            <% if (user != null) { %>

                                <% if (isSubscribed) { %>
                                    <div class="alert alert-success text-center"
                                         style="border-radius:8px;">
                                        You are subscribed to this plan!
                                    </div>

                                    <p style="margin-top:15px;">
                                        <%= plan.getDescription() %>
                                    </p>

                                    <div class="text-center" style="margin-top:25px;">
                                        <a href="./userhome.jsp"
                                           style="display:inline-block;
                                                  width:100%;
                                                  height:50px;
                                                  line-height:50px;
                                                  background:#f36100;
                                                  color:#fff;
                                                  font-weight:700;
                                                  border-radius:6px;
                                                  text-decoration:none;">
                                            Back to Dashboard
                                        </a>
                                    </div>

                                <% } else { %>
                                    <div class="alert alert-warning text-center"
                                         style="border-radius:8px;">
                                        You need to subscribe to view the full plan details.
                                    </div>

                                    <p style="margin-top:15px;">
                                        <%= plan.getDescription().length() > 100
                                            ? plan.getDescription().substring(0, 100) + "..."
                                            : plan.getDescription() %>
                                    </p>

                                    <form action="Payment.jsp" method="post">
                                          
                                        <input type="hidden" name="planId"
                                               value="<%= plan.getId() %>">

                                        <button type="submit"
                                            style="width:100%;
                                                   height:50px;
                                                   background:#f36100;
                                                   border:none;
                                                   border-radius:6px;
                                                   color:#ffffff;
                                                   font-weight:700;">
                                            Subscribe Now ($<%= plan.getPrice() %>)
                                        </button>
                                    </form>
                                <% } %>

                            <% } else if (trainer != null) { %>

                                <% if (isOwner) { %>
                                    <div class="alert alert-info text-center"
                                         style="border-radius:8px;">
                                        This is your plan.
                                    </div>

                                    <p style="margin-top:15px;">
                                        <%= plan.getDescription() %>
                                    </p>

                                    <div class="row" style="margin-top:25px;">
                                        <div class="col-6">
                                            <a href="editplan.jsp?id=<%= plan.getId() %>"
                                               style="display:block;
                                                      text-align:center;
                                                      height:50px;
                                                      line-height:50px;
                                                      border:2px solid #f36100;
                                                      border-radius:6px;
                                                      color:#f36100;
                                                      font-weight:700;
                                                      text-decoration:none;">
                                                Edit Plan
                                            </a>
                                        </div>
                                        <div class="col-6">
                                            <a href="./trainerhome.jsp"
                                               style="display:block;
                                                      text-align:center;
                                                      height:50px;
                                                      line-height:50px;
                                                      background:#f36100;
                                                      border-radius:6px;
                                                      color:#ffffff;
                                                      font-weight:700;
                                                      text-decoration:none;">
                                                Back
                                            </a>
                                        </div>
                                    </div>

                                <% } else { %>
                                    <div class="alert alert-info text-center"
                                         style="border-radius:8px;">
                                        Plan details preview.
                                    </div>

                                    <p style="margin-top:15px;">
                                        <%= plan.getDescription().length() > 100
                                            ? plan.getDescription().substring(0, 100) + "..."
                                            : plan.getDescription() %>
                                    </p>

                                    <div class="text-center" style="margin-top:25px;">
                                        <a href="./trainerhome.jsp"
                                           style="display:inline-block;
                                                  width:100%;
                                                  height:50px;
                                                  line-height:50px;
                                                  background:#f36100;
                                                  color:#fff;
                                                  font-weight:700;
                                                  border-radius:6px;
                                                  text-decoration:none;">
                                            Back to Dashboard
                                        </a>
                                    </div>
                                <% } %>

                            <% } %>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>
<!-- Plan Details Section End -->
    
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