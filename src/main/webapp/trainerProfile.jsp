<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pojo.Trainer" %>
<%@ page import="pojo.FitnessPlan" %>
<%@ page import="daoimpl.TrainerDaoImpl" %>
<%@ page import="daoimpl.FitnessPlanDaoImpl" %>
<%@ page import="daoimpl.FollowingDaoImpl" %>
<%@ page import="pojo.User" %>
<%@ page import="java.util.List" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    Trainer currentTrainer = (Trainer) session.getAttribute("trainer");
    
    if (user == null && currentTrainer == null) {
        response.sendRedirect("login.jsp?msg=Please login to view trainer profile");
        return;
    }
    
    // Get trainer ID from request
    String trainerIdStr = request.getParameter("id");
    if (trainerIdStr == null || trainerIdStr.isEmpty()) {
        if (currentTrainer != null) {
            // If a trainer is logged in and no ID is provided, show their own profile
            response.sendRedirect("trainerProfile.jsp?id=" + currentTrainer.getId());
            return;
        } else {
            response.sendRedirect("userhome.jsp?msg=Invalid trainer selection");
            return;
        }
    }
    
    int trainerId = Integer.parseInt(trainerIdStr);
    
    // Get trainer details
    TrainerDaoImpl trainerDao = new TrainerDaoImpl();
    Trainer trainer = trainerDao.searchTrainer(trainerId);
    
    if (trainer == null) {
        response.sendRedirect("userhome.jsp?msg=Trainer not found");
        return;
    }
    
    // Get trainer's fitness plans
    FitnessPlanDaoImpl planDao = new FitnessPlanDaoImpl();
    List<FitnessPlan> plans = planDao.getFitnessPlansByTrainer(trainerId);
    
    // Check if current user is following this trainer
    boolean isFollowing = false;
    if (user != null) {
        FollowingDaoImpl followingDao = new FollowingDaoImpl();
        isFollowing = followingDao.isFollowing(user.getId(), trainerId);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="FitPlanHub - Trainer Profile">
    <meta name="keywords" content="FitPlanHub, fitness, trainer profile">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title><%= trainer.getFirstName() %> <%= trainer.getLastName() %> - FitPlanHub</title>

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
                                <% } else if (currentTrainer != null) { %>
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
           padding:80px 0; min-height:100vh;">

    <div class="container">

        <!-- Title -->
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="section-title">
                    <span style="color:#f36100; letter-spacing:2px; font-size:14px;">
                        Trainer
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

            <!-- LEFT: Trainer Info -->
            <div class="col-lg-4">
                <div class="contact-form"
                     style="background:#ffffff;
                            padding:30px;
                            border-radius:12px;
                            box-shadow:0 10px 30px rgba(0,0,0,0.35);">

                    <h4 style="font-weight:700; margin-bottom:20px;">
                        Trainer Profile
                    </h4>

                    <p><strong>Name:</strong>
                        <%= trainer.getFirstName() %> <%= trainer.getLastName() %>
                    </p>
                    <p><strong>Certification:</strong> <%= trainer.getCertification() %></p>
                    <p><strong>Experience:</strong> <%= trainer.getExperienceYears() %> years</p>
                    <p><strong>Specialization:</strong> <%= trainer.getSpecialization() %></p>
                    <p><strong>Bio:</strong> <%= trainer.getBio() %></p>

                    <% if (user != null) { %>
                        <form action="FollowServlet" method="post" style="margin-top:25px;">
                            <input type="hidden" name="trainerId" value="<%= trainer.getId() %>">

                            <% if (isFollowing) { %>
                                <input type="hidden" name="action" value="unfollow">
                                <button type="submit"
                                    style="width:100%; height:45px;
                                           background:#f36100;
                                           border:none;
                                           border-radius:6px;
                                           color:#ffffff;
                                           font-weight:700;">
                                    Unfollow
                                </button>
                            <% } else { %>
                                <input type="hidden" name="action" value="follow">
                                <button type="submit"
                                    style="width:100%; height:45px;
                                           border:2px solid #f36100;
                                           border-radius:6px;
                                           color:#f36100;
                                           font-weight:700;
                                           background:none;">
                                    Follow
                                </button>
                            <% } %>
                        </form>
                    <% } %>
                </div>
            </div>

            <!-- RIGHT: Trainer Plans -->
            <div class="col-lg-8">
                <div class="contact-form"
                     style="background:#ffffff;
                            padding:30px;
                            border-radius:12px;
                            box-shadow:0 10px 30px rgba(0,0,0,0.35);">

                    <h4 style="font-weight:700; margin-bottom:30px;">
                        Fitness Plans by <%= trainer.getFirstName() %>
                    </h4>

                    <% if(plans != null && !plans.isEmpty()) { %>
                    <div class="row">
                        <% for(FitnessPlan plan : plans) { %>
                        <div class="col-lg-6">
                            <div class="single-service"
                                 style="background:#f9f9f9;
                                        padding:20px;
                                        border-radius:10px;
                                        margin-bottom:25px;
                                        box-shadow:0 5px 15px rgba(0,0,0,0.15);">

                                <h5 style="font-weight:700; margin-bottom:10px;">
                                    <%= plan.getTitle() %>
                                </h5>

                                <p style="font-size:14px; color:#444;">
                                    <strong>Price:</strong> $<%= plan.getPrice() %><br>
                                    <strong>Duration:</strong> <%= plan.getDurationDays() %> days<br>
                                    <strong>Difficulty:</strong> <%= plan.getDifficultyLevel() %>
                                </p>

                                <a href="planDetails.jsp?id=<%= plan.getId() %>"
                                   style="display:block;
                                          text-align:center;
                                          margin-top:12px;
                                          height:40px;
                                          line-height:40px;
                                          background:#f36100;
                                          color:#ffffff;
                                          font-weight:700;
                                          border-radius:6px;
                                          text-decoration:none;">
                                    View Details
                                </a>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <% } else { %>
                        <p style="color:#666;">
                            This trainer hasn't created any fitness plans yet.
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