#!/bin/bash
# Update packages
sudo yum update -y

# Install Apache (httpd)
sudo yum install -y httpd

# Start and enable httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Create custom index.html to show load balancing
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head><title>Utrains Load Balancer Demo</title></head>
<body>
<h1>Welcome to Utrains!</h1>
<p>You are redirected to <strong>${HOSTNAME}</strong> to see how the load balancer is sharing the traffic.</p>
</body>
</html>
EOF

# Set proper permissions
sudo chown -R apache:apache /var/www/html
sudo chmod 644 /var/www/html/index.html