# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
   factory :post  do
     	content "lorem ipsum"
     	title "hello"
     	user
    end
end
