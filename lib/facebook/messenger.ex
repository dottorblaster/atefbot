defmodule Messenger do
    alias Messenger.Api

    def send(recipient, text) do
        payload = %{
            "messaging_type" => "UPDATE",
            "recipient" => %{ "id" => recipient },
            "message" => %{ "test" => text }
        } |> Poison.encode!()
        Api.post!("/", payload)
    end

    def response(recipient, text) do
        payload = %{
            "messaging_type" => "RESPONSE",
            "recipient" => %{ "id" => recipient },
            "message" => %{ "text" => text }
        } |> Poison.encode!()
        Api.post!("/", payload, [{"Content-Type", "application/json"}])
    end
end