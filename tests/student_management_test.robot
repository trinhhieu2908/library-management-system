*** Settings ***
Resource    common_keywords.robot
Resource    common_variables.robot

Suite Setup       Open Library System
Suite Teardown    Close Library System
Test Setup    Set Selenium Speed    0.1s

# *** Keywords ***
# Login
#     [Documentation]    Logs in as staff
#     [Arguments]    ${username}=darkdevilxy    ${password}=aayushgta
#     Go To    ${LOGIN_URL}
#     Wait Until Page Contains    ${LOGIN_PAGE_TITLE}    ${SHORT_TIMEOUT}
#     Input Text    name:loginuname    ${username}
#     Input Text    name:loginpassword    ${password}
#     Click Button    Login

# *** Variables ***
# ${add_student}    ${BASE_URL}/addstudent/

*** Test Cases ***
Add Student
    [Documentation]    Add a student, view all students, and verify the student appears in the list.
    Run Keyword And Ignore Error    Login
    Run Keyword    Navigate To Dashboard
    Click Link    Add Student
    Page Should Contain    Student name:
    Page Should Contain    Student Id:
    Input Text    name:sname    Test Student
    Input Text    name:studentid    STU12345
    Click Button    Submit

Check For Student
    [Documentation]    Check if the added student exists or not
    Run Keyword    Navigate To Dashboard
    Click Link    View Student
    Wait Until Page Contains    Student Name
    Wait Until Page Contains    Student Id
    Page Should Contain    Test Student
    Page Should Contain    STU12345
    Logout

Search Student Using Student ID
    [Documentation]    Use search bar to look for newly added student
    Run Keyword And Ignore Error    Login
    Run Keyword    Navigate To Dashboard
    Click Link    View Student
    Wait Until Page Contains    Student Id
    Wait Until Page Contains    Student Name
    Input Text    name:query3    STU12345
    Click Button    Submit
    Page Should Contain    Test Student
    Page Should Contain    STU12345
    Logout

Add Student With Missing Name
    [Documentation]    Try to add a student without a name, expect an error.
    Run Keyword And Ignore Error    Login
    Run Keyword    Navigate To Dashboard
    Click Link    Add Student
    Page Should Contain    Student name:
    Page Should Contain    Student Id:
    Input Text    name:sname    ''
    Input Text    name:studentid    STU99999
    Click Button    Submit
    Wait Until Page Contains    Name is required

Add Student With Invalid ID
    [Documentation]    Try to add a student with an invalid ID, expect an error.
    Run Keyword And Ignore Error    Login
    Run Keyword    Navigate To Dashboard
    Click Link    Add Student
    Page Should Contain    Student name:
    Page Should Contain    Student Id:
    Input Text    name:sname    Invalid Student
    Input Text    name:studentid    @@@@
    Click Button    Submit
    Wait Until Page Contains    Invalid student ID

Search For Nonexistent Student
    [Documentation]    Search for a student ID that does not exist, expect not found message.
    Run Keyword And Ignore Error    Login
    Run Keyword    Navigate To Dashboard
    Click Link    View Student
    Wait Until Page Contains    Student Id
    Wait Until Page Contains    Student Name
    Input Text    name:query3    DOESNOTEXIST
    Click Button    Submit
    Wait Until Page Contains    Student not found