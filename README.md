# Speck

Particle API integration.
The following can be run in iex.

``` elixir
email = "youremail@test.com"
password = "yourpassword"
auth_token = Particle.Api.auth_token(email, password)
Particle.Api.devices(auth_token)
```
