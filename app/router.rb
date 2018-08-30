require 'rubygems'
require 'rack'
require 'rack/handler/puma'
require 'dish'

class Router 
  @@routes = []

  def route(path, controller, *methods)
    @@routes.push({ path: path, controller: controller, methods: methods })
  end

  def send_response (request)
    # reads active route
    active_route = request.path

    # iterate list of posible routes
    @@routes.each do |route|
      route = Dish(route)
    
      if active_route == route.path
        # execute controller for method and method if available 
        route.get? route.controller.get
      end
    end
  end
end

class Handler < Router
  def call(env)
    # gets the request and sends response
    request = Rack::Request.new(env)
    send_response request
  end
end

app = Rack::Builder.new do
  run Handler.new
end

Rack::Handler::Puma.run(app, Port: 9292)