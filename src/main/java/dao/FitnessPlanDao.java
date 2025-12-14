package dao;

import java.util.List;
import pojo.FitnessPlan;

public interface FitnessPlanDao {
    boolean addFitnessPlan(FitnessPlan fp);
    boolean updateFitnessPlan(FitnessPlan fp);
    boolean deleteFitnessPlan(int id);
    FitnessPlan searchFitnessPlan(int id);
    List<FitnessPlan> getAllFitnessPlans();
    List<FitnessPlan> getFitnessPlansByTrainer(int trainerId);
    List<FitnessPlan> getFitnessPlansByCategory(String category);
    List<FitnessPlan> getFitnessPlansByDifficulty(String difficulty);
}