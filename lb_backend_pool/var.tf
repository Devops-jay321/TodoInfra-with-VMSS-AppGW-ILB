variable "backend_pool" {
  type = map(object({
    name                = string
  }))
}
variable "lb_id" {
  type = string
}
