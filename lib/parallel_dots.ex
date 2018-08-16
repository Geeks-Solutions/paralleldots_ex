defmodule ParallelDots do
  @moduledoc """
  Elixir Wrapper for ParallelDots APIs

  ## Http Code
    `200: Successful response`  
    `304: There was no new text to return`  
    `500: Backend Error`  
    `400: Please provide valid input parameter`  
    `401: Invalid Credentials. Please provide valid API key`  
    `403: Daily/Monthy Limit Exceeded`  
    `429: Too Many Requests. Please try after sometime`  
    `406: Invalid Format`

  """
  require Logger

  @doc false
  def config do
    :parallel_dots
    |> Application.get_env(ParallelDots)
    |> check_config
  end

  @doc false
  def check_config(nil),
    do: raise("ParallelDots is not configured in your application, 
      please add a configuration for ParallelDots to be able to use this library. 
      Read the documentation about configuration for more details")

  @doc false
  def check_config(list) do
    case Keyword.has_key?(list, :api_key) do
      false -> raise "ParallelDots requires an api key, 
        please add a configuration for ParallelDots to be able to use this library. 
        Read the documentation about configuration for more details"
      true -> list
    end
  end

  @doc false
  def config(key, default \\ nil), do: config() |> Keyword.get(key, default)

  @doc false
  defp endpoints do
    api_root = "https://apis.paralleldots.com/v3/"

    %{
      "name" => api_root <> "ner",
      "sentiment" => api_root <> "sentiment",
      "intent" => api_root <> "intent"
    }
  end

  @doc """
  Extract name or sentiment from given text

  ## Functionality
  Send POST request to ParallelDots API with a text to extract names from it

  ## Parameters
    text::String  
    api_key::String

  ## Returns
    if type = name 
      in case of finding names  
      `{:ok, %{"code" => 200, "entities" => ["category" => "name", "confidence_score" => Float, "name" => String, ...]}}`  
      in case of didnt find names  
      `{:ok, %{"code" => 200, "entities" => "The statement belongs to none of the categories."}}`  
      in case of the HTTPoison failt to execute the request  
      `{:error, reason}`  
    if type = sentiment  
      in case of successful call    
      `{:ok, %{"code" => 200, "probabilities" => %{"negative" => 0.134, "neutral" => 0.29, "positive" => 0.576}, "sentiment" => "positive"}}`  
      in case of the HTTPoison failt to execute the request  
      `{:error, reason}`   
  """
  def text_analysis(text, type) do
    api_key = config(:api_key)

    body =
      {:form,
       [
         {:api_key, api_key},
         {:text, text}
       ]}

    headers = [
      {"Accept", "application/json"},
      {"Content_Type", "application/json"}
    ]

    case HTTPoison.post(endpoints[type], body, headers) do
      {:ok, response} ->
        Poison.decode(response.body)

      {:error, reason} ->
        {:error, reason}
    end
  end
end
