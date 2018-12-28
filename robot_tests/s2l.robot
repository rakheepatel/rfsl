*** Settings ***
Documentation  These tests attempt to demonstrate how all keywords from Selenium 2 Library should be used in context
Library  SeleniumLibrary
Resource  common.robot
Suite Setup  Suite Setup
Suite Teardown  Suite Teardown
# robot -d Results robot_tests/s2l.robot  Execute this command to run the test suite

*** Variables ***
${screenshot_name}  page-screenshot.png
${prompt_cat}  Clawy
${cat_pic}  //img[@title="Cute cat is cute"]
${view_map_link}  //a[contains(., "View larger map")]
${h1}  css=h1


*** Test Cases ***
All Keywords
    Browser Related Keywords
    Alerts and Prompts
    Assign ID to Element Keyword
    Screenshot Keywords
    Choose File Keyword
    Forms
    Coordinates
    Image
    Links
    iFrames
    Other
    Assertions
    Mouse Actions


*** Keywords ***
Browser Related Keywords
    click link  kitten
    go back  # For this keyword to work you need to navigate to a link via click link or something similar. Go to keyword will not let you go back
    @{windows}=  list windows
    ${width}  ${height}=  get window size
    set window size  1200  800
    ${x}  ${y}=  get window position
    set window position  20  20
    maximize browser window
    ${current_url}=  get location
    log location
    log title
    log source
    ${sel_wait}=  get selenium implicit wait
    ${sel_speed}=  get selenium speed
    ${sel_timeout}=  get selenium timeout
    set browser implicit wait  2
    set selenium implicit wait  3
    ${sel_wait}=  get selenium implicit wait
    set selenium speed  4
    ${sel_speed}=  get selenium speed
    set selenium timeout  6
    ${sel_timeout}=  get selenium timeout
    ${source}=  get source
    get window identifiers
    get window names
    get window titles
    reload page

Alerts and Prompts
    Alert Text
    Dismiss Alert Keyword
    Get Alert Message Keyword
    Prompt Cancel
    Prompt Confirm

Alert Text
    click button  Click Me!
    alert should be present  Hehe click bait!
    double click element  id=dblClick
    dismiss alert

Dismiss Alert Keyword
    click button  Click Me!
    dismiss alert

Get Alert Message Keyword
    click button  Click Me!
    get alert message

Prompt Cancel
    choose cancel on next confirmation
    click button  Prompt
    confirm action
    wait until element is visible  id=prompt
    element text should be  id=prompt  User cancelled the prompt.

Prompt Confirm
    choose ok on next confirmation
    click button  Prompt
    input text into prompt  ${prompt_cat}
    confirm action
    element text should be  id=prompt  Good ${prompt_cat}! Who's a good kitteh?

Assign ID to Element Keyword
    assign id to element  //form/button  Alert
    click button  id=Alert
    confirm action
    ${element_attribute}=  get element attribute  ${h1}  id

Screenshot Keywords
    capture page screenshot  filename=${screenshot_name}
    # This screenshot will be saved in the "Results" folder by default when run
    # set screenshot directory  C:\\development\\robot-scripts\\rfs2l\\Results\\Screenshots
    set screenshot directory  /Users/ra/robotscripts/backup/robotscripts/rfs2l/Results/Screenshots    # For mac users
    capture page screenshot  filename=${screenshot_name}

Choose File Keyword
    # choose file  css=[type="file"]  C:\\development\\robot-scripts\\rfs2l\\images\\800-650.jpg
    choose file  css=[type="file"]  /Users/ra/robotscripts/backup/robotscripts/rfs2l/images/800-650.jpg    # For mac users
    # Change the file path to wherever you have downloaded this repo

Forms
    textarea should contain  message  cat
    textarea value should be  message  The cat was playing in the garden.
    textfield should contain  first_name  Jane-Anne
    textfield value should be  first_name  Jane-Anne O'Doe
    click element  css=[name="prefilled"]
    clear element text  css=[name="prefilled"]
    input text  id=first_name  ${prompt_cat}
    element should be disabled  //input[@disabled="disabled"]
    element should be enabled  //input[@name="emptytext"]
    # Radio buttons and checkboxes
    radio button should be set to  breed  Persian
    radio button should not be selected  no_select
    select radio button  breed  Ragdoll
    checkbox should be selected  css=[name="cat1"]
    checkbox should not be selected  css=[name="cat2"]
    select checkbox  absolutely
    unselect checkbox  love
    # Lists
    list selection should be  Breeds List
    list should have no selections  Breeds List
    @{ListItems}=  get list items  //select[@name="Breeds"]
    select from list  //select[@name="Breeds List"]  Norwegian Forest Cat
    ${list_label}=  get selected list label  //select[@name="Breeds List"]
    ${list_value}=  get selected list value  //select[@name="Breeds List"]
    select from list by index  //select[@name="Breeds List"]  1
    select from list by label  //select[@name="Breeds List"]  Maine Coon
    select from list by value  //select[@name="Breeds List"]  Other
    ${list_labels}=  get selected list labels  //select[@name="Breeds List"]
    ${list_values}=  get selected list values  //select[@name="Breeds List"]
    unselect from list  //select[@name="Breeds List"]  Norwegian Forest Cat
    unselect from list by index  //select[@name="Breeds List"]  1
    unselect from list by label  //select[@name="Breeds List"]  Maine Coon
    unselect from list by value  //select[@name="Breeds List"]  Other
    select all from list  //select[@name="Breeds List"]
    submit form

