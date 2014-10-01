module GriffithCommon
  module ListTableBuilder

    ## add instance methods to class
    def self.included(base)
      base.send :include, ListTableBuilder
    end

    module ListTableBuilder
      include ::ActionView::Helpers::TagHelper

      def list_table_for collection, options = {}
        options = { class: 'table table-hover' }.merge(options)

        raise ArgumentError, "Missing block" unless block_given?
        @collection = collection
        content_tag :div, class: 'table-responsive' do
          content_tag :table , class: "#{options[:class]}" do
            yield(collection)
          end
        end.html_safe
      end

      def list_table_tag(options = {}, &block)
        raise ArgumentError, "Missing block" unless block_given?
        content_tag :table , class: "#{options[:class]}" do |t|
          yield
        end.html_safe
      end

      def item attribute, value = nil, title: nil, include_blank: false, th_class: '', td_class: ''
        value = if value.nil?
                  object = eval("@collection.#{attribute}")
                  if object.respond_to? :name
                    object.name
                  else
                    object
                  end
                else
                  value
                end

        title = title || attribute.to_s.titleize
        if value.present? || include_blank
          content_tag :tr do
            content_tag(:th, title, class: th_class) +
            content_tag(:td, value, class: td_class)
          end
        end
      end
    end
  end
end
