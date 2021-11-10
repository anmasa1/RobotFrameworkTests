*** Settings ***
Documentation     A resource file with reusable keywords and variables.

Library           Browser


*** Variables ***
${SERVER}         128.214.253.181
${LOCALSERVER}    localhost:4100
${BROWSER}        chromium
${VALID EMAIL}     adad@aa.fi
${VALID PASSWORD}    sfaf
${NEW USERNAME}        newuser
${NEW EMAIL}        newuser@aa.fi
${NEW PASSWORD}       testtest
${CONDUIT URL}      http://${SERVER}/
${CONDUITLOCAL URL}    http://${LOCALSERVER}/

*** Keywords ***


Sign In
        [Arguments]         ${MAIL}    ${PWD}
        click           css=[href="/login"]
        type text       css=[type="email"]        ${MAIL}       
        type secret     css=[type="password"]     ${PWD}     
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
        get text         css=[href="/@newuser"]       equal        ${UNAME}

Log Out
        click           css=[href="/settings"]
        click           //*[@id="root"]/div/div/div/div/div/button[1]

Finish Testcase
        Log Out
        Close Browser
        


         
       
