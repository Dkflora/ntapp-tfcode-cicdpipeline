// Target group
resource "aws_lb_target_group" "group1" {
  name     = "ntc-tg"  # Added quotes for string.
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.my-vpc.id  # Assumes aws_vpc.my-vpc is defined elsewhere.

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = ["200"]  # Fixed: List of strings required for HTTP.
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 6
    unhealthy_threshold = 3
  }
  depends_on = [aws_vpc.my-vpc]  # Assumes resource name is "my-vpc".
}

# Attach EC2 to target group
resource "aws_lb_target_group_attachment" "name" {
  target_group_arn = aws_lb_target_group.group1.arn
  target_id        = aws_instance.server1.id  # References ec2.tf; assumes defined.
  port             = 80
}

resource "aws_lb_target_group_attachment" "name1" {
  target_group_arn = aws_lb_target_group.group1.arn
  target_id        = aws_instance.server2.id  # References ec2.tf; assumes defined.
  port             = 80
}

# ALB
resource "aws_lb" "name" {
  name                = "ntc-alb"
  load_balancer_type  = "application"
  security_groups     = [aws_security_group.alb_sg.id]  # Assumes defined elsewhere.
  subnets             = [aws_subnet.public1.id, aws_subnet.public2.id]  # Assumes defined.
  enable_deletion_protection = false
}

# Create listener
resource "aws_lb_listener" "name" {
  load_balancer_arn = aws_lb.name.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.group1.arn
  }
}

