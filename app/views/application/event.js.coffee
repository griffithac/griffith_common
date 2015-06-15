<% if @object.errors.present? %>
  alert("<%= j @object.errors.full_messages.join(', ').html_safe %>")
<% else %>
  $('#<%= "#{@object.class.to_s.underscore}_#{@object.id}_states" %>').replaceWith('<%= j render( partial: 'state_changer', locals: { object: @object }) %>')
<% end %>
