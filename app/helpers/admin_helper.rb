# in app/helpers/admin_helper.rb
module AdminHelper

  def admin_form_for(name, *args, &block)
    options = args.extract_options!
    form_for name, *(args << options.merge(:builder => AdminFormBuilder)), &block
  end

end

