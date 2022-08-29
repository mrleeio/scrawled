defmodule Scrawled.Repo do
  use Ecto.Repo,
    otp_app: :scrawled,
    adapter: Ecto.Adapters.Postgres
end
