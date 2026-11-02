
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>

<%-- JSTL Core: JSP mein conditions, loops aur safe output ke liye --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Document Management System</title>

<!-- Bootstrap CSS: Responsive layout aur ready-made UI components -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons: Sidebar aur buttons ke icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<style>

/* =====================================================
   COMMON THEME COLORS
   ===================================================== */
:root {
    --primary: #034E42;
    --hover: #02372f;
    --background: #eef3f2;
    --border: #ced8d5;
}

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    background: var(--background);
    font-family: Arial, sans-serif;
    font-size: 13px;
    color: #343a40;
}

/* =====================================================
   TOP NAVBAR
   ===================================================== */
.topbar {
    height: 58px;
    padding: 0 18px;
    background: var(--primary);
    color: white;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: sticky;
    top: 0;
    z-index: 1000;
}

.brand {
    display: flex;
    align-items: center;
    gap: 9px;
    color: white;
    text-decoration: none;
    font-weight: bold;
    font-size: 17px;
}

.brand img {
    width: 40px;
    height: 40px;
    object-fit: contain;
    background: white;
    border-radius: 5px;
    padding: 2px;
}

/* =====================================================
   SIDEBAR
   ===================================================== */
.sidebar {
    position: fixed;
    top: 58px;
    left: 0;
    bottom: 0;
    width: 215px;
    padding: 14px 10px;
    overflow-y: auto;
    background: var(--primary);
    z-index: 900;
}

.sidebar a {
    display: block;
    padding: 11px 12px;
    margin-bottom: 4px;
    color: white;
    text-decoration: none;
    border-radius: 7px;
    cursor: pointer;
}

.sidebar a:hover,
.sidebar a.active {
    background: var(--hover);
}

.sidebar a i {
    margin-right: 8px;
}

.submenu {
    display: none;
    padding-left: 14px;
}

/* =====================================================
   MAIN CONTENT
   ===================================================== */
.main {
    margin-left: 215px;
    padding: 17px;
}

/* Ek time par sirf selected section visible rahega */
.view {
    display: none;
}

.view.active {
    display: block;
}

.panel {
    background: white;
    border: 1px solid var(--border);
    border-radius: 10px;
    padding: 15px;
    box-shadow: 0 3px 12px rgba(0,0,0,.045);
}

.heading {
    color: var(--primary);
    font-size: 16px;
    font-weight: bold;
}

.welcome {
    padding: 17px;
    margin-bottom: 14px;
    background: white;
    border-left: 4px solid var(--primary);
    border-radius: 8px;
}

.welcome h4 {
    color: var(--primary);
    font-weight: bold;
    font-size: 20px;
    margin-bottom: 5px;
}

/* =====================================================
   FORMS AND BUTTONS
   ===================================================== */
.form-label {
    font-weight: 600;
    margin-bottom: 5px;
}

.form-control,
.form-select {
    font-size: 13px;
    padding: 8px 10px;
    border: 1px solid var(--border);
    border-radius: 7px;
}

.form-control:focus,
.form-select:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 .2rem rgba(3,78,66,.12);
}

.btn-custom {
    background: var(--primary);
    color: white;
    border: none;
    border-radius: 7px;
    padding: 8px 12px;
    font-size: 13px;
    font-weight: 600;
}

.btn-custom:hover {
    background: var(--hover);
    color: white;
}

.btn-outline-custom {
    color: var(--primary);
    border: 1px solid var(--primary);
    border-radius: 7px;
    padding: 7px 10px;
    font-size: 13px;
    background: white;
}

.btn-outline-custom:hover {
    background: var(--primary);
    color: white;
}

.upload-icon {
    font-size: 25px;
    color: var(--primary);
    margin-bottom: 7px;
}

/* =====================================================
   TABLE
   ===================================================== */
.table {
    font-size: 12px;
}

.table thead th {
    background: var(--background);
    color: var(--primary);
    white-space: nowrap;
}

.table td {
    vertical-align: middle;
}

/* =====================================================
   PROFILE PHOTO
   ===================================================== */
.profile-photo {
    width: 150px;
    height: 150px;
    object-fit: cover;
    border: 2px solid var(--border);
    border-radius: 50%;
    background: var(--background);
}

/* =====================================================
   IMAGE GALLERY
   ===================================================== */
.image-card {
    background: white;
    border: 1px solid var(--border);
    border-radius: 8px;
    overflow: hidden;
}

.image-card img {
    width: 100%;
    height: 135px;
    object-fit: cover;
}

.image-info {
    padding: 9px;
}

/* =====================================================
   PAGINATION
   ===================================================== */
.pagination .page-link {
    color: var(--primary);
    cursor: pointer;
}

.pagination .active .page-link {
    background: var(--primary);
    border-color: var(--primary);
    color: white;
}

/* =====================================================
   RESPONSIVE DESIGN
   ===================================================== */
@media (max-width: 768px) {

    .topbar {
        padding: 0 10px;
    }

    .brand {
        font-size: 13px;
    }

    .sidebar {
        display: none;
        position: relative;
        top: 0;
        width: 100%;
    }

    .sidebar.mobile-open {
        display: block;
    }

    .main {
        margin-left: 0;
        padding: 12px;
    }
}

</style>
</head>

<body>

<!-- =====================================================
     TOP NAVBAR
     ===================================================== -->
