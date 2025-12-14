package dao;

import java.util.List;
import pojo.Subscription;

public interface SubscriptionDao {
    boolean addSubscription(Subscription s);
    boolean updateSubscription(Subscription s);
    boolean deleteSubscription(int id);
    Subscription searchSubscription(int id);
    List<Subscription> getSubscriptionsByUser(int userId);
    List<Subscription> getSubscriptionsByPlan(int planId);
    Subscription getSubscriptionByUserAndPlan(int userId, int planId);
    boolean isUserSubscribedToPlan(int userId, int planId);
}