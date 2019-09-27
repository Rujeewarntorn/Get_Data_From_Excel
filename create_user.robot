*** Settings ***
Library    Selenium2Library
Library    ExcelLibrary
Library    BuiltIn

*** Variables ***
${URL}    https://robot-stage-1.firebaseapp.com/#/user/create-user
${Browser}    gc
${FileExcel}    ${EXECDIR}/create_user.xls
${Sheet}    Sheet1

*** Test Case ***
Test Load Data Excel
    Open
    For

*** Keywords ***
Open
   Open Browser    ${URL}    ${Browser}
   Open Excel    ${FileExcel}
For
    ${GetRow}    Get Row Count    ${Sheet}
    : For    ${Index}    IN RANGE    0    ${Get Row}
    \    @{data}=    Get Data Excel    ${Sheet}    ${Index}
    \    Add Data    @{data}[0]    @{data}[1]    @{data}[2]    @{data}[3]

Add Data
    [Arguments]    ${username}    ${userlogin}    ${Passwd}    ${ConfirmPasswd}
    Wait Until Element Is Visible    id=inputName
    Input Text    id=inputName    ${username}
    Wait Until Element Is Visible    id=inputLogin
    Input Text    id=inputLogin    ${userlogin}
    Wait Until Element Is Visible    id=inputPassword
    Input Text    id=inputPassword    ${Passwd} 
    Wait Until Element Is Visible    id=inputPassword2
    Input Text   id=inputPassword2    ${ConfirmPasswd}
    Wait Until Element Is Visible    id=buttonConfirm
    Click Button     id=buttonConfirm

Get Data Excel
    [Arguments]    ${Sheet}    ${Index}
    ${username}=    Read Cell Data By Coordinates    ${Sheet}    0    ${Index}
    ${userlogin}=    Read Cell Data By Coordinates    ${Sheet}    1    ${Index}
    ${Passwd}=    Read Cell Data By Coordinates    ${Sheet}    2    ${Index}
    ${ConfirmPasswd}=    Read Cell Data By Coordinates    ${Sheet}    3    ${Index}
    @{sData}=    Set Variable    ${username}    ${userlogin}    ${Passwd}    ${ConfirmPasswd}
    [Return]    @{sData}

