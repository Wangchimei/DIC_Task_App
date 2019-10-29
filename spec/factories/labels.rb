FactoryBot.define do
  factory :label do
    name { "遊び" }
  end

  factory :second_label, class: Label do
    name { "勉強" }
  end
end
