*** Settings ***
Library  SeleniumLibrary

*** Variables ***
# ${LOCAL}  file:///C:/development/robot-scripts/rfs2l/index.html  # Change the file path to wherever you have downloaded this repo
${LOCAL}  file:///Users/ra/robotscripts/backup/robotscripts/rfs2l/index.html  # Change the file path to wherever you have downloaded this repo
${BROWSER1}  headlesschrome
${BROWSER2}  ie
${TITLE}  Robot Framework Testing Page

*** Keywords ***
Suite Setup
    open browser  ${LOCAL}  ${BROWSER1}  #alias=chrome
    wait until page contains  Hello Kitteh!
    wait until page contains element  id=map
#    open browser  ${LOCAL}  ${BROWSER2}  alias=ie
#    switch browser  chrome
    # Focus remains on the second browser, but the tests run on the first browser Todo: Change focus back to first browser
    register keyword to run on failure  Failed Test

Suite Teardown
    close browser
    close all browsers

Failed Test
    Log  Test failed!
    capture page screenshot