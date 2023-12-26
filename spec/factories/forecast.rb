FactoryBot.define do
  factory :forecast do
    temperature { rand(-20..40) }
    observation_time { Time.now.utc }
  end
end
