class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # def status_i18n(enum_key, enum_value)
  #   enum_name = enum_key
  #   I18n.t("activerecord.attributes.task.#{enum_name}.#{enum_value}")
  # end

end
