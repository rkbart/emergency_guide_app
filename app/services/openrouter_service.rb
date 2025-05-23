class OpenrouterService
  include HTTParty
  base_uri "https://openrouter.ai/api/v1"
  headers "Content-Type" => "application/json"
  debug_output $stdout  # This will show the raw HTTP request/response

  def self.generate_answer(question)
    api_key = ENV['OPENROUTER_API_KEY']

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
            content: "You are an expert first aid and survival responder based in the Philippines. Provide concise, practical advice in bullet points."
          },
          {
            role: "user",
            content: question
          }
        ]
      }.to_json,
      timeout: 30
    )

    puts "RAW RESPONSE: #{response.body}"  # Debug output

    if response.success?
      response.parsed_response.dig("choices", 0, "message", "content") || "No content received"
    else
      "API Error #{response.code}: #{response.body}"
    end
  rescue => e
    "Request failed: #{e.message}"
  end
end
