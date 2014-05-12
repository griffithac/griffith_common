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

      def item attribute, value = nil, options = {}
        if value.present? || (if attribute.class == Symbol then eval("@collection.#{attribute}.present?") end)
          val = value.nil? ? eval("@collection.#{attribute}") : value
          title = attribute.class == String ? attribute : attribute.to_s.titleize
          content_tag :tr do
            content_tag( :th, title, class: options[:th_class] ) +
            content_tag( :td, val, class: options[:td_class] )
          end
        end
      end

    end

  end
end
