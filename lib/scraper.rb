require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = page.css(".student-card")
    stud_arr = []
    students.each do |student|
      stud_arr << {:name=> student.css(".student-name").text,
                   :location=> student.css(".student-location").text,
                   :profile_url=> student.css("a").attribute("href").value
                  }
    end
    stud_arr
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student = {}
    page.css(".social-icon-container").each do |social|
      binding.pry
      puts social
      # if social.css("a").attribute("href").value.include?("twitter")
      #   student[:twitter] = social.css("a").attribute("href").value
      # elsif social.css("a").attribute("href").value.include?("linkedin")
      #   student[:linkedin] = social.css("a").attribute("href").value
      # elsif social.css("a").attribute("href").value.include?("github")
      #   student[:github] = social.css("a").attribute("href").value
      # else
      #   student[:blog] = social.css("a").attribute("href").value
      # end
    end


    student[:profile_quote] = page.css(".profile-quote").text
    student[:bio] = page.css(".bio-content.content-holder p").text
    student
  end

end
