module ChangesHelper

  def text_or_nil(object)
    if object.nil?
      return content_tag('span', 'nil', :class => 'nil')
    else
      return h(object)
    end
  end


  def changes_for(version)
    changes  = {}
    current  = version.next.try(:reify)
    previous = version.reify rescue nil
    record   = \
      begin
        version.item_type.constantize.find(version.item_id)
      rescue ActiveRecord::RecordNotFound
        previous || current
      end

    # Bail out if no changes are available
    return changes unless record

    case version.event
      when "create", "update"
        current ||= record
      when "destroy"
        previous ||= record
      else
        raise ArgumentError, "Unknown event: #{version.event}"
    end

    (current or previous).attribute_names.each do |name|
      next if name == "updated_at"
      next if name == "created_at"
      current_value  = current.read_attribute(name) if current
      previous_value = previous.read_attribute(name) if previous
      unless current_value == previous_value || (version.event == "create" && current_value.blank?)
        changes[name] = {
          :previous => previous_value,
          :current => current_value,
        }
      end
    end

    return changes
  end


  def change_item_types
    return ActiveRecord::Base.connection.select_values('SELECT DISTINCT(item_type) FROM versions ORDER BY item_type')
  end


  def change_title_for(version)
    current  = version.next.try(:reify)
    previous = version.reify rescue nil
    record   = version.item_type.constantize.find(version.item_id) rescue nil

    name = nil

    [:name, :title, :email, :invoice_number, :to_s].each do |name_method|
      [previous, current, record].each do |obj|
        name = obj.send(name_method) if obj.respond_to?(name_method)
        if name_method == :invoice_number && name && record
          name = "#{Invoice.model_name.human} #{name}"
        end
        break if name
      end
      break if name
    end

    return h(name)
  end


  def change_item_link(version)
    if version.event != 'destroy' && version.item_type.constantize.exists?(version.item_id)
      if !(path = change_item_path(version)).nil?
        return link_to change_title_for(version), change_item_path(version)
      end
    end
    content_tag :span, t('app.label.not_available'), :class => 'nil'
  end


  def change_whodunnit_link(version)
    if user = User.find(version.whodunnit) rescue nil
      link_to(user.email, user_path(user))
    end
  end


  def change_mandator_link(version)
    if mandator = Mandator.find(version.mandator_id) rescue nil
      link_to(mandator.name, mandator_path(mandator))
    end
  end

end
