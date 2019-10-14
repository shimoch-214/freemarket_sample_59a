module MypagesHelper
  
  def set_active_notification
    %w(show notification).include?(action_name) ? 'active' : ''
  end

  def set_active_todo
    action_name == 'todo' ? 'active' : ''
  end
end
