variable "location" {
  type = string
}

variable "name_unit" {
  type    = string
  default = "SL"
}

variable "name_app" {
  type = string
}

variable "name_env" {
  type = string
}

variable "vm_configs" {
  type = list(object({
    user_first_name = string
    user_last_name  = string
    user_initials   = string
    vm_size         = string
  }))
}

variable "rgp_name" {
  type = string
}
