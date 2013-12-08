module BootstrapHelpers
  
  def panel_for heading, opts = {}
    heading = heading.to_s.titleize
    opts = {class: 'panel-default'}.merge(opts)

    content_tag :div, class: "panel #{opts[:class]}" do
      concat content_tag( :div, content_tag( :h3, heading, class: 'panel-title center' ),
                          class: 'panel-heading' )
      yield
    end.html_safe
  end

  def icon name
    "<i class='fa fa-#{name.to_s} fa-fw'></i>".html_safe
  end
  
  def badge count
    "<span class='badge'>#{count}</span>"
  end

end
