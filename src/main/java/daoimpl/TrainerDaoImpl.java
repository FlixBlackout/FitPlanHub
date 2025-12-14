package daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.TrainerDao;
import pojo.Trainer;
import util.DBConnection;

public class TrainerDaoImpl implements TrainerDao {
    
    @Override
    public boolean addTrainer(Trainer t) {
        String sql = "INSERT INTO trainers (username, email, password_hash, first_name, last_name, certification, experience_years, specialization, bio, profile_image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, t.getUsername());
            stmt.setString(2, t.getEmail());
            stmt.setString(3, t.getPasswordHash());
            stmt.setString(4, t.getFirstName());
            stmt.setString(5, t.getLastName());
            stmt.setString(6, t.getCertification());
            stmt.setInt(7, t.getExperienceYears());
            stmt.setString(8, t.getSpecialization());
            stmt.setString(9, t.getBio());
            stmt.setString(10, t.getProfileImageUrl());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean updateTrainer(Trainer t) {
        String sql = "UPDATE trainers SET username=?, email=?, password_hash=?, first_name=?, last_name=?, certification=?, experience_years=?, specialization=?, bio=?, profile_image_url=? WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, t.getUsername());
            stmt.setString(2, t.getEmail());
            stmt.setString(3, t.getPasswordHash());
            stmt.setString(4, t.getFirstName());
            stmt.setString(5, t.getLastName());
            stmt.setString(6, t.getCertification());
            stmt.setInt(7, t.getExperienceYears());
            stmt.setString(8, t.getSpecialization());
            stmt.setString(9, t.getBio());
            stmt.setString(10, t.getProfileImageUrl());
            stmt.setInt(11, t.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean deleteTrainer(int id) {
        String sql = "DELETE FROM trainers WHERE id=?";
        
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
    public Trainer searchTrainer(int id) {
        String sql = "SELECT * FROM trainers WHERE id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Trainer trainer = new Trainer();
                    trainer.setId(rs.getInt("id"));
                    trainer.setUsername(rs.getString("username"));
                    trainer.setEmail(rs.getString("email"));
                    trainer.setPasswordHash(rs.getString("password_hash"));
                    trainer.setFirstName(rs.getString("first_name"));
                    trainer.setLastName(rs.getString("last_name"));
                    trainer.setCertification(rs.getString("certification"));
                    trainer.setExperienceYears(rs.getInt("experience_years"));
                    trainer.setSpecialization(rs.getString("specialization"));
                    trainer.setBio(rs.getString("bio"));
                    trainer.setProfileImageUrl(rs.getString("profile_image_url"));
                    return trainer;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public Trainer searchTrainerByEmail(String email) {
        String sql = "SELECT * FROM trainers WHERE email=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Trainer trainer = new Trainer();
                    trainer.setId(rs.getInt("id"));
                    trainer.setUsername(rs.getString("username"));
                    trainer.setEmail(rs.getString("email"));
                    trainer.setPasswordHash(rs.getString("password_hash"));
                    trainer.setFirstName(rs.getString("first_name"));
                    trainer.setLastName(rs.getString("last_name"));
                    trainer.setCertification(rs.getString("certification"));
                    trainer.setExperienceYears(rs.getInt("experience_years"));
                    trainer.setSpecialization(rs.getString("specialization"));
                    trainer.setBio(rs.getString("bio"));
                    trainer.setProfileImageUrl(rs.getString("profile_image_url"));
                    return trainer;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public List<Trainer> getAllTrainers() {
        List<Trainer> trainers = new ArrayList<>();
        String sql = "SELECT * FROM trainers";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Trainer trainer = new Trainer();
                trainer.setId(rs.getInt("id"));
                trainer.setUsername(rs.getString("username"));
                trainer.setEmail(rs.getString("email"));
                trainer.setPasswordHash(rs.getString("password_hash"));
                trainer.setFirstName(rs.getString("first_name"));
                trainer.setLastName(rs.getString("last_name"));
                trainer.setCertification(rs.getString("certification"));
                trainer.setExperienceYears(rs.getInt("experience_years"));
                trainer.setSpecialization(rs.getString("specialization"));
                trainer.setBio(rs.getString("bio"));
                trainer.setProfileImageUrl(rs.getString("profile_image_url"));
                trainers.add(trainer);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return trainers;
    }
    
    @Override
    public boolean validateTrainer(String email, String password) {
        String sql = "SELECT COUNT(*) FROM trainers WHERE email=? AND password_hash=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, password); // In real app, this should compare hashed passwords
            
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
    
    @Override
    public Trainer getTrainerAfterValidation(String email, String password) {
        String sql = "SELECT * FROM trainers WHERE email=? AND password_hash=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            stmt.setString(2, password); // In real app, this should compare hashed passwords
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Trainer trainer = new Trainer();
                    trainer.setId(rs.getInt("id"));
                    trainer.setUsername(rs.getString("username"));
                    trainer.setEmail(rs.getString("email"));
                    trainer.setPasswordHash(rs.getString("password_hash"));
                    trainer.setFirstName(rs.getString("first_name"));
                    trainer.setLastName(rs.getString("last_name"));
                    trainer.setCertification(rs.getString("certification"));
                    trainer.setExperienceYears(rs.getInt("experience_years"));
                    trainer.setSpecialization(rs.getString("specialization"));
                    trainer.setBio(rs.getString("bio"));
                    trainer.setProfileImageUrl(rs.getString("profile_image_url"));
                    return trainer;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}