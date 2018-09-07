require 'selenium-webdriver'
require '../PageObject/FreelancerSearch_po'

# This is specification file that call the methods form page object file and adding the logs.
class FreelancerSearch_spec
  searchPO = FreelancerSearch_po.new

  keyword = ARGV[0]
  setBrowser = ARGV[1]

  puts "Initialisation of driver and open browser."
  searchPO.init(setBrowser)
  puts "Search keyword in Find Freelancer search box."
  searchPO.find_Freelancer(keyword)
  sleep(10)
  puts "Parsing the list of freelancere based on search keyword, get Name, Title, Description and Tags."
  freelancerList = searchPO.parse_data
  puts "Find keyword in all freelacers one by one."
  searchPO.assert_data(keyword)
  puts "Select first freelancer form list."
  searchPO.select_first_freelancer
  end
