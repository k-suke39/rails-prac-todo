require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PracApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.i18n.default_locale = :ja
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # generateファイルの設定
    config.generators do |g|
      g.skip_routes     true           # routes.rbにルーティングを追加しない、falseで追加する(falseがデフォルト)
      #g.assets          false          # assets以下のファイル(CSS, JavaScriptファイル)を作成しない 
      
      # g.assetsは分けて記述することもできる
      # g.stylesheets   false          # stylesheets以下にファイルを作成しない  
      # g.javascripts   false          # javascripts以下にファイルを作成しない

      #g.helper          false          # helper以下にファイルを作成しない 
      g.test_framework  false          # test以下にファイル作成しない     
      g.test_framework :rspec, # ここから5行を追記
      fixtures: false, # テストDBにレコードを作るfixtureの作成をスキップ(FactoryBotを使用するため)
      view_specs: false, # ビューファイル用のスペックを作成しない
      helper_specs: false, # ヘルパーファイル用のスペックを作成しない
      routing_specs: false # routes.rb用のスペックファイル作成しない
    end 
  end
end
