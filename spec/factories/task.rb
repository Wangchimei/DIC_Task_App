FactoryBot.define do

  factory :task do
    title { 'titletitle1' }
    content { 'contentcontent1' }
    deadline { DateTime.now + 5}
  end

  factory :second_task, class: Task do
    title { 'titletitle2' }
    content { 'contentcontent2' }
    deadline { DateTime.now + 10 }
  end

  factory :third_task, class: Task do
    title { 'titletitle3' }
    content { 'contentcontent3' }
    deadline { DateTime.now + 15 }
  end
end
