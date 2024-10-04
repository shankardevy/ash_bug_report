import Config

config :ash_bug, AshBug.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ash_bug_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
