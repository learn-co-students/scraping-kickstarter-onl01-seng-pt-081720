# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  
  projects = {}
  kickstarter = Nokogiri::HTML(html)
  kickstarter.css("li.project.grid_4").each do |p|
    title = p.css("h2.bbcard_name strong a").text 
    projects[title] = {
   
      :image_link => p.css("div.project-thumbnail a img").attribute("src").value, 
      :description => p.css("p.bbcard_blurb").text,
      :location => p.css("span.location-name").children.text,
      :percent_funded => p.css("li.first.funded strong").children.text.to_i

    }

  end
  projects
end