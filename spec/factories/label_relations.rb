FactoryBot.define do
  factory :label_relation do
    task_id { 1 }
    label_id { 1 }
  end

  factory :second_label_relation, class: LabelRelation do
    task_id { 2 }
    label_id { 1 }
  end

  factory :third_LabelRelation, class: LabelRelation do
    task_id { 2 }
    label_id { 2 }
  end
end
