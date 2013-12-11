module GriffithCommon
  class Engine < ::Rails::Engine 

    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    initializer "griffith_common.loader" do |app|
      ActiveSupport.on_load :action_view do
        include GriffithCommon::ApplicationHelper
      end
      ActiveSupport.on_load :action_controller do
        include, GriffithCommon::ApplicationController
      end
    end

  end
end
