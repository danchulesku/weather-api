Rswag::Ui.configure do |c|
  c.swagger_endpoint '/swagger/weather.openapi.yaml', 'Weather API Docs'
  c.swagger_endpoint '/swagger/historical.openapi.yaml', 'Historical API Docs'
  c.swagger_endpoint '/swagger/health_check.openapi.yaml', 'HealthCheck API Docs'
end
