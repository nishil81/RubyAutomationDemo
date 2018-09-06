require 'selenium-webdriver'
require '../Specs/FreelancerSearch_specs'

class FreelancerSearch_Po
  # general varioables

  # xpath variables

  @@freelancerSearchBoxArrow_icon = "//*[@id='visitor-nav']/div[1]/form/div/div/div[2]"
  @@findFreelancerOption_text = "//*[@id='visitor-nav']/div[1]/form/div/ul/li[1]/a[@data-qa='freelancer_value']"

  @@findfreelancer_searchbox = "//*[@id='layout']/nav/div/div[2]/div[1]/form/div[3]/input[2]"
  @@freelancerName_List = "//h4/a[@class='freelancer-tile-name']"
  @@frellancertitle_List = "//h4[contains(@class,'freelancer-tile-title')]"
  @@freelancerDes_List = "//div[contains(@class,'d-none') and @data-profile-description]"
  @@freelancerTile_List = '//article/div[1]'

  @@freelancerNameOnDetailPage = "//div[@class='media-body']//span[@itemprop='name']"

  browser = FreelancerSearch_Spec.setBrowser

  def init
    if searchSpec.browser.equal? 'chrome'

      Selenium::WebDriver::Chrome.driver_path = File.expand_path('../chromedriver_mac/chromedriver', Dir.pwd)
      @driver = Selenium::WebDriver.for :chrome

    elsif searchSpec.browser.equal? 'firefox'
      Selenium::WebDriver::Firefox.driver_path = File.expand_path('../geckodriver_mac/geckodriver', Dir.pwd)
      @driver = Selenium::WebDriver.for :firefox

      end

    @driver.manage.delete_all_cookies
    @driver.navigate.to 'https://upwork.com/'

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
          find_element(@@freelancerSearchBoxArrow_icon.to_s).click
          sleep(1)
          find_element(@@findFreelancerOption_text.to_s).click
        rescue StandardError => msg
        end

    sleep(5)
    freelancer_textBox = find_element(@@findfreelancer_searchbox.to_s)

    freelancer_textBox.send_keys keyword.to_s
    freelancer_textBox.send_keys :return
    # sleep(200)
  end

  def parse_data
    sleep(10)
    nameList = find_elements(@@freelancerName_List.to_s)
    titleList = find_elements(@@frellancertitle_List.to_s)
    desList = find_elements(@@freelancerDes_List.to_s)

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
    @@nameOnDetailPage = nameList[0].text
  end

  def assert_data(keyword)
    for i in 0..@freelancerList.length - 1

      arrayMember = @freelancerList[i]

      if arrayMember['name'].downcase.include? "#{keyword.downcase}."
        puts "Keyword #{keyword.downcase} found in Name"
      else
        puts "Keyword #{keyword} Not found in Name"
        end

      if arrayMember['title'].downcase.include? keyword.downcase.to_s
        puts "Keyword #{keyword} found in title"
      else
        puts "Keyword #{keyword} Not found in title"
      end

      if arrayMember['desc'].downcase.include? keyword.downcase.to_s
        puts "Keyword #{keyword.downcase} found in des"
      else
        puts "Keyword #{keyword} Not found in des"
      end

      end
  end

  def select_first_freelancer
    nameList = find_elements(@@freelancerTile_List.to_s)

    nameElement = nameList[0]
    nameElement.location_once_scrolled_into_view

    nameElement.click
    sleep(10)
  end

  def assert_FreelancerDetails
    freelancerName = find_element(@@freelancerNameOnDetailPage).text
  end
end
