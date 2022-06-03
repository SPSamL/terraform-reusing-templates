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

variable "name-unit" {
  type    = string
  default = "SL"
}

variable "name-app" {
  type = string
}

variable "name-env" {
  type = string
}
