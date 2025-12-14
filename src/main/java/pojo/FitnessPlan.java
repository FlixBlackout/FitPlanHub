package pojo;

public class FitnessPlan {
    private int id;
    private int trainerId;
    private String title;
    private String description;
    private double price;
    private int durationDays;
    private String difficultyLevel;
    private String category;
    private boolean isActive;

    public FitnessPlan() {
        super();
    }

    public FitnessPlan(int id, int trainerId, String title, String description, double price,
                       int durationDays, String difficultyLevel, String category, boolean isActive) {
        super();
        this.id = id;
        this.trainerId = trainerId;
        this.title = title;
        this.description = description;
        this.price = price;
        this.durationDays = durationDays;
        this.difficultyLevel = difficultyLevel;
        this.category = category;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTrainerId() {
        return trainerId;
    }

    public void setTrainerId(int trainerId) {
        this.trainerId = trainerId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(int durationDays) {
        this.durationDays = durationDays;
    }

    public String getDifficultyLevel() {
        return difficultyLevel;
    }

    public void setDifficultyLevel(String difficultyLevel) {
        this.difficultyLevel = difficultyLevel;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}