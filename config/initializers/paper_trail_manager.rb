PaperTrailManager.allow_revert_when do |controller, version|
  controller.current_user and controller.current_user.has_role?(:meta_admin)
end

PaperTrailManager.whodunnit_class = User
PaperTrailManager.whodunnit_name_method = :email
