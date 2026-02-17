data "aws_acm_certificate" "issued" {
  domain   = "*.tfmaster.shop"
  statuses = ["ISSUED"]
}