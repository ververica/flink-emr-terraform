# EMR Cluster Main and Core node  security groups.

resource "aws_security_group" "main_security_group" {
  name        = "${var.project}-emr-main-security-group-${var.environment}"
  description = "Allow inbound traffic for EMR main node."
  vpc_id      = var.vpc_id
  tags        = var.tags

  # Avoid circular dependencies which may stop the destroy of the
  # cluster.
  revoke_rules_on_delete = true

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "core_security_group" {
  name        = "${var.project}-emr-core-security-group-${var.environment}"
  description = "Allow inbound outbound traffic for EMR core nodes."
  vpc_id      = var.vpc_id
  tags        = var.tags

  revoke_rules_on_delete = true

  # Allow communication between nodes, adds itself as a source.
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
