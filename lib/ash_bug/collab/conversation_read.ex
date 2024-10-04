defmodule AshBug.Collab.ConversationRead do
  use Ash.Resource, otp_app: :ash_bug, domain: AshBug.Collab, data_layer: AshPostgres.DataLayer

  alias AshBug.Collab.{Conversation, User}

  postgres do
    table "conversation_reads"
    repo AshBug.Repo
  end

  actions do
    defaults [:read, create: :*]
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :last_read_at, :utc_datetime_usec do
      allow_nil? false
      public? true
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :conversation, Conversation, public?: true
    belongs_to :user, User, public?: true
  end
end
