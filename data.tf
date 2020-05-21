data "template_file" "script" {
  template = file("${path.module}/attach-to-tg.sh")
  vars = {
    region = var.region
    target_group_arns = join("|", var.target_group_arns)
  }
}