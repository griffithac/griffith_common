module GriffithCommon
  class Engine < ::Rails::Engine
    # initializer "griffith_common.include_helpers" do |app|
    #   ActionView::Base.send :include, GriffithCommon::ApplicationHelper
    # end
    isolate_namespace GriffithCommon
  end
end
