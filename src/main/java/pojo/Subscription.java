package pojo;

public class Subscription {
    private int id;
    private int userId;
    private int planId;
    private String subscriptionDate;
    private String expiryDate;
    private boolean isActive;
    private String paymentStatus;
    private double amountPaid;

    public Subscription() {
        super();
    }

    public Subscription(int id, int userId, int planId, String subscriptionDate, String expiryDate,
                        boolean isActive, String paymentStatus, double amountPaid) {
        super();
        this.id = id;
        this.userId = userId;
        this.planId = planId;
        this.subscriptionDate = subscriptionDate;
        this.expiryDate = expiryDate;
        this.isActive = isActive;
        this.paymentStatus = paymentStatus;
        this.amountPaid = amountPaid;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPlanId() {
        return planId;
    }

    public void setPlanId(int planId) {
        this.planId = planId;
    }

    public String getSubscriptionDate() {
        return subscriptionDate;
    }

    public void setSubscriptionDate(String subscriptionDate) {
        this.subscriptionDate = subscriptionDate;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public double getAmountPaid() {
        return amountPaid;
    }

    public void setAmountPaid(double amountPaid) {
        this.amountPaid = amountPaid;
    }
}