<nav class="topbar">

    <div class="d-flex align-items-center gap-2">

        <!-- Mobile screen par sidebar open/close button -->
        <button type="button"
                class="btn btn-sm btn-outline-light d-md-none"
                onclick="toggleSidebar()">

            <i class="bi bi-list"></i>
        </button>

        <!-- Logo par click karne se dashboard open hoga -->
        <a href="#dashboard"
           class="brand"
           onclick="showView('dashboard', this); return false;">

            <img src="${pageContext.request.contextPath}/images/logo.png"
                 alt="Website Logo">

            <span>Document Management System</span>
        </a>

    </div>

    <!-- Logged-in user ki email session se display hogi -->
    <span>
        Welcome,
        <c:out value="${sessionScope.emailID}" />
    </span>

</nav>


<!-- =====================================================
     SIDEBAR NAVIGATION
     ===================================================== -->
<aside class="sidebar" id="sidebar">

    <a href="#dashboard"
       class="active"
       onclick="showView('dashboard', this); return false;">

        <i class="bi bi-house"></i> Dashboard
    </a>

    <!-- Dashboard open karke document upload section tak scroll -->
    <a href="#uploadDocument"
       onclick="showView('dashboard', this); scrollToUpload('uploadDocument'); return false;">

        <i class="bi bi-file-earmark-arrow-up"></i> Upload Document
    </a>

    <!-- Dashboard open karke image upload section tak scroll -->
    <a href="#uploadImage"
       onclick="showView('dashboard', this); scrollToUpload('uploadImage'); return false;">

        <i class="bi bi-image"></i> Upload Image
    </a>

    <!-- Submenu open/close karne ke liye -->
    <a href="#uploads" onclick="toggleSubmenu(); return false;">

        <i class="bi bi-list-ul"></i> List of Uploads
        <i class="bi bi-chevron-down float-end"></i>
    </a>

    <div class="submenu" id="uploadSubmenu">

        <a href="#documents"
           onclick="showView('documents', this); return false;">

            <i class="bi bi-file-earmark-text"></i> View Documents
        </a>

        <a href="#images"
           onclick="showView('images', this); return false;">

            <i class="bi bi-images"></i> View Images
        </a>

    </div>

    <!-- Profile section -->
    <a href="#profile"
       onclick="showView('profile', this); return false;">

        <i class="bi bi-person"></i> Profile
    </a>

    <!-- Logout confirmation -->
    <a href="logout"
       onclick="return confirm('Are you sure you want to logout?');">

        <i class="bi bi-box-arrow-right"></i> Logout
    </a>

</aside>


<main class="main">


<!-- =====================================================
     DASHBOARD SECTION
     ===================================================== -->
<section id="dashboard" class="view active">

    <div class="welcome">

        <h4>
            Welcome,
            <c:out value="${sessionScope.username}" default="user"/>!
        </h4>

        <span class="text-secondary">
            Manage your documents, images and profile in one place.
        </span>

    </div>


    <!-- Backend se aaya success message -->
    <c:if test="${not empty msg}">

        <div class="alert alert-success py-2" id="successMsg">
            <c:out value="${msg}" />
        </div>

    </c:if>


    <!-- Backend se aaya error message -->
    <c:if test="${not empty error}">

        <div class="alert alert-danger py-2" id="errorMsg">
            <c:out value="${error}" />
        </div>

    </c:if>


    <!-- Dashboard counts -->
    <div class="row g-3 mb-3">

        <div class="col-md-4">
            <div class="panel">

                <div class="heading">Documents</div>

                <h4 class="mt-2 mb-0">
                    <c:out value="${documentCount != null ? documentCount : 0}" />
                </h4>

            </div>
        </div>


        <div class="col-md-4">
            <div class="panel">

                <div class="heading">Images</div>

                <h4 class="mt-2 mb-0">
                    <c:out value="${imageCount != null ? imageCount : 0}" />
                </h4>

            </div>
        </div>


        <div class="col-md-4">
            <div class="panel">

                <div class="heading">Total Uploads</div>

                <h4 class="mt-2 mb-0">
                    <c:out value="${totalCount != null ? totalCount : 0}" />
                </h4>

            </div>
        </div>

    </div>


    <!-- =================================================
         DOCUMENT AND IMAGE UPLOAD FORMS
         ================================================= -->
    <div class="row g-3 mb-3">


        <!-- DOCUMENT UPLOAD FORM -->
        <div class="col-lg-6" id="uploadDocument">

            <div class="panel">

                <div class="upload-icon">
                    <i class="bi bi-file-earmark-arrow-up"></i>
                </div>

                <h5 class="heading">Upload Documents</h5>

                <p class="text-secondary">
                    Select multiple documents in one go.
                </p>

                <!--
                    multipart/form-data:
                    File upload ke liye enctype multipart/form-data required hota hai.
                -->
                <form action="${pageContext.request.contextPath}/uploadDocument"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- name documents backend ke parameter se match hona chahiye -->
                    <input type="file"
                           id="documentFiles"
                           name="documents"
                           class="form-control mb-2"
                           multiple
                           required
                           accept=".pdf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.txt,.csv">

                    <!-- jQuery selected files ki count update karega -->
                    <small id="selectedFiles"
                           class="text-secondary d-block mb-2">

                        No files selected
                    </small>

                    <button type="submit" class="btn-custom w-100">

                        <i class="bi bi-cloud-upload me-1"></i>
                        Upload Documents

                    </button>

                </form>

            </div>
        </div>


        <!-- IMAGE UPLOAD FORM -->
        <div class="col-lg-6" id="uploadImage">

            <div class="panel">

                <div class="upload-icon">
                    <i class="bi bi-image"></i>
                </div>

                <h5 class="heading">Upload Images</h5>

                <p class="text-secondary">
                    Select multiple images for your gallery.
                </p>

                <form action="${pageContext.request.contextPath}/uploadImage"
                      method="post"
                      enctype="multipart/form-data">

                    <input type="file"
                           id="imageFiles"
                           name="images"
                           class="form-control mb-2"
                           multiple
                           required
                           accept="image/jpeg,image/png,image/webp">

                    <!-- jQuery selected images ki count update karega -->
                    <small id="selectedImages"
                           class="text-secondary d-block mb-2">

                        No images selected
                    </small>

                    <button type="submit" class="btn-custom w-100">

                        <i class="bi bi-cloud-upload me-1"></i>
                        Upload Images

                    </button>

                </form>

            </div>
        </div>

    </div>


    <!-- =================================================
         RECENT UPLOADS
         ================================================= -->
    <div class="panel">

        <div class="d-flex justify-content-between align-items-center mb-2">

            <h5 class="heading mb-0">Recent Uploads</h5>

            <button type="button"
                    class="btn-outline-custom"
                    onclick="showView('documents', null)">

                View Documents
            </button>

        </div>


        <div class="table-responsive">

            <table class="table table-hover mb-0">

                <thead>
                    <tr>
                        <th>File Name</th>
                        <th>Type</th>
                        <th>Upload Date</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                    <!-- Backend ki recentUploads list par loop -->
                    <c:forEach items="${recentUploads}" var="file">

                        <tr>

                            <td>
                                <c:out value="${file.fileName}"/>
                            </td>

                            <td>
                                <c:out value="${file.fileType}"/>
                            </td>

                            <td>
                                <c:out value="${file.uploadDate}"/>
                            </td>

                            <td>

                                <!-- docID entity ka primary key hai -->
                                <a class="btn-outline-custom"
                                   href="${pageContext.request.contextPath}/downloadDocument?id=${file.docID}"
                                   title="Download">

                                    <i class="bi bi-download"></i>
                                </a>

                            </td>

                        </tr>

                    </c:forEach>


                    <!-- Collection empty hone par message -->
                    <c:if test="${empty recentUploads}">

                        <tr>
                            <td colspan="4"
                                class="text-center text-secondary py-3">

                                No uploads available yet.

                            </td>
                        </tr>

                    </c:if>

                </tbody>

            </table>

        </div>

    </div>

