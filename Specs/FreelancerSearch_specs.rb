require 'selenium-webdriver'
require '../PageObject/FreelancerSearch_po'

class FreelancerSearch_Spec

  setKeyword = "java"
  setBrowser = "chrome"
  searchPO = FreelancerSearch_Po.new



  searchPO.init
  searchPO.find_Freelancer(keyword)
  sleep(10)
  freelancerList = searchPO.parse_data
  searchPO.assert_data(keyword)
  searchPO.select_random_freelancer
  searchPO.assert_data(keyword)
  searchPO.select_first_freelancer

  def self.setBrowser
    # code here
  end
end
