module MypagesHelper

  def set_active_notification
    %w(show notification).include?(action_name) ? 'active' : ''
  end

  def set_active_todo
    action_name == 'todo' ? 'active' : ''
  end

  def set_active_parchase
    %w(show parchase).include?(action_name) ? 'active' : ''
  end

  def set_active_parchased
    action_name == 'parchased' ? 'active' : ''
  end

  def side_bar_active(link)
    link == request.path ? 'active' : ''
  end

  def side_bar_arrow_active(link)
    link == request.path ? 'arrow-active' : ''
  end

end
