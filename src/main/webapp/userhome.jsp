<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="pojo.FitnessPlan" %>
<%@ page import="pojo.Trainer" %>
<%@ page import="daoimpl.FitnessPlanDaoImpl" %>
<%@ page import="daoimpl.TrainerDaoImpl" %>
<%@ page import="pojo.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    FitnessPlanDaoImpl planDao = new FitnessPlanDaoImpl();
    List<FitnessPlan> plans = planDao.getAllFitnessPlans();
    
    TrainerDaoImpl trainerDao = new TrainerDaoImpl();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="FitPlanHub - User Dashboard">
    <meta name="keywords" content="FitPlanHub, fitness, dashboard">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>User Dashboard - FitPlanHub</title>

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
                                <li><a href="./feed.jsp">My Feed</a></li>
                                <li><a href="./userProfile.jsp">My Profile</a></li>
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
    
   <!-- Dashboard Section Begin -->
<section class="contact-section spad"
    style="background: linear-gradient(135deg, #111111, #1c1c1c);
           min-height:100vh; padding:80px 0;">

    <div class="container">

        <!-- Header -->
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="section-title">
                    <span style="color:#f36100; letter-spacing:2px; font-size:14px;">
                        Welcome Back
                    </span>
                    <h2 style="color:#ffffff; font-weight:700; margin-top:10px;">
                        <%= user.getFirstName() %>'s Dashboard
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

        <!-- Plans -->
        <div class="row">
            <div class="col-lg-12">
                <h3 style="color:#ffffff; margin-bottom:30px; font-weight:700;">
                    All Fitness Plans
                </h3>

                <% if(plans != null && !plans.isEmpty()) { %>
                <div class="row">

                    <% for(FitnessPlan plan : plans) {
                        Trainer trainer = trainerDao.searchTrainer(plan.getTrainerId());
                    %>

                    <div class="col-lg-4 col-md-6" style="margin-bottom:30px;">
                        <div style="background:#ffffff; padding:30px;
                                    border-radius:12px;
                                    box-shadow:0 10px 30px rgba(0,0,0,0.25);
                                    height:100%;">

                            <h5 style="font-weight:700; margin-bottom:15px;">
                                <%= plan.getTitle() %>
                            </h5>

                            <p style="font-size:14px; color:#555; line-height:1.7;">
                                <strong>Trainer:</strong>
                                <%= trainer != null
                                    ? trainer.getFirstName() + " " + trainer.getLastName()
                                    : "Unknown" %><br>

                                <strong>Price:</strong> $<%= plan.getPrice() %><br>
                                <strong>Duration:</strong> <%= plan.getDurationDays() %> days<br>
                                <strong>Difficulty:</strong> <%= plan.getDifficultyLevel() %><br>
                                <strong>Category:</strong> <%= plan.getCategory() %>
                            </p>

                            <!-- Subscribe -->
                            <form action="SubscribeServlet" method="post">
                                <input type="hidden" name="planId" value="<%= plan.getId() %>">
                                <button type="submit"
                                    style="width:100%; height:45px;
                                           background:#f36100; border:none;
                                           border-radius:6px; color:#fff;
                                           font-weight:700; text-transform:uppercase;
                                           margin-bottom:10px;">
                                    Subscribe
                                </button>
                            </form>

                            <!-- Follow -->
                            <form action="FollowServlet" method="post">
                                <input type="hidden" name="trainerId" value="<%= plan.getTrainerId() %>">
                                <input type="hidden" name="action" value="follow">
                                <button type="submit"
                                    style="width:100%; height:45px;
                                           background:transparent;
                                           border:2px solid #f36100;
                                           border-radius:6px;
                                           color:#f36100;
                                           font-weight:700;
                                           text-transform:uppercase;">
                                    Follow Trainer
                                </button>
                            </form>

                        </div>
                    </div>

                    <% } %>
                </div>

                <% } else { %>
                <!-- Empty State -->
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <p style="color:#ffffff; font-size:16px; margin-bottom:20px;">
                            No fitness plans available at the moment.
                        </p>
                        <a href="./feed.jsp"
                           style="display:inline-block; padding:12px 30px;
                                  background:#f36100; color:#fff;
                                  border-radius:6px; font-weight:700;
                                  text-decoration:none;">
                            View My Feed
                        </a>
                    </div>
                </div>
                <% } %>

            </div>
        </div>

    </div>
</section>
<!-- Dashboard Section End -->
    
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