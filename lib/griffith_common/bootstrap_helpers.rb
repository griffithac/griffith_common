module GriffithCommon
  module BootstrapHelpers

    def panel_for heading, opts = {}
      opts = {id: "#{heading.to_s.dasherize}", class: 'panel-default'}.merge(opts)
      heading = heading.to_s.titleize

      content_tag :div, id: opts[:id],class: "panel #{opts[:class]}" do
        concat content_tag(:div,
                           content_tag(:h3,
                                       heading,
                                       class: 'panel-title center'),
                           class: 'panel-heading')
        yield
      end.html_safe
    end

    def badge count
      "<span class='badge pull-right'>#{count}</span>".html_safe
    end

    module Icon
      def icon name, classes = ''
        "<i class='fa fa-#{name.to_s} fa-fw #{classes}'></i>".html_safe
      end
    end

    include Icon

  end
end
