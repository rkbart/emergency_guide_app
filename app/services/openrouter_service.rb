class OpenrouterService
  include HTTParty
  base_uri "https://openrouter.ai/api/v1"
  headers "Content-Type" => "application/json"
  debug_output $stdout  # This will show the raw HTTP request/response

  def self.generate_answer(question)
    api_key = ENV['OPENROUTER_API_KEY'] || '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'

    response = post(
      "/chat/completions",
      headers: {
        "Authorization" => "Bearer #{api_key}",
        # "HTTP-Referer" => "http://localhost:3000",
        # "X-Title" => "Survival Guide App",  # Additional identifying header
        "Content-Type" => "application/json"
      },
      body: {
        model: "mistralai/mistral-7b-instruct",
        messages: [
          {
            role: "system",
            content: "You are an expert first aid and survival responder. Provide concise, practical advice in bullet points."
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
