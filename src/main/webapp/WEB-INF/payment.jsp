<%@ page import="pojo.FitnessPlan" %>

<section style="min-height:100vh; background:#111; padding:80px 0;">
    <div style="max-width:500px; margin:auto; background:#fff;
                padding:30px; border-radius:12px; text-align:center;">

        <h2>Payment Gateway</h2>
        <p><strong>Plan:</strong> ${plan.title}</p>
        <p><strong>Amount:</strong> ₹${plan.price}</p>

        <form action="PaymentServlet" method="post">
            <input type="hidden" name="planId" value="${plan.id}">
            <input type="hidden" name="amount" value="${plan.price}">

            <button type="submit"
                style="width:100%; padding:12px;
                       background:#f36100; color:#fff;
                       border:none; border-radius:6px;
                       font-weight:700;">
                Pay Now (Demo)
            </button>
        </form>

        <p style="margin-top:15px; color:#777; font-size:13px;">
            * This is a demo payment. No real money involved.
        </p>
    </div>
</section>