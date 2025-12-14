package daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.FitnessPlanDao;
import pojo.FitnessPlan;
import util.DBConnection;

public class FitnessPlanDaoImpl implements FitnessPlanDao {
    
    @Override
    public boolean addFitnessPlan(FitnessPlan fp) {
        String sql = "INSERT INTO fitness_plans (trainer_id, title, description, price, duration_days, difficulty_level, category, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, fp.getTrainerId());
            stmt.setString(2, fp.getTitle());
            stmt.setString(3, fp.getDescription());
            stmt.setDouble(4, fp.getPrice());
            stmt.setInt(5, fp.getDurationDays());
            stmt.setString(6, fp.getDifficultyLevel());
            stmt.setString(7, fp.getCategory());
            stmt.setBoolean(8, fp.isActive());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean updateFitnessPlan(FitnessPlan fp) {
        String sql = "UPDATE fitness_plans SET trainer_id=?, title=?, description=?, price=?, duration_days=?, difficulty_level=?, category=?, is_active=? WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, fp.getTrainerId());
            stmt.setString(2, fp.getTitle());
            stmt.setString(3, fp.getDescription());
            stmt.setDouble(4, fp.getPrice());
            stmt.setInt(5, fp.getDurationDays());
            stmt.setString(6, fp.getDifficultyLevel());
            stmt.setString(7, fp.getCategory());
            stmt.setBoolean(8, fp.isActive());
            stmt.setInt(9, fp.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean deleteFitnessPlan(int id) {
        String sql = "DELETE FROM fitness_plans WHERE id=?";
        
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
    public FitnessPlan searchFitnessPlan(int id) {
        String sql = "SELECT * FROM fitness_plans WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    FitnessPlan plan = new FitnessPlan();
                    plan.setId(rs.getInt("id"));
                    plan.setTrainerId(rs.getInt("trainer_id"));
                    plan.setTitle(rs.getString("title"));
                    plan.setDescription(rs.getString("description"));
                    plan.setPrice(rs.getDouble("price"));
                    plan.setDurationDays(rs.getInt("duration_days"));
                    plan.setDifficultyLevel(rs.getString("difficulty_level"));
                    plan.setCategory(rs.getString("category"));
                    plan.setActive(rs.getBoolean("is_active"));
                    return plan;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public List<FitnessPlan> getAllFitnessPlans() {
        List<FitnessPlan> plans = new ArrayList<>();
        String sql = "SELECT * FROM fitness_plans WHERE is_active=true";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                FitnessPlan plan = new FitnessPlan();
                plan.setId(rs.getInt("id"));
                plan.setTrainerId(rs.getInt("trainer_id"));
                plan.setTitle(rs.getString("title"));
                plan.setDescription(rs.getString("description"));
                plan.setPrice(rs.getDouble("price"));
                plan.setDurationDays(rs.getInt("duration_days"));
                plan.setDifficultyLevel(rs.getString("difficulty_level"));
                plan.setCategory(rs.getString("category"));
                plan.setActive(rs.getBoolean("is_active"));
                plans.add(plan);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return plans;
    }
    
    @Override
    public List<FitnessPlan> getFitnessPlansByTrainer(int trainerId) {
        List<FitnessPlan> plans = new ArrayList<>();
        String sql = "SELECT * FROM fitness_plans WHERE trainer_id=? AND is_active=true";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, trainerId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    FitnessPlan plan = new FitnessPlan();
                    plan.setId(rs.getInt("id"));
                    plan.setTrainerId(rs.getInt("trainer_id"));
                    plan.setTitle(rs.getString("title"));
                    plan.setDescription(rs.getString("description"));
                    plan.setPrice(rs.getDouble("price"));
                    plan.setDurationDays(rs.getInt("duration_days"));
                    plan.setDifficultyLevel(rs.getString("difficulty_level"));
                    plan.setCategory(rs.getString("category"));
                    plan.setActive(rs.getBoolean("is_active"));
                    plans.add(plan);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return plans;
    }
    
    @Override
    public List<FitnessPlan> getFitnessPlansByCategory(String category) {
        List<FitnessPlan> plans = new ArrayList<>();
        String sql = "SELECT * FROM fitness_plans WHERE category=? AND is_active=true";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    FitnessPlan plan = new FitnessPlan();
                    plan.setId(rs.getInt("id"));
                    plan.setTrainerId(rs.getInt("trainer_id"));
                    plan.setTitle(rs.getString("title"));
                    plan.setDescription(rs.getString("description"));
                    plan.setPrice(rs.getDouble("price"));
                    plan.setDurationDays(rs.getInt("duration_days"));
                    plan.setDifficultyLevel(rs.getString("difficulty_level"));
                    plan.setCategory(rs.getString("category"));
                    plan.setActive(rs.getBoolean("is_active"));
                    plans.add(plan);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return plans;
    }
    
    @Override
    public List<FitnessPlan> getFitnessPlansByDifficulty(String difficulty) {
        List<FitnessPlan> plans = new ArrayList<>();
        String sql = "SELECT * FROM fitness_plans WHERE difficulty_level=? AND is_active=true";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, difficulty);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    FitnessPlan plan = new FitnessPlan();
                    plan.setId(rs.getInt("id"));
                    plan.setTrainerId(rs.getInt("trainer_id"));
                    plan.setTitle(rs.getString("title"));
                    plan.setDescription(rs.getString("description"));
                    plan.setPrice(rs.getDouble("price"));
                    plan.setDurationDays(rs.getInt("duration_days"));
                    plan.setDifficultyLevel(rs.getString("difficulty_level"));
                    plan.setCategory(rs.getString("category"));
                    plan.setActive(rs.getBoolean("is_active"));
                    plans.add(plan);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return plans;
    }
}