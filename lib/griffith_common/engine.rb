require 'griffith_common/application_helper.rb'
require 'griffith_common/application_controller.rb'

module GriffithCommon
  class Engine < ::Rails::Engine

    ActionView::Base.send :include, GriffithCommon::ApplicationHelper
    ActionController::Base.send :include, GriffithCommon::ApplicationController
  

  end
end
