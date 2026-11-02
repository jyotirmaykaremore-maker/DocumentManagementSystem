<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
    
    <%-- JSTL core library: conditions, loops aur safe output ke liye --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Document Management System | Login</title>

<!-- Bootstrap 5.3.3 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<style>

/* Page ka background aur content ko center mein rakhne ke liye */
body {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #e0f2fe, #eef2ff);
    font-family: Arial, sans-serif;
    padding: 20px;
}

/* Login form ka main white card */
.login-card {
    width: 100%;
    max-width: 420px;
    background: #ffffff;
    padding: 35px;
    border-radius: 18px;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
}

/* Logo ki size aur alignment */
.logo {
    width: 85px;
    height: 85px;
    object-fit: contain;
    display: block;
    margin: 0 auto 12px;
}

/* Project title ka dashboard jaisa dark green color */
.brand-name {
    color: #034E42;
    font-weight: bold;
    font-size: 22px;
}

/* Email aur password fields ki styling */
.form-control {
    padding: 12px;
    border-radius: 8px;
    border: 1px solid #ced4da;
}

/* Input field select karne par dark green border */
.form-control:focus {
    border-color: #034E42;
    box-shadow: 0 0 0 0.2rem rgba(3, 78, 66, 0.15);
}

/* Login button ka dashboard jaisa dark green color */
.login-btn {
    background: #034E42;
    color: #ffffff;
    padding: 12px;
    border: 1px solid #034E42;
    border-radius: 8px;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

/* Mouse hover karne par button ka color thoda dark hoga */
.login-btn:hover {
    background: #02372f;
    border-color: #02372f;
    color: #ffffff;
}

/* Forgot Password aur Register links */
a {
    color: #034E42;
    text-decoration: none;
}

/* Link par mouse le jaane par underline */
a:hover {
    color: #02372f;
    text-decoration: underline;
}

/* Mobile screen par card ki padding adjust hogi */
@media (max-width: 480px) {
    .login-card {
        padding: 25px 20px;
    }

    .brand-name {
        font-size: 20px;
    }
}

</style>
</head>

<body>

<!-- Login form ka main card -->
<div class="login-card">

    <!-- Logo aur project title -->
    <div class="text-center mb-4">

        <!-- Project logo ka path -->
        <img src="${pageContext.request.contextPath}/images/logo.png"
             alt="Document Management System Logo"
             width="140"
             height="110"
             style="display: block; object-fit: contain; margin: 0 auto 12px;">

        <!-- Dashboard ke matching dark green title -->
        <div class="brand-name">Document Management System</div>

        <p class="text-secondary mt-2 mb-0">
            Login to your account
        </p>

    </div>

    <!-- Login details submit karne ke liye form -->
    <form action="loginpass" method="post">

        <!-- Email field -->
        <div class="mb-3">
            <label for="email" class="form-label">Email Address</label>

            <input type="email"
                   class="form-control"
                   id="email"
                   name="email"
                   placeholder="Enter your email"
                   required>
        </div>

        <!-- Password field -->
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>

            <input type="password"
                   class="form-control"
                   id="password"
                   name="password"
                   placeholder="Enter your password"
                   required>
        </div>

        <!-- Forgot Password page ka link -->
        <div class="text-end mb-3">
            <a href="forgotPassword">Forgot Password?</a>
        </div>

        <!-- Login submit button -->
        <button type="submit" class="btn login-btn w-100">
            Login
        </button>

    </form>

    <!-- Login form aur registration link ke beech divider -->
    <hr class="my-4">

    <!-- New user registration page ka link -->
    <div class="text-center">
        <span class="text-secondary">Don't have an account?</span>
        <a href="register" class="fw-bold">New User? Register</a>
    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<c:if test="${not empty sessionScope.LoginFailed }">
		<script type="text/javascript">
			alert("<c:out value="${sessionScope.LoginFailed }"></c:out>")
		</script>

		<c:remove var="LoginFailed" scope="session" />
	</c:if>

</body>
</html>
