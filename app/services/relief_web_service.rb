class ReliefWebService
  include HTTParty
  base_uri "https://api.reliefweb.int"
  default_params appname: "emergency_guide_app"

  THEME_MAPPING = {
    "Epidemic" => :health,
    "Health" => :health,
    "Food and Nutrition" => :food,
    "Agriculture" => :food,
    "Natural Disaster" => :disaster,
    "Earthquake" => :disaster,
    "Flood" => :disaster,
    "Conflict" => :security,
    "Security" => :security,
    "Education" => :education,
    "Refugees" => :migration,
    "Migration" => :migration,
    "Climate Change" => :environment
  }.freeze

  def self.fetch_articles(limit = 20)
    response = get("/v1/reports", query: {
      limit: limit,
      fields: {
        include: [ "title", "headline", "url", "theme", "primary_country" ]
      }
    })

    return [] unless response.success?

    articles = response.parsed_response["data"].map do |item|
      id = item["id"]
      fields = item["fields"]
      headline = fields["headline"] || {}
      theme = determine_theme(fields["theme"])

    {
      id: id,
      title: fields["title"],
      url: fields["url"] || "https://reliefweb.int/report/#{id}",
      description: fields.dig("headline", "summary") || fields["body"]&.truncate(300) || "No description available.",
      image_url: extract_image_url(fields.dig("headline", "image")),
      theme: theme
    }
  end

  articles.compact # removes any nil values from the articles array, returning a new array with only the non-nil elements.
  end

  private

  def self.determine_theme(theme_data)
    return :general unless theme_data

    # Find the first theme that matches our mapping
    theme_data.each do |theme|
      mapped_theme = THEME_MAPPING[theme["name"]]
      return mapped_theme if mapped_theme
    end

    :general
  end

  def self.extract_image_url(image_data)
    return nil unless image_data

    # Try different image sizes in order of preference
    image_data["url-large"] ||
    image_data["url"] ||
    image_data["url-thumb"] ||
    image_data["url-small"]
  end

  def self.default_image_for(theme = :general)
    theme_dir = Rails.root.join("app", "assets", "images", "defaults", theme.to_s)

    # Verify theme directory exists and has images
    if File.directory?(theme_dir)
      images = Dir.glob(theme_dir.join("*.{jpg,png,gif}"))
      if images.any?
        "defaults/#{theme}/#{File.basename(images.sample)}"
      else
        "defaults/general/general1.jpg"
      end
    else
      "defaults/general/general1.jpg"
    end
  end
end
