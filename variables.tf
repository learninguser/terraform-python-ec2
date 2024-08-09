variable "ami_id" {
  type    = string
  default = "ami-0f3c7d07486cad139"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "cidr_blocks" {
  type = list
  default = ["0.0.0.0/0"]
}