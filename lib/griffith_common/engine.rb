module GriffithCommon
  class Engine < ::Rails::Engine
    config.autoload_paths << File.expand_path("../../app/lib/", __FILE__)
    isolate_namespace GriffithCommon
  end
end
