module GriffithCommon
  module BootstrapHelpers
    def panel_for(resource, opts = {})
      opts = {id: "#{resource.to_s.underscore}", class: 'panel panel-default'}.merge(opts)
      title = opts.fetch(:title) { resource }

      content_tag :div, **opts do
        concat content_tag(:div,
                           content_tag(
                             :h3,
                             title.to_s.titleize,
                             class: 'panel-title center'),
                           class: 'panel-heading')
        yield
      end.html_safe
    end

    def badge(count)
      "<span class='badge pull-right'>#{count}</span>".html_safe
    end

    def label_for(name, opts = {})
      opts = {class: 'label-default'}.merge(opts)
      "<span class='label #{opts[:class]}'>#{name}</span>".html_safe
    end

    def modal_for(heading,
                  id: nil,
                  button_label: "#{ heading.to_s.titleize }",
                  submit: "create #{ heading }",
                  button_class: 'btn-xs btn-primary',
                  button_style: '',
                  modal_class: '')

      id ||= heading.to_s.downcase.underscore
      title = heading.to_s.titleize
      x = '&times;'.html_safe
      concat button_tag(button_label, id: "#{ id }-button",
                                      href: "##{ id }",
                                      data: { toggle: 'modal' },
                                      class: "btn #{ button_class }",
                                      style: "#{ button_style }")
      content_tag :div, class: 'modal fade',
                        id: "#{ id }",
                        role: 'dialog',
                        tabindex: '-1',
                        'z-index' => '-1',
                        'aria-labelledby' => "#{ heading }",
                        'aria-hidden' => 'true' do
        content_tag :div, class: "modal-dialog #{ modal_class }" do
          content_tag :div, class: 'modal-content' do
            content = content_tag(:div, class: 'modal-header') do
              header = button_tag(x, class: 'close',
                                     type: 'button',
                                     data: { dismiss: 'modal' },
                                     'aria-hidden' => true)
              header << content_tag(:h4, class: 'modal-title',
                                         id: "#{ id }") do
                "#{ title }".html_safe
              end
            end
            content << content_tag(:div, class: 'modal-body') do
              yield if block_given?
            end
          end
        end
      end
    end

    def modal_action_bar
      content_tag :div, class: 'modal-action-bar' do
        button = content_tag(:span) do
          yield if block_given?
        end
        button << button_tag('Close', class: 'btn btn-default',
                                      data: { dismiss: 'modal' })
      end
    end

    module Icon
      def icon(name, classes = '')
        "<i class='fa fa-#{name.to_s} fa-fw #{classes}'></i>".html_safe
      end
    end

    include Icon
  end
end
