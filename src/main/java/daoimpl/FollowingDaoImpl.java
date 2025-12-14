package daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.FollowingDao;
import pojo.Following;
import util.DBConnection;

public class FollowingDaoImpl implements FollowingDao {
    
    @Override
    public boolean followTrainer(Following f) {
        String sql = "INSERT INTO following (user_id, trainer_id, followed_at) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, f.getUserId());
            stmt.setInt(2, f.getTrainerId());
            stmt.setString(3, f.getFollowedAt());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean unfollowTrainer(int userId, int trainerId) {
        String sql = "DELETE FROM following WHERE user_id=? AND trainer_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, trainerId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean isFollowing(int userId, int trainerId) {
        String sql = "SELECT COUNT(*) FROM following WHERE user_id=? AND trainer_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, trainerId);
            
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
    public List<Following> getFollowingByUser(int userId) {
        List<Following> followingList = new ArrayList<>();
        String sql = "SELECT * FROM following WHERE user_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Following following = new Following();
                    following.setId(rs.getInt("id"));
                    following.setUserId(rs.getInt("user_id"));
                    following.setTrainerId(rs.getInt("trainer_id"));
                    following.setFollowedAt(rs.getString("followed_at"));
                    followingList.add(following);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return followingList;
    }
    
    @Override
    public List<Following> getFollowersOfTrainer(int trainerId) {
        List<Following> followersList = new ArrayList<>();
        String sql = "SELECT * FROM following WHERE trainer_id=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, trainerId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Following following = new Following();
                    following.setId(rs.getInt("id"));
                    following.setUserId(rs.getInt("user_id"));
                    following.setTrainerId(rs.getInt("trainer_id"));
                    following.setFollowedAt(rs.getString("followed_at"));
                    followersList.add(following);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return followersList;
    }
}