module "attach_node_to_tg" {
  source = "git::https://github.com/greg-solutions/terraform_aws_k8s_tg_attach.git?ref=v1.0.0"
  region = "us-east-1"
  target_group_arns = [aws_lb_target_group.http.arn, aws_lb_target_group.https.arn]
}