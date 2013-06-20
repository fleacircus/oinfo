<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < RestrictionController

  def index
    @<%= plural_table_name %>_grid = initialize_grid(<%= class_name %>.accessible_by(current_ability))
  end

end
<% end -%>
