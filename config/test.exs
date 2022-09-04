import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :scrawled, Scrawled.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "scrawled_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :scrawled, ScrawledWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "YTAFXb2Y4NLWJujr1lVrp3Qb9rymuFYOymPKLdMnOEvLzKksIWFP2L6hwEAMXfjK",
  server: false

# In test we don't send emails.
config :scrawled, Scrawled.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
