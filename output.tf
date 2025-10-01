output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.name.dns_name  # Fixed: Use aws_lb (matches alb.tf resource).
}