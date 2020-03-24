*** Settings ***
Documentation                           Infotiv Car Rental Booking
Library                                 SeleniumLibrary
Resource                                ../Resourses/Keywords.robot
Test Setup                              Begin Web Test
Test Teardown                           End Web Test

*** Test Cases ***
TC01_Register the existing USER
   [Documentation]                     Test Register the user test case
    [Tags]                              TC_01
    click element  xpath://*[@id="createUser"]
    input text      id:name  bhagya1
    input text      id:last    kummara1
    input text      id:phone    0767427099
    input text      id:emailCreate  nanisree1234@gmail.com
    input text      id:confirmEmail  nanisree1234@gmail.com
    input text      id:passwordCreate  Sanvi@345
    input text      id:confirmPassword  Sanvi@345
    click element   xpath://*[@id="create"]
    Element Should Contain  id:signInError    That E-mail is already taken
    close browser
TC02_Valid Login
    [Documentation]                     Test login function with valid inputs, given valid user exist
    [Tags]                              TC_02
    Input Text                          id:email  ${VALID_USER}
    Input Text                          id:password  ${VALID_PASSWORD}
    Click Button                        ${LOGIN_BUTTON}
   Title Should Be                      Infotiv Car Rental

Invalid Login, valid Password
    [Documentation]                     Test login funtion with invalid email
    [Tags]                              TC_02
    Input Text                          id:email  ${INVALID_USER}
    Input Text                          id:password  ${VALID_PASSWORD}
    Click Button                        ${LOGIN_BUTTON}
    Element Should Contain              id:signInError      Wrong e-mail or password

Invalid Login, invalid inputs
    [Documentation]                     Test login funtion with invalid inputs
    [Tags]                              TC_02
    Input Text                          id:email  ${INVALID_USER}
    Input Text                          id:password  ${INVALID_PASSWORD}
    Click Button                        ${LOGIN_BUTTON}
    Element Should Contain              id:signInError      Wrong e-mail or password

TC03_Invalid Login
    [Documentation]                     Test login funtion with invalid inputs
    [Tags]                              TC_03
    Input Text                          id:email  ${INVALID_USER}
    Input Text                          id:password  ${INVALID_PASSWORD}
    Click Button                        ${LOGIN_BUTTON}
    Element Should Contain              id:signInError      Wrong e-mail or password

TC04_Booking the car
    [Documentation]                     login with existing user and booking the car
    [Tags]                              TC_04
    Log in
    ${start_date}                       Get Time     month day  NOW
    ${end_date}                         Get Time     month day  NOW + 6 days
    Input Text                          ${BOOK_START}    ${start_date}
    Input Text                          ${BOOK_END}      ${end_date}
    Click Continue
    Click Button                        ${BOOK_TESLA}
    Input Text                          id:cardNum  ${CARD_NUMBER}
    Input Text                          id:fullName    bhagya1 kummara1
    Click Element                       xpath://*[@id="confirmSelection"]/form/select[1]
    Click Element                       id:month6
    Click Element                       xpath://*[@id="confirmSelection"]/form/select[2]
    Click Element                       id:month2023
    Input Text                          id:cvc          123
    Click Button                        id:confirm
    Page should contain                 A Tesla Model S is now ready for pickup
    Clean-up


TC_05_GHERKIN Valid Login
      [Documentation]                     GHERKIN Syntax valid user login
      [Tags]                              TC_05
    Given the user is on the right page
    And enter wrong credential
    When the user clicks the login button
    Then user should not be logged in