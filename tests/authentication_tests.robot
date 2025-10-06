*** Settings ***
Documentation    Authentication tests covering signup, login, and logout functionality
Library    SeleniumLibrary
Resource   common_keywords.robot
Resource  common_variables.robot

Suite Setup    Open Library System
Suite Teardown    Close Library System
Test Setup    Set Selenium Speed    0.5s

*** Variables ***
# Signup Test Data
${NEW_USERNAME}          user003
${NEW_FIRST_NAME}        Test
${NEW_LAST_NAME}         User3
${NEW_EMAIL}             user003@gmail.com
${NEW_PHONE}             0401234567
${NEW_PASSWORD}          TestPass123
${INVALID_USERNAME}      test-user@123

*** Keywords ***
Fill Signup Form
    [Documentation]    Fills the signup form with provided data
    [Arguments]    ${username}    ${fname}    ${lname}    ${email}    ${phone}    ${password}
    Input Text    name:uname    ${username}
    Input Text    name:fname    ${fname}
    Input Text    name:lname    ${lname}
    Input Text    name:email    ${email}
    Input Text    name:phone    ${phone}
    Input Text    name:password    ${password}

Submit Signup Form
    [Documentation]    Submits the signup form
    Click Button    Create

*** Test Cases ***
# Signup Tests
Verify Signup Page Loads
    [Documentation]    Test that the signup page loads successfully
    Go To    ${SIGNUP_URL}
    Page Should Contain    ${SIGNUP_PAGE_TITLE}
    Page Should Contain Element    name:uname
    Page Should Contain Element    name:fname
    Page Should Contain Element    name:lname
    Page Should Contain Element    name:email
    Page Should Contain Element    name:phone
    Page Should Contain Element    name:password

Signup with Valid Data
    [Documentation]    Test successful user registration with valid data
    Go To    ${SIGNUP_URL}
    Fill Signup Form    ${NEW_USERNAME}    ${NEW_FIRST_NAME}    ${NEW_LAST_NAME}    ${NEW_EMAIL}    ${NEW_PHONE}    ${NEW_PASSWORD}
    Submit Signup Form
    # Verify redirect to login page
    Wait Until Page Contains    ${LOGIN_PAGE_TITLE}    ${SHORT_TIMEOUT}
    Page Should Contain    ${LOGIN_PAGE_TITLE}

Signup with Duplicate Username
    [Documentation]    Test signup with existing username should show error
    Go To    ${SIGNUP_URL}
    Fill Signup Form    ${NEW_USERNAME}    ${NEW_FIRST_NAME}    ${NEW_LAST_NAME}    ${NEW_EMAIL}    ${NEW_PHONE}    ${NEW_PASSWORD}
    Submit Signup Form
    Wait Until Page Contains    ${USERNAME_ALREADY_TAKEN_MESSAGE}    ${SHORT_TIMEOUT}
    Page Should Contain    ${USERNAME_ALREADY_TAKEN_MESSAGE}

Signup with Invalid Username
    [Documentation]    Test signup with non-alphanumeric username
    Go To    ${SIGNUP_URL}
    Fill Signup Form    ${INVALID_USERNAME}    ${NEW_FIRST_NAME}    ${NEW_LAST_NAME}    ${NEW_EMAIL}    ${NEW_PHONE}    ${NEW_PASSWORD}
    Submit Signup Form
    Wait Until Page Contains    ${INVALID_USERNAME_MESSAGE}    ${SHORT_TIMEOUT}
    Page Should Contain    ${INVALID_USERNAME_MESSAGE}

# Login Tests
Verify Login Page Loads
    [Documentation]    Test that the login page loads successfully and contains required elements
    Go To    ${LOGIN_URL}
    Page Should Contain    ${LOGIN_PAGE_TITLE}
    Page Should Contain Element    name:loginuname
    Page Should Contain Element    name:loginpassword

Login with Invalid Credentials
    [Documentation]    Test login with invalid credentials
    Login    invaliduser    wrongpassword
    Wait Until Page Contains    ${INVALID_CREDENTIALS_MESSAGE}    ${SHORT_TIMEOUT}
    Page Should Contain    ${INVALID_CREDENTIALS_MESSAGE}

Login with Valid Credentials
    [Documentation]    Test successful login with valid credentials
    Login     ${NEW_USERNAME}    ${NEW_PASSWORD}
    Page Should Contain    ${LOGIN_SUCCESSFULLY_MESSAGE}

# Logout Tests
Logout Test
    [Documentation]    Test successful logout functionality
    Page Should Contain    ${DASHBOARD_TITLE}
    Logout
    Wait Until Page Contains    ${LOGIN_PAGE_TITLE}    ${SHORT_TIMEOUT}
    Page Should Contain    ${LOGIN_PAGE_TITLE}

Try access dashboard after logging out
    [Documentation]    Test accessing dashboard without logging in
    Go To    ${DASHBOARD_URL}
    Page Should Contain    ${LOGIN_PAGE_TITLE}
