require 'nokogiri'
require 'open-uri'
class VisitSiteJob < ApplicationJob
  queue_as :default

  def perform(id = nil)
    if id
      address = WebAddress.find(id)
      visit_site(address)
    else
      addresses = WebAddress.where(title: nil)
      addresses.each do |address|
        visit_site(address)
      end
    end
  end

  private
  def visit_site(address)
    begin
      doc = Nokogiri::HTML(URI.open(address.full_url))
      title = doc.title.gsub!(/[^0-9A-Za-z]/, ' ').split(" ").join(" ")
      if title
        address.update(title: title)
      end
    rescue
      Rails.logger "something wrong in url fetch"
    end
  end
end
