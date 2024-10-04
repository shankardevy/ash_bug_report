defmodule AshBug.AggregateTest do
  use AshBug.DataCase, async: true

  alias AshBug.Collab.{User, Conversation, Message, ConversationRead}

  describe "my conversations" do
    setup do
      # Create users
      alice =
        User
        |> Ash.Changeset.for_create(:create, %{email: "alice@example.com"})
        |> Ash.create!()

      bob =
        User
        |> Ash.Changeset.for_create(:create, %{email: "bob@example.com"})
        |> Ash.create!()

      # Create conversations
      conversation =
        Conversation
        |> Ash.Changeset.for_create(:create, %{name: "General"})
        |> Ash.create!()


      # Create messages
      messages = [
        %{conversation_id: conversation.id, user_id: alice.id, text: "Hello everyone!", inserted_at: ~U[2023-10-01 10:00:00Z]},
        %{conversation_id: conversation.id, user_id: bob.id, text: "Hi Alice!", inserted_at: ~U[2023-10-01 10:05:00Z]},
        %{conversation_id: conversation.id, user_id: bob.id, text: "Good morning!", inserted_at: ~U[2023-10-01 10:10:00Z]},
      ]

      Enum.each(messages, fn message ->
        Message
        |> Ash.Changeset.for_create(:create, message)
        |> Ash.create!()
      end)

      # Create conversation reads
      conversation_reads = [
        %{conversation_id: conversation.id, user_id: alice.id, last_read_at: ~U[2023-10-01 10:00:00Z]},
        %{conversation_id: conversation.id, user_id: bob.id, last_read_at: ~U[2023-10-01 10:10:00Z]},
      ]
      Enum.each(conversation_reads, fn conversation_read ->
        ConversationRead
        |> Ash.Changeset.for_create(:create, conversation_read)
        |> Ash.create!()
      end)

      {:ok, alice_id: alice.id}
    end

    test "get current_user conversations", %{alice_id: alice_id} do
      result =
        AshBug.Collab.Conversation
        |> Ash.Query.for_read(:list_current_user_conversations, %{}, actor: %{id: alice_id})
        |> Ash.read!()

      assert  [
        %{id: _, name: "General", last_read_at: ~U[2023-10-01 10:00:00Z], unread_count: 2},
      ] =  result
    end
  end
end
