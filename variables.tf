variable "ami_id" {
  description = "ID of the desired AMI"
  type        = string
  default     = "ami-0c94855ba95c71c99"  # Default AMI ID, replace with your desired value
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"  # Default instance type, replace with your desired value
}
