defmodule ShortUrl.ShortUrls.Url do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "urls" do
    field :original_url, :string
    field :short_key, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:original_url, :short_key])
    |> validate_required([:original_url, :short_key])
  end
end
