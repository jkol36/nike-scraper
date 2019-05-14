require 'HTTPParty'
require "Nokogiri"

class Scraper
	url = 'http://store.nike.com/us/en_us/pw/mens-nikeid-lifestyle-shoes/1k9Z7puZoneZoi3'
	doc = HTTPParty.get(url)
	attr_accessor:parse_page
	def initialize
		doc = HTTPParty.get(url)
		@parse_page ||= Nokogiri::HTML(doc)
	end

	def get_names
		item_container.css('".product_name').css('p').children.map { |name| name.text}.compact
	end
	def get_prices
		item_container.css('.product-price').css("span.local").children.map { |price| price.text}.compact
	end
	def item_container
		parse_page.css('.grid-item-info')
	end

end

scraper = Scraper.new
names = scraper.get_names
prices = scraper.get_prices
puts names