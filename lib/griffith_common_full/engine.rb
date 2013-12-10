require 'griffith_common_full/application_helper.rb'
require 'griffith_common_full/application_controller.rb'

module GriffithCommonFull
  class Engine < ::Rails::Engine

    ActionView::Base.send :include, GriffithCommonFull::ApplicationHelper
    ActionController::Base.send :include, GriffithCommonFull::ApplicationController
  

  end
end
