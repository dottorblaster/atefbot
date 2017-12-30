defmodule AtefBotWeb.BotController do
    use AtefBotWeb, :controller

    def challenge(conn, params) do
        case params do
            %{"hub.challenge" => challenge, "hub.mode" => "subscribe", "hub.verify_token" => "topkek"} ->
                conn |> send_resp(200, challenge)
            _ -> conn |> send_resp(200, "OK")
        end
    end

    def message(conn, %{"entry" => entry}) do
        messages = entry
        |> Enum.map(fn(e) -> e["messaging"] end)
        |> Enum.map(fn(messaging) -> Enum.at(messaging, 0) end)

        messages |> Enum.each(fn(message) -> 
            %{
                "sender" => %{"id" => id},
                "message" => %{"nlp" => %{"entities" => nlp_entities}}
            } = message
            case ["greetings", "datetime"] |> Enum.all?(&(Map.has_key?(nlp_entities, &1))) do
                true -> Messenger.response(id, "To you and your family!")
                _ -> Messenger.response(id, "OHAI! :3")
            end
        end)
        
        conn |> send_resp(200, "OK")
    end

    def index(conn, _params) do
        conn |> send_resp(200, "OK")
    end
end