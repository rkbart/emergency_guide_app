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
        include: %w[title headline url theme primary_country]
      }
    })

    return [] unless response.success?

    response.parsed_response["data"].map do |item|
      build_article(item)
    end.compact
  end

  private

  def self.build_article(item)
    fields = item["fields"]
    {
      id: item["id"],
      title: fields["title"],
      url: fields["url"] || fallback_url(item["id"]),
      description: extract_description(fields),
      image_url: extract_image_url(fields.dig("headline", "image")),
      theme: determine_theme(fields["theme"])
    }
  end

  def self.fallback_url(id)
    "https://reliefweb.int/report/#{id}"
  end

  def self.extract_description(fields)
    fields.dig("headline", "summary") ||
      fields["body"]&.truncate(300) ||
      "No description available."
  end

  def self.determine_theme(theme_data)
    theme_data&.find { |theme| THEME_MAPPING[theme["name"]] }&.then { |theme| THEME_MAPPING[theme["name"]] } || :general
  end

  def self.extract_image_url(image_data)
    image_data&.[]("url-large") ||
    image_data&.[]("url") ||
    image_data&.[]("url-thumb") ||
    image_data&.[]("url-small")
  end

  def self.default_image_for(theme = :general)
    theme_path = Rails.root.join("app", "assets", "images", "defaults", theme.to_s)
    images = Dir.glob(theme_path.join("*.{jpg,png,gif}"))
    if images.any?
      "defaults/#{theme}/#{File.basename(images.sample)}"
    else
      "defaults/general/general1.jpg"
    end
  end
end
