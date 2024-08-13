resource "aws_cloudwatch_event_rule" "ec2_auto_stop_rule" {
  name                = "ec2-auto-stop-weekdays-8pm"
  description         = "Triggers EC2 auto-stop at 8 PM on weekdays"
  schedule_expression = "cron(00 20 ? * MON-FRI *)" # 8 PM UTC, Monday to Friday
}

resource "aws_cloudwatch_event_rule" "ec2_auto_start_rule" {
  name                = "ec2-auto-start-weekdays-8am"
  description         = "Triggers EC2 auto-start at 8 AM on weekdays"
  schedule_expression = "cron(00 8 ? * MON-FRI *)" # 8 AM UTC, Monday to Friday
}

resource "aws_cloudwatch_event_target" "ec2_auto_stop_target" {
  rule      = aws_cloudwatch_event_rule.ec2_auto_stop_rule.name
  target_id = "EC2AutoStopLambda"
  arn       = aws_lambda_function.ec2_auto_stop.arn
}

resource "aws_cloudwatch_event_target" "ec2_auto_start_target" {
  rule      = aws_cloudwatch_event_rule.ec2_auto_start_rule.name
  target_id = "EC2AutoStartLambda"
  arn       = aws_lambda_function.ec2_auto_start.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ec2_auto_stop" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_auto_stop.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_auto_stop_rule.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_ec2_auto_start" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_auto_start.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_auto_start_rule.arn
}
