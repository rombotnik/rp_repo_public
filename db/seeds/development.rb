def main
  create_users
  create_genres
  create_characters
  create_stories
end

def create_users
  @red = User.create_with(name: 'Red', password: 'abcd1234').find_or_create_by(email: 'user@example.com')
  @blue = User.create_with(name: 'Blue', password: 'abcd1234').find_or_create_by(email: 'user2@example.com')

  @users = User.all
end

def create_genres
  genres = ['Fantasy', 'Sci-fi', 'Modern', 'Horror']
  genres.each { |g| Genre.find_or_create_by(name: g) }
  @genres = Genre.all
end

def create_characters
  @users.each do |user|
    while user.characters.count < 10 do
      Character.create(
        name: Faker::Overwatch.hero,
        gender: Character::GENDERS.sample,
        user: user
        )
    end
  end

  @characters = Character.all
end

def create_stories
  while Story.count < 10 do
    story = Story.create(
      title: Faker::Overwatch.quote,
      genre: @genres.sample,
      description: html_text(2)
      )

    build_story_roles(story)
    build_scenes(story)
  end
end

def build_story_roles(story)
  count = [2, 4, 8].sample

  count.times do
    StoryRole.create(story: story, character: @characters.sample)
  end
end

def build_scenes(story)
  5.times do |i|
    scene = Scene.create(
      story: story,
      order: i + 1,
      title: "Scene #{i+1}"
      )
    create_posts(scene)
  end
end

def create_posts(scene)
  count = [10, 20].sample
  para_count = [1, 2, 3]

  count.times do |i|
    Post.create(
      scene: scene,
      user: @users.sample,
      body: html_text(para_count.sample)
    )
  end
end

def html_text(paragraph_count)
  '<div>' + Faker::Lorem.paragraphs(paragraph_count).join('<br><br>') + '</div>'
end

main
