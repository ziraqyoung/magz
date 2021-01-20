def seed_users
  puts "seeding users..."
  user_id = 0

  10.times do
    User.create(
      name: "name-#{user_id}",
      email: "test-#{user_id}@test.com",
      password: '123456',
      password_confirmation: '123456'
    )
    user_id = user_id + 1
  end
end

def seed_categories
  puts "seeding categories..."

  hobby = ['Arts', 'Crafts', 'Sports', 'Sciences', 'Collecting', 'Reading', 'Other']
  study = ['Arts and Humanities', 'Physical Science and Engineering', 'Math and Logic',
          'Computer Science', 'Data Science', 'Economics and Finance', 'Business',
          'Social Sciences', 'Language', 'Other']
  team = ['Study', 'Development', 'Arts and Hobby', 'Other']

  hobby.each do |hobby|
    Category.create(
      branch: "hobby",
      name: hobby
    )
  end

  study.each do |study|
    Category.create(
      branch: "study",
      name: study
    )
  end

  team.each do |team|
    Category.create(
      branch: "team",
      name: team
    )
  end
end

def seed_posts
  puts "seeding posts..."
  categories = Category.all

  categories.each do |category|
    5.times do
      Post.create(
        title: Faker::Lorem.sentences[0],
        content: Faker::Lorem.sentences[0],
        user_id: rand(1..9),
        category_id: category.id
      )
    end
  end
end

seed_users
seed_categories
seed_posts
