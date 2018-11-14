source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.3'
gem 'pg', '~> 0.18'

gem 'puma', '~> 3.7'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'

gem 'redis', '~> 3.0'

gem 'devise'
gem 'simple_form'
gem 'trix', github: 'maclover7/trix', branch: 'master'

gem 'faker'

gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'font-awesome-sass', '~> 4.7.0'

gem 'lazy_high_charts'
gem 'groupdate'

gem 'jquery-rails'
gem 'cocoon'

gem 'acts-as-taggable-on', '~> 5.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'annotate'
gem 'bootsnap', require: false

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails_real_favicon'
  gem 'bullet'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 1.2017.2'

ruby "2.4.1"
