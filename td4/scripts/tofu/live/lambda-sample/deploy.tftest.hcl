run "deploy" {
  command = apply
}

run "validate" {
  command = apply
  module {
    # On pointe vers le module de test créé précédemment
    source = "../../modules/test-endpoint"
  }
  variables {
    # On récupère l'URL générée par le bloc "deploy"
    endpoint = run.deploy.api_endpoint
  }

  assert {
    condition     = data.http.test_endpoint.status_code == 200
    error_message = "Status code was ${data.http.test_endpoint.status_code}"
  }

  assert {
    condition     = data.http.test_endpoint.response_body == "Hello, World!"
    error_message = "Response body was ${data.http.test_endpoint.response_body}"
  }
}
assert {
  condition     = data.http.test_endpoint.response_body == "{\"status\":\"ok\",\"message\":\"Hello from JSON\"}"
  error_message = "JSON response was unexpected"
}
