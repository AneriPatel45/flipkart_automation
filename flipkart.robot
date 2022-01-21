*** Settings ***
Library  Selenium2Library
Library    String
Resource	Common/Flipkart__variable.txt
Suite Setup	Open Flipkart
Suite Teardown	Close Browser

*** Test Cases ***

Click on Login link
    Click Element    ${popup}
    Click Link       ${login_link}

Login With Your Account
    Wait Until Element Is Visible    ${email}
    Input Text	${email}	9664531884
    Wait Until Element Is Visible    ${password}
    Input Text	${password}	aneripatel4520
    Click Element	${submit}

Search for the Electronic devices
    Wait Until Element Is Visible    ${myaccount_btn} 
    Element Should Be Visible    ${myaccount_btn} 
    Input Text	${searchmenu}    Electronics
    Click Element    ${search_btn}
    Wait Until Element Is Visible    ${electronics_txt}
    Element Should Be Visible    ${electronics_txt}
    Click Element    ${electronics_txt}

View samsung Mobiles
    Wait Until Element Is Visible    ${samsung_btn}    timeout=5s
    Element Should Be Visible    ${samsung_btn}        timeout=5s
    Click Element   ${samsung_btn}

view all items 
    Wait Until Element Is Visible    ${samsung_txt}
    Element Should Be Visible    ${samsung_txt}
    Click Element    ${view_all} 
    Wait Until Element Is Visible    ${min_range}
    Click Element  ${min_range}
    Select From List By Value    ${min_range}  2000
    Click Element    ${max_range}
    Select From List By Value   ${max_range}  7000
    Element Should Be Visible    ${AllItems}

check price of each items 
    FOR  ${i}  IN RANGE   500
        ${count_items}=  Get Element Count  ${AllItems}
        FOR  ${j}  IN RANGE  2   ${count_items}+1
            ${price_name}=  Get Text    css=div._1YokD2._3Mn1Gg:nth-child(2) div._1AtVbE.col-12-12:nth-child(${j}) div._3tbKJL div> div._30jeq3._1_WHN1
            ${string_name}=	Remove String	${price_name}	₹   ,
            ${price}=   Convert To Integer  ${string_name}
            Run Keyword Unless    2000 <= ${price} <= 7000    Fail
            
        END 
        Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
            ${next_btn}=  Run Keyword And Return Status    Element Should Be Visible   ${next}
            Run Keyword if    '${next_btn}'=='True'     Click Element   ${next}  
            Wait Until Element Is Visible    ${next_btn} 
            Element Should Be Visible    ${next_btn} 
            Exit For Loop IF    "${next_btn}" == "False"
    END

*** Keywords ***
Open Flipkart
    Open Browser   ${Flipkart_Url}  Chrome 
    Maximize Browser Window
