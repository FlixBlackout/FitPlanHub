package dao;

import java.util.List;
import pojo.Following;

public interface FollowingDao {
    boolean followTrainer(Following f);
    boolean unfollowTrainer(int userId, int trainerId);
    boolean isFollowing(int userId, int trainerId);
    List<Following> getFollowingByUser(int userId);
    List<Following> getFollowersOfTrainer(int trainerId);
}