*** Settings ***
Library  SeleniumLibrary
Library    String

*** Variables ***
${Flipkart_Url}     https://www.flipkart.com/
${popup}      xpath://button[contains(text(),"✕")]
${login_link}       xpath://a[contains(text(),"Login")]
${email}      xpath://form/div[1]/input[@type="text"]
${password_box}     xpath://form/div[2]/input[@type="password"]
${Login_Button}         xpath://form/div[4]/button
${phone_number}            9664531884
${password}        aneripatel4520
${Electronics_Menu}     //*[@id="container"]/div/div[2]/div/div/span[1]
${samsung}         //a[contains(text(),'Samsung')]
${view_all}           //*[@id="container"]/div/div[3]/div[2]/div/div[1]/div[2]/a/span
${electronics}   //*[@id="container"]/div/div[2]/div/div/div[3]
${min_range}         //div[contains(text(),"to")]/ancestor::div/div[1]/select
${max_range}    //body/div[@id='container']/div[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[1]/section[2]/div[4]/div[3]/select[1]
${next}                 //a/span[contains(text(),"Next")]
${AllItems}                 //div[@class="_1YokD2 _3Mn1Gg"][1]//div[@class="_1AtVbE col-12-12"]/div/div/div/a/div/div/div/div/img


*** Test Cases ***
Open website
    Open Browser   ${Flipkart_Url}  Chrome 
    Maximize Browser Window

Click on Login link
    Click Element    ${popup}
    Click Link       ${login_link}

Enter details
    Input Text   ${email}     ${phone_number}
    Sleep  2
    Input Text   ${password_box}     ${password}
    Sleep  2

Click on the login button
    Click Element    ${Login_Button}
    Sleep  2
    
Click on the Electronic
    Click Element  ${electronics}
    Sleep  1 
    Click Element   ${Electronics_Menu}

Click on samsung
    Sleep  2
    Click Element   ${samsung}

view all items 
    Sleep  2
    Click Element  ${view_all} 
    Wait Until Element Is Visible      ${min_range}
    Click Element  ${min_range}
    Sleep  2
    Select From List By Value   ${min_range}  2000
    Click Element   ${max_range}
    Select From List By Value   ${max_range}  10000
    Sleep  2


check price of each items 
    FOR  ${i}  IN RANGE   500
        ${count_items} =  Get Element Count  ${AllItems}
        FOR  ${j}  IN RANGE  1   ${count_items}+1
            ${price_name} =  Get Text  //div[@class="_1YokD2 _3Mn1Gg"][1]//div[@class="_1AtVbE col-12-12"][${j}]/div/div/div/a/div[2]/div[2]/div[1]/div[1]/div[1]

            ${string_name}=	Remove String	${price_name}	₹   ,
            ${price}=   Convert To Integer  ${string_name}
            
        END 
        Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
            ${next_btn}=  Run Keyword And Return Status    Element Should Be Visible   ${next}
            Run Keyword if    '${next_btn}'=='True'     Click Element   ${next}
            Sleep  2
            Exit For Loop IF    "${next_btn}" == "False"
            Sleep  2
    END
    Close Window

 