</section>



<!-- =====================================================
     DOCUMENTS SECTION
     ===================================================== -->
<section id="documents" class="view">

    <div class="panel">

        <h5 class="heading mb-3">My Documents</h5>


        <div class="row g-2 mb-3">

            <!-- Document search -->
            <div class="col-md-8">

                <input type="search"
                       id="documentSearch"
                       class="form-control"
                       placeholder="Search by document name...">

            </div>


            <!-- Ek page par kitne records dikhane hain -->
            <div class="col-md-4">

                <select id="pageSize" class="form-select">

                    <option value="5">Show 5</option>
                    <option value="10">Show 10</option>
                    <option value="25">Show 25</option>
                    <option value="50">Show 50</option>

                </select>

            </div>

        </div>


        <div class="table-responsive">

            <table class="table table-hover">

                <thead>

                    <tr>
                        <th>#</th>
                        <th>Document Name</th>
                        <th>Type</th>
                        <th>Upload Date</th>
                        <th>Actions</th>
                    </tr>

                </thead>


                <tbody id="documentRows">

                    <!-- documents collection ke har record ki row -->
                    <c:forEach items="${documents}" var="file" varStatus="loop">

                        <!-- data-name attribute filename search mein help karta hai -->
                        <tr class="document-row"
                            data-name="<c:out value='${file.fileName}'/>">

                            <td>
                                <c:out value="${loop.count}"/>
                            </td>

                            <td>
                                <c:out value="${file.fileName}"/>
                            </td>

                            <td>
                                <c:out value="${file.fileType}"/>
                            </td>

                            <td>
                                <c:out value="${file.uploadDate}"/>
                            </td>

                            <td class="text-nowrap">

                                <!-- Document download -->
                                <a class="btn btn-sm btn-outline-custom"
                                   href="${pageContext.request.contextPath}/downloadDocument?id=${file.docID}"
                                   title="Download">

                                    <i class="bi bi-download"></i>
                                </a>


                                <!-- Document delete form -->
                                <form action="${pageContext.request.contextPath}/deleteDocument"
                                      method="post"
                                      class="d-inline delete-form">

                                    <!-- Hidden input mein document ki ID bhej rahe hain -->
                                    <input type="hidden"
                                           name="id"
                                           value="<c:out value='${file.docID}'/>">

                                    <button type="submit"
                                            class="btn btn-sm btn-danger"
                                            title="Delete">

                                        <i class="bi bi-trash"></i>
                                    </button>

                                </form>

                            </td>

                        </tr>

                    </c:forEach>

                </tbody>

            </table>

        </div>


        <!-- Search result aur pagination yahan show honge -->
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">

            <small id="documentInfo" class="text-secondary"></small>

            <ul class="pagination pagination-sm mb-0"
                id="documentPagination">

            </ul>

        </div>

    </div>

