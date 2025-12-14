# FitPlanHub - Fitness Plans Platform

FitPlanHub is a comprehensive web application that connects fitness enthusiasts with certified trainers. The platform allows trainers to create and manage fitness plans, while users can browse, subscribe to, and follow their favorite trainers.

## Features

### User Roles
- **Fitness Enthusiasts**: Browse fitness plans, subscribe to plans, and follow trainers
- **Certified Trainers**: Create and manage fitness plans, build a client base

### Core Functionality
- User and trainer authentication (registration/login)
- Fitness plan creation and management
- Subscription system for accessing premium content
- Follow/unfollow trainers
- Personalized feed based on subscriptions and followed trainers
- Profile management

## Technology Stack

### Backend
- Java Servlets
- JSP (JavaServer Pages)
- MySQL Database
- JDBC for database connectivity

### Frontend
- HTML5, CSS3, JavaScript
- Bootstrap for responsive design
- Custom fitness-themed template

## Project Structure
```
FitHub/
├── src/main/java/
│   ├── controller/     # Servlet controllers
│   ├── dao/           # Data Access Objects interfaces
│   ├── daoimpl/       # Data Access Objects implementations
│   ├── pojo/          # Plain Old Java Objects (data models)
│   └── util/          # Utility classes
├── src/main/webapp/
│   ├── css/           # Stylesheets
│   ├── js/            # JavaScript files
│   ├── img/           # Images
│   └── *.jsp          # JSP pages
├── database_schema.sql # Database schema and sample data
└── README.md
```

## Database Schema

The application uses a MySQL database with the following tables:

### Users Table
Stores user information for fitness enthusiasts:
- `id` - Unique identifier
- `username` - Unique username
- `email` - Unique email address
- `password_hash` - Hashed password
- `first_name`, `last_name` - User's name
- `date_of_birth` - User's date of birth
- `gender` - Gender (Male/Female/Other)
- `height`, `weight` - Physical measurements

### Trainers Table
Stores information for certified fitness trainers:
- `id` - Unique identifier
- `username` - Unique username
- `email` - Unique email address
- `password_hash` - Hashed password
- `first_name`, `last_name` - Trainer's name
- `certification` - Trainer's certifications
- `experience_years` - Years of experience
- `specialization` - Area of expertise
- `bio` - Biography
- `profile_image_url` - Link to profile image

### Fitness Plans Table
Stores fitness plans created by trainers:
- `id` - Unique identifier
- `trainer_id` - Foreign key to trainers table
- `title` - Plan title
- `description` - Detailed description
- `price` - Cost to subscribe
- `duration_days` - Plan duration in days
- `difficulty_level` - Difficulty (Beginner/Intermediate/Advanced)
- `category` - Type of fitness plan
- `is_active` - Whether the plan is available

### Subscriptions Table
Tracks user subscriptions to fitness plans:
- `id` - Unique identifier
- `user_id` - Foreign key to users table
- `plan_id` - Foreign key to fitness_plans table
- `subscription_date` - Date subscription started
- `expiry_date` - Date subscription expires
- `is_active` - Whether subscription is active
- `payment_status` - Status of payment
- `amount_paid` - Amount paid for subscription

### Following Table
Tracks which trainers users are following:
- `id` - Unique identifier
- `user_id` - Foreign key to users table
- `trainer_id` - Foreign key to trainers table
- `followed_at` - Timestamp when followed

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/FlixBlackout/FitPlanHub.git
   cd FitPlanHub
   ```

2. **Set up MySQL database**
   - Install MySQL Server (version 5.7 or higher)
   - Create a database user with appropriate permissions
   - Execute the database schema:
     ```sql
     mysql -u root -p < database_schema.sql
     ```

3. **Configure database connection**
   - Open `src/main/java/util/DBConnection.java`
   - Update the database credentials if needed:
     ```java
     private static final String URL = "jdbc:mysql://localhost:3306/fitplanhub";
     private static final String USERNAME = "root";
     private static final String PASSWORD = "your_password";
     ```

4. **Add MySQL JDBC Driver**
   - Download MySQL Connector/J (version 8.0 or higher)
   - Add the JAR file to your project's classpath or WEB-INF/lib folder

5. **Deploy to a servlet container**
   - Package the project as a WAR file or deploy directly to Apache Tomcat (version 9.0 or higher)
   - Start the Tomcat server
   - Access the application at `http://localhost:8080/FitHub`

## Running the Application

1. **Prerequisites**
   - Java JDK 8 or higher
   - Apache Tomcat 9.0 or higher
   - MySQL Server 5.7 or higher
   - MySQL Connector/J JDBC driver

2. **Database Setup**
   ```bash
   # Connect to MySQL
   mysql -u root -p
   
   # Create and populate the database
   source database_schema.sql
   ```

3. **Application Deployment**
   - Build the project using your preferred IDE or build tool
   - Deploy the generated WAR file to Tomcat's webapps directory
   - Start Tomcat server
   - Navigate to `http://localhost:8080/FitHub` in your browser

4. **Default Test Accounts**
   - User Account:
     - Email: john@example.com
     - Password: (Use the hash stored in DB)
   - Trainer Account:
     - Email: mike@fitness.com
     - Password: (Use the hash stored in DB)

## Contributing

Contributions are welcome! Please fork the repository and submit pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

[FlixBlackout](https://github.com/FlixBlackout)