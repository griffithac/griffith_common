require 'application_helper'
require 'application_controller'

module GriffithCommon
  class Engine < ::Rails::Engine 
    
    initializer "griffith_common.loader" do |app|
      ActionView::Base.send :include, GriffithCommon::ApplicationHelper
      ActionController::Base.send :include, GriffithCommon::ApplicationController
    end

  end
end
