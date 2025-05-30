class OpenrouterService
  include HTTParty
  base_uri "https://openrouter.ai/api/v1"
  headers "Content-Type" => "application/json"

  def self.generate_answer(question)
    api_key = ENV["OPENROUTER_API_KEY"]

    response = post(
      "/chat/completions",
      headers: {
        "Authorization" => "Bearer #{api_key}",
        "Content-Type" => "application/json"
      },
      body: {
        model: "mistralai/mistral-7b-instruct",
        messages: [
          {
            role: "system",
            content: "You are an expert first aid and survival responder based in the Philippines. Provide concise, practical advice in bullet points. Keep it under 100 words and don't provide bullet points if not needed."
          },
          {
            role: "user",
            content: question
          }
        ]
      }.to_json,
      timeout: 30
    )

    if response.success?
      response.parsed_response.dig("choices", 0, "message", "content") || "No content received"
    else
      "API Error #{response.code}: #{response.body}"
    end
  rescue => e
    "Request failed: #{e.message}"
  end
end
