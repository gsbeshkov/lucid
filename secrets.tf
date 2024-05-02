data "external" "aws_secrets" {
  program = ["bash", "-c", "aws secretsmanager get-secret-value --secret-id your-secret-name --query 'SecretString' --output text | jq -r ."]
}

provider "aws" {
  access_key = "${lookup(data.external.aws_secrets.result, "AWS_ACCESS_KEY_ID")}"
  secret_key = "${lookup(data.external.aws_secrets.result, "AWS_SECRET_ACCESS_KEY")}"
  region     = "us-east-1"
}
