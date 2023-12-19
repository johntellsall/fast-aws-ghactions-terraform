resource "aws_ssm_parameter" "hello" {
  name  = "/hello"
  value = "world-404"
  type  = "String"
}
