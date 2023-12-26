Rswag::Ui.configure do |c|
  c.openapi_endpoint '/swagger/weather.openapi.yaml', 'Weather API Docs'
  c.openapi_endpoint '/swagger/historical.openapi.yaml', 'Historical API Docs'
  c.openapi_endpoint '/swagger/health_check.openapi.yaml', 'HealthCheck API Docs'
end
