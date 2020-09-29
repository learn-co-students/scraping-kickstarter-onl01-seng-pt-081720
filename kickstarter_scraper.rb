require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  # empty projects hash to start with
  projects = {}

  # iterate through our projects from the html
  kickstarter.css('li.project.grid_4').each do |project|

    title_value = project.css("h2.bbcard_name strong a").text
    image_link_value = project.css("div.project-thumbnail a img").attribute("src").value
    description_value = project.css("p.bbcard_blurb").text.strip
    location_value = project.css("span.location-name").text
    percent_funded_value =  project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

    # create the keys with symbols with empty values for later
    projects[title_value.to_sym] = {
      :image_link => image_link_value,
      :description => description_value,
      :location => location_value,
      :percent_funded => percent_funded_value
    }

  end
  projects
end

create_project_hash