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
      student[:twitter] = social.css("a")[0].attribute("href").value
      student[:linkedin] = social.css("a")[1].attribute("href").value
      student[:github] = social.css("a")[2].attribute("href").value
      student[:blog] = social.css("a")[3].attribute("href").value
    end

    student[:profile_quote] = page.css(".profile-quote").text
    student[:bio] = page.css(".bio-content.content-holder p").text
    student
  end

end
