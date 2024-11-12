
resource "aws_apigatewayv2_api" "website-apigateway" {
    name          = "website-apigateway"
    protocol_type = "HTTP"
}

resource "aws_apigatewayv2_api_mapping" "website-apigateway-mapping" {
    api_id      = aws_apigatewayv2_api.website-apigateway.id
    domain_name     = aws_apigatewayv2_domain_name.website-apigateway-domain.domain_name
    stage      = aws_apigatewayv2_stage.website-apigateway-stage.name
}

resource "aws_apigatewayv2_domain_name" "website-apigateway-domain" {
    domain_name = var.domain_name
    domain_name_configuration {
        certificate_arn = aws_acm_certificate.website-cert.arn
        endpoint_type = "REGIONAL"
        security_policy = "TLS_1_2"
    }
}

resource "aws_apigatewayv2_stage" "website-apigateway-stage" {
    api_id      = aws_apigatewayv2_api.website-apigateway.id
    name        = "$default"
    auto_deploy = true
}

resource "aws_apigatewayv2_integration" "website-apigateway-integration-get" {
    api_id = aws_apigatewayv2_api.website-apigateway.id
    integration_type = "AWS_PROXY"
    connection_type = "INTERNET"
    integration_method = "POST"
    integration_uri = aws_lambda_function.website-lambda-trackedactions.invoke_arn
}

resource "aws_apigatewayv2_integration" "website-apigateway-integration-post" {
    api_id = aws_apigatewayv2_api.website-apigateway.id
    integration_type = "AWS_PROXY"
    connection_type = "INTERNET"
    integration_method = "POST"
    integration_uri = aws_lambda_function.website-lambda-track.invoke_arn
}

resource "aws_apigatewayv2_integration" "website-apigateway-integration-delete" {
    api_id = aws_apigatewayv2_api.website-apigateway.id
    integration_type = "AWS_PROXY"
    connection_type = "INTERNET"
    integration_method = "POST"
    integration_uri = aws_lambda_function.website-lambda-donottrack.invoke_arn
}

resource "aws_apigatewayv2_route" "website-apigateway-route" {
    api_id = aws_apigatewayv2_api.website-apigateway.id
    route_key = "POST /api/track"
    target = "integrations/${aws_apigatewayv2_integration.website-apigateway-integration-post.id}"
}

resource "aws_apigatewayv2_route" "website-apigateway-route-donottrack" {
    api_id = aws_apigatewayv2_api.website-apigateway.id
    route_key = "POST /api/donottrack"
    target = "integrations/${aws_apigatewayv2_integration.website-apigateway-integration-delete.id}"
}

resource "aws_apigatewayv2_route" "website-apigateway-route-trackedactions" {
    api_id = aws_apigatewayv2_api.website-apigateway.id
    route_key = "POST /api/trackedactions"
    target = "integrations/${aws_apigatewayv2_integration.website-apigateway-integration-get.id}"
}