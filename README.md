Online-College-Canteen
🍽️ The Online Canteen Ordering System is a web-based application designed to improve the food ordering experience within a college environment. It helps reduce crowding and wait times by allowing users to browse the menu and place orders directly from their devices.

🍴 Online College Canteen
📅 Duration: January 2025 – May 2025
🛠️ Technologies Used: JSP, Servlet, JDBC, Spring Boot, Spring Data JPA, MySQL, HTML, CSS

🏫 Industry
Education / Food-Tech

📌 Project Title
Online College Canteen Ordering System

❓ Problem Statement / Opportunity
Managing food orders in college canteens is often chaotic due to long queues, delayed service, and lack of transparency.
The opportunity lies in developing an online canteen ordering system where students can browse menus, place orders digitally, and track order status. This not only saves time but also improves canteen efficiency and user satisfaction.

📖 Project Description
The Online College Canteen Ordering System is a web application built in two phases:

JSP + Servlet + JDBC (Core Java Web App)

Implemented MVC architecture with DAO and POJO classes for database interaction.
Users can browse menus, add items to cart, select a table, and place orders.
Admins can manage food items and track customer orders.
Spring Boot + JPA (Enhanced Version)

Migrated to Spring Boot for scalability and modularity.
Built REST APIs for menu, order, and user management.
Integrated Spring Data JPA for efficient database operations.
The system provides an interactive interface for users and a robust management panel for admins.

Key Features

1. Digital Menu Access:-
Users can easily view the canteen menu on their smartphones or other devices.

2. Table-Side Ordering:-
Orders can be placed directly from the table, eliminating the need to stand in queues.

3. Real-Time Order Tracking:-
Users receive live updates on their order status, ensuring a smoother experience.

4. Role-Based Access:-
Supports different user roles—Student, Teacher, and Guest—for a personalized interface and ordering flow.

5. Peak-Hour Efficiency:-
Optimized for handling high traffic during lunch breaks and college events, improving overall service efficiency.

🛠️ Admin (Canteen Manager)
Secure login
Add/Edit/Delete menu items & categories
View & manage user orders
Update order status (Pending → Preparing → Ready → Delivered)
Manage table availability

🔒 Security
Role-based authentication (User & Admin)
Session handling in JSP/Servlet version
Spring Security in Spring Boot version
Secure database interactions with DAO/POJO and JPA

📦 Order Management System
Prevents duplicate orders
Cancelling an order frees up the table
Real-time status updates for users
📸 Screenshots (Add Images Later)
🏠 Home Page
📋 Food Menu
🛒 Cart & Checkout
📊 Admin Dashboard

Using tech stacks:- 
| Layer               | Technology                     |
| ------------------- | ------------------------------ |
| **Frontend**        | HTML, CSS, JavaScript (or JSP) |
| **Backend**         | Java Servlets, JSP             |
| **Database**        | MySQL                          |
| **Server**          | Apache Tomcat                  |
| **Tools & IDEs**    | Netbeans                       |
| **Version Control** | Git & GitHub                   |

⚙️ Setup Instructions (Local)
1️⃣ Clone the Repository
git clone https://github.com/your-username/OnlineCollegeCanteen.git
cd OnlineCollegeCanteen
Got it ✅ Here’s your complete **README.md file** (all in one Markdown file, clean and ready to use):

````markdown
# 🍴 Online College Canteen Management System

---

## 2️⃣ Setup Database (MySQL)
```sql
CREATE DATABASE canteen_db;
3️⃣ JSP + Servlet + JDBC Version
Import into Eclipse/IntelliJ
Configure JDBC connection in DBConnection.java:
String url = "jdbc:mysql://localhost:3306/canteen_db";
String username = "root";
String password = "yourpassword";
Deploy on Apache Tomcat
Access at: http://localhost:8080/OnlineCollegeCanteen

🎯 Role & Responsibilities
Designed and developed Java web application using JSP, Servlet, DAO, and POJO
Implemented database connectivity & modeling with JDBC + MySQL
Migrated application to Spring Boot + JPA for modern scalability
Built secure session handling & order management system
Designed responsive JSP pages with HTML & CSS
🌟 Future Enhancements
💳 Online Payment Gateway (UPI/Wallet/NetBanking)
📱 Mobile App version (Android/iOS)
🔔 Push Notifications for order updates
📊 Analytics Dashboard for Admin
🧾 Digital Invoice Generation
👨‍💻 Contributor
Prince Rajput – Leader , Frontend , Backend And Database(DBA) :https://github.com/Pr-09 .

Nityanand Dwivedi – Developer, Frontend , Backend , PPT, Content : https://github.com/nitya45 .

Orish khan - Developer, Frontend, Database, Synopsis :

⚠️ Disclaimer
This project is built as an academic/portfolio project for demonstration purposes only. It does not include production-grade payment systems and does not store sensitive user data.

📧 Contact
Developer: Prince Rajput, Nityanand Dwivedi & Orish Khan
Email: pr7509645@gmail.com
GitHub: https://github.com/Pr-09




