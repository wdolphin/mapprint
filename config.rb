# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

ignore 'REAMDME.md'

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :layouts_dir, 'layouts'

activate :external_pipeline,
  name: :gulp,
  command: build? ? './node_modules/gulp/bin/gulp.js build' : './node_modules/gulp/bin/gulp.js watch',
  source: ".tmp/dist",
  latency: 0.25

# Layouts
# https://middlemanapp.com/basics/layouts/
set :haml, { :format => :html5 }
Haml::TempleEngine.disable_option_validator!


# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

activate :livereload

configure :build do
  activate :asset_host, :host => "/mapprint"
  ignore /stylesheets\/.*\.scss/
  ignore /javascripts\/(?!bundle).*\.js/
  ignore /javascripts\/(?!bundle).*\.ts/
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
  deploy.remote = ENV['DEPLOY_REMOTE'] || 'origin'
  deploy.branch = ENV['DEPLOY_BRANCH'] || 'gh-pages'
  deploy.commit_message = "[ci skip] Automated commit at #{Time.now.utc} by middleman-deploy #{Middleman::Deploy::PACKAGE} #{Middleman::Deploy::VERSION}"
end
