variable "namespace" {
  type = string
  description = "(Optional) Namepsace name"
  default = "tg-attach"
}
variable "name" {
  type = string
  description = "App Name"
  default = "attach-to-tg"
}
variable "create_namespace" {
  type = bool
  description = "(Optional) If true module will create namespace for app"
  default = true
}
variable "region" {
  type = string
  description = "(Required) AWS Region where Target Group located"
}
variable "target_group_arns" {
  description = "(Required) Target Groups ARNs"
  type = list(string)
}