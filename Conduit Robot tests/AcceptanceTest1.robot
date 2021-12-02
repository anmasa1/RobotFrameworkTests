*** Settings ***
Library    Browser

Resource          resource.robot
Resource          Password.robot

Test Setup    Open Browser     ${CONDUITLOCAL URL}    ${BROWSER}
        
Test Teardown       Close Browser

*** Test Cases ***


       

Register New User
        Read GDPR
        sleep              4s
        Close Browser
        Open Browser     ${CONDUITLOCAL URL}    ${BROWSER}
        Sign Up            ${NEW USERNAME}     ${NEW EMAIL}    ${NEW PASSWORD}    ${NEW PASSWORD}      ${NEW USERNAME}
        sleep              2s
        Log Out
        sleep              2s

Swear Word Filter
        Sign In         ${NEW EMAIL}    ${NEW PASSWORD}
        Publish Article        ${TITLE}         ${DESCRIPTION}     ${BADWORD}    ${TAG}         ${NEW USERNAME}
        get text            //*[@id="root"]/div/div/div/div/div/form/fieldset/ul/li        equal     Please note that title and body text are needed, and no offensive language is allowed.
        Publish Article    ${TITLE}         ${DESCRIPTION}     ${TEXT}    ${TAG}         ${NEW USERNAME}
         # click Home
        click           //*[@id="root"]/div/nav/div/ul/li[2]/a
        # click Global Feed
        click           //*[@id="root"]/div/div/div/div/div[1]/div[1]/ul/li[2]/a
        # check that the latest article is written by ${NEW USERNAME}
        get text        //*[@id="root"]/div/div/div/div/div[1]/div[2]/div[1]/div/div[1]/a       equal         ${NEW USERNAME}
        sleep           2s 



Twitter Share
        Sign In         ${NEW EMAIL}    ${NEW PASSWORD}
        click           //*[@id="root"]/div/div/div/div/div[1]/div[1]/ul/li[2]/a
        sleep            4s
        click           //*[@id="root"]/div/div/div/div/div[1]/div[2]/div[1]/a/h1
        sleep            4s
        click            //*[@id="root"]/div/div/div[1]/div/button
        #sleep            4s
        ${previous} =    Switch Page      NEW
        get text        //*[@id="layers"]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div[1]/div[1]/div[1]/div/span        equal        Haluatko kirjautua ensin sisään?
        type text         css=[name="session[username_or_email]"]          ${TWITTERUSER}
        type text         css=[name="session[password]"]         ${TWITTERPWD}
        #kirjaudu sisään
        click       //*[@id="layers"]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div[2]/div[2]/div/span/span/span
        #jaa twiitti
        click          //*[@id="react-root"]/div/div/div[2]/main/div/div/div[2]/div/div/div/div/div[3]/div
        sleep            4s
        Switch Page        ${previous}
        Log Out

Give Feedback
        Sign In          ${NEW EMAIL}    ${NEW PASSWORD}
        sleep            2s
        click            //*[@id="doorbell-button"]
        get text         //*[@id="doorbell-title"]        equal          Feedback
        sleep            2s
        type text        css=[placeholder="Send us your comments or suggestions..."]        Doorbell test
        type text        css=[placeholder="Your email address"]      ${NEW EMAIL}
        click            //*[@id="doorbell-submit-button"]
        sleep            4s
        Log Out

Delete Account
        Sign In         ${NEW EMAIL}    ${NEW PASSWORD}
        click           css=[href="/settings"]
        sleep           2s
        click           //*[@id="root"]/div/div/div/div/div/button
        sleep           2s
        # check that the latest article is not written by ${NEW USERNAME}
        get text        //*[@id="root"]/div/div/div[2]/div/div[1]/div[2]/div[1]/div/div[1]/a           !=        ${NEW USERNAME}
        sleep           2s

Try Sign In Again
        Sign In         ${NEW EMAIL}    ${NEW PASSWORD}
        sleep           2s
        get text       //*[@id="root"]/div/div/div/div/div/ul       equal        email or password is invalid