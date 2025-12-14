package daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.SubscriptionDao;
import pojo.Subscription;
import util.DBConnection;

public class SubscriptionDaoImpl implements SubscriptionDao {
    
    @Override
    public boolean addSubscription(Subscription s) {
        String sql = "INSERT INTO subscriptions (user_id, plan_id, subscription_date, expiry_date, is_active, payment_status, amount_paid) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, s.getUserId());
            stmt.setInt(2, s.getPlanId());
            stmt.setString(3, s.getSubscriptionDate());
            stmt.setString(4, s.getExpiryDate());
            stmt.setBoolean(5, s.isActive());
            stmt.setString(6, s.getPaymentStatus());
            stmt.setDouble(7, s.getAmountPaid());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean updateSubscription(Subscription s) {
        String sql = "UPDATE subscriptions SET user_id=?, plan_id=?, subscription_date=?, expiry_date=?, is_active=?, payment_status=?, amount_paid=? WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, s.getUserId());
            stmt.setInt(2, s.getPlanId());
            stmt.setString(3, s.getSubscriptionDate());
            stmt.setString(4, s.getExpiryDate());
            stmt.setBoolean(5, s.isActive());
            stmt.setString(6, s.getPaymentStatus());
            stmt.setDouble(7, s.getAmountPaid());
            stmt.setInt(8, s.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean deleteSubscription(int id) {
        String sql = "DELETE FROM subscriptions WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public Subscription searchSubscription(int id) {
        String sql = "SELECT * FROM subscriptions WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Subscription subscription = new Subscription();
                    subscription.setId(rs.getInt("id"));
                    subscription.setUserId(rs.getInt("user_id"));
                    subscription.setPlanId(rs.getInt("plan_id"));
                    subscription.setSubscriptionDate(rs.getString("subscription_date"));
                    subscription.setExpiryDate(rs.getString("expiry_date"));
                    subscription.setActive(rs.getBoolean("is_active"));
                    subscription.setPaymentStatus(rs.getString("payment_status"));
                    subscription.setAmountPaid(rs.getDouble("amount_paid"));
                    return subscription;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public List<Subscription> getSubscriptionsByUser(int userId) {
        List<Subscription> subscriptions = new ArrayList<>();
        String sql = "SELECT * FROM subscriptions WHERE user_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Subscription subscription = new Subscription();
                    subscription.setId(rs.getInt("id"));
                    subscription.setUserId(rs.getInt("user_id"));
                    subscription.setPlanId(rs.getInt("plan_id"));
                    subscription.setSubscriptionDate(rs.getString("subscription_date"));
                    subscription.setExpiryDate(rs.getString("expiry_date"));
                    subscription.setActive(rs.getBoolean("is_active"));
                    subscription.setPaymentStatus(rs.getString("payment_status"));
                    subscription.setAmountPaid(rs.getDouble("amount_paid"));
                    subscriptions.add(subscription);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return subscriptions;
    }
    
    @Override
    public List<Subscription> getSubscriptionsByPlan(int planId) {
        List<Subscription> subscriptions = new ArrayList<>();
        String sql = "SELECT * FROM subscriptions WHERE plan_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, planId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Subscription subscription = new Subscription();
                    subscription.setId(rs.getInt("id"));
                    subscription.setUserId(rs.getInt("user_id"));
                    subscription.setPlanId(rs.getInt("plan_id"));
                    subscription.setSubscriptionDate(rs.getString("subscription_date"));
                    subscription.setExpiryDate(rs.getString("expiry_date"));
                    subscription.setActive(rs.getBoolean("is_active"));
                    subscription.setPaymentStatus(rs.getString("payment_status"));
                    subscription.setAmountPaid(rs.getDouble("amount_paid"));
                    subscriptions.add(subscription);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return subscriptions;
    }
    
    @Override
    public Subscription getSubscriptionByUserAndPlan(int userId, int planId) {
        String sql = "SELECT * FROM subscriptions WHERE user_id=? AND plan_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, planId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Subscription subscription = new Subscription();
                    subscription.setId(rs.getInt("id"));
                    subscription.setUserId(rs.getInt("user_id"));
                    subscription.setPlanId(rs.getInt("plan_id"));
                    subscription.setSubscriptionDate(rs.getString("subscription_date"));
                    subscription.setExpiryDate(rs.getString("expiry_date"));
                    subscription.setActive(rs.getBoolean("is_active"));
                    subscription.setPaymentStatus(rs.getString("payment_status"));
                    subscription.setAmountPaid(rs.getDouble("amount_paid"));
                    return subscription;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public boolean isUserSubscribedToPlan(int userId, int planId) {
        String sql = "SELECT COUNT(*) FROM subscriptions WHERE user_id=? AND plan_id=? AND is_active=true";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, planId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
}