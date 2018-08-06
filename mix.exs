defmodule ParallelDots.MixProject do
  use Mix.Project

  @version "0.1.0"
  @name "parallel_dots"
  @maintainers ["Hussein Merhi"]
  @url "https://github.com/Eweev/parallel_dots"

  def project do
    [
      app: :parallel_dots,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: @name,
      source_url: @url
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:inch_ex, "~> 0.5", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false},
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"}
    ]
  end

  defp description() do
    "Elixir Wrapper Around the Parallel Dots APIs"
  end

  defp package() do
    [
      name: @name,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: @maintainers,
      licenses: ["MIT"],
      links: %{"GitHub" => @url}
    ]
  end
end
