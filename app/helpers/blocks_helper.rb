module BlocksHelper
  def render_dynamic_form_fields(form, base_block, opts)
    s = ''
    begin
      (Block.module_types[base_block.module_type] || {}).each do |k,v| 
        datatype = v[:datatype].to_sym
        method = {:string => :text_field, :text => :text_area_field}[datatype]
        if method
          s += form.send(method, k, opts)
        end
      end
      s.html_safe
    rescue Exception => ex
      Rails.logger.warn 'Failed to add form fields for block [%s]' % base_block.inspect
      Rails.logger.warn 'Check the YAML file for that madule and make sure it\'s properly configured'
      Rails.logger.warn ex
      ''
    end
  end
end