</section>



<!-- =====================================================
     IMAGES SECTION
     ===================================================== -->
<section id="images" class="view">

    <div class="panel">

        <div class="d-flex justify-content-between align-items-center gap-2 mb-3">

            <h5 class="heading mb-0">My Images</h5>

            <!-- Image filename search -->
            <input type="search"
                   id="imageSearch"
                   class="form-control"
                   style="max-width:220px"
                   placeholder="Search image name...">

        </div>


        <div class="row g-3" id="imageGrid">

            <!-- Backend ki images collection par loop -->
            <c:forEach items="${images}" var="img">

                <div class="col-6 col-md-4 col-lg-3 image-item"
                     data-name="<c:out value='${img.fileName}'/>">

                    <div class="image-card h-100">

                        <!-- Image click karne par new tab mein open hogi -->
                        <a href="${pageContext.request.contextPath}/viewImage?id=${img.docID}"
                           target="_blank">

                            <img src="${pageContext.request.contextPath}/viewImage?id=${img.docID}"
                                 alt="Uploaded image"
                                 loading="lazy">

                        </a>


                        <div class="image-info">

                            <div class="text-truncate fw-semibold mb-2">

                                <c:out value="${img.fileName}"/>

                            </div>


                            <!-- Image download -->
                            <a class="btn btn-sm btn-outline-custom"
                               href="${pageContext.request.contextPath}/downloadDocument?id=${img.docID}">

                                <i class="bi bi-download"></i>
                            </a>


                            <!-- Image delete -->
                            <form action="${pageContext.request.contextPath}/deleteDocument"
                                  method="post"
                                  class="d-inline delete-form">

                                <input type="hidden"
                                       name="id"
                                       value="<c:out value='${img.docID}'/>">

                                <button class="btn btn-sm btn-danger"
                                        type="submit">

                                    <i class="bi bi-trash"></i>

                                </button>

                            </form>

                        </div>

                    </div>

                </div>

            </c:forEach>

        </div>


        <!-- Images collection empty hone par message -->
        <c:if test="${empty images}">

            <p class="text-center text-secondary py-4">
                No images uploaded yet.
            </p>

        </c:if>

    </div>

</section>



<!-- =====================================================
     PROFILE SECTION
     ===================================================== -->
<section id="profile" class="view">

    <div class="row justify-content-center">

        <div class="col-lg-8">

            <div class="panel">

                <h5 class="heading mb-3">My Profile</h5>


                <!-- Profile details aur photo update karne ka multipart form -->
                <form id="profileForm"
                      action="${pageContext.request.contextPath}/updateProfile"
                      method="post"
                      enctype="multipart/form-data">


                    <!-- PROFILE PHOTO -->
                    <div class="text-center mb-3">

								<c:choose>

									<%-- User ki saved profile photo available hai toh wahi show karo --%>
									<c:when test="${not empty user.filename}">

										<img id="profilePreview" class="profile-photo"
											src="${pageContext.request.contextPath}/upload/${user.filename}"
											alt="Profile photo">

									</c:when>

									<%-- Profile photo available nahi hai toh default photo show karo --%>
									<c:otherwise>

										<img id="profilePreview" class="profile-photo"
											src="${pageContext.request.contextPath}/images/ByDefaultProfile.jpg"
											alt="Default profile photo">

									</c:otherwise>

								</c:choose>


								<div class="mt-2">

                            <label for="profilePhoto"
                                   class="btn-outline-custom">

                                <i class="bi bi-camera me-1"></i>
                                Change Profile Photo

                            </label>

                        </div>


                        <!-- Hidden file input label se open hoga -->
                        <input type="file"
                               id="profilePhoto"
                               name="profile"
                               class="d-none"
                               accept="image/jpeg,image/png,image/webp">

                    </div>



                    <div class="row g-3">


                        <!-- FULL NAME -->
                        <div class="col-md-6">

                            <label class="form-label">Full Name</label>

                            <input type="text"
                                   name="fname"
                                   class="form-control"
                                   value="<c:out value='${user.fname}'/>"
                                   required>

                        </div>



                        <!-- EMAIL -->
                        <div class="col-md-6">

                            <label class="form-label">Email Address</label>

                            <input type="email"
                                   id="newEmail"
                                   name="email"
                                   class="form-control"
                                   value="<c:out value='${user.email}'/>"
                                   required>

                            <button type="button"
                                    class="btn-custom mt-2"
                                    id="sendOtpBtn">

                                Send OTP

                            </button>

                            <small id="emailMessage"
                                   class="d-block mt-1 text-secondary">

                            </small>

                        </div>



                        <!-- OTP SECTION: Naya email enter karne par visible -->
                        <div class="col-md-6"
                             id="otpSection"
                             style="display:none;">

                            <label class="form-label">Enter OTP</label>

                            <input type="text"
                                   id="profileOtp"
                                   class="form-control"
                                   maxlength="6"
                                   inputmode="numeric"
                                   autocomplete="one-time-code"
                                   placeholder="Enter email OTP">

                            <button type="button"
                                    class="btn-custom mt-2"
                                    id="verifyOtpBtn">

                                Verify OTP

                            </button>

                            <small id="otpMessage"
                                   class="d-block mt-1">

                            </small>

                        </div>


                        <!--
                            Hidden field sirf UI state ke liye hai.
                            Security ke liye backend session mein OTP verification check karna zaroori hai.
                        -->
                        <input type="hidden"
                               id="emailVerified"
                               name="emailVerified"
                               value="false">



                        <!-- PHONE -->
                        <div class="col-md-6">

                            <label class="form-label">Phone Number</label>

                            <input type="tel"
                                   name="phone"
                                   class="form-control"
                                   value="<c:out value='${user.phone}'/>"
                                   required>

                        </div>



                        <!-- GENDER -->
                        <div class="col-md-6">

                            <label class="form-label">Gender</label>

                            <select name="gender" class="form-select">

                                <option value="">Select Gender</option>

                                <option value="Male"
                                    ${user.gender == 'Male' ? 'selected' : ''}>
                                    Male
                                </option>

                                <option value="Female"
                                    ${user.gender == 'Female' ? 'selected' : ''}>
                                    Female
                                </option>

                                <option value="Other"
                                    ${user.gender == 'Other' ? 'selected' : ''}>
                                    Other
                                </option>

                            </select>

                        </div>



                        <!-- ADDRESS -->
                        <div class="col-12">

                            <label class="form-label">Address</label>

                            <textarea name="address"
                                      rows="3"
                                      class="form-control"
                                      required><c:out value="${user.address}"/></textarea>

                        </div>

                    </div>


                    <!-- Profile update button -->
                    <button type="submit" class="btn-custom mt-3">

                        <i class="bi bi-check-circle me-1"></i>
                        Update Profile

                    </button>

                </form>

            </div>

        </div>

    </div>

