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
└── README.md
```

## Database Schema

The application uses a MySQL database with the following tables:
- `users` - Stores user information
- `trainers` - Stores trainer information
- `fitness_plans` - Stores fitness plans created by trainers
- `subscriptions` - Tracks user subscriptions to fitness plans
- `following` - Tracks user-followed trainer relationships

## Setup Instructions

1. Clone the repository
2. Set up MySQL database
3. Configure database connection in `src/main/java/util/DBConnection.java`
4. Deploy to a servlet container (Apache Tomcat, Jetty, etc.)

## Contributing

Contributions are welcome! Please fork the repository and submit pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

[FlixBlackout](https://github.com/FlixBlackout)