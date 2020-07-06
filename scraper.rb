require 'httparty'
require 'Nokogiri'

class Scraper

attr_accessor :parse_page

  def initialize
    doc = HTTParty.get("https://www.nike.com/w/mens-lifestyle-shoes-13jrmznik1zy7ok")
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def get_names
    names = item_container.css(".product-msg__info").css(".product-card__titles").css(".product-card__title").children.map { |name| name.text }.compact
  end

  # def get_price
  #   price = item_container.css(".product-price").css("span-local").children.map { |price| price.text }.compact
  # end

  private

  def item_container
    parse_page.css(".product-card").css(".product-card__body").css(".product-card__info")
  end

  scraper = Scraper.new
  names = Scraper.get_names
  prices = Scraper.get_price

  (0...prices.size).each do |index| 
    puts "- - - index: #{index + 1} - - -  "
    puts " Name: #{names [index]}"
    # puts " Name: #{names [index]} Price: #{prices[index]}"
  end
end