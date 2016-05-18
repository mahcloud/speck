defmodule Particle.Api do
  @api_base "https://api.particle.io"

  """
  curl https://api.particle.io/oauth/token -u particle:particle -d grant_type=password -d username=joe@example.com -d password=SuperSecret
  """
  def auth_token(email, password) do
    encoded = Base.encode64("particle:particle")
    header = [{"Authorization", "Basic #{encoded}"}, {"content-type", "application/x-www-form-urlencoded"}]
    case HTTPoison.post(build_url("/oauth/token"), ["grant_type=password&username=#{email}&password=#{password}"], header) do
      {:ok, %HTTPoison.Response{body: body}} -> parse_auth_token(body)
    end
  end

  """
  curl https://api.particle.io/v1/devices/1234?access_token=1234
  """
  def device(access_token, device_id) do
    case HTTPoison.request("GET", build_url("/v1/devices/#{device_id}?access_token=#{access_token}"), []) do
      {:ok, %HTTPoison.Response{body: body}} -> parse_json(body)
    end
  end

  def devices(access_token) do
    case HTTPoison.request("GET", build_url("/v1/devices?access_token=#{access_token}"), []) do
      {:ok, %HTTPoison.Response{body: body}} -> parse_json(body)
    end
  end

  def var(access_token, device_id, var) do
    case HTTPoison.request("GET", build_url("/v1/devices/#{device_id}/#{var}?access_token=#{access_token}"), []) do
      {:ok, %HTTPoison.Response{body: body}} -> parse_json(body)
    end
  end

  ###
  ### PRIVATE
  ###

  defp build_url(url) do
    @api_base <> url
  end

  defp parse_json(body) do
    body |> Poison.decode!
  end

  defp parse_auth_token(body) do
    case parse_json(body) do
      %{"access_token" => token} -> token
      _ -> nil
    end
  end
end