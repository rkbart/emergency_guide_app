# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Precompile all default images
Dir.glob(Rails.root.join("app", "assets", "images", "defaults", "**", "*.{jpg,png,gif}")).each do |path|
  relative_path = Pathname.new(path).relative_path_from(Rails.root.join("app", "assets", "images"))
  Rails.application.config.assets.precompile << relative_path.to_s
end
