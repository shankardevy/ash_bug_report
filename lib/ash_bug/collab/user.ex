defmodule AshBug.Collab.User do
  use Ash.Resource, otp_app: :ash_bug, domain: AshBug.Collab, data_layer: AshPostgres.DataLayer

  postgres do
    table "users"
    repo AshBug.Repo
  end

  actions do
    defaults [:read, create: :*]
  end

  attributes do
    uuid_v7_primary_key :id
    attribute :email, :string do
      public? true
    end
  end
end
