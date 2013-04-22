require "rest_client"
require "nokogiri"
require "json"

module Tinysong
  Song = Struct.new(:title, :artist, :href, :id)

  class Search < Struct.new(:search, :amount)
    #
    # Search and return first result
    #
    # @search String Track to be found
    # @return Song A song
    #
    def self.find(search)
      Search.new(search, 1).perform.first
    end

    #
    # Search and return all songs
    #
    # @search String Track to be found
    # @options[:limit] Amount of results
    # @return Array<Song> A list of songs
    #
    def self.all(search, options = {})
      limit = options[:limit] || -1
      Search.new(search, limit).perform
    end
    
    def perform
      res = JSON.parse(RestClient.post("http://tinysong.com/?s=s", {q: [search, 0]}))
      res = Nokogiri::HTML(res["html"]).css("ul.result")
      res.take(limit(res)).map do |result|
        song_id = result.attr("rel").match(/^(\d+)/).to_a.last
        res = JSON.parse(RestClient.post("http://tinysong.com/?s=sh", {q: [song_id, "search", search]}))
        build(Nokogiri::HTML(res["message"]), song_id)
      end
    end

    private

    def build(element, song_id)
      artist = element.at_css("h3").text
      title  = element.at_css("h2").text
      href   = element.at_css(".link a").attr("href")
      Song.new(title, artist, href, song_id.to_i)
    end

    def limit(res)
      amount == -1 ? res.length : amount
    end
  end
end