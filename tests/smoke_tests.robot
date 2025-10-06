*** Settings ***
Documentation    Smoke tests to verify basic system functionality
Library    SeleniumLibrary
Resource   common_keywords.robot
Resource  common_variables.robot

Suite Setup    Open Library System
Suite Teardown    Close Library System
Test Setup    Set Selenium Speed    1s

*** Test Cases ***
Verify Homepage Loads
    [Documentation]    Test that the homepage loads successfully
    Go To    ${BASE_URL}
    Wait Until Page Contains    TechVidvan Library Management    ${SHORT_TIMEOUT}
    Page Should Contain    TechVidvan Library Management

