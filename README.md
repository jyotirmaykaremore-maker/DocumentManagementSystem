# Document Management System

## 📌 Project Overview
The Document Management System is a web-based application developed using Java Full Stack technologies. It allows users to register, log in, upload, manage, download and delete their personal documents and images securely.

Users can also manage their profile details and update their profile photo.

## 🚀 Features

- User Registration and Login
- Forgot Password using Email OTP Verification
- Secure User Session Management
- Upload Multiple Documents
- Upload Images
- View Uploaded Documents and Images
- Download Documents
- Delete Documents
- Search Documents by Name
- Pagination for Document Listing
- User Profile Management
- Update Profile Details and Profile Photo
- Email Change with OTP Verification

## 🛠️ Technologies Used

**Backend:**
- Java
- Spring Web MVC
- Hibernate ORM
- JDBC

**Frontend:**
- HTML
- CSS
- JavaScript
- JSP
- JSTL
- Bootstrap 5.3.3

**Database:**
- MySQL

**Tools & Server:**
- Eclipse IDE
- Apache Tomcat
- Maven

## 🏗️ Project Architecture

This project follows the MVC (Model-View-Controller) architecture.

- **Controller:** Handles HTTP requests and application flow.
- **Model:** Contains entity classes and application data.
- **DAO:** Handles database operations.
- **Service:** Contains business logic.
- **View:** JSP pages used for the user interface.

## 🔐 Security and File Storage

- Database and email credentials are maintained outside the project using an external properties file.
- User-uploaded documents and images are stored in external folders on the server.
- User session is maintained after successful login.

## ⚙️ Project Setup

1. Clone or download this repository.
2. Import the project into Eclipse as an existing Maven project.
3. Configure the MySQL database.
4. Create your external `secrets.properties` file and configure the required database and email credentials.
5. Update the external properties file location in the Spring configuration if required.
6. Configure the external document and image storage directories.
7. Configure Apache Tomcat Server.
8. Run the project on the server.

## 👨‍💻 Developer

**Jyotirmay Karemore**

Java Full Stack Developer | MCA

---

*This project was developed as a practical implementation of Java Full Stack technologies, Spring MVC, Hibernate and MySQL.*
