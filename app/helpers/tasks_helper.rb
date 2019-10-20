module TasksHelper
  def button_text
    if action_name == "new" || action_name == "create" || action_name == "confirm"
        return "作成する"
    elsif action_name == "edit"
        return "更新する"
    end
  end
end
