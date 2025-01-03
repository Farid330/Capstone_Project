# Create CloudWatch alarm for decreasing capacity
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "stress_on_ec2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80 # Adjust this threshold as needed for decreasing capacity
    dimensions = {
    InstanceId = aws_instance.wordpress_instance.id
  }
}