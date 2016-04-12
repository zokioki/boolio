require "json"
require "http"
require "boolio/version"

class Boolio
  attr_reader   :id
  attr_accessor :val

  URL = "https://api.booleans.io/"

  def initialize(opts = {})
    @val = process_init_value(opts[:val])
    @id  = opts[:id] || post(@val)["id"]
  end

  def update(value = val)
    put(value)
  end

  def destroy!
    return if frozen?
    response = delete
    if response.code == 200
      @id  = nil
      @val = nil
      freeze
    else
      raise "Could not destroy boolean: #{response.status}"
    end
  end

  def self.fetch(id)
    response = HTTP.get(URL + id)
    boolean  = JSON.parse response.body
    Boolio.new(id: boolean["id"], val: boolean["val"])
  end

  def to_s
    val
  end

  private

  def process_init_value(value)
    return [true, false].sample if value.nil?
    raise ArgumentError, "Provide a boolean." unless [TrueClass, FalseClass, String].include?(value.class)
    value.to_s == "true"
  end

  def put(value)
    response = HTTP.put((URL + id), form: { val: value })
    JSON.parse response.body
  end

  def post(value)
    response = HTTP.post(URL, form: { val: value })
    JSON.parse response.body
  end

  def delete
    HTTP.delete(URL + id)
  end
end
