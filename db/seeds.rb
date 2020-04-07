publishers = []
categories = []
tags = []
user = User.where(email: 'test@tt.tt').first_or_create do |user|
  user.email = 'test@tt.tt'
  user.password = '123123123'
end

100.times { |i| publishers << Publisher.find_or_create_by!(name: FFaker::Name.name) }
20.times { |i| categories << Category.find_or_create_by!(name: FFaker::Lorem.word) }
200.times { |i| tags << Tag.find_or_create_by!(name: FFaker::Lorem.word) }
articles_count = ENV['ARTICLES_COUNT'] || 10000
articles_count.times do |i|
  Article.create!(
    title: FFaker::Lorem.word,
    body: FFaker::Lorem.paragraphs,
    user: user,
    publishers: publishers.sample(rand(1..3)),
    tags: tags.sample(rand(4..7)),
    category: categories.sample
  )
end
