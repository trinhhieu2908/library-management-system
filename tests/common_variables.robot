*** Variables ***
# Base URL for the Library Management System
${BASE_URL}              http://localhost:8000
${BROWSER}               chrome

# URLs
${LOGIN_URL}             ${BASE_URL}/stafflogin/
${SIGNUP_URL}            ${BASE_URL}/staffsignup/
${DASHBOARD_URL}         ${BASE_URL}/dashboard/

# Page Titles
${LOGIN_PAGE_TITLE}      Staff Login
${SIGNUP_PAGE_TITLE}     STAFF SIGNUP
${DASHBOARD_TITLE}       TechVidvanLibrary

# Timeouts
${TIMEOUT}               3s
${SHORT_TIMEOUT}         0.5s

# Success Messages
${LOGIN_SUCCESSFULLY_MESSAGE}    Successfully logged in

# Error Messages
${USERNAME_ALREADY_TAKEN_MESSAGE}    Username already taken
${INVALID_USERNAME_MESSAGE}    Username should only contain letters and numbers
${INVALID_CREDENTIALS_MESSAGE}    Invalid Credentials

# Test Data
${STAFF_USERNAME}        trinhhieu
${STAFF_PASSWORD}        123456aA@
${STUDENT_ID}            S394100
${BOOK_ID}               BK001


