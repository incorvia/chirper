Factory.define :user do |user|
  user.name                     "Kevin Incorvia"
  user.email                    "incorvia@test.com"
  user.password                 "foobar"
  user.password_confirmation    "foobar"
end

Factory.sequence :email do |n|
	"person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
	micropost.content "Foo bar"
	micropost.association :user
end