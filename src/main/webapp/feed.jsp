<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pojo.User" %>
<%@ page import="pojo.Trainer" %>
<%@ page import="pojo.FitnessPlan" %>
<%@ page import="pojo.Following" %>
<%@ page import="daoimpl.UserDaoImpl" %>
<%@ page import="daoimpl.TrainerDaoImpl" %>
<%@ page import="daoimpl.FitnessPlanDaoImpl" %>
<%@ page import="daoimpl.FollowingDaoImpl" %>
<%@ page import="daoimpl.SubscriptionDaoImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    Trainer trainer = (Trainer) session.getAttribute("trainer");
    
    if (user == null && trainer == null) {
        response.sendRedirect("login.jsp?msg=Please login to view your feed");
        return;
    }
    
    List<FitnessPlan> feedPlans = new ArrayList<>();
    
    if (user != null) {
        // Get user's followed trainers
        FollowingDaoImpl followingDao = new FollowingDaoImpl();
        List<Following> followingList = followingDao.getFollowingByUser(user.getId());
        
        // Get plans from followed trainers
        FitnessPlanDaoImpl planDao = new FitnessPlanDaoImpl();
        for (Following following : followingList) {
            List<FitnessPlan> trainerPlans = planDao.getFitnessPlansByTrainer(following.getTrainerId());
            feedPlans.addAll(trainerPlans);
        }
        
        // Also get user's subscribed plans
        SubscriptionDaoImpl subscriptionDao = new SubscriptionDaoImpl();
        List<pojo.Subscription> subscriptions = subscriptionDao.getSubscriptionsByUser(user.getId());
        
        for (pojo.Subscription subscription : subscriptions) {
            FitnessPlan plan = planDao.searchFitnessPlan(subscription.getPlanId());
            if (plan != null && !feedPlans.contains(plan)) {
                feedPlans.add(plan);
            }
        }
    } else if (trainer != null) {
        // For trainers, show their own plans
        FitnessPlanDaoImpl planDao = new FitnessPlanDaoImpl();
        feedPlans = planDao.getFitnessPlansByTrainer(trainer.getId());
    }
    
    // Get trainer details for display
    TrainerDaoImpl trainerDao = new TrainerDaoImpl();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="FitPlanHub - Your Personalized Feed">
    <meta name="keywords" content="FitPlanHub, fitness, feed">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Your Feed - FitPlanHub</title>

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
    
   <!-- Feed Section Begin -->
<section class="contact-section spad"
    style="background: linear-gradient(135deg, #111111, #1c1c1c);
           padding:80px 0; min-height:100vh;">

    <div class="container">

        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="section-title">
                    <span style="color:#f36100; letter-spacing:2px; font-size:14px;">
                        Your Personalized
                    </span>
                    <h2 style="color:#ffffff; font-weight:700; margin-top:10px;">
                        Feed
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

        <div class="row">
            <div class="col-lg-12">
                <p class="text-center"
                   style="color:#ccc; margin-bottom:30px;">
                    Discover new fitness plans from trainers you follow and your subscribed plans.
                </p>

                <% if (user != null) { %>
                    <% if (feedPlans.isEmpty()) { %>
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="alert alert-info text-center"
                                     style="border-radius:10px;">
                                    <p style="margin-bottom:15px;">
                                        Your feed is empty. Start following trainers or subscribing to plans.
                                    </p>
                                    <a href="./userhome.jsp"
                                       style="display:inline-block;
                                              padding:12px 25px;
                                              background:#f36100;
                                              color:#fff;
                                              font-weight:700;
                                              border-radius:6px;
                                              text-decoration:none;">
                                        Browse All Plans
                                    </a>
                                </div>
                            </div>
                        </div>
                    <% } else { %>

                        <div class="row">
                            <% for(FitnessPlan plan : feedPlans) {
                                Trainer planTrainer = trainerDao.searchTrainer(plan.getTrainerId());
                            %>
                            <div class="col-lg-4 col-md-6">
                                <div class="single-service"
                                     style="background:#ffffff;
                                            padding:25px;
                                            border-radius:12px;
                                            margin-bottom:30px;
                                            box-shadow:0 8px 25px rgba(0,0,0,0.25);">

                                    <h5 style="font-weight:700; margin-bottom:15px;">
                                        <%= plan.getTitle() %>
                                    </h5>

                                    <p style="font-size:14px; color:#444;">
                                        <strong>Trainer:</strong>
                                        <%= planTrainer != null ? planTrainer.getFirstName() + " " + planTrainer.getLastName() : "Unknown" %><br>
                                        <strong>Price:</strong> $<%= plan.getPrice() %><br>
                                        <strong>Duration:</strong> <%= plan.getDurationDays() %> days<br>
                                        <strong>Difficulty:</strong> <%= plan.getDifficultyLevel() %><br>
                                        <strong>Category:</strong> <%= plan.getCategory() %>
                                    </p>

                                    <a href="planDetails.jsp?id=<%= plan.getId() %>"
                                       style="display:block;
                                              text-align:center;
                                              margin-top:15px;
                                              padding:12px;
                                              background:#f36100;
                                              color:#fff;
                                              font-weight:700;
                                              border-radius:6px;
                                              text-decoration:none;">
                                        View Details
                                    </a>
                                </div>
                            </div>
                            <% } %>
                        </div>

                    <% } %>

                <% } else if (trainer != null) { %>

                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="alert alert-info text-center"
                                 style="border-radius:10px;">
                                <p>As a trainer, your feed shows your own fitness plans.</p>
                            </div>
                        </div>
                    </div>

                    <% if (feedPlans.isEmpty()) { %>
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="alert alert-info text-center"
                                     style="border-radius:10px;">
                                    <p style="margin-bottom:15px;">
                                        You haven't created any fitness plans yet.
                                    </p>
                                    <a href="./createplan.jsp"
                                       style="display:inline-block;
                                              padding:12px 25px;
                                              background:#f36100;
                                              color:#fff;
                                              font-weight:700;
                                              border-radius:6px;
                                              text-decoration:none;">
                                        Create Your First Plan
                                    </a>
                                </div>
                            </div>
                        </div>
                    <% } else { %>

                        <div class="row">
                            <% for(FitnessPlan plan : feedPlans) { %>
                            <div class="col-lg-4 col-md-6">
                                <div class="single-service"
                                     style="background:#ffffff;
                                            padding:25px;
                                            border-radius:12px;
                                            margin-bottom:30px;
                                            box-shadow:0 8px 25px rgba(0,0,0,0.25);">

                                    <h5 style="font-weight:700; margin-bottom:15px;">
                                        <%= plan.getTitle() %>
                                    </h5>

                                    <p style="font-size:14px; color:#444;">
                                        <strong>Price:</strong> $<%= plan.getPrice() %><br>
                                        <strong>Duration:</strong> <%= plan.getDurationDays() %> days<br>
                                        <strong>Difficulty:</strong> <%= plan.getDifficultyLevel() %><br>
                                        <strong>Category:</strong> <%= plan.getCategory() %>
                                    </p>

                                    <a href="planDetails.jsp?id=<%= plan.getId() %>"
                                       style="display:block;
                                              text-align:center;
                                              margin-top:15px;
                                              padding:12px;
                                              background:#f36100;
                                              color:#fff;
                                              font-weight:700;
                                              border-radius:6px;
                                              text-decoration:none;">
                                        View Details
                                    </a>
                                </div>
                            </div>
                            <% } %>
                        </div>

                    <% } %>
                <% } %>

            </div>
        </div>
    </div>
</section>
<!-- Feed Section End -->
    
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