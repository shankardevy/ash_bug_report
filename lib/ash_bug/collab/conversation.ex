defmodule AshBug.Collab.Conversation do
  use Ash.Resource, otp_app: :ash_bug, domain: AshBug.Collab, data_layer: AshPostgres.DataLayer

  alias AshBug.Collab.{Message, ConversationRead}

  postgres do
    table "conversations"
    repo AshBug.Repo
  end

  actions do
    defaults [:read, create: :*]

    read :list_current_user_conversations do
      prepare build(load: [:last_read_at])
      # prepare build(load: [:last_read_at, :unread_count])
    end
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :name, :string do
      allow_nil? false
      public? true
    end
  end

  relationships do
    has_many :messages, Message
    has_one :conversation_reads, ConversationRead do
      filter expr(user_id == ^actor(:id))
    end
  end

  calculations do
    calculate :last_read_at, :utc_datetime, expr(conversation_reads.last_read_at)

    # calculate :unread_count,
    #           :integer,
    #           expr(count(messages, query: [filter: expr(inserted_at > parent(last_read_at))]))
  end

  aggregates do
    count :unread_count, :messages do
      filter expr(inserted_at > parent(last_read_at))
    end
  end

  #   max :last_read_at, :conversation_reads, :last_read_at

  #   count :unread_count, :messages do
  #     filter expr(inserted_at > parent(:last_read_at))
  #   end
end
