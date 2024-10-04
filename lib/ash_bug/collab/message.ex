defmodule AshBug.Collab.Message do
  use Ash.Resource, otp_app: :ash_bug, domain: AshBug.Collab, data_layer: AshPostgres.DataLayer

  alias AshBug.Collab.{Conversation, User}

  postgres do
    table "messages"
    repo AshBug.Repo
  end

  actions do
    defaults [:read, create: :*]
  end

  attributes do
    uuid_v7_primary_key :id
    attribute :text, :string do
      public? true
    end
    create_timestamp :inserted_at do
      public? true
      writable? true
    end
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :conversation, Conversation do
      public? true
    end
    belongs_to :user, User do
      public? true
    end
  end
end
