require "selenium-webdriver"

class FreelancerSearch_Po
  # general varioables

  # xpath variables

  @@freelancerSearchBoxArrow_icon = "//*[@id='visitor-nav']/div[1]/form/div/div/div[2]"
  @@findFreelancerOption_text = "//*[@id='visitor-nav']/div[1]/form/div/ul/li[1]/a[@data-qa='freelancer_value']"

  @@findfreelancer_searchbox = "//*[@id='layout']/nav/div/div[2]/div[1]/form/div[3]/input[2]"
  @@freelancerName_List = "//h4/a[@class='freelancer-tile-name']"
  @@frellancertitle_List = "//h4[contains(@class,'freelancer-tile-title')]"
  @@freelancerDes_List = "//div[contains(@class,'d-none') and @data-profile-description]"
  @@freelancerTile_List = "//article/div[1]"

  def init
    Selenium::WebDriver::Chrome.driver_path = "C:\\Users\\Tesbo\\RubymineProjects\\untitled\\Lib\\chromedriver_win32\\chromedriver.exe"
    # Selenium::WebDriver::Firefox.driver_path = "C:\\Users\\Tesbo\\RubymineProjects\\untitled\\Lib\\geckodriver-v0.21.0-win64\\geckodriver.exe"

    @driver = Selenium::WebDriver.for :chrome
    @driver.manage.delete_all_cookies
    @driver.navigate.to "https://upwork.com/"

    @driver.manage.window.maximize
      end

  def find_element(xpath)
    @driver.find_element(:xpath, xpath)
  end

  def find_elements(xpath)
    @driver.find_elements(:xpath, xpath)
  end

  def find_Freelancer(keyword)
    sleep(1)

    begin
          find_element("#{@@freelancerSearchBoxArrow_icon}").click
          sleep(1)
          find_element("#{@@findFreelancerOption_text}").click
        rescue StandardError => msg
        end

    sleep(5)
    freelancer_textBox = find_element("#{@@findfreelancer_searchbox}")

    freelancer_textBox.send_keys "#{keyword}"
    freelancer_textBox.send_keys :return
    # sleep(200)
  end

  def parse_data
    sleep(10)
    nameList = find_elements("#{@@freelancerName_List}")
    titleList = find_elements("#{@@frellancertitle_List}")
    desList = find_elements("#{@@freelancerDes_List}")

    listSize = nameList.length

    @freelancerList = []

    for i in 0..listSize - 1

      nameElement = nameList[i]
      name = nameElement.text

      taglist = find_elements("//h4/a[@title='#{name}']/../../../..//span[contains(@class,'o-tag-skill')]")

      freelancer = Hash['name' => nameList[i].text,
                        'title' => titleList[i].text,
                        'desc' => desList[i].text,
                        'tag' => taglist]

      @freelancerList << freelancer

    end
    @freelancerList
  end

  def assert_data(keyword)
    for i in 0..@freelancerList.length - 1

      arrayMember = @freelancerList[i]

      if arrayMember['name'].downcase.include? "#{keyword.downcase}."
        puts "Keyword #{keyword.downcase} found in Name"
      else
        puts "Keyword #{keyword} Not found in Name"
        end

      if arrayMember['title'].downcase.include? "#{keyword.downcase}"
        puts "Keyword #{keyword} found in title"
      else
        puts "Keyword #{keyword} Not found in title"
      end

      if arrayMember['desc'].downcase.include? "#{keyword.downcase}"
        puts "Keyword #{keyword.downcase} found in des"
      else
        puts "Keyword #{keyword} Not found in des"
      end

      end
  end

  def select_first_freelancer
    r = Random.new

    nameList = find_elements("#{@@freelancerTile_List}")

    r = r.rand(0...nameList.length)

    nameElement = nameList[0]
    nameElement.location_once_scrolled_into_view

    nameElement.click
    sleep(10)
  end

end
