package dao;

import java.util.List;
import pojo.User;

public interface UserDao {
    boolean addUser(User u);
    boolean updateUser(User u);
    boolean deleteUser(int id);
    User searchUser(int id);
    User searchUserByEmail(String email);
    List<User> getAllUsers();
    boolean validateUser(String email, String password);
    User getUserAfterValidation(String email, String password);
}