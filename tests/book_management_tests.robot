*** Settings ***
Documentation    Book Management Test Suite for Library Management System
...              Tests the complete book lifecycle: Add, Edit, Delete, Search with assertions

Library          SeleniumLibrary
Library          String
Resource         common_keywords.robot
Resource         common_variables.robot

Suite Setup      Open Library System
Suite Teardown   Close Library System
Test Setup    Set Selenium Speed    0.1s

*** Keywords ***
Navigate To Dashboard
    [Documentation]    Navigates to the dashboard page
    Go To    ${DASHBOARD_URL}
    Wait Until Page Contains Element    ${SIDEBAR}    timeout=${TIMEOUT}
    Wait Until Page Contains Element    ${BOOKS_TABLE}    timeout=${TIMEOUT}

Navigate To Add Book Page
    [Documentation]    Navigates to the add book page
    Navigate To Dashboard
    Wait Until Element Is Visible    ${ADD_BOOK_LINK}    timeout=${TIMEOUT}
    Click Element    ${ADD_BOOK_LINK}
    Wait Until Page Contains Element    ${BOOK_ID_FIELD}    timeout=${TIMEOUT}
    Location Should Be    ${ADD_BOOK_URL}

Fill Book Form
    [Documentation]    Fills in the book form with provided details
    [Arguments]    ${bookid}    ${bookname}    ${subject}    ${category}
    Input Text    ${BOOK_ID_FIELD}        ${bookid}
    Input Text    ${BOOK_NAME_FIELD}      ${bookname}
    Input Text    ${BOOK_SUBJECT_FIELD}   ${subject}
    Input Text    ${BOOK_CATEGORY_FIELD}  ${category}

Submit Book Form
    [Documentation]    Submits the book form
    Click Element    ${SUBMIT_BUTTON}
    Sleep    1s

Verify Book In Dashboard Table
    [Documentation]    Verifies that a book appears in the dashboard table
    [Arguments]    ${bookid}
    Navigate To Dashboard
    Wait Until Page Contains Element    ${BOOKS_TABLE}    timeout=${TIMEOUT}
    Page Should Contain    ${bookid}

Verify Book Details In Table
    [Documentation]    Verifies book details appear correctly
    [Arguments]    ${bookid}    ${bookname}    ${subject}    ${category}
    Navigate To Dashboard
    Page Should Contain    ${bookid}
    Page Should Contain    ${bookname}
    Page Should Contain    ${subject}
    Page Should Contain    ${category}

Click Edit Button For Book
    [Documentation]    Clicks the edit button for a specific book
    [Arguments]    ${bookid}
    Navigate To Dashboard
    ${edit_locator}=    Replace String    ${EDIT_BUTTON_XPATH}    {bookid}    ${bookid}
    Wait Until Element Is Visible    ${edit_locator}    timeout=${TIMEOUT}
    Click Element    ${edit_locator}
    Wait Until Page Contains Element    ${BOOK_ID_FIELD}    timeout=${TIMEOUT}

Update Form Field
    [Documentation]    Clears and updates a form field
    [Arguments]    ${locator}    ${new_value}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${new_value}

Click Delete Button For Book
    [Documentation]    Clicks the delete button for a specific book
    [Arguments]    ${bookid}
    Navigate To Dashboard
    ${delete_locator}=    Replace String    ${DELETE_BUTTON_XPATH}    {bookid}    ${bookid}
    Wait Until Element Is Visible    ${delete_locator}    timeout=${TIMEOUT}
    Click Element    ${delete_locator}
    Sleep    1s

Verify Book Not In Dashboard Table
    [Documentation]    Verifies book does not appear in table
    [Arguments]    ${bookid}
    Navigate To Dashboard
    Wait Until Page Contains Element    ${BOOKS_TABLE}    timeout=${TIMEOUT}
    Page Should Not Contain    ${bookid}

Search For Book By BookId
    [Documentation]    Searches for a book using bookid
    [Arguments]    ${bookid}
    Navigate To Dashboard
    Wait Until Element Is Visible    ${SEARCH_FIELD}    timeout=${TIMEOUT}
    Input Text    ${SEARCH_FIELD}    ${bookid}
    Click Element    ${SEARCH_SUBMIT_BUTTON}
    Sleep    1s

Get Row Count In Books Table
    [Documentation]    Returns the number of book rows in table
    Navigate To Dashboard
    ${count}=    Get Element Count    xpath://table[@id='dataTable']//tr[td]
    [Return]    ${count}


*** Variables ***
# Book Test Data
${BOOK_ID_1}           BK001
${BOOK_NAME_1}         The Great Gatsby
${BOOK_SUBJECT_1}      Literature
${BOOK_CATEGORY_1}     Not-Issued

${BOOK_ID_2}           BK002
${BOOK_NAME_2}         To Kill a Mockingbird
${BOOK_SUBJECT_2}      Fiction
${BOOK_CATEGORY_2}     Not-Issued

${BOOK_ID_3}           BK003
${BOOK_NAME_3}         1984
${BOOK_SUBJECT_3}      Dystopian
${BOOK_CATEGORY_3}     Not-Issued

${BOOK_ID_4}           BK004
${BOOK_NAME_4}         Python Programming
${BOOK_SUBJECT_4}      Technology
${BOOK_CATEGORY_4}     Not-Issued

# Updated Book Data (for edit tests)
${UPDATED_BOOK_NAME}   The Great Gatsby - Updated Edition
${UPDATED_SUBJECT}     Classic Literature
${UPDATED_CATEGORY}    Issued

# Search Test Data
${SEARCH_VALID}        BK001
${SEARCH_INVALID}      BK999

# Element Locators - Login Page
${LOGIN_USERNAME_FIELD}    id:loginuname
${LOGIN_PASSWORD_FIELD}    id:loginpassword
${LOGIN_SUBMIT_BUTTON}     xpath://input[@type='submit'][@value='Login']

# Element Locators - Dashboard/Books
${SIDEBAR}                 xpath://div[@class='sidebar']
${ADD_BOOK_LINK}           xpath://a[@href='/addbook/']
${BOOKS_TABLE}             id:dataTable

# Element Locators - Book Form
${BOOK_ID_FIELD}           id:bookid
${BOOK_NAME_FIELD}         id:bookname
${BOOK_SUBJECT_FIELD}      id:subject
${BOOK_CATEGORY_FIELD}     id:category
${SUBMIT_BUTTON}           xpath://button[@type='submit']

# Element Locators - Search
${SEARCH_FIELD}            id:query2
${SEARCH_SUBMIT_BUTTON}    xpath://form[@action='/Search/']//button[@type='submit']

# Element Locators - Actions (Dynamic)
${EDIT_BUTTON_XPATH}       xpath://td[contains(text(),'{bookid}')]/following-sibling::td//a[contains(@class,'btn-success')]
${DELETE_BUTTON_XPATH}     xpath://td[contains(text(),'{bookid}')]/following-sibling::td//a[contains(@class,'btn-danger')]

*** Test Cases ***
Add Book With Valid Data
    [Documentation]    Add a book with valid information and assert it appears in dashboard
    [Tags]    add    positive
    
    Login
    # Navigate to Add Book page
    Click Element    ${ADD_BOOK_LINK}
    Wait Until Page Contains Element    ${BOOK_ID_FIELD}    timeout=${TIMEOUT}
    
    # Fill book form with valid data
    Fill Book Form    
    ...    ${BOOK_ID_1}
    ...    ${BOOK_NAME_1}
    ...    ${BOOK_SUBJECT_1}
    ...    ${BOOK_CATEGORY_1}
    
    # Submit the form
    Submit Book Form
    Sleep    2s
    
    # Assert: Verify book appears in dashboard table
    Verify Book In Dashboard Table    ${BOOK_ID_1}
    Verify Book Details In Table    ${BOOK_ID_1}    ${BOOK_NAME_1}    ${BOOK_SUBJECT_1}    ${BOOK_CATEGORY_1}

