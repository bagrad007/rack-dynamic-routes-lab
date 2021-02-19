require "pry"

class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match ("/items/")
      item = req.path.split("/items/").last
      item_name = @@items.find { |i|
        # binding.pry
        if i.name == item
          i.name = item
        else
          resp.write "Item not found"
          resp.status = 400
        end
      }
      resp.write item_name.price
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
