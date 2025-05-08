package com.example.demo.service;

import com.example.demo.models.User;
import com.example.demo.utils.FileHandler;

import java.util.ArrayList;
import java.util.List;

public class UserManager {
    private String role;
    private String filePath;

    // Constructor to initialize role and file path based on the role
    public UserManager(String role) {
        this.role = role;
        this.filePath = FileHandler.getFilePathByRole(role);
    }

    // CREATE - Adds a new user to the file
    public boolean addUser(User user) {
        String data = user.getEmail() + "," + user.getPassword() + "," + user.getRole() + "\n";
        return FileHandler.writeToFile(filePath, true, data);
    }

    // READ - Gets a list of all users from the file
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String[] lines = FileHandler.readFromFile(filePath);
        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length == 3) {
                users.add(new User(parts[0], parts[1], parts[2]));
            }
        }
        return users;
    }

    // FIND user by email
    public User findUserByEmail(String email) {
        for (User user : getAllUsers()) {
            if (user.getEmail().equalsIgnoreCase(email)) {
                return user;
            }
        }
        return null;
    }

    // CHECK if email already exists
    public boolean emailExists(String email) {
        return findUserByEmail(email) != null;
    }

    // UPDATE user email and password
    public boolean updateUser(String currentEmail, String newEmail, String newPassword) {
        return FileHandler.updateCredentials(currentEmail, newEmail, newPassword, role);
    }

    // DELETE user by email
    public boolean deleteUserByEmail(String email) {
        return FileHandler.deleteUserByEmail(email);
    }

    // Static convenience method
    public static User findUserByEmail(String email, String role) {
        UserManager userManager = new UserManager(role);
        return userManager.findUserByEmail(email);
    }
}
