FactoryBot.define do
  factory :category,class: Category do
    id { 1 }
    name { "前橋育英" }
  end

  factory :category_2,class: Category do
    id { 2 }
    name {"作新学院"}
  end

  factory :tournament,class: Category do
    id { 1 }
    name {"第99回全国高校野球選手権大会"}
  end
end