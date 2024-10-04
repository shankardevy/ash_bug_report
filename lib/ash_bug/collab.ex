defmodule AshBug.Collab do
  use Ash.Domain

  resources do
    resource AshBug.Collab.User
    resource AshBug.Collab.Conversation
    resource AshBug.Collab.ConversationRead
    resource AshBug.Collab.Message
  end
end
