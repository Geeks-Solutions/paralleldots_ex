defmodule ParallelDots do
  require Logger

  def get_name(text) do
    
    api_key = Application.get_env(:parallel_dots, :api_key)
    url = Application.get_env(:parallel_dots, :ner_endpoint)
    
    body = {:form, [
      {:api_key, api_key},
      {:text, text}
    ]}
    
    headers = [
      {"Accept", "application/json"},
      {"Content_Type", "application/json"}
    ]
    
    case HTTPoison.post(url, body, headers) do
      {:ok, response} ->
        IO.inspect response
      {:error, reason} ->
        IO.inspect reason
    end

  end
end