Add Book With Empty Book ID
    [Documentation]    Attempt to add book without Book ID (edge case - validation)
    [Tags]    add    negative    validation
    
    Navigate To Add Book Page
    
    # Fill form but leave Book ID empty
    Input Text    ${BOOK_NAME_FIELD}    Test Book Name
    Input Text    ${BOOK_SUBJECT_FIELD}    Test Subject
    Input Text    ${BOOK_CATEGORY_FIELD}    Not-Issued
    
    # Try to submit - HTML5 validation should prevent it
    Click Element    ${SUBMIT_BUTTON}
    Sleep    1s
    
    # Assert: Still on add book page (form not submitted)
    Location Should Be    ${ADD_BOOK_URL}

Add Book With Empty Book Name
    [Documentation]    Attempt to add book without Book Name (edge case - validation)
    [Tags]    add    negative    validation
    
    Navigate To Add Book Page
    
    # Fill form but leave Book Name empty
    Input Text    ${BOOK_ID_FIELD}    BK_TEST_001
    Input Text    ${BOOK_SUBJECT_FIELD}    Test Subject
    Input Text    ${BOOK_CATEGORY_FIELD}    Not-Issued
    
    # Try to submit
    Click Element    ${SUBMIT_BUTTON}
    Sleep    1s
    
    # Assert: Still on add book page
    Location Should Be    ${ADD_BOOK_URL}

Add Book With Empty Subject
    [Documentation]    Attempt to add book without Subject (edge case - validation)
    [Tags]    add    negative    validation
    
    Navigate To Add Book Page
    
    # Fill form but leave Subject empty
    Input Text    ${BOOK_ID_FIELD}    BK_TEST_002
    Input Text    ${BOOK_NAME_FIELD}    Test Book Name
    Input Text    ${BOOK_CATEGORY_FIELD}    Not-Issued
    
    # Try to submit
    Click Element    ${SUBMIT_BUTTON}
    Sleep    1s
    
    # Assert: Still on add book page
    Location Should Be    ${ADD_BOOK_URL}

Add Book With Empty Category
    [Documentation]    Attempt to add book without Category (edge case - validation)
    [Tags]    add    negative    validation
    
    Navigate To Add Book Page
    
    # Fill form but leave Category empty
    Input Text    ${BOOK_ID_FIELD}    BK_TEST_003
    Input Text    ${BOOK_NAME_FIELD}    Test Book Name
    Input Text    ${BOOK_SUBJECT_FIELD}    Test Subject
    
    # Try to submit
    Click Element    ${SUBMIT_BUTTON}
    Sleep    1s
    
    # Assert: Still on add book page
    Location Should Be    ${ADD_BOOK_URL}

Edit Book And Verify Updated Info
    [Documentation]    Edit an existing book and assert changes appear in dashboard
    [Tags]    edit    positive
    
    # First verify the book exists
    Verify Book In Dashboard Table    ${BOOK_ID_1}
    
    # Click edit button for the book
    Click Edit Button For Book    ${BOOK_ID_1}
    
    # Verify current data is pre-filled
    ${current_bookname}=    Get Value    ${BOOK_NAME_FIELD}
    Should Be Equal    ${current_bookname}    ${BOOK_NAME_1}
    
    # Update book details
    Update Form Field    ${BOOK_NAME_FIELD}    ${UPDATED_BOOK_NAME}
    Update Form Field    ${BOOK_SUBJECT_FIELD}    ${UPDATED_SUBJECT}
    Update Form Field    ${BOOK_CATEGORY_FIELD}    ${UPDATED_CATEGORY}
    
    # Submit changes
    Submit Book Form
    Sleep    2s
    
    # Assert: Verify updated information appears in dashboard
    Navigate To Dashboard
    Verify Book In Dashboard Table    ${BOOK_ID_1}
    Page Should Contain    ${UPDATED_BOOK_NAME}
    Page Should Contain    ${UPDATED_SUBJECT}
    Page Should Contain    ${UPDATED_CATEGORY}

