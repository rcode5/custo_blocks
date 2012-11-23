module BlocksHelper
  def render_dynamic_form_fields(form, block, opts={})
    s = ''
    begin
      (Block.block_types[block.block_type] || {}).each do |k,v| 
        opts.merge!({as: v[:datatype], label: v[:display_name]})
        s += form.send('input', k, opts)
      end
      s.html_safe
    rescue Exception => ex
      Rails.logger.warn 'Failed to add form fields for block [%s]' % block.inspect
      Rails.logger.warn 'Check the YAML file for that block and make sure it\'s properly configured'
      Rails.logger.warn ex
      ''
    end
  end

  def render_config_file(block)
    fname = File.join(Rails.root, 'config','blocks', "#{block.template_name}.yml")
    File.open(fname).read if File.exists? fname
  end
      
end
