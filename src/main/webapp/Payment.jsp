<%@ page import="pojo.User, pojo.FitnessPlan, daoimpl.FitnessPlanDaoImpl" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int planId = Integer.parseInt(request.getParameter("planId"));
    FitnessPlanDaoImpl planDao = new FitnessPlanDaoImpl();
    FitnessPlan plan = planDao.searchFitnessPlan(planId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Demo Payment - FitPlanHub</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body style="margin:0; font-family:Arial, sans-serif;
             background:linear-gradient(135deg,#111,#1c1c1c);
             min-height:100vh; display:flex; align-items:center;">

    <div style="max-width:420px; margin:auto; background:#ffffff;
                padding:35px 30px; border-radius:14px;
                box-shadow:0 12px 35px rgba(0,0,0,0.35);
                width:100%;">

        <h2 style="text-align:center; margin-bottom:10px; font-weight:700;">
            Payment Gateway
        </h2>

        <p style="text-align:center; font-size:14px; color:#777;
                  margin-bottom:25px;">
            
        </p>

        <div style="border:1px solid #eee; border-radius:8px;
                    padding:15px; margin-bottom:25px;
                    background:#f9f9f9;">

            <p style="margin:8px 0; font-size:14px;">
                <strong>Plan:</strong> <%= plan.getTitle() %>
            </p>
            <p style="margin:8px 0; font-size:14px;">
                <strong>Amount:</strong>
                <span style="color:#f36100; font-weight:700;">
                    ₹<%= plan.getPrice() %>
                </span>
            </p>
        </div>

        <form action="subscribe.jsp" method="post">
            <input type="hidden" name="planId" value="<%= plan.getId() %>">
            <input type="hidden" name="amount" value="<%= plan.getPrice()+"$"%>">

            <button type="submit"
                style="width:100%; height:50px;
                       background:#f36100;
                       border:none; border-radius:8px;
                       color:#ffffff;
                       font-weight:700;
                       font-size:15px;
                       cursor:pointer;">
                Pay Now 
            </button>
        </form>

        <p style="text-align:center; margin-top:20px;
                  font-size:12px; color:#999;">
            .
        </p>

    </div>

</body>
</html>
