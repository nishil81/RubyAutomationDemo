## Directory info
#### Lib: contains required driver to run script


1. Chromedriver(mac): chromedriver_mac >> chromedriver
2. chromedriver_win32(Win) >> chromedriver.exe
3. Geckodriver: geckodriver_mac >> geckodriver


#### Pageobject: This directory contains all the ruby class that define the locators and core methods.
1. FreelacerSearch_po: This file that contains all the locators and all logical functions that require to perform action on webpages.

#### Specs: This directory contains all the ruby class that define the Test scenarios and logs.
1. This is specification file that call the methods form page object file and adding the logs. This the executable file to run the test.

## How to run test:
1. Navigate up to "../RubyAutomationDemo/Specs" in terminal.
2. Hit below command: 
    
        ruby FreelancerSearch_specs.rb "java"  "chrome"
        
3. In above command "java" and "chrome" are command line arguments.
        
        keyword --> "Java"
        browser --> "chrome"
 
