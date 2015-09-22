# Use integers for states, but never zero.  This is because '' evaluates to zero
# which can case problems with the use of all in state select controls.

module StateMachineMixins
  module Model
    extend ActiveSupport::Concern

    included do
      after_initialize do
        if respond_to?(:state)
          self[:state] ||= 1
        end
      end
    end

    def current_state
      human_state_name.titleize
    end

    def call_event(params)
      if (send(params[:event]) if state_events.include?(params[:event].to_sym))
        if respond_to? :current_user_id
          self.current_user_id = params[:current_user_id].to_i
          save
        end
      end
    end

    def event_names
      ary = state_events.map { |val| [ val.to_s.titleize, val ] }
      Hash[*ary.flatten]
    end

    def state_number_for(state_symbol)
      self.class.states[state_symbol]
    end

    module ClassMethods
      def states
        {}
      end

      def valid_state?(val)
        states.values.include?(val.to_i)
      end

      # used to override empty states method
      def map_states(states_hash)
        metaclass = class << self; self; end
        metaclass.instance_eval do
          define_method(:states) { states_hash }
        end

        build_scopes
      end

      def state_names
        ary = states_map.prepend([ 'All', nil ])
        Hash[*ary.flatten]
      end

      def extended_state_names
        ary = extended_states_map.prepend([ 'All', nil ])
        Hash[*ary.flatten]
      end

      def states_map
        states.map { |key, val| [ key.to_s.titleize, val ] }
      end

      def extended_states_map
        extended_states.map { |key, val| [ key.to_s.titleize, val ] }
      end

      def states_list
        states_map.unshift(['All', nil])
      end

      private

      def build_scopes
        states.each do |key, value|
          scope key, -> { where(state: value) }
        end
      end
    end
  end

  module Controller
    def event
      set_object
      respond_to do |format|
        format.js do
          @object.call_event(params)
        end
      end
    end

    # This can be overridden if needed
    def set_object
      @object = current_resource.to_s
                                .singularize
                                .classify
                                .constantize
                                .find(params[:id])
    end
  end

  module Helper
    def state_changer(model)
      current_state =
      list_table_for model, class: 'table table-condensed table-hover table-responsive' do |model|
        item :current_state, value: state_label(model)
      end

      panel_for :state do
        concat current_state
        concat content_tag(:div, state_changer_buttons(model), class: 'panel-footer')
      end.html_safe
    end

    def state_changer_buttons(models,
                              remote: true,
                              path: nil,
                              redirect_to: nil,
                              link_class: 'btn btn-xs btn-default',
                              link_data: {})
      models         = [models].flatten
      primary_model  = models.last
      path_partial   = models.map(&:model_name).map(&:name).map(&:to_s).map(&:underscore).join('_')
      state_buttons = ''
      redirect = redirect_to.present? ? ", redirect_to: '#{redirect_to}'" : ''
      format = remote ? ', format: :js' : ''
      path ||= eval("event_#{path_partial}_path(*models#{format})")

      primary_model.state_events.each do |event|
        if eval("primary_model.can_#{event.to_s}?")
          state_buttons += button_to(event.to_s.titleize,
                                     path,
                                     remote: remote,
                                     params: { event: event, redirect: redirect },
                                     class: link_class,
                                     data: link_data)
        end
      end
      button_group = content_tag(:div, state_buttons.html_safe, class: 'btn-group')
    end

    def state_label(model)
      content_tag(:div, class: state_label_classes(model)) do
        model.current_state
      end
    end

    private

    def state_label_classes(model)
      klass = if model.respond_to?(:state_label_class)
                model.state_label_class ||
                  state_classes[model.current_state]
              else
                state_classes[model.current_state]
              end

      "label label-#{klass || 'default'}"
    end

    def state_classes
      warn "[DEPRECATION] StateMachineMixins##{__method__} is deprecated. " \
           "Please add `#state_label_class to your model or decorator instead."
      {
        'Active'                 => 'info',
        'Actual Needed'          => 'warning',
        'Alternate'              => 'purple',
        'Archived'               => 'default',
        'Approved'               => 'success',
        'Available'              => 'success',
        'Banned'                 => 'danger',
        'Canceled'               => 'danger',
        'Closed'                 => 'default',
        'Complete'               => 'default',
        'Core'                   => 'success',
        'Denied'                 => 'danger',
        'Draft'                  => 'warning',
        'Filled'                 => 'warning',
        'Follow Up Needed'       => 'warning',
        'In Transit'             => 'purple',
        'Inactive'               => 'default',
        'Inactive Client'        => 'default',
        'Incomplete'             => 'warning',
        'Installed'              => 'success',
        'Inventory Reduction'    => 'purple',
        'Invoiced'               => 'default',
        'Liquidation'            => 'warning',
        'Measure Needed'         => 'warning',
        'Missing'                => 'danger',
        'Needs Reassignment'     => 'warning',
        'Needs Update'           => 'warning',
        'On Hold'                => 'warning',
        'On Order'               => 'info',
        'Open'                   => 'info',
        'Ordering Client'        => 'success',
        'Out For Delivery'       => 'purple',
        'Pending'                => 'info',
        'Pick Listed'            => 'info',
        'Picked'                 => 'purple',
        'Placed'                 => 'info',
        'Pricing Needed'         => 'warning',
        'Pricing Presented'      => 'purple',
        'Primary'                => 'success',
        'Processed'              => 'primary',
        'Prospect'               => 'info',
        'Question Answered'      => 'success',
        'Question Asked'         => 'warning',
        'Ready For Will Call'    => 'purple',
        'Received'               => 'success',
        'Rejected'               => 'warning',
        'Returned'               => 'danger',
        'Remeasure Meeded'       => 'warning',
        'Requires Clarification' => 'info',
        'Reserved'               => 'warning',
        'Routed For Delivery'    => 'warning',
        'Running Line'           => 'success',
        'Scheduled'              => 'purple',
        'Signed For'             => 'success',
        'Shipped'                => 'success',
        'Spec Needed'            => 'warning',
        'Submitted'              => 'primary',
        'Suspended'              => 'warning',
        'To Be Processed'        => 'info',
        'Work In Progress'       => 'warning',
        'Workflowed'             => 'warning',
      }
    end
  end
end
