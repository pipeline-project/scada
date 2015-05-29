Dir.glob(File.join(Rails.root, "app", "models", "steps", "*.rb")).each do |f|
  require f
end
