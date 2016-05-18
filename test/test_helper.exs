ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Speck.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Speck.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Speck.Repo)

