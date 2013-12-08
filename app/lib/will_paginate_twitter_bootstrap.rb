require "will_paginate/view_helpers/action_view"

# custom will paginate renderer for twitter bootstrap
module WillPaginateTwitterBootstrap
  class Renderer < WillPaginate::ActionView::LinkRenderer

    ELLIPSIS = '&hellip;'

    def to_html
      list_items = pagination.map do |item|
        case item
          when Fixnum
            page_number(item)
          else
            send(item)
        end
      end

      html_container(tag('ul', list_items.join(@options[:link_separator]), class: 'pagination'))
    end

    protected

    def page_number(page)
      if page == current_page
        tag('li', tag('span', page), :class => 'active')
      else
        tag('li', link(page, page, :rel => rel_value(page)))
      end
    end

    def gap
      tag('li', link(ELLIPSIS, '#'), :class => 'disabled')
    end

    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      # previous_or_next_page(num, @options[:previous_label], 'prev')
      previous_or_next_page(num, icon('chevron-left'), 'prev')

    end

    def next_page
      num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
      # previous_or_next_page(num, @options[:next_label], 'next')
      previous_or_next_page(num, icon('chevron-right'), 'next')

    end

    def previous_or_next_page(page, text, classname)
      if page
        tag('li', link(text, page), :class => classname)
      else
        tag('li', tag('span', text), :class => "%s disabled" % classname)
      end
    end

    def icon name
      "<i class='fa fa-#{name.to_s} fa-fw'></i>".html_safe
    end

  end
  
  class AjaxRenderer < WillPaginateTwitterBootstrap::Renderer
    def prepare(collection, options, template)
      options[:params] ||= {}
      options[:params]["_"] = nil
      super(collection, options, template)
    end

    protected
    def link(text, target, attributes = {})
      if target.is_a? Fixnum
        attributes[:rel] = rel_value(target)
        target = url(target)
      end
      ajax_call = "$.ajax({url: '#{target}', dataType: 'script'});"
      @template.link_to_function(text.to_s.html_safe, ajax_call, attributes)
    end
  end


  module Helper
    
    # set default renderer
    def will_paginate(collection_or_options = nil, options = {})
      if collection_or_options.is_a? Hash
        options, collection_or_options = collection_or_options, nil
      end
      unless options[:renderer]
        options = options.merge :renderer => WillPaginateTwitterBootstrap::Renderer, class: 'text-center'
      end
      super *[collection_or_options, options].compact
    end
 
    def ajax_will_paginate(collection, options = {})
      will_paginate(collection, options.merge(:renderer => WillPaginateTwitterBootstrap::AjaxRenderer, class: 'text-center'))
    end

  end

end