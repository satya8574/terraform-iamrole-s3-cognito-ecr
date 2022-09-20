variable "role_name" {
  default = "veloce_role"
}
variable "role_env" {
  default = "dev"
}
variable "role_build_by" {
  default = "terraform"
}
variable "ec2_ami" {
  default = "ami-068257025f72f470d"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "key_name" {
  default = "cogkey-1"
}
variable "instance_role_profile_name" {
  default = "veloce_profile"
}
variable "ploicy_name" {
  default = "veloce_policy_s3"
}
variable "access_key" {
  default = "AKIAVHJGYUGWTPGYFYTTFYTGJKJKHUDTRDIXG34FFH5EZWK"
}
variable "secret_key" {
  default = "7QYs28B6ieQmbfhgvghvghvghvghvghQS1lVugJ3fMTDioVW0kmwb2Bwq"
}
variable "region" {
  default = "ap-south-1"
}
variable "subnet_name" {
  default = "abc"
}
