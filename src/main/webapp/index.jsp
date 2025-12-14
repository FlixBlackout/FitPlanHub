<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Redirect to the main index page with the new template
    response.sendRedirect("IndexMain.jsp");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FitPlanHub - Fitness Plans Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="#">FitPlanHub</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="login.jsp">Login</a>
            <a class="nav-link" href="register.jsp">Register</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="jumbotron">
        <h1 class="display-4">Welcome to FitPlanHub</h1>
        <p class="lead">Connect with certified trainers and discover personalized fitness plans tailored to your goals.</p>
        <hr class="my-4">
        <p>Whether you're looking to lose weight, build muscle, or improve your overall fitness, FitPlanHub has the perfect plan for you.</p>
        <a class="btn btn-primary btn-lg" href="register.jsp" role="button">Get Started</a>
    </div>
    
    <div class="row mt-5">
        <div class="col-md-4">
            <h3>For Users</h3>
            <p>Discover and subscribe to fitness plans created by certified trainers. Track your progress and achieve your fitness goals.</p>
        </div>
        <div class="col-md-4">
            <h3>For Trainers</h3>
            <p>Create and manage your fitness plans. Build your client base and help people achieve their fitness goals.</p>
        </div>
        <div class="col-md-4">
            <h3>Personalized Experience</h3>
            <p>Follow your favorite trainers and get personalized recommendations based on your interests and goals.</p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>