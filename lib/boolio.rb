require "uri"
require "json"
require "net/http"
# require "boolio/version"

class Boolio
  attr_reader   :id
  attr_accessor :val

  URL = "https://api.booleans.io/"

  def initialize(opts={})
    @val = opts[:val] || [true, false].sample
    @id  = opts[:id] || JSON.parse(post @val)["id"]
  end

  def put(val)
    request = Net::HTTP::Put.new("/#{id}")
    request.set_form_data({ val: val })
    response = Net::HTTP.new(URI.parse(URL)).request(request)
  end

  def post(val)
    response = Net::HTTP.post_form(URI.parse(URL), { val: val })
    response.body
  end

  def delete(id)
    response = Net::HTTP.new(URI.parse(URL)).delete("#{id}")
    response.body
  end

  def self.fetch(id)
    response = Net::HTTP.get_response(URI.parse(URL + "#{id}"))
    boolean = JSON.parse response.body
    Boolio.new(id: boolean["id"], val: boolean["val"])
  end
end
