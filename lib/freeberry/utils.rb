# encoding: utf-8
module Freeberry
  class Utils
    class << self
      def form_field(form_name, field_name, column, options={})
        field = case column.type
          when :string, :binary, :integer, :float, :decimal then 
            options[:class] = "'text'"
            "text_field"
          when :boolean then "check_box"
          when :datetime, :date, :timestamp, :time then 
            options[:extra_html] ||= "<script type='text/javascript'>
              $(function() {
	              $('#_#{field_name}').datepicker({
		              numberOfMonths: 1,
		              dateFormat: 'dd.mm.yy'
	              });
              });
            </script>"
            'text_field'
          when :text then 
            options[:cols] ||= 70
            options[:rows] ||= 5
            "text_area"
        end
        
        extra_html = options.delete(:extra_html) || ''
        
        options_fields = []
        options.each { |k, v| options_fields << ":#{k}=>#{v}" }
        
        options_str = ", {#{options_fields.join(', ')}}" unless options_fields.empty? 
        options_str ||= ''
        
        "<%= #{form_name}.#{field} #{field_name}#{options_str} %>#{extra_html}"
      end
    end
  end
end
