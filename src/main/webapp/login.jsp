<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="FitPlanHub - Login">
    <meta name="keywords" content="FitPlanHub, fitness, login">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login - FitPlanHub</title>

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
                                <li><a href="./register.jsp">Register</a></li>
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
    
    <!-- Login Section Begin -->
<section class="contact-section spad"
    style="background: linear-gradient(135deg, #111111, #1c1c1c); min-height:100vh; padding:80px 0;">
    
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="section-title">
                    <span style="color:#f36100; letter-spacing:2px; font-size:14px;">
                        Welcome Back
                    </span>
                    <h2 style="color:#fff; font-weight:700; margin-top:10px;">
                        Login to FitPlanHub
                    </h2>
                </div>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="contact-form"
                     style="background:#fff; padding:40px 35px; border-radius:12px;
                            box-shadow:0 10px 30px rgba(0,0,0,0.3);">

                    <%
                        String msg = (String) request.getAttribute("msg");
                        if (msg != null) {
                    %>
                        <div class="alert alert-info text-center"
                             style="border-radius:6px; font-size:14px;">
                            <%= msg %>
                        </div>
                    <% } %>

                    <form action="LoginServlet" method="post">
                        <div class="row justify-content-center">

                            <div class="col-lg-12">
                                <label for="email" style="font-weight:600; color:#333;">
                                    Email Address
                                </label>
                                <input type="email" id="email" name="email" required
                                    placeholder="Enter your email"
                                    style="width:100%; height:50px; border:1px solid #ddd;
                                           border-radius:6px; padding:0 15px; margin-bottom:20px;">
                            </div>

                            <div class="col-lg-12">
                                <label for="password" style="font-weight:600; color:#333;">
                                    Password
                                </label>
                                <input type="password" id="password" name="password" required
                                    placeholder="Enter your password"
                                    style="width:100%; height:50px; border:1px solid #ddd;
                                           border-radius:6px; padding:0 15px; margin-bottom:20px;">
                            </div>

                            <div class="col-lg-12">
                                <label for="role" style="font-weight:600; color:#333;">
                                    Login As
                                </label>
                                <select id="role" name="role" required
                                    style="width:100%; height:50px; border:1px solid #ddd;
                                           border-radius:6px; padding:0 15px; margin-bottom:25px;">
                                    <option value="">-- Select Role --</option>
                                    <option value="user">Fitness Enthusiast</option>
                                    <option value="trainer">Fitness Trainer</option>
                                </select>
                            </div>

                            <div class="col-lg-12 text-center">
                                <button type="submit"
                                    style="width:100%; height:50px; background:#f36100;
                                           border:none; border-radius:6px; color:#fff;
                                           font-weight:700; text-transform:uppercase;
                                           cursor:pointer;">
                                    Login
                                </button>
                            </div>

                            <div class="col-lg-12 text-center">
                                <p style="margin-top:20px; font-size:14px; color:#555;">
                                    Don't have an account?
                                    <a href="./register.jsp"
                                       style="color:#f36100; font-weight:600; text-decoration:none;">
                                        Register here
                                    </a>
                                </p>
                            </div>

                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</section>
<!-- Login Section End -->
    
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