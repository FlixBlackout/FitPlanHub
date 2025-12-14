package dao;

import java.util.List;
import pojo.Trainer;

public interface TrainerDao {
    boolean addTrainer(Trainer t);
    boolean updateTrainer(Trainer t);
    boolean deleteTrainer(int id);
    Trainer searchTrainer(int id);
    Trainer searchTrainerByEmail(String email);
    List<Trainer> getAllTrainers();
    boolean validateTrainer(String email, String password);
    Trainer getTrainerAfterValidation(String email, String password);
}