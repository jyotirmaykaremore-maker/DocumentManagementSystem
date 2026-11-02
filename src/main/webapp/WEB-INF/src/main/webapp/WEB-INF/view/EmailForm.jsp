<%@ page language="java"  isELIgnored="false" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>OTP Verification</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<style>
    body {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        background: linear-gradient(135deg, #e0f2fe, #eef2ff);
        font-family: Arial, sans-serif;
        padding: 25px 0;
    }

    .otp-card {
        width: 100%;
        max-width: 430px;
        padding: 32px;
        background: #ffffff;
        border: 1px solid #dbeafe;
        border-radius: 16px;
        box-shadow: 0 12px 35px rgba(30, 64, 175, 0.12);
    }

    .otp-icon {
        font-size: 38px;
        color: #2563eb;
    }

    h3 {
        color: #1e3a8a;
        font-weight: bold;
    }

    .form-label {
        color: #1e40af;
        font-weight: 600;
    }

    .form-control {
        padding: 12px;
        border: 1px solid #cbd5e1;
        border-radius: 8px;
    }

    .form-control:focus {
        border-color: #3b82f6;
        box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.15);
    }

    .otp-input {
        text-align: center;
        font-size: 20px;
        letter-spacing: 8px;
    }

    .btn-main {
        width: 100%;
        padding: 12px;
        background: #2563eb;
        color: #ffffff;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        transition: background 0.2s ease;
    }

    .btn-main:hover {
        background: #1d4ed8;
        color: #ffffff;
    }

    .subtitle {
        color: #64748b;
        font-size: 14px;
    }

    hr {
        border-color: #bfdbfe;
        margin: 25px 0;
        opacity: 1;
    }

    .security-note {
        color: #64748b;
        font-size: 12px;
    }
</style>
</head>

<body>

<div class="container px-3">

    <div class="otp-card mx-auto text-center">

        <div class="otp-icon">&#9993;</div>

        <h3 class="mt-2">Email OTP Verification</h3>

        <p class="subtitle mb-4">
            Verify your email to continue securely.
        </p>

        <!-- FORM 1: SEND OTP -->
        <form action="sendOtp"
              method="post">

            <div class="text-start mb-3">
                <label for="email" class="form-label">
                    Email Address
                </label>

                <input type="email"
                       class="form-control"
                       id="email"
                       name="email"
                       placeholder="Enter your email address"
                       value="<c:out value="${sessionScope.emailget}"></c:out>"
                       required>
            </div>
            
            

            <button type="submit" class="btn btn-main">
                Send OTP
            </button>

        </form>

        <hr>

        <!-- FORM 2: VERIFY OTP -->
        <form action="verifyOtp"
              method="post">

            <div class="text-start mb-3">
                <label for="otp" class="form-label">
                    Enter OTP
                </label>

                <input type="text"
                       class="form-control otp-input"
                       id="otp"
                       name="otp"
                       placeholder="------"
                       maxlength="6"
                       pattern="[0-9]{6}"
                       inputmode="numeric"
                       autocomplete="one-time-code"
                       required>
            </div>

            <button type="submit" class="btn btn-main">
                Verify OTP
            </button>

        </form>

        <p class="security-note mt-4 mb-0">
            &#128274; Never share your OTP with anyone.
        </p>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<!-- Otp successfully send ki session -->

<c:if test="${not empty sessionScope.OtpMsg }">

<script type="text/javascript">
alert("<c:out value="${sessionScope.OtpMsg}"></c:out>")

</script>
<c:remove var="OtpMsg" scope="session"/>
</c:if>


<!-- email register hai nhi uski session -->
<c:if test="${not empty sessionScope.emailmsg }">

<script type="text/javascript">
alert("<c:out value="${sessionScope.emailmsg}"></c:out>")

</script>
<c:remove var="emailmsg" scope="session"/>
</c:if>


<!-- Otp agar match nhi hua to  -->
<c:if test="${not empty sessionScope.wrongOtp }">

<script type="text/javascript">
alert("<c:out value="${sessionScope.wrongOtp}"></c:out>")

</script>
<c:remove var="wrongOtp" scope="session"/>
</c:if>


<!-- Otp match hua to  -->
<c:if test="${not empty sessionScope.OtpVerifedSucc }">

<script type="text/javascript">
alert("<c:out value="${sessionScope.OtpVerifedSucc}"></c:out>")

</script>
<c:remove var="OtpVerifedSucc" scope="session"/>
</c:if>



</body>
</html>
