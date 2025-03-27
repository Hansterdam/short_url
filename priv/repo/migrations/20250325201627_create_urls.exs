defmodule ShortUrl.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :short_key, :string

      timestamps(type: :utc_datetime)
    end
  end
end
