oauth_creds = OAuther.credentials([
  consumer_key: System.get_env("EN_CONSUMER_KEY"),
  consumer_secret: System.get_env("EN_CONSUMER_SECRET"),
  method: :plaintext,
])

temp_req_params = [{"oauth_callback", "http://localhost:4000/oauth_callback"}]
temp_req_url = "https://sandbox.evernote.com/oauth"

signed_params = OAuther.sign("GET", temp_req_url, temp_req_params, oauth_creds)

IO.inspect signed_params

{auth_header, params} = OAuther.header(signed_params)

IO.inspect {auth_header, params}

response = HTTPoison.get!(temp_req_url, [auth_header], params)

IO.inspect response
