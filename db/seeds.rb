def seed_users
  puts "seeding users..."
  user_id = 0

  10.times do
    User.create(
      name: "#{Faker::Name.name}-#{user_id}",
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

  hobby.each do |name|
    Category.create(
      branch: "hobby",
      name: name
    )
  end

  study.each do |name|
    Category.create(
      branch: "study",
      name: name
    )
  end

  team.each do |name|
    Category.create(
      branch: "team",
      name: name
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


def seed_group_conversations
  puts "seeding groups"
  user1 = User.first
  user2 = User.second

  user1.created_group_conversations.create(name: "Hotwire and Rails")
  user1.created_group_conversations.create(name: "Rails 101")
  user1.created_group_conversations.create(name: "Availabel for Hire")

  user2.created_group_conversations.create(name: "Chelsea and Thoma Tuchel")
  user2.created_group_conversations.create(name: "WWE Roman Reigns")
  user2.created_group_conversations.create(name: "Laliga Santander")
end

seed_users
seed_categories
seed_posts
seed_group_conversations
