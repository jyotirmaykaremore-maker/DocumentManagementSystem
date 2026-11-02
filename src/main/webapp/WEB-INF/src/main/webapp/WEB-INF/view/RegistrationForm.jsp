
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Document Management System - Registration</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body {
            background: #eef3f2;
            font-family: Arial, sans-serif;
            padding: 35px 12px;
        }

        .main-container {
            max-width: 520px;
            margin: auto;
        }

        .register-box {
            background: #ffffff;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 5px 22px rgba(0, 0, 0, 0.10);
        }

        .brand-title {
            color: #034E42;
            text-align: center;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .subtitle {
            text-align: center;
            color: #777;
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 600;
            color: #343a40;
            margin-bottom: 7px;
        }

        .form-control {
            padding: 11px;
            border: 1px solid #ced8d5;
            border-radius: 7px;
        }

        .form-control:focus {
            border-color: #034E42;
            box-shadow: 0 0 0 0.2rem rgba(3, 78, 66, 0.12);
        }

        .btn-custom {
            background: #034E42;
            color: white;
            border: none;
            border-radius: 7px;
            padding: 11px;
            font-weight: 600;
        }

        .btn-custom:hover {
            background: #02372f;
            color: white;
        }

        .email-row {
            display: flex;
            gap: 8px;
        }

        .email-row .form-control {
            min-width: 0;
            flex: 1;
        }

        .otp-btn {
            white-space: nowrap;
            padding: 0 13px;
        }

        .otp-section {
            margin-top: 16px;
            margin-bottom: 22px;
        }

        .divider {
            border: 0;
            border-top: 1px solid #e5e9e7;
            margin: 23px 0;
        }

        .form-check-input:checked {
            background-color: #034E42;
            border-color: #034E42;
        }

        .form-check-input:focus {
            border-color: #034E42;
            box-shadow: 0 0 0 0.2rem rgba(3, 78, 66, 0.12);
        }

        .status-message {
            font-size: 14px;
        }

        @media (max-width: 400px) {
            .register-box {
                padding: 20px;
            }

            .otp-btn {
                padding: 0 9px;
                font-size: 13px;
            }
        }
    </style>
</head>


<body>

<div class="main-container">

    <div class="register-box">

        <h3 class="brand-title">Create Account</h3>

        <p class="subtitle">
            Register to access your documents
        </p>


        <!-- EMAIL FIELD AND SEND OTP -->

        <form action="RegisterSendOtp"
              method="post">

            <div class="mb-3">

                <label class="form-label">
                    Email Address
                </label>

                <div class="email-row">

                    <input type="email"
                           name="email"
                           class="form-control"
                           id="emailField"
                           placeholder="Enter your email address"
                           value="<c:out value='${emailStore}'/>"
                           required>

                    <button type="submit"
                            class="btn btn-custom otp-btn">
                        Send OTP
                    </button>

                </div>

            </div>

        </form>


        <!-- OTP MESSAGE -->

        <c:if test="${not empty otpMsg}">
            <div class="alert alert-info status-message">
                <c:out value="${otpMsg}"/>
            </div>
            <c:remove var="otpMsg" scope="session"/>
        </c:if>
        
        
        


        <!-- OTP FIELD AND VERIFY BUTTON -->

        <form action="RegisterVerifyOtp"
              method="post">

            <div class="otp-section">

                <label class="form-label">
                    Enter OTP
                </label>

                <div class="email-row">

                    <input type="text"
                           name="otp"
                           class="form-control"
                           placeholder="Enter 6-digit OTP"
                           inputmode="numeric"
                           pattern="[0-9]{6}"
                           maxlength="6"
                           required>

                    <button type="submit"
                            class="btn btn-custom otp-btn">
                        Verify
                    </button>

                </div>

            </div>

        </form>


        <!-- OTP VERIFICATION MESSAGE -->

        <c:if test="${not empty OtpMatch}">
            <div class="alert alert-info status-message">
                <c:out value="${OtpMatch}"/>
            </div>
            <c:remove var="OtpMatch" scope="session"/>
        </c:if>


        <hr class="divider">


        <!-- REGISTRATION FORM -->

        <form action="registration"  method="post">

            <!-- FULL NAME -->

            <div class="mb-3">

                <label class="form-label">
                    Full Name
                </label>

                <input type="text"
                       name="fname"
                       class="form-control"
                       placeholder="Enter your full name"
                       required>

            </div>


            <!-- EMAIL -->

            <div class="mb-3">

                <label class="form-label">
                    Email Address
                </label>

                <input type="email"
                       name="email"
                       class="form-control"
                       id="registeremailField"
                       placeholder="Enter your verified email"
                       value= "<c:out value="${emailStore}"></c:out>"
                       required
                       readonly>

            </div>


            <!-- PASSWORD -->

            <div class="mb-3">

                <label class="form-label">
                    Password
                </label>

                <input type="password"
                       name="password"
                       class="form-control"
                       placeholder="Create a password"
                       minlength="8"
                       required>

            </div>


            <!-- PHONE -->

            <div class="mb-3">

                <label class="form-label">
                    Phone Number
                </label>

                <input type="tel"
                       name="phone"
                       class="form-control"
                       placeholder="Enter 10-digit phone number"
                       pattern="[0-9]{10}"
                       maxlength="10"
                       required>

            </div>


            <!-- GENDER RADIO BUTTONS -->

            <div class="mb-3">

                <label class="form-label d-block">
                    Gender
                </label>

                <div class="d-flex gap-4 flex-wrap">

                    <div class="form-check">

                        <input class="form-check-input"
                               type="radio"
                               name="gender"
                               id="male"
                               value="Male"
                               required>

                        <label class="form-check-label"
                               for="male">
                            Male
                        </label>

                    </div>

                    <div class="form-check">

                        <input class="form-check-input"
                               type="radio"
                               name="gender"
                               id="female"
                               value="Female">

                        <label class="form-check-label"
                               for="female">
                            Female
                        </label>

                    </div>

                    <div class="form-check">

                        <input class="form-check-input"
                               type="radio"
                               name="gender"
                               id="other"
                               value="Other">

                        <label class="form-check-label"
                               for="other">
                            Other
                        </label>

                    </div>

                </div>

            </div>


            <!-- ADDRESS -->

            <div class="mb-4">

                <label class="form-label">
                    Address
                </label>

                <textarea name="address"
                          class="form-control"
                          rows="3"
                          placeholder="Enter your full address"
                          required></textarea>

            </div>


            <!-- REGISTER BUTTON -->

            <button type="submit"
                    class="btn btn-custom w-100">
                Register
            </button>


            <!-- LOGIN LINK -->

            <p class="text-center mt-3 mb-0">

                Already have an account?

                <a href="goToLoginPage"
                   style="color:#034E42; font-weight:600;">
                    Login Here
                </a>

            </p>

        </form>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<c:if test="${not empty sessionScope.EmailExist }">
<script type="text/javascript">
alert("<c:out value="${sessionScope.EmailExist}"></c:out>")
</script>
<c:remove var="EmailExist" scope="session"/>
</c:if>


<c:if test="${not empty sessionScope.otpNotMatch }">
<script type="text/javascript">
alert("<c:out value="${sessionScope.otpNotMatch}"></c:out>")
</script>
<c:remove var="otpNotMatch" scope="session"/>
</c:if>

<!--  page reload ho to eamil ki field bhi hatte and jo otp email pe aya vo verify na ho -->

<script>
window.addEventListener("load", function () {

    var nav = performance.getEntriesByType("navigation")[0];

    if (nav && nav.type === "reload") {

        // Email fields clear karo
        var email1 = document.getElementById("emailField");
        var email2 = document.getElementById("registeremailField");

        if (email1) {
            email1.value = "";
        }

        if (email2) {
            email2.value = "";
        }

        // OTP aur email session se clear karne ke liye
        window.location.replace("clearOtpOnReload");
    }

});
</script>


<c:if test="${not empty sessionScope.SuccessRegister }">
<script type="text/javascript">
alert("<c:out value="${sessionScope.SuccessRegister}"></c:out>")
</script>
<c:remove var="SuccessRegister" scope="session"/>
</c:if>


</body>
</html>



</body>
</html>