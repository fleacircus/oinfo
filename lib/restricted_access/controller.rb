module RestrictedAccess
  class Controller < ApplicationController
    before_filter :authenticate_user!
    authorize_resource

    before_filter :load_instance, :only => [:show, :edit, :update, :destroy]

    def index
      name = "@#{get_model_name.downcase.pluralize}"
      self.instance_variable_set(name, get_model_name.camelize.constantize.pluralize.all)
    end

    def new
      set_instance get_model_name.camelize.constantize.new
    end

    def create
      instance = get_model_name.camelize.constantize.new(get_params)
      instance = restrict_instance(instance)

      if instance.save
        redirect get_instance_descriptor(instance)
      else
        set_instance instance
        render action: "new"
      end
    end

    def update
      instance = restrict_instance(get_instance)

      if instance.update_attributes(get_params)
          redirect get_instance_descriptor(instance)
      else
        set_instance instance
        render action: "edit"
      end
    end

    def destroy
      instance = get_instance
      instance.destroy
      redirect get_instance_descriptor(instance)
    end


    protected

    def restrict_instance(instance)
      if instance.attributes.has_key? 'user_id'
        instance.user_id = current_user.id
      end
      if instance.attributes.has_key? 'mandator_id' && !current_user.mandator_id.nil?
        instance.mandator_id = current_user.mandator_id
      end
      return instance
    end

    def redirect(name = '')
      redirect_to_with_flash controller_path.split(/::|\//)[0..1], :notice,
        "#{self.action_name}_instance",
        get_model_name.camelize.constantize, name
      return
    end


    private

    def load_instance
      instance = find_by_id_or_redirect(get_model_name.camelize.constantize)
      set_instance instance
    end

    def set_instance(instance)
      self.instance_variable_set("@#{get_model_name.downcase}", instance)
    end

    def get_instance
      return self.instance_variable_get("@#{get_model_name.downcase}")
    end

    def get_params
      return params[get_model_name.downcase]
    end

    def get_model_name
      self.controller_name.singularize
    end

    def get_instance_descriptor(instance)
      descriptor = nil
      [:name, :title].each do |attr|
        descriptor = instance[attr]
        break if descriptor
      end
      return descriptor
    end

  end
end
