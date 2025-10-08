*** Variables ***
# Base URL for the Library Management System
${BASE_URL}              http://localhost:8000
${BROWSER}               chrome

# URLs
${LOGIN_URL}             ${BASE_URL}/stafflogin/
${SIGNUP_URL}            ${BASE_URL}/staffsignup/
${DASHBOARD_URL}         ${BASE_URL}/dashboard/
${BOOK_ISSUE_URL}        ${BASE_URL}/bookissue/
${BOOK_RETURN_URL}       ${BASE_URL}/returnbook/
${VIEW_ISSUED_BOOK_URL}  ${BASE_URL}/viewissuedbook/

# Page Titles
${LOGIN_PAGE_TITLE}      Staff Login
${SIGNUP_PAGE_TITLE}     STAFF SIGNUP
${DASHBOARD_TITLE}       TechVidvanLibrary
${BOOK_ISSUE_PAGE_TITLE}    Issue Book
${BOOK_RETURN_PAGE_TITLE}    Return Book
${VIEW_ISSUED_BOOK_PAGE_TITLE}    View Issued Book

# Timeouts
${TIMEOUT}               3s
${SHORT_TIMEOUT}         0.5s

# Success Messages
${LOGIN_SUCCESSFULLY_MESSAGE}    Successfully logged in

# Error Messages
${USERNAME_ALREADY_TAKEN_MESSAGE}    Username already taken
${INVALID_USERNAME_MESSAGE}    Username should only contain letters and numbers
${INVALID_CREDENTIALS_MESSAGE}    Invalid Credentials
${BOOK_ALREADY_ISSUED_MESSAGE}    Book already issued
${BOOK_NOT_ISSUED_MESSAGE}    Book not issued
${BOOK_ID_NOT_FOUND_MESSAGE}    Book id not found

# Test Data
${STAFF_USERNAME}        trinhhieu
${STAFF_PASSWORD}        123456aA@
