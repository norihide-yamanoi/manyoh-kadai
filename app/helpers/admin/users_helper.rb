module Admin::UsersHelper
  def choose_new_or_edit_admin
    if action_name == 'new' || action_name == 'create'
      confirm_admin_users_path
    elsif action_name == 'edit'
      admin_user_path
    end
  end
end
