-- FitPlanHub Database Schema
-- Database: fitplanhub

-- Create database
CREATE DATABASE IF NOT EXISTS fitplanhub;
USE fitplanhub;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    height DECIMAL(5,2),
    weight DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Trainers table
CREATE TABLE trainers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    certification VARCHAR(100),
    experience_years INT,
    specialization VARCHAR(100),
    bio TEXT,
    profile_image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Fitness plans table
CREATE TABLE fitness_plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trainer_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    duration_days INT NOT NULL,
    difficulty_level ENUM('Beginner', 'Intermediate', 'Advanced') NOT NULL,
    category VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (trainer_id) REFERENCES trainers(id) ON DELETE CASCADE
);

-- Subscriptions table
CREATE TABLE subscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    plan_id INT NOT NULL,
    subscription_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    payment_status ENUM('Pending', 'Completed', 'Failed', 'Refunded') DEFAULT 'Pending',
    amount_paid DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES fitness_plans(id) ON DELETE CASCADE
);

-- Following table (users following trainers)
CREATE TABLE following (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    trainer_id INT NOT NULL,
    followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (trainer_id) REFERENCES trainers(id) ON DELETE CASCADE,
    UNIQUE KEY unique_following (user_id, trainer_id)
);

-- Insert sample data for testing
-- Sample users
INSERT INTO users (username, email, password_hash, first_name, last_name, date_of_birth, gender, height, weight) VALUES
('john_doe', 'john@example.com', 'hashed_password_1', 'John', 'Doe', '1990-05-15', 'Male', 175.5, 70.2),
('jane_smith', 'jane@example.com', 'hashed_password_2', 'Jane', 'Smith', '1992-08-22', 'Female', 165.0, 55.8);

-- Sample trainers
INSERT INTO trainers (username, email, password_hash, first_name, last_name, certification, experience_years, specialization, bio) VALUES
('mike_fitness', 'mike@fitness.com', 'hashed_password_3', 'Mike', 'Johnson', 'Certified Personal Trainer', 5, 'Weight Loss', 'Professional fitness trainer with 5 years of experience specializing in weight loss programs.'),
('sarah_yoga', 'sarah@yoga.com', 'hashed_password_4', 'Sarah', 'Williams', 'Yoga Instructor Certification', 3, 'Yoga', 'Certified yoga instructor focusing on mindfulness and flexibility.');

-- Sample fitness plans
INSERT INTO fitness_plans (trainer_id, title, description, price, duration_days, difficulty_level, category) VALUES
(1, '30-Day Weight Loss Challenge', 'Intensive program designed to help you lose weight and build healthy habits.', 49.99, 30, 'Intermediate', 'Weight Loss'),
(1, 'Beginner Strength Training', 'Perfect for newcomers to strength training with progressive workouts.', 29.99, 60, 'Beginner', 'Strength'),
(2, 'Morning Yoga Flow', 'Start your day with energizing yoga sequences to improve flexibility and focus.', 39.99, 30, 'Beginner', 'Yoga');

-- Sample subscriptions
INSERT INTO subscriptions (user_id, plan_id, subscription_date, expiry_date, payment_status, amount_paid) VALUES
(1, 1, '2023-01-01', '2023-01-31', 'Completed', 49.99),
(2, 3, '2023-01-15', '2023-02-14', 'Completed', 39.99);

-- Sample following relationships
INSERT INTO following (user_id, trainer_id) VALUES
(1, 1),
(1, 2),
(2, 2);