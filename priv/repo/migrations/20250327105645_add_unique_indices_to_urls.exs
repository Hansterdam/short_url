defmodule ShortUrl.Repo.Migrations.AddUniqueIndicesToUrls do
  use Ecto.Migration

  def change do
    create unique_index(:urls, [:url])
    create unique_index(:urls, [:short_key])
  end
end
