require "rack"
require "rack/handler/puma"

class Router 
  def initialize(req, routes)
    handle(req, routes)
  end

  def handle(req, routes)
    p req == nil
    p routes == nil

    [200, {}, ["got request\n"]]
  end
end


class Handler
  def initialize(routes)
    @routes = routes
  end

  def call(env)
    request = Rack::Request.new(env)
    router = Router.new(request, @routes)
  end
end

class RootGetController
end

def build_routes
end

routes = build_routes do 
 route '/', RootGetController, :get, :post, :patch
 route '/list', RootGetController, :get, :post, :patch
 route '/list/:id', RootGetController, :get, :post, :patch
end

app = Rack::Builder.new do
  run Handler.new(routes: routes)
end

Rack::Handler::Puma.run(app, Port: 9292)
