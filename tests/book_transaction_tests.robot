*** Settings ***
Documentation    Book transaction tests covering issue and return scenarios
Library    SeleniumLibrary
Resource   common_keywords.robot
Resource  common_variables.robot

Suite Setup    Open Library System
Suite Teardown    Close Library System
Test Setup    Set Selenium Speed    0.5s

*** Variables ***
${STUDENT_ID}            S394100
${BOOK_ID}               BK001
${BOOK_NAME}             Python
${NON_EXISTENT_BOOK_ID}  BK9999

*** Keywords ***
Fill Issue Book Form
    [Arguments]    ${book_id}    ${student_id}
    Input Text    name:book1    ${book_id}
    Input Text    name:studentid    ${student_id}

Fill Return Book Form
    [Arguments]    ${book_id}
    Input Text    name:bookid2    ${book_id}

Submit Form
    Click Button    Submit

*** Test Cases ***
Verify Issue Book Page Loads
    [Documentation]    Verify that the issue book page loads successfully
    Login
    Go To    ${BOOK_ISSUE_URL}
    Page Should Contain    ${BOOK_ISSUE_PAGE_TITLE}
    Page Should Contain Element    name:book1
    Page Should Contain Element    name:studentid

Issue Book With Valid Data
    [Documentation]    Issue a book to an existing student with valid data
    Go To    ${BOOK_ISSUE_URL}
    Fill Issue Book Form    ${BOOK_ID}    ${STUDENT_ID}
    Submit Form
    Go To    ${VIEW_ISSUED_BOOK_URL}
    # Expect book to appear in issued list
    Page Should Contain    ${BOOK_NAME}

Issue Book Already Issued
    [Documentation]    Attempt to issue the same book again; system should show an error
    Go To    ${BOOK_ISSUE_URL}
    Fill Issue Book Form    ${BOOK_ID}    ${STUDENT_ID}
    Submit Form
    Page Should Contain    ${BOOK_ALREADY_ISSUED_MESSAGE}

Issue Book With Unknown ID
    [Documentation]    Attempt to issue a non-existent book id; system should show an error
    Go To    ${BOOK_ISSUE_URL}
    Fill Issue Book Form    ${NON_EXISTENT_BOOK_ID}    ${STUDENT_ID}
    Submit Form
    Page Should Contain    ${BOOK_ID_NOT_FOUND_MESSAGE}

Verify Return Book Page Loads
    [Documentation]    Verify that the return book page loads successfully
    Go To    ${BOOK_RETURN_URL}
    Page Should Contain    ${BOOK_RETURN_PAGE_TITLE}
    Page Should Contain Element    name:bookid2

Return Issued Book
    [Documentation]    Return the issued book with valid data
    Go To    ${BOOK_RETURN_URL}
    Fill Return Book Form    ${BOOK_ID}
    Submit Form
    # Expect book to not appear in issued list
    Go To    ${VIEW_ISSUED_BOOK_URL}
    Page Should Not Contain    ${BOOK_ID}

Return Not-Issued Book
    [Documentation]    Attempt to return the same book again; system should show an error
    Go To    ${BOOK_RETURN_URL}
    Fill Return Book Form    ${BOOK_ID}
    Submit Form
    Page Should Contain    ${BOOK_NOT_ISSUED_MESSAGE}

Return Book With Unknown ID
    [Documentation]    Attempt to return a non-existent book id; system should show an error
    Go To    ${BOOK_RETURN_URL}
    Fill Return Book Form    ${NON_EXISTENT_BOOK_ID}
    Submit Form
    Page Should Contain    ${BOOK_ID_NOT_FOUND_MESSAGE}
