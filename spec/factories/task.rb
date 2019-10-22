FactoryBot.define do

  factory :task do
    title { 'titletitle1' }
    content { 'contentcontent1' }
  end

  factory :second_task, class: Task do
    title { 'titletitle2' }
    content { 'contentcontent2' }
  end

  factory :third_task, class: Task do
    title { 'titletitle3' }
    content { 'contentcontent3' }
  end
end
