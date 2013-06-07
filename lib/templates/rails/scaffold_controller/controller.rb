<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
  end

  def show
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  def edit
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>

    if @<%= orm_instance.save %>
      redirect_to <%= plural_table_name %>_path, notice: flash_message('created')
    else
      render <%= key_value :action, '"new"' %>
    end
  end

  def update
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>

    if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
        redirect_to <%= plural_table_name %>_path, notice: flash_message('updated')
    else
        render <%= key_value :action, '"edit"' %>
    end
  end

  def destroy
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.destroy %>

    redirect_to <%= plural_table_name %>_path, notice: flash_message('deleted')
  end

  private

  def flash_message(type)
    t('app.messages.'+type+'_model', :model => <%= class_name %>.model_name.human, :name => @<%= singular_table_name %>.id)
  end
end
<% end -%>
