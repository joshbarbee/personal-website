
data "archive_file" "backend-track" {
    type        = "zip"
    source_file  = "../backend/handle_track.py"
    output_path = "../dist/backend-track.zip"
}

data "archive_file" "backend-donottrack" {
    type        = "zip"
    source_file  = "../backend/handle_donottrack.py"
    output_path = "../dist/backend-donottrack.zip"
}

data "archive_file" "backend-trackedactions" {
    type        = "zip"
    source_file  = "../backend/handle_trackedactions.py"
    output_path = "../dist/backend-trackedactions.zip"
}

resource "aws_lambda_function" "website-lambda-track" {
    filename         = data.archive_file.backend-track.output_path
    function_name    = "website-lambda-track"
    role             = aws_iam_role.website-lambda-role-put.arn
    handler          = "handle_track.lambda_handler"
    runtime          = "python3.12"
    timeout          = 10
    memory_size      = 128
    source_code_hash = filebase64sha256(data.archive_file.backend-track.output_path)

    environment {
        variables = {
            TABLE_NAME = aws_dynamodb_table.website-tracking-table.name
        }
    }
}

resource "aws_lambda_function" "website-lambda-donottrack" {
    filename         = data.archive_file.backend-donottrack.output_path
    function_name    = "website-lambda-donottrack"
    role             = aws_iam_role.website-lambda-role-put.arn
    handler          = "handle_donottrack.lambda_handler"
    runtime          = "python3.12"
    timeout          = 10
    memory_size      = 128
    source_code_hash = filebase64sha256(data.archive_file.backend-donottrack.output_path)

    environment {
        variables = {
            TABLE_NAME = aws_dynamodb_table.website-tracking-table.name
        }
    }
}

resource "aws_lambda_function" "website-lambda-trackedactions" {
    filename         = data.archive_file.backend-trackedactions.output_path
    function_name    = "website-lambda-trackedactions"
    role             = aws_iam_role.website-lambda-role-get.arn
    handler          = "handle_trackedactions.lambda_handler"
    runtime          = "python3.12"
    timeout          = 10
    memory_size      = 128
    source_code_hash = filebase64sha256(data.archive_file.backend-trackedactions.output_path)

    environment {
        variables = {
            TABLE_NAME = aws_dynamodb_table.website-tracking-table.name
            INDEX_NAME = "FingerprintIndex"
        }
    }
}

resource "aws_lambda_permission" "website-lambda-track-permission" {
    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.website-lambda-track.function_name
    principal     = "apigateway.amazonaws.com"
    source_arn = "${aws_apigatewayv2_api.website-apigateway.execution_arn}/*/*"
}

resource "aws_lambda_permission" "website-lambda-donottrack-permission" {
    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.website-lambda-donottrack.function_name
    principal     = "apigateway.amazonaws.com"
    source_arn = "${aws_apigatewayv2_api.website-apigateway.execution_arn}/*/*"
}

resource "aws_lambda_permission" "website-lambda-trackedactions-permission" {
    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.website-lambda-trackedactions.function_name
    principal     = "apigateway.amazonaws.com"
    source_arn = "${aws_apigatewayv2_api.website-apigateway.execution_arn}/*/*"
}