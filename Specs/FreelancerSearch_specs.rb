require "selenium-webdriver"
require '../PageObject/FreelancerSearch_po.rb'


class FreelancerSearch_Spec

searchPO = FreelancerSearch_Po.new




searchPO.init

searchPO.find_Freelancer("java")
sleep(10)
freelancerList = searchPO.parse_data
searchPO.assert_data("java")
searchPO.select_random_freelancer


end



