provider "random" {}

resource "random_password" "aws-secret-pass" {
  length  = 22
  special = true
  override_special = "!@#$%^&*"
}

resource "aws_secretsmanager_secret" "secret-terra" {
  name        = "adminuser"
  description = "This password is used to connect to the RDS DB"
}

resource "aws_secretsmanager_secret_version" "ss-terra" {
  secret_id     = aws_secretsmanager_secret.secret-terra.id
  secret_string = random_password.aws-secret-pass.result
  lifecycle {
    ignore_changes = [ secret_string ]
  }
}