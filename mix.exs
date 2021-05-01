defmodule ExMatchers.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_matchers,
     version: "0.1.4",
     elixir: "~> 1.11",
     package: package(),
     description: "Matchers for ExUnit assertions",
     source_url: "https://github.com/10Pines/ex_matchers",
     homepage_url: "https://hex.pm/packages/ex_matchers",
     deps: deps(),
     docs: [
       main: "readme",
       extras: [
         "README.md"
       ]
     ]]
  end

  def application do
    [applications: []]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.24.0", only: :dev}
    ]
  end

  defp package do
    [
      name: :ex_matchers,
      files: ["lib", "mix.exs"],
      maintainers: ["Emilio Gutter"],
      licenses: ["MIT"],
      links: %{"github" => "https://github.com/10Pines/ex_matchers"}
    ]
  end
end
