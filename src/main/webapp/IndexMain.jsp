<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pojo.User, pojo.Trainer" %>
<%
    // Check user session
    User user = (User) session.getAttribute("user");
    Trainer trainer = (Trainer) session.getAttribute("trainer");
    
    // Determine if user is logged in
    boolean isLoggedIn = (user != null || trainer != null);
    String userRole = "";
    if (user != null) {
        userRole = "user";
    } else if (trainer != null) {
        userRole = "trainer";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="FitPlanHub - Fitness Plans Platform">
    <meta name="keywords" content="FitPlanHub, fitness, trainers, workout plans">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>FitPlanHub | Fitness Plans Platform</title>

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
                                <% if (isLoggedIn) { %>
                                    <% if ("user".equals(userRole)) { %>
                                        <li><a href="./userhome.jsp">My Dashboard</a></li>
                                        <li><a href="./feed.jsp">My Feed</a></li>
                                    <% } else if ("trainer".equals(userRole)) { %>
                                        <li><a href="./trainerhome.jsp">My Dashboard</a></li>
                                        <li><a href="./createplan.jsp">Create Plan</a></li>
                                    <% } %>
                                    <li><a href="./logout.jsp">Logout</a></li>
                                <% } else { %>
                                    <li><a href="./login.jsp">Login</a></li>
                                    <li><a href="./register.jsp">Register</a></li>
                                <% } %>
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
    <!-- Top Social Begin -->
    <div class="top-social">
        <div class="top-social-links">
            <ul>
                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                <li><a href="#"><i class="fa fa-youtube"></i></a></li>
            </ul>
        </div>
    </div>
    <!-- Top Social End -->
    <!-- Hero Slider Section Begin -->
    <section class="hero-slider">
        <div class="slide-items owl-carousel">
            <div class="single-slide set-bg active" data-setbg="img/bg.jpg">
                <a href="https://www.youtube.com/watch?v=SEVuD_djKrU" class="play-btn pop-up"><i class="fa fa-play"></i></a>
                <h1>Transform Your Body With FitPlanHub</h1>
                <% if (!isLoggedIn) { %>
                    <a href="./register.jsp" class="primary-btn">Join Now</a>
                <% } else { %>
                    <a href="<%= "user".equals(userRole) ? "./userhome.jsp" : "./trainerhome.jsp" %>" class="primary-btn">My Dashboard</a>
                <% } %>
            </div>
            <div class="single-slide set-bg" data-setbg="img/bg-2.jpg">
                <a href="https://www.youtube.com/watch?v=SEVuD_djKrU" class="play-btn pop-up"><i class="fa fa-play"></i></a>
                <h1>Expert Trainers, Proven Results</h1>
                <% if (!isLoggedIn) { %>
                    <a href="./register.jsp" class="primary-btn">Get Started</a>
                <% } else { %>
                    <a href="<%= "user".equals(userRole) ? "./feed.jsp" : "./trainerhome.jsp" %>" class="primary-btn">View Plans</a>
                <% } %>
            </div>
            <div class="single-slide set-bg" data-setbg="img/bg-3.jpg">
                <a href="https://www.youtube.com/watch?v=SEVuD_djKrU" class="play-btn pop-up"><i class="fa fa-play"></i></a>
                <h1>Personalized Fitness Plans</h1>
                <% if (!isLoggedIn) { %>
                    <a href="./register.jsp" class="primary-btn">Create Account</a>
                <% } else { %>
                    <a href="<%= "user".equals(userRole) ? "./userhome.jsp" : "./createplan.jsp" %>" class="primary-btn">Create Plan</a>
                <% } %>
            </div>
        </div>
    </section>
    <!-- Hero Slider End -->
    <!-- Features Section Begin -->
    <section class="features-section spad">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="single-features">
                        <div class="features-img">
                            <img src="img/features/feature-1.jpg" alt="Personalized Plans">
                        </div>
                        <div class="feature-text">
                            <div class="feature-icon">
                                <img src="img/features/icon-1.png" alt="Icon">
                            </div>
                            <h5>Personalized Plans</h5>
                            <p>Get customized fitness plans designed by certified trainers based on your goals and fitness level.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="single-features">
                        <div class="features-img">
                            <img src="img/features/feature-2.jpg" alt="Expert Trainers">
                        </div>
                        <div class="feature-text">
                            <div class="feature-icon">
                                <img src="img/features/icon-2.png" alt="Icon">
                            </div>
                            <h5>Expert Trainers</h5>
                            <p>Work with certified fitness professionals who create effective workout routines tailored to you.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="single-features">
                        <div class="features-img">
                            <img src="img/features/feature-3.jpg" alt="Progress Tracking">
                        </div>
                        <div class="feature-text">
                            <div class="feature-icon">
                                <img src="img/features/icon-3.png" alt="Icon">
                            </div>
                            <h5>Progress Tracking</h5>
                            <p>Monitor your fitness journey with detailed progress reports and achievement milestones.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Features Section End -->
    <!-- Services Section Begin -->
    <section class="services-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="section-title">
                        <span>Fitness Categories</span>
                        <h2>Our Services</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-sm-6">
                    <div class="single-service">
                        <img src="img/icon-1.png" alt="Pilates">
                        <h5>Weight Loss</h5>
                        <p>Scientifically designed programs to help you shed pounds and maintain healthy weight loss.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="single-service c-text">
                        <img src="img/icon-2.png" alt="Strength Training">
                        <h5>Muscle Building</h5>
                        <p>Targeted workouts focused on hypertrophy and strength gains for body transformation.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="single-service">
                        <img src="img/icon-3.png" alt="Yoga">
                        <h5>Flexibility & Mobility</h5>
                        <p>Improve range of motion and reduce injury risk with our flexibility programs.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="single-service">
                        <img src="img/icon-4.png" alt="Cardio">
                        <h5>Cardiovascular Health</h5>
                        <p>Boost heart health and endurance with our specialized cardio training programs.</p>
                    </div>
                </div>
            </div>
            <div class="row p-70">
                <div class="col-lg-12 text-center">
                    <% if (!isLoggedIn) { %>
                        <a href="./register.jsp" class="service-btn primary-btn">Join FitPlanHub Today</a>
                    <% } else { %>
                        <a href="<%= "user".equals(userRole) ? "./userhome.jsp" : "./trainerhome.jsp" %>" class="service-btn primary-btn">Browse All Plans</a>
                    <% } %>
                </div>
            </div>
        </div>
    </section>
    <!-- Services Section End -->
    <!-- Trainer Section Begin -->
    <section class="trainer-section set-bg" data-setbg="img/trainer-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="section-title">
                        <span>Meet Our</span>
                        <h2>Expert Trainers</h2>
                        <a href="./userhome.jsp" class="primary-btn trainer-btn">View All Trainers</a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="single-trainer">
                        <div class="trainer-img">
                            <img src="img/trainer/trainer-1.jpg" alt="Rachel Smith">
                            <div class="img-hover">
                                <a href="#"><i class="fa fa-plus"></i></a>
                            </div>
                        </div>
                        <div class="trainer-text">
                            <h5>Rachel Smith <span>Certified Fitness Trainer</span></h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="single-trainer">
                        <div class="trainer-img">
                            <img src="img/trainer/trainer-2.jpg" alt="Michael Williams">
                            <div class="img-hover">
                                <a href="#"><i class="fa fa-plus"></i></a>
                            </div>
                        </div>
                        <div class="trainer-text">
                            <h5>Michael Williams <span>Nutrition Specialist</span></h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="single-trainer">
                        <div class="trainer-img">
                            <img src="img/trainer/trainer-3.jpg" alt="James Brown">
                            <div class="img-hover">
                                <a href="#"><i class="fa fa-plus"></i></a>
                            </div>
                        </div>
                        <div class="trainer-text">
                            <h5>James Brown <span>Strength Coach</span></h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Trainer Section End -->
    <!-- Upcoming Event Begin -->
    <section class="upcoming-event-section spad-2">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="upcoming-classes">
                        <div class="up-title">
                            <span>Popular</span>
                            <h5>Fitness Plans</h5>
                        </div>
                        <ul class="classes-time">
                            <li><img src="img/stopwatch.png" alt=""> Fat Loss Beginner <span>30 Days</span></li>
                            <li><img src="img/stopwatch.png" alt=""> Muscle Building Pro <span>60 Days</span></li>
                            <li><img src="img/stopwatch.png" alt=""> Yoga for Flexibility <span>45 Days</span></li>
                            <li><img src="img/stopwatch.png" alt=""> Cardio Blast <span>30 Days</span></li>
                            <li><img src="img/stopwatch.png" alt=""> Strength Foundation <span>45 Days</span></li>
                            <li><img src="img/stopwatch.png" alt=""> HIIT Challenge <span>30 Days</span></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="membership-card set-bg" data-setbg="img/m-card.jpg">
                        <div class="membership-details">
                            <div class="up-title">
                                <span>Limited Time</span>
                                <h5>Special Offer</h5>
                            </div>
                            <div class="discount">
                                <h1>20% <span>Off</span></h1>
                                <p>On annual subscription</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-12">
                    <div class="member-sign-up set-bg" data-setbg="img/signup-bg.jpg">
                        <div class="up-title">
                            <span>Start Your</span>
                            <h5>Fitness Journey</h5>
                        </div>
                        <p>Join thousands of satisfied users who have transformed their bodies with our expert-designed fitness plans.</p>
                        <div class="member-signup-btn">
                            <% if (!isLoggedIn) { %>
                                <a href="./register.jsp" class="primary-btn">Sign Up Now</a>
                            <% } else { %>
                                <a href="<%= "user".equals(userRole) ? "./userhome.jsp" : "./createplan.jsp" %>" class="primary-btn">Get Started</a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Upcoming Event End -->
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