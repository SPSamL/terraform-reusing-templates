variable "list" {
  type = list(object({
    fn = string
    ln = string
  }))
  default = [
    {
      fn = "sam"
      ln = "larko"
    },
    {
      fn = "bill"
      ln = "ding"
    }
  ]
}

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