Delete Book And Verify Removal
    [Documentation]    Delete a book and assert it no longer appears in dashboard
    [Tags]    delete    positive
    
    # Add a temporary book for deletion test
    Navigate To Add Book Page
    Fill Book Form    
    ...    ${BOOK_ID_4}
    ...    ${BOOK_NAME_4}
    ...    ${BOOK_SUBJECT_4}
    ...    ${BOOK_CATEGORY_4}
    Submit Book Form
    Sleep    2s
    
    # Verify book exists before deletion
    Verify Book In Dashboard Table    ${BOOK_ID_4}
    
    # Get initial book count
    ${initial_count}=    Get Row Count In Books Table
    
    # Delete the book
    Click Delete Button For Book    ${BOOK_ID_4}
    Sleep    2s
    
    # Assert: Verify book is removed from table
    Verify Book Not In Dashboard Table    ${BOOK_ID_4}
    
    # Assert: Verify book count decreased
    ${final_count}=    Get Row Count In Books Table
    Should Be True    ${final_count} < ${initial_count}

Search Book With Valid ID
    [Documentation]    Search for an existing book and assert it appears in results
    [Tags]    search    positive
    
    # First ensure the book exists
    Verify Book In Dashboard Table    ${BOOK_ID_1}
    
    # Perform search
    Search For Book By BookId    ${BOOK_ID_1}
    
    # Assert: Verify book appears in search results
    Page Should Contain    ${BOOK_ID_1}

Search Book With Invalid ID
    [Documentation]    Search with non-existent book ID and assert graceful handling
    [Tags]    search    negative
    
    # Perform search with invalid ID
    Search For Book By BookId    ${SEARCH_INVALID}
    
    # Assert: Book should not appear
    Page Should Not Contain    ${SEARCH_INVALID}
    
    # System should show either empty results or "no results" message
    ${has_books}=    Run Keyword And Return Status    Page Should Contain    ${BOOK_ID_1}
    ${has_message}=    Run Keyword And Return Status    Page Should Contain    No
    Should Be True    ${has_books} == False or ${has_message} == True

Add Multiple Books Successfully
    [Documentation]    Add multiple books and verify all appear in dashboard
    [Tags]    add    positive
    
    # Add second book
    Navigate To Add Book Page
    Fill Book Form    
    ...    ${BOOK_ID_2}
    ...    ${BOOK_NAME_2}
    ...    ${BOOK_SUBJECT_2}
    ...    ${BOOK_CATEGORY_2}
    Submit Book Form
    Sleep    2s
    
    # Assert: Verify second book added
    Verify Book In Dashboard Table    ${BOOK_ID_2}
    
    # Add third book
    Navigate To Add Book Page
    Fill Book Form    
    ...    ${BOOK_ID_3}
    ...    ${BOOK_NAME_3}
    ...    ${BOOK_SUBJECT_3}
    ...    ${BOOK_CATEGORY_3}
    Submit Book Form
    Sleep    2s
    
    # Assert: Verify third book added
    Verify Book In Dashboard Table    ${BOOK_ID_3}
    
    # Assert: Verify all books are present
    Navigate To Dashboard
    Page Should Contain    ${BOOK_ID_2}
    Page Should Contain    ${BOOK_ID_3}
    Page Should Contain    ${BOOK_NAME_2}
    Page Should Contain    ${BOOK_NAME_3}

View Books Dashboard
    [Documentation]    Verify dashboard displays books table correctly
    [Tags]    view    positive
    
    Navigate To Dashboard
    
    # Assert: Page elements are present
    Page Should Contain Element    ${BOOKS_TABLE}
    Page Should Contain Element    ${SIDEBAR}
    
    # Assert: Table headers present
    Page Should Contain    Book Id
    Page Should Contain    Book Name
    Page Should Contain    Subject
    Page Should Contain    Status
    Page Should Contain    Edit
    Page Should Contain    Delete
    
    # Assert: At least one book exists
    ${count}=    Get Row Count In Books Table
    Should Be True    ${count} > 0

