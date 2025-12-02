
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&()*+,-.:;<=>?[]^_{|}"
}

locals {
  db_password = random_password.db_password.result
  db_username = base64decode(var.db_username_base64)
  db_name     = base64decode(var.db_name_base64)

}

resource "aws_secretsmanager_secret" "rds_creds" {
  name = "rds-credentials"
  tags = {
    Name = "${var.env}-rds-password"
  }
}


resource "aws_db_subnet_group" "db_subnets" {
  name       = "${var.env}-db-private-subnet-group"
  subnet_ids = var.subnet_ids_private

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_security_group" "rds_sg" {
  name        = "${var.env}-rds-sg"
  description = "Security group for the RDS instance"
  vpc_id      = var.vpc-id

  ingress {
    description = "Allow MariaDB/MySQL from VPC subnets where EKS nodes are"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.private-subnet-cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-rds-sg"
  }
}


resource "aws_db_instance" "mariadb" {
  engine               = "mariadb"
  engine_version       = "10.6"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  region               = var.region
  availability_zone    = var.availability-zone
  db_subnet_group_name = aws_db_subnet_group.db_subnets.name
  # storage_encrypted       = true
  # backup_retention_period = 7

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  username = local.db_username
  password = local.db_password
  db_name  = local.db_name

  performance_insights_enabled = false
  publicly_accessible          = false
  skip_final_snapshot          = true


  depends_on = [
    aws_secretsmanager_secret.rds_creds
  ]

  tags = {
    Name = "MariaDB"
  }
}


resource "aws_secretsmanager_secret_version" "rds_creds_version" {
  secret_id = aws_secretsmanager_secret.rds_creds.id
  secret_string = jsonencode({
    DBUSER     = local.db_username
    DBPASSWORD = local.db_password
    DBHOST     = aws_db_instance.mariadb.address
    DBPORT     = tostring(aws_db_instance.mariadb.port)
    DBNAME     = local.db_name
  })

  depends_on = [
    aws_db_instance.mariadb
  ]
}


resource "aws_iam_policy" "secrets_manager_read" {
  name        = "secrets-manager-read"
  description = "Allow reading secrets from Secrets Manager"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = [
          aws_secretsmanager_secret.rds_creds.arn
        ]
      }
    ]
  })

  tags = {
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}