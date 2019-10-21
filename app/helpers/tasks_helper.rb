module TasksHelper
  def button_text
    if action_name == "new" || action_name == "create"
      t('task_form.create')
    elsif action_name == "edit"
      t('task_form.update')
    end
  end
end
