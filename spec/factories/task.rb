FactoryBot.define do

  factory :task do
    title { 'titletitle1' }
    content { 'contentcontent1' }
    deadline { DateTime.now + 5}
    status { 0 }
    priority { 1 }
    user_id { 2 }
  end

  factory :second_task, class: Task do
    title { 'titletitle2' }
    content { 'contentcontent2' }
    deadline { DateTime.now + 10 }
    status { 1 }
    priority { 2 }
    user_id { 2 }
  end

  factory :third_task, class: Task do
    title { 'titletitle3' }
    content { 'contentcontent3' }
    deadline { DateTime.now + 15 }
    status { 2 }
    priority { 0 }
    user_id { 2 }
  end

  factory :task_by_user, class: Task do
    title { 'myself' }
    content { 'myself' }
    deadline { DateTime.now + 5}
    user_id { 2 }
  end

  factory :task_by_other_user, class: Task do
    title { 'other user' }
    content { 'other user' }
    deadline { DateTime.now + 5}
    user_id { 3 }
  end
end
