package pojo;

public class Following {
    private int id;
    private int userId;
    private int trainerId;
    private String followedAt;

    public Following() {
        super();
    }

    public Following(int id, int userId, int trainerId, String followedAt) {
        super();
        this.id = id;
        this.userId = userId;
        this.trainerId = trainerId;
        this.followedAt = followedAt;
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

    public int getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(int trainerId) {
        this.trainerId = trainerId;
    }

    public String getFollowedAt() {
        return followedAt;
    }

    public void setFollowedAt(String followedAt) {
        this.followedAt = followedAt;
    }
}