*** Settings ***
Documentation     A resource file with reusable keywords and variables.

Library           Browser


*** Variables ***
${TESTSERVER}         https://vm3980.kaj.pouta.csc.fi/
${PRODUCTIONSERVER}      https://vm3935.kaj.pouta.csc.fi/
${LOCALSERVER}    localhost:4100
${BROWSER}        chromium
${VALID EMAIL}     adad@aa.fi
${VALID PASSWORD}    sfaf
${NEW USERNAME}        tester123
${NEW EMAIL}        tester123@aa.fi
${NEW PASSWORD}       asdzxcvbn
${CONDUIT URL}      http://${TESTSERVER}/
${CONDUITLOCAL URL}    http://${LOCALSERVER}/
${FEEDBACK}         Doorbell test
${TITLE}            Article title
${DESCRIPTION}        This article is about...
${TEXT}            This is a test article.
${TAG}        RobotFrameWork
${BADWORD}        shit


*** Keywords ***


Sign In
        [Arguments]         ${MAIL}    ${PWD}
        click           css=[href="/login"]
        type text       css=[placeholder="Email"]         ${MAIL}       
        type secret     css=[placeholder="Password"]    ${PWD}     
        sleep           2s
        click           css=[type="submit"]
        sleep           2s

Sign Up
        [Arguments]      ${UNAME}    ${MAIL}    ${PWD}    ${PWD}      ${UNAME}
        sleep            2s       
        click            css=[href="/register"]
        sleep            2s
        type text        css=[placeholder="Username"]     ${UNAME}
        type text        css=[placeholder="Email"]    ${MAIL}
        type text        css=[placeholder="Password"]    ${PWD}
        type text        css=[placeholder="Password Retype"]    ${PWD}
        sleep            4s
        click            css=[type="submit"]
        sleep            4s
        get text         css=[href="/@tester123"]       equal        ${UNAME}

Log Out
        click           //*[@id="root"]/div/nav/div/ul/li[6]/button
                 

Finish Testcase
        Log Out
        Close Browser


Read GDPR
        click           css=[href="/static/media/WIMMAGDPR.8f3f5e1b.pdf"]

Give Feedback
        [Arguments]       ${MAIL}         ${FEEDBACK}
        sleep            2s
        click            //*[@id="doorbell-button"]
        sleep            2s
        type text        css=[placeholder="Send us your comments or suggestions..."]           ${FEEDBACK} 
        type text        css=[placeholder="Your email address"]      ${MAIL}
        click            //*[@id="doorbell-submit-button"]
        sleep            4s
        

Publish Article
        [Arguments]       ${TITLE}         ${DESCRIPTION}     ${TEXT}     ${TAG}         ${UNAME}
        click           css=[href="/editor"]
        sleep           2s
        type text       css=[placeholder="Article Title"]         ${TITLE} 
        type text       css=[placeholder="What's this article about?"]        ${DESCRIPTION}
        type text       css=[placeholder="Write your article (in markdown)"]         ${TEXT}
        type text       css=[placeholder="Enter tags"]            ${TAG}
        Press Keys      css=[placeholder="Enter tags"]        Enter
        sleep           2s
        click           css=[type="button"]
        sleep           2s

        
       
         
       
