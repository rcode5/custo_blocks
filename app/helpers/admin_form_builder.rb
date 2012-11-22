# in app/helpers/admin_form_builder.rb
class AdminFormBuilder < ActionView::Helpers::FormBuilder
  
  ####
  # To control classes on fields, pass in the following in your options hash
  #   :row_class => 'whatever'  : this will add a class 'whatever' to the field wrapper (which is a row)
  #   :input_html => {:class => 'whatever'}  : this will add all these elements to the input/textarea tag as attributes
  #                                           Note: if you use the field_row method, this will be ignored
  #
  def file_input_row(field, hint = '', opts = {})
    exists_method = "#{field}?"
    # wrap input in div.span5 for file only
    if object.respond_to?(exists_method) && object.send(exists_method)
      opts[:help] = ["Current Image: #{File.basename(object.send(field).to_s)}", opts[:help].to_s].join('<br>').html_safe
      opts[:icon] = object.send(field).url(:icon)
    end
    input_field = @template.content_tag(:div, self.send(:file_field, field, opts[:input_html] || {}), :class => 'span5')
    field_row(field, input_field, hint, opts)
  end
  
  def text_input_row(field, hint = '', opts = {})
    input_field_row field, :text_field, hint, opts
  end
  
  def textarea_input_row(field, hint = '', opts = {})
    input_field_row field, :text_area, hint, opts
  end

  def select_input_row(field, hint = '', opts = {})
    # select_opts looks like [ [display1, value1], [display2, value2]...]
    field_row field, select(field, opts.delete(:select)), hint, opts
  end
      
  def date_input_row(field, hint = '', opts = {})
    input_field_row field, :date_select, hint, opts.merge({:input_field_wrapper_class => 'date'})
  end

  def input_field_row(field, input_field_helper, hint, opts = {})
    input_field = self.send(input_field_helper, field, opts[:input_html] || {})
    field_row(field, input_field, hint, opts)
  end
  
  # use this only when you have some custom input content that needs to be built outside of these
  # functions.  For example, a select button might be constructed like this
  #
  #   field_row form, :my_field, form.select(:my_field, MyModel.select_options.map{|m| [m.name, m.id]}), 'Select a value for field.'
  #
  
  def field_row(field, input_area_content, hint, opts = {})
    begin
      if object.class == ContentModule 
        module_info = ContentModule.module_types[object.module_type]
        if module_info && module_info[:exclude]
          return '' if module_info[:exclude].include? field.to_s
        end
      end
    rescue
    end

    required_fields = object.class.validators.select{|c| /Presence/.match(c.class.to_s)}.map(&:attributes).flatten
    row_classes = ["field_#{field}", opts[:row_class].to_s]
    row_classes << 'required' if required_fields.include? field
    row_class = row_classes.uniq.join ' '
    input_field_wrapper_class = ['controls','span6', opts[:input_field_wrapper_class].to_s].join ' '

    @template.content_tag 'div', :class => "control-group row #{row_class}" do 
      
      # put label block and input field block together in the wrapper row and return it
      (@template.content_tag :div, :class => 'span2' do
         self.label(field, :class => 'control-label') +
           @template.content_tag(:p, hint, :class => 'caption')
       end) + 
        (@template.content_tag(:div, :class => input_field_wrapper_class) do
           help_chunk = ''
           img_chunk = ''
           if opts[:icon] && !opts[:icon].empty?
             img_chunk = @template.content_tag(:div, @template.tag(:img, :src => opts[:icon]), :class => 'span1')
           end
           if opts[:help] && !opts[:help].empty?
             help_chunk = @template.content_tag(:span, opts[:help], :class => 'span6 help-block')
           end
           img_chunk.html_safe + input_area_content.html_safe + help_chunk.html_safe
         end)
    end
  end
end
