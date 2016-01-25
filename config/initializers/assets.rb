# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( datatables.js )
Rails.application.config.assets.precompile += %w( datatables-bootstrap.js )
Rails.application.config.assets.precompile += %w( users.coffee )
Rails.application.config.assets.precompile += %w( material-bonus.js )
Rails.application.config.assets.precompile += %w( clients.coffee )
Rails.application.config.assets.precompile += %w( services.coffee )
Rails.application.config.assets.precompile += %w( transactions.coffee )
Rails.application.config.assets.precompile += %w( users_new.coffee )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css.sass, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( custom-icons.eot )
Rails.application.config.assets.precompile += %w( custom-icons.ttf )
Rails.application.config.assets.precompile += %w( custom-icons.woff )
Rails.application.config.assets.precompile += %w( custom-icons.svg )
