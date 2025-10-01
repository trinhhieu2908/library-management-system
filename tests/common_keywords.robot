*** Settings ***
Library    SeleniumLibrary
Resource  common_variables.robot

*** Keywords ***
Open Library System
    [Documentation]    Opens the Library Management System
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}

Close Library System
    [Documentation]    Closes the browser
    Close Browser

Login
    [Documentation]    Logs in as staff
    [Arguments]    ${username}=${STAFF_USERNAME}    ${password}=${STAFF_PASSWORD}
    Go To    ${BASE_URL}/stafflogin/
    Wait Until Page Contains    ${LOGIN_PAGE_TITLE}    ${SHORT_TIMEOUT}
    Input Text    name:loginuname    ${username}
    Input Text    name:loginpassword    ${password}
    Click Button    Login

Logout
    [Documentation]    Logs out from the system
    Click Link    Logout
    Wait Until Page Contains    ${LOGIN_PAGE_TITLE}    ${SHORT_TIMEOUT}

Navigate To Dashboard
    [Documentation]    Navigates to the dashboard
    Go To    ${BASE_URL}/