</section>


</main>



<!-- =====================================================
     JAVASCRIPT LIBRARIES
     ===================================================== -->

<!-- Bootstrap JS bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery library: DOM manipulation, events aur AJAX ke liye -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>



<script>

/*
=========================================================
DOCUMENT READY
=========================================================

jQuery ka $(document).ready() tab execute hota hai
jab HTML document ka DOM structure load ho chuka hota hai.

Iske andar hum event handlers aur initial functions set karte hain.
*/

$(document).ready(function() {


    /*
    =====================================================
    1. SHOW VIEW FUNCTION
    =====================================================

    Dashboard, Documents, Images aur Profile mein se
    jis section ko select karenge sirf wahi visible hoga.

    jQuery:
    addClass()    -> CSS class add karta hai
    removeClass() -> CSS class remove karta hai
    */

    window.showView = function(id, link) {

        // Sabhi sections se active class remove karo
        $(".view").removeClass("active");

        // Selected section ko active karo
        $("#" + id).addClass("active");


        // Sidebar ke main links se purani active class remove karo
        $(".sidebar > a").removeClass("active");

        // Agar user ne sidebar link click kiya hai
        if (link) {

            $(link).addClass("active");

        } else {

            // Programmatically section open hua toh matching link active karo
            $('.sidebar > a[href="#' + id + '"]').addClass("active");

        }


        // Documents section open hone par search/pagination refresh
        if (id === "documents") {

            filterDocuments();

        }


        // Images section open hone par image filtering refresh
        if (id === "images") {

            filterImages();

        }


        // Mobile par section select hone ke baad sidebar close karo
        if ($(window).width() <= 768) {

            $("#sidebar").removeClass("mobile-open");

        }


        // Page ko smoothly top par le jao
        $("html, body").animate({

            scrollTop: 0

        }, 300);

    };



    /*
    =====================================================
    2. TOGGLE SUBMENU
    =====================================================

    slideToggle():
    Agar submenu hidden hai toh show karega.
    Agar visible hai toh hide karega.
    */

    window.toggleSubmenu = function() {

        $("#uploadSubmenu").stop(true, true).slideToggle(200);

    };



    /*
    =====================================================
    3. TOGGLE MOBILE SIDEBAR
    =====================================================

    toggleClass():
    Class available hai toh remove karta hai.
    Class available nahi hai toh add karta hai.
    */

    window.toggleSidebar = function() {

        $("#sidebar").toggleClass("mobile-open");

    };



    /*
    =====================================================
    4. SCROLL TO UPLOAD SECTION
    =====================================================

    offset().top se element ki document ke according position milti hai.
    animate() smooth scrolling ke liye use hota hai.
    */

    window.scrollToUpload = function(id) {

        var target = $("#" + id);

        if (target.length) {

            $("html, body").animate({

                scrollTop: target.offset().top - 75

            }, 400);

        }

    };



    /*
    =====================================================
    5. DOCUMENT FILE SELECTION
    =====================================================

    change event tab trigger hota hai jab user file select karta hai.

    this.files:
    File input se selected files ki list deta hai.

    length:
    Selected files ki total count batata hai.
    */

    $("#documentFiles").on("change", function() {

        var totalFiles = this.files.length;

        if (totalFiles > 0) {

            $("#selectedFiles").text(totalFiles + " document(s) selected");

        } else {

            $("#selectedFiles").text("No files selected");

        }

    });



    /*
    =====================================================
    6. IMAGE FILE SELECTION
    =====================================================
    */

    $("#imageFiles").on("change", function() {

        var totalImages = this.files.length;

        if (totalImages > 0) {

            $("#selectedImages").text(totalImages + " image(s) selected");

        } else {

            $("#selectedImages").text("No images selected");

        }

    });



    /*
    =====================================================
    7. DOCUMENT SEARCH AND PAGINATION VARIABLES
    =====================================================

    filteredRows:
    Search ke baad match hone wali document rows store karta hai.

    currentPage:
    Abhi user kaunsa page dekh raha hai, woh store karta hai.

    Ye variables pagination ka state maintain karte hain.
    */

    var filteredRows = [];

    var currentPage = 1;



    /*
    =====================================================
    8. FILTER DOCUMENTS
    =====================================================

    User search box mein filename enter karega.
    Hum har document row ka filename search text se compare karenge.

    toLowerCase():
    Uppercase/lowercase ka difference remove karta hai.

    includes():
    Check karta hai ki ek string ke andar doosri string available hai ya nahi.
    */

    window.filterDocuments = function() {

        var query = $.trim($("#documentSearch").val()).toLowerCase();


        // Pehle saari document rows select karo
        var allRows = $(".document-row");


        // Search ke according matching rows filter karo
        filteredRows = allRows.filter(function() {

            var fileName = String($(this).attr("data-name") || "").toLowerCase();

            return fileName.includes(query);

        }).toArray();


        // Nayi search hamesha first page se start hogi
        currentPage = 1;


        // Filtered result ko pagination ke saath display karo
        renderDocumentPage();

    };



    /*
    =====================================================
    9. RENDER DOCUMENT PAGE
    =====================================================

    Is function ka kaam:
    1. Total pages calculate karna.
    2. Current page ki rows show karna.
    3. Baaki rows hide karna.
    4. Pagination buttons create karna.
    */

    function renderDocumentPage() {

        // Select box se ek page par records ki limit lo
        var pageSize = parseInt($("#pageSize").val(), 10);


        // Search ke baad total matching documents
        var total = filteredRows.length;


        // Total pages calculate karne ka formula
        var pages = Math.ceil(total / pageSize);


        // Agar current page available pages se bada ho gaya toh last page set karo
        if (pages > 0 && currentPage > pages) {

            currentPage = pages;

        }


        // Pehle saari document rows hide karo
        $(".document-row").hide();


        /*
            Starting index formula:

            start = (currentPage - 1) * pageSize

            Example:
            currentPage = 2
            pageSize = 5

            start = (2 - 1) * 5
            start = 5

            Matlab second page ka data index 5 se start hoga.
        */

        var start = (currentPage - 1) * pageSize;


        // Ending index calculate karo
        var end = Math.min(start + pageSize, total);



        /*
            slice(start, end):
            Filtered array ka selected portion return karta hai.

            each():
            Har selected document row par operation perform karta hai.
        */

        filteredRows.slice(start, end).forEach(function(row, index) {

            // Current page ki row show karo
            $(row).show();


            // Table ki first column mein serial number update karo
            $(row).find("td:first").text(start + index + 1);

        });



        // Result information update karo
        if (total === 0) {

            $("#documentInfo").text("No documents found");

        } else {

            $("#documentInfo").text(
                "Showing " + (start + 1) + " to " + end + " of " + total
            );

        }



        /*
            Pagination buttons create karne se pehle
            purane buttons remove kar do.
        */

        var pagination = $("#documentPagination");

        pagination.empty();



        /*
        =================================================
        PAGINATION BUTTON HELPER FUNCTION
        =================================================

        Is function se Previous, Next aur page number buttons
        dynamically create hote hain.

        $('<li>') aur $('<a>'):
        jQuery ke through naye HTML elements create karte hain.
        */

        function addPage(label, page, disabled, active) {

            var li = $("<li>");

            li.addClass("page-item");


            // Disabled button par disabled class
            if (disabled) {

                li.addClass("disabled");

            }


            // Current page par active class
            if (active) {

                li.addClass("active");

            }


            var anchor = $("<a>");

            anchor.addClass("page-link");

            anchor.attr("href", "#documents");

            anchor.text(label);


            // Button click event
            anchor.on("click", function(event) {

                // Default anchor navigation ko prevent karo
                event.preventDefault();


                // Disabled button click par kuch nahi hoga
                if (disabled) {

                    return;

                }


                // Current page update karo
                currentPage = page;


                // Updated page ka data render karo
                renderDocumentPage();

            });


            // Anchor ko li ke andar add karo
            li.append(anchor);


            // Li ko pagination list mein add karo
            pagination.append(li);

        }



        // Previous button
        addPage(
            "Previous",
            currentPage - 1,
            currentPage <= 1,
            false
        );


        // Har page number ka button create karo
        for (var p = 1; p <= pages; p++) {

            addPage(
                p,
                p,
                false,
                p === currentPage
            );

        }


        // Next button
        addPage(
            "Next",
            currentPage + 1,
            pages === 0 || currentPage >= pages,
            false
        );

    }



    /*
    =====================================================
    10. IMAGE SEARCH
    =====================================================

    Image filename ke basis par gallery filter hoti hai.

    show():
    Matching image card visible karta hai.

    hide():
    Non-matching image card hide karta hai.
    */

    window.filterImages = function() {

        var query = $.trim($("#imageSearch").val()).toLowerCase();


        $(".image-item").each(function() {

            var fileName = String($(this).attr("data-name") || "").toLowerCase();


            if (fileName.includes(query)) {

                $(this).show();

            } else {

                $(this).hide();

            }

        });

    };



    /*
    =====================================================
    11. PROFILE PHOTO PREVIEW
    =====================================================

    User nayi photo select karega toh form submit hone se pehle
    browser mein uska preview display hoga.

    URL.createObjectURL():
    Selected file ke liye temporary browser URL create karta hai.
    */

    $("#profilePhoto").on("change", function() {

        var file = this.files[0];


        // User ne koi file select nahi ki toh function stop
        if (!file) {

            return;

        }


        // Allowed image formats
        var allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/webp"
        ];


        // File MIME type validation
        if (!allowedTypes.includes(file.type)) {

            alert("Please select a JPG, PNG or WEBP image.");

            // Invalid file selection clear karo
            $(this).val("");

            return;

        }


        // Temporary URL create karke preview image update karo
        var imageURL = URL.createObjectURL(file);

        $("#profilePreview").attr("src", imageURL);

    });



    /*
    =====================================================
    12. EMAIL AND OTP VERIFICATION VARIABLES
    =====================================================

    originalEmail:
    Database se aaya hua existing email.

    verifiedEmail:
    OTP successfully verify hone ke baad verified email.

    Client-side variables sirf UI control karte hain.
    Actual security backend session verification se honi chahiye.
    */

    var originalEmail = $.trim($("#newEmail").val());

    var verifiedEmail = originalEmail;



    /*
    =====================================================
    13. EMAIL VERIFICATION STATE
    =====================================================

    Agar email original hai toh OTP required nahi.

    Agar email change hua hai toh OTP verification required hai.
    */

    function updateEmailVerificationState() {

        var currentEmail = $.trim($("#newEmail").val());


        var isOriginalEmail =
            currentEmail.toLowerCase() === originalEmail.toLowerCase();


        var isVerified =
            currentEmail.toLowerCase() === verifiedEmail.toLowerCase();



        // Hidden input ko UI ke according update kar rahe hain
        $("#emailVerified").val(
            (isOriginalEmail || isVerified) ? "true" : "false"
        );


        // Original email ke liye OTP section hide
        if (isOriginalEmail) {

            $("#otpSection").hide();

            $("#emailMessage").text("");

            $("#otpMessage").text("");

        } else {

            // New email ke liye OTP section show
            $("#otpSection").show();


            if (!isVerified) {

                $("#emailMessage")
                    .removeClass("text-success")
                    .addClass("text-secondary")
                    .text("Verify this new email before updating your profile.");

            }

        }

    }



    /*
    =====================================================
    14. EMAIL INPUT CHANGE EVENT
    =====================================================

    Jab bhi user email change karega,
    verification state dobara check hogi.
    */

    $("#newEmail").on("input", function() {

        // Naya email enter karne par old OTP result clear karo
        verifiedEmail = originalEmail;

        $("#otpMessage").text("").removeClass("text-success text-danger");

        updateEmailVerificationState();

    });



    /*
    =====================================================
    15. SEND OTP USING AJAX
    =====================================================

    AJAX:
    Asynchronous JavaScript and XML.

    Iska use page reload kiye bina server ko request bhejne ke liye hota hai.

    $.ajax():
    jQuery ka AJAX method hai.

    type: POST:
    Data server ko POST request ke through bhejta hai.

    data:
    Controller ko email parameter bhejta hai.
    */

    window.sendProfileOtp = function() {

        var email = $.trim($("#newEmail").val());


        // Email message element
        var message = $("#emailMessage");


        // Empty email validation
        if (!email) {

            message.text("Please enter an email address.");

            return;

        }


        // Same email par OTP bhejne ki zaroorat nahi
        if (email.toLowerCase() === originalEmail.toLowerCase()) {

            message.text("This is already your current email.");

            return;

        }


        // Email format validation
        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailPattern.test(email)) {

            message.text("Please enter a valid email address.");

            return;

        }


        // Purani verification reset karo
        verifiedEmail = originalEmail;

        $("#emailVerified").val("false");

        $("#otpMessage").text("").removeClass("text-success text-danger");


        // Button ko temporarily disable karo
        $("#sendOtpBtn").prop("disabled", true).text("Sending...");



        /*
            $.ajax() server ke saath communication karta hai.

            URL:
            Spring MVC controller ka existing mapping.

            data:
            Email parameter server ko send hoga.

            dataType: text:
            Controller se plain text response expect kar rahe hain.
        */

        $.ajax({

            url: "${pageContext.request.contextPath}/profile/sendOtp",

            type: "POST",

            data: {
                email: email
            },

            dataType: "text",


            // Request successful hone par
            success: function(response) {

                var result = $.trim(response);


                // Backend ka plain text response display karo
                message.text(result || "Check your email for the OTP.");

            },


            // Server/network error hone par
            error: function(xhr, status, error) {

                message.text(
                    "Unable to send OTP. Check your controller mapping and try again."
                );

            },


            // Success ya error dono cases mein button enable karo
            complete: function() {

                $("#sendOtpBtn")
                    .prop("disabled", false)
                    .text("Send OTP");

            }

        });

    };



    /*
    =====================================================
    16. VERIFY OTP USING AJAX
    =====================================================

    User ka entered OTP backend ko send hoga.

    Backend session mein stored OTP ke saath compare karega.

    Important:
    Sirf frontend par OTP compare karna secure nahi hai.
    Verification backend par honi chahiye.
    */

    window.verifyProfileOtp = function() {

        var email = $.trim($("#newEmail").val());

        var otp = $.trim($("#profileOtp").val());

        var message = $("#otpMessage");



        // Email aur OTP dono required hain
        if (!email || !otp) {

            message
                .removeClass("text-success")
                .addClass("text-danger")
                .text("Enter your email and OTP.");

            return;

        }


        // OTP numeric aur 6 digit hona chahiye
        if (!/^\d{6}$/.test(otp)) {

            message
                .removeClass("text-success")
                .addClass("text-danger")
                .text("Please enter a valid 6-digit OTP.");

            return;

        }


        // Verify button temporarily disable karo
        $("#verifyOtpBtn").prop("disabled", true).text("Verifying...");



        /*
            Backend ko email aur OTP POST request mein send kar rahe hain.
        */

        $.ajax({

            url: "${pageContext.request.contextPath}/profile/verifyOtp",

            type: "POST",

            data: {
                email: email,
                otp: otp
            },

            dataType: "text",


            // Backend response receive hone par
            success: function(response) {

                var result = $.trim(response);


                /*
                    Tumhare controller ke according:
                    "OTP Verified" = Successful verification
                    Other response = Invalid OTP ya error
                */

                if (result === "OTP Verified") {

                    // Verified email ko save karo
                    verifiedEmail = email;


                    // UI verification state update karo
                    $("#emailVerified").val("true");


                    message
                        .removeClass("text-danger")
                        .addClass("text-success")
                        .text("Email verified successfully.");


                    $("#emailMessage")
                        .removeClass("text-secondary")
                        .addClass("text-success")
                        .text("New email verified. You can update your profile.");

                } else {

                    // Invalid OTP par email verified nahi rahega
                    verifiedEmail = originalEmail;

                    $("#emailVerified").val("false");


                    message
                        .removeClass("text-success")
                        .addClass("text-danger")
                        .text(result || "Invalid or expired OTP.");

                }

            },


            // Server error handling
            error: function() {

                message
                    .removeClass("text-success")
                    .addClass("text-danger")
                    .text("Unable to verify OTP. Check your controller mapping and try again.");

            },


            // Request complete hone par button enable
            complete: function() {

                $("#verifyOtpBtn")
                    .prop("disabled", false)
                    .text("Verify OTP");

            }

        });

    };



    /*
    =====================================================
    17. PROFILE FORM SUBMIT VALIDATION
    =====================================================

    Submit event form submit hone se pehle execute hota hai.

    preventDefault():
    Default form submission ko rokta hai.

    Agar email change hua hai aur OTP verify nahi hua,
    toh profile form submit nahi hone denge.
    */

    $("#profileForm").on("submit", function(event) {

        var email = $.trim($("#newEmail").val());


        var isOriginalEmail =
            email.toLowerCase() === originalEmail.toLowerCase();


        var isVerified =
            email.toLowerCase() === verifiedEmail.toLowerCase();



        // Changed email verified nahi hai toh submission stop
        if (!isOriginalEmail && !isVerified) {

            event.preventDefault();

            alert("Please verify your new email address through OTP first.");

            return false;

        }

    });



    /*
    =====================================================
    18. DELETE CONFIRMATION
    =====================================================

    Document ya image delete karne se pehle confirmation.
    */

    $(".delete-form").on("submit", function(event) {

        var confirmed = confirm("Are you sure you want to delete this file?");

        if (!confirmed) {

            event.preventDefault();

        }

    });



    /*
    =====================================================
    19. DOCUMENT SEARCH EVENT
    =====================================================

    keyup/input event par search function call hota hai.
    */

    $("#documentSearch").on("input", function() {

        filterDocuments();

    });



    /*
    =====================================================
    20. PAGE SIZE CHANGE EVENT
    =====================================================

    User Show 5 se Show 10 select karega,
    toh pagination first page se dobara calculate hogi.
    */

    $("#pageSize").on("change", function() {

        filterDocuments();

    });



    /*
    =====================================================
    21. IMAGE SEARCH EVENT
    =====================================================
    */

    $("#imageSearch").on("input", function() {

        filterImages();

    });



    /*
    =====================================================
    22. INITIAL PAGE SETUP
    =====================================================

    Page load hone par:
    1. Document pagination initialize.
    2. Image filtering initialize.
    3. Email verification state initialize.
    4. URL hash ke according section open.
    */

    filterDocuments();

    filterImages();

    updateEmailVerificationState();



    /*
        Agar URL mein #documents, #images ya #profile hai,
        toh corresponding section open karenge.
    */

    var pageHash = window.location.hash;


    if (pageHash === "#documents") {

        showView("documents", null);

    } else if (pageHash === "#images") {

        showView("images", null);

    } else if (pageHash === "#profile") {

        showView("profile", null);

    } else {

        showView("dashboard", null);

    }



    /*
    =====================================================
    23. SUCCESS / ERROR MESSAGE AUTO HIDE
    =====================================================

    delay(3000):
    3 seconds wait karega.

    fadeOut():
    Message ko smoothly hide karega.
    */

    $("#successMsg, #errorMsg").delay(3000).fadeOut(500);


});

</script>



<!-- =====================================================
     SESSION EMAIL MESSAGE
     ===================================================== -->

<!-- Agar entered email already registered hai toh alert show karo -->
<c:if test="${not empty sessionScope.emailHaiYeRegister}">

    <script>

        alert("<c:out value='${sessionScope.emailHaiYeRegister}'/>");

    </script>

    <!-- Alert display hone ke baad session attribute remove -->
    <c:remove var="emailHaiYeRegister" scope="session"/>

</c:if>


</body>
</html>