Tables
    ${table_cell}=  get table cell  table  4  1
    table cell should contain  table  1  1  Breed
    table column should contain  table  2  Lifespan
    table footer should contain  table  Lifespan Footer
    table header should contain  table  Lifespan
    table row should contain  table  7  Somali
    table should contain  table  -15 yrs

Coordinates
    ${horz} =  get horizontal position  ${cat_pic}
    log  ${horz}
    ${vert} =  get vertical position  ${cat_pic}
    log  ${vert}
    ${cat_url} =  get element attribute  ${cat_pic}/..  href
    log  ${cat_url}
    click element at coordinates  ${cat_pic}  0  0
    select window  url=${cat_url}
    close window
    select window  title=${TITLE}

Image
    ${cat_url} =  get element attribute  ${cat_pic}/..  href
    click image  ${cat_pic}
    select window  url=${cat_url}
    close window
    select window  title=${TITLE}
    ${element_size}=  get element size  css=#CatImage>img

Links
    ${link_url} =  get element attribute  //p[1]/a  href
    click link  pink ears
#    ${current_urls}=  get locations  #Commented this one out because it's for S2L 3
    select window  url=${link_url}
    close window
    select window  title=${TITLE}
    @{LinkItems}  get all links
    ${xpaths}=  get matching xpath count  //a
    xpath should match x times  //a  ${xpaths}

iFrames
    wait until page contains element  //iframe
    frame should contain  id=map  Map data
    select frame  //iframe
    current frame contains  Map data
    current frame should not contain  qwerty
    click link  ${view_map_link}
    unselect frame

Other
    element should not be visible  id=dateTime
    click element  id=btn-dateTime
    element should be visible  id=dateTime
    execute javascript  window.scrollTo(0, 2200)
    ${some_text}=  get text  id=demo
    ${get_title}=  get title
    should be equal  ${get_title}  ${TITLE}
    ${value}=  get value  first_name
    ${web_element}=  get webelement  id=dblClick
    @{web_elements}=  get webelements  css=input

Assertions
    current frame contains  Run in circles
    current frame should not contain  Run in squares
    element should be disabled  //input[@disabled="disabled"]
    element should be enabled  //input[@name="emptytext"]
#    Element Should Be Focused  #S2L v3
    element should be visible  id=btn-dateTime
    element should contain  css=.fancy  cat
    reload page
    element should not be visible  id=doggo
    element should not contain  css=.fancy  dog
    element text should be  id=PinkEars  pink ears
    location should be  ${LOCAL}  # Or you can change this to ${current_url}
    location should contain  index.html
#    Locator Should Match X Times  # Deprecated
    page should contain  Run in circles
    page should contain button  Click Me!
    page should contain checkbox  cat1
    page should contain element  cat1
    page should contain image  Cute cat is cute
    page should contain link  pink ears
    page should contain list  Breeds List
    page should contain radio button  Persian
    page should contain textfield  first_name
    page should not contain  Run in squares
    page should not contain button  Click You!
    page should not contain checkbox  I love dogs
    page should not contain element  dog1
    page should not contain image  Cute dog is cute
    page should not contain link  blue ears
    page should not contain list  Dog List
    page should not contain radio button  Dachshund
    page should not contain textfield  surname
    title should be  ${TITLE}
    wait for condition  return window.document.title == "${TITLE}"
    wait until element contains  id=PinkEars  pink ears
    wait until element does not contain  id=PinkEars  blue ears
    wait until element is enabled  emptytext
    wait until element is not visible  id=dateTime
    wait until element is visible  id=btn-dateTime
    wait until page contains  Run in circles
    wait until page contains element  cat1
    wait until page does not contain  Run in squares
    wait until page does not contain element  dog1
    xpath should match x times  //h1  1
    checkbox should be selected  cat1
    checkbox should not be selected  cat2
    list selection should be  Breeds List
    list should have no selections  Breeds List
    radio button should be set to  breed  Persian
    radio button should not be selected  no_select
    table cell should contain  table  1  1  Breed
    table column should contain  table  2  Lifespan
    table footer should contain  table  Lifespan Footer
    table header should contain  table  Lifespan
    table row should contain  table  7  Somali
    table should contain  table  -15 yrs
    textarea should contain  message  cat
    textarea value should be  message  The cat was playing in the garden.
    textfield should contain  first_name  Jane-Anne
    textfield value should be  first_name  Jane-Anne O'Doe

Mouse Actions
    double click element  id=dblClick
    dismiss alert
    mouse out  css=.hover 
    mouse over  css=.hover
    mouse down  singleClick
    mouse up  singleClick
    dismiss alert
    ${cat_url} =  get element attribute  ${cat_pic}/..  href
    mouse down on image  css=#CatImage>img
    mouse up  css=#CatImage>img
    select window  url=${cat_url}
    close window
    select window  title=${TITLE}
    ${cat_link} =  get element attribute  //a[@id="PinkEars"]  href
    mouse down on link  id=PinkEars
    mouse up  id=PinkEars
    select window  url=${cat_link}
    close window