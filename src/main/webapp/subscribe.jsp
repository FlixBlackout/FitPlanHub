<%@ page import="java.sql.Timestamp" %>
<%@ page import="pojo.*, daoimpl.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int planId = Integer.parseInt(request.getParameter("planId"));
    double amount = Double.parseDouble(request.getParameter("amount"));

    SubscriptionDaoImpl dao = new SubscriptionDaoImpl();

    if (dao.isUserSubscribedToPlan(user.getId(), planId)) {
        response.sendRedirect("userhome.jsp?msg=Already subscribed");
        return;
    }

    FitnessPlanDaoImpl planDao = new FitnessPlanDaoImpl();
    FitnessPlan plan = planDao.searchFitnessPlan(planId);

    Subscription s = new Subscription();
    s.setUserId(user.getId());
    s.setPlanId(planId);
    s.setSubscriptionDate(new Timestamp(System.currentTimeMillis()).toString());

    long expiry = System.currentTimeMillis()
            + plan.getDurationDays() * 24L * 60 * 60 * 1000;
    s.setExpiryDate(new Timestamp(expiry).toString());

    s.setActive(true);
    s.setPaymentStatus("Completed");
    s.setAmountPaid(amount);

    if (dao.addSubscription(s)) {
        response.sendRedirect("userhome.jsp?msg=Subscription successful");
    } else {
        response.sendRedirect("userhome.jsp?msg=Subscription failed");
    }
%>
