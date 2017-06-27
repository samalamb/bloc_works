require "bloc_works/version"
require "bloc_works/router"
require "bloc_works/utility"
require "bloc_works/version"
require "bloc_works/dependencies"
require "bloc_works/controller"

module BlocWorks
  class Application
    def call(env)
      response = fav_icon(env) # [404, {'Content-Type' => 'text/html'}, []] || nil

      if(response)
        return response
      else
        # controller = BooksController.new(env)
        # controller.welcome
        controller, action = controller_and_action(env)[0].new(env), controller_and_action(env)[1]

        if controller.respond_to?(action)
          var = controller.send(action)

          [200, {'Content-Type' => 'text/html'}, [var]]
        else
          [404, {"Content-Type" => "text/plain"}, []]
        end
      end
    end
  end
end
