# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :bootstrap, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.use :input, wrap_with: { tag: 'div', class: 'form-input'}
      input.use :error, wrap_with: { tag: 'span', class: 'label label-danger help-inline' }
      input.use :hint,  wrap_with: { tag: 'span', class: 'hidden hint' }
    end
  end

  config.wrappers :prepend, tag: 'div', class: "control-group", error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.wrapper tag: 'div', class: 'input-prepend' do |prepend|
        prepend.use :input
        prepend.use :error, wrap_with: { tag: 'span', class: 'label label-danger help-inline' }
        prepend.use :hint,  wrap_with: { tag: 'span', class: 'hidden hint' }
      end
    end
  end

  config.wrappers :append, tag: 'div', class: "control-group", error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.wrapper tag: 'div', class: 'input-append' do |append|
        append.use :input
        append.use :error, wrap_with: { tag: 'span', class: 'label label-danger help-inline' }
        append.use :hint,  wrap_with: { tag: 'span', class: 'hidden hint' }
      end
    end
  end

  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://twitter.github.com/bootstrap)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.

  config.default_wrapper = :bootstrap

  config.label_class = 'form-label'

end
