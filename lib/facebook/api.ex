defmodule Messenger.Api do
    use HTTPoison.Base

    @endpoint "https://graph.facebook.com/v2.6/me/messages"
    @token Application.fetch_env!(:atef_bot, :token)

    def process_url(url) do
        @endpoint <> "?access_token=" <> @token
    end

    def process_response_body(body) do
        body |> Poison.decode!()
    end
end