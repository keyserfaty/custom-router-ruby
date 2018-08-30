require_relative "router"
require_relative "controllers"

class RoutesHandler < Router
  def routes
    route '/', RootGetController, :get, :post, :patch
    route '/list', RootGetController, :get, :post, :patch
    route '/list/:id', RootGetController, :get, :post, :patch
  end
end