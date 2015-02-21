# Use integers for states, but never zero.  This is because '' evaluates to zero
# which can case problems with the use of all in state select controls.

module StateMachineMixins
  module Model
    extend ActiveSupport::Concern

    included do
      after_initialize do
        self[:state] ||= 1
      end
    end

    def current_state
      human_state_name.titleize
    end

    def call_event params
      if ( send(params[:event]) if state_events.include?(params[:event].to_sym) )
        if respond_to? :current_user_id
          self.current_user_id = params[:current_user_id].to_i
          set_creator_and_updater
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

      def valid_state? val
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


  module Helper

    def state_changer model

      current_state =
      list_table_for model, class: 'table table-condensed table-hover table-responsive' do |model|
        item :current_state, value: state_label(model)
      end

      panel_for :state do
        concat current_state
        concat content_tag(:div, state_changer_buttons(model), class: 'panel-footer')
      end.html_safe

    end

    def state_changer_buttons models, link_class: 'btn btn-xs btn-default', link_data: {}
      models         = [models].flatten
      primary_model  = models.last
      path_partial   = models.map(&:class).map(&:to_s).map(&:underscore).join('_')
      state_buttons = ''
      primary_model.state_events.each do |event|
        if eval("primary_model.can_#{event.to_s}?")
          path = eval("event_#{path_partial}_path(*models, event: :#{event})")
          state_buttons += link_to(event.to_s.titleize, path, class: link_class, data: link_data )
        end
      end
      button_group = content_tag(:div, state_buttons.html_safe, class: 'btn-group')
    end

    def state_label model
      content_tag(:div, class: state_label_classes(model)) do
        model.current_state
      end
    end

    private

    def state_label_classes model
      klass = state_classes[model.current_state] || 'default'
      "label label-#{klass}"
    end

    def state_classes
      {
        'To Be Processed'        => 'info',
        'Open'                   => 'info',
        'Pending'                => 'info',
        'Scheduled'              => 'success',
        'Processed'              => 'success',
        'On Hold'                => 'warning',
        'Rejected'               => 'warning',
        'Workflowed'             => 'warning',
        'Archived'               => 'default',
        'Needs Reassignment'     => 'warning',
        'Closed'                 => 'default',
        'Question Asked'         => 'warning',
        'Requires Clarification' => 'info',
        'Question Answered'      => 'success',
        'Incomplete'             => 'warning',
        'Complete'               => 'default',
        'Ordering Client'        => 'success',
        'Prospect'               => 'info',
        'Inactive Client'        => 'default',
        'Follow Up Needed'       => 'warning',
        'Pricing Presented'      => 'purple',
        'Needs Update'           => 'warning',
        'Active'                 => 'info',
        'Inactive'               => 'default',
        'Work In Progress'       => 'warning',
        'Primary'                => 'success',
        'Core'                   => 'success',
        'Banned'                 => 'danger',
        'Suspended'              => 'warning',
        'Running Line'           => 'success',
        'Liquidation'            => 'warning',
        'Missing'                => 'danger',
        'Submitted'              => 'primary',
        'Draft'                  => 'default',
        'Approved'               => 'success',
        'Denied'                 => 'danger',
        'On Order'               => 'info',
        'Reserved'               => 'warning',
        'Placed'                 => 'info',
        'Pick Listed'            => 'info',
        'Canceled'               => 'danger',
        'Ready For Will Call'    => 'purple',
        'Routed For Delivery'    => 'purple',
        'Out For Delivery'       => 'warning',
        'Signed For'             => 'success',
        'Invoiced'               => 'default',
      }
    end
  end
end
