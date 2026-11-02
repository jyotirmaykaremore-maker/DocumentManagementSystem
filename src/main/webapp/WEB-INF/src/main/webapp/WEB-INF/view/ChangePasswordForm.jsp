<%@ page language="java"  isELIgnored="false" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Reset Password</title>

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

    .password-card {
        width: 100%;
        max-width: 430px;
        padding: 32px;
        background: #ffffff;
        border: 1px solid #dbeafe;
        border-radius: 16px;
        box-shadow: 0 12px 35px rgba(30, 64, 175, 0.12);
    }

    .password-icon {
        font-size: 38px;
        color: #2563eb;
    }

    h3 {
        color: #1e3a8a;
        font-weight: bold;
    }

    .subtitle {
        color: #64748b;
        font-size: 14px;
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

    .security-note {
        color: #64748b;
        font-size: 12px;
    }
</style>
</head>


<script type="text/javascript">

function validatePassword() {
	
	var newPassword = document.getElementById("newPassword").value;
	
	var confirmPassword = document.getElementById("confirmPassword").value;
	
	var error = document.getElementById("passwordError");
	
	if(newPassword !== confirmPassword){
		error.innerHTML ="New Password and Confirm Password do not match!";
		return false;
	}
	
	error.innerHTML="";
	return true;
}


</script>





<body>

<div class="container px-3">

    <div class="password-card mx-auto text-center">

        <div class="password-icon">&#128274;</div>

        <h3 class="mt-2">Reset Password</h3>

        <p class="subtitle mb-4">
            Create a new password for your account.
        </p>

        <form action="resetPassword"
              method="post"
              onsubmit="return validatePassword()">

            <!-- NEW PASSWORD -->
            <div class="text-start mb-3">

                <label for="newPassword" class="form-label">
                    New Password
                </label>

                <input type="password"
                       class="form-control"
                       id="newPassword"
                       name="newPassword"
                       placeholder="Enter new password"
                       autocomplete="new-password"
                       required>

            </div>

            <!-- CONFIRM PASSWORD -->
            <div class="text-start mb-4">

                <label for="confirmPassword" class="form-label">
                    Confirm Password
                </label>

                <input type="password"
                       class="form-control"
                       id="confirmPassword"
                       name="confirmPassword"
                       placeholder="Confirm new password"
                       autocomplete="new-password"
                       required>

            </div>

<!-- Ye yha java script ka msg show honga ky new password and confirm password ye same hai ki nhi  -->

				<div id="passwordError"
					style="color: red; font-size: 13px; margin-top: 5px;"></div>


				<!-- SUBMIT BUTTON -->
            <button type="submit" class="btn btn-main">
                Update Password
            </button>

        </form>

        <p class="security-note mt-4 mb-0">
            &#128274; Keep your password secure.
        </p>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<!-- agar password mismatch huye to ye show karenge agar nhi huye password udate ka show karenga  -->

<c:if test="${not empty sessionScope.WrongPass }">
<script type="text/javascript">
alert("<c:out value="${sessionScope.WrongPass}"></c:out>")
</script>
<c:remove var="WrongPass" scope="session"/>
</c:if>


<c:if test="${not empty sessionScope.passwordChange }">
<script type="text/javascript">
alert("<c:out value="${sessionScope.passwordChange}"></c:out>")
</script>
<c:remove var="passwordChange" scope="session"/>
</c:if>


</body>
</html>