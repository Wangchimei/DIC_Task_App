FactoryBot.define do
  factory :label do
    # id { 1 }
    name { "遊び" }
  end

  factory :second_label, class: Label do
    # id { 2 }
    name { "勉強" }
  end
end
