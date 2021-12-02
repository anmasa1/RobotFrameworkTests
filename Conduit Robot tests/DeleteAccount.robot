*** Settings ***
Library    Browser

Resource          resource.robot

Test Setup    Open Browser     ${CONDUITLOCAL URL}    ${BROWSER}
        
Test Teardown       Close Browser

*** Test Cases ***

Register New User
       Sign Up            ${NEW USERNAME}     ${NEW EMAIL}    ${NEW PASSWORD}    ${NEW PASSWORD}      ${NEW USERNAME}
       sleep              2s
       Log Out
       sleep              2s
       


Publish Article
        Sign In         ${NEW EMAIL}    ${NEW PASSWORD}
        click           css=[href="/editor"]
        sleep           2s
        type text       css=[placeholder="Article Title"]    Delete account 
        type text       css=[placeholder="What's this article about?"]    this is about...
        type text       css=[placeholder="Write your article (in markdown)"]    Delete the account, doest the article stay?
        type text       css=[placeholder="Enter tags"]        account
        Press Keys      css=[placeholder="Enter tags"]        Enter
        sleep           2s
        click           css=[type="button"]
        sleep           2s
        # click Home
        click           //*[@id="root"]/div/nav/div/ul/li[2]/a
        # click Global Feed
        click           //*[@id="root"]/div/div/div/div/div[1]/div[1]/ul/li[2]/a
        # check that the latest article is written by ${NEW USERNAME}
        get text        //*[@id="root"]/div/div/div/div/div[1]/div[2]/div[1]/div/div[1]/a       equal         ${NEW USERNAME}
        sleep           2s 
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

Login
        Sign In         ${NEW EMAIL}    ${NEW PASSWORD}
        sleep           2s
        get text       //*[@id="root"]/div/div/div/div/div/ul       equal        email or password is invalid
    
       