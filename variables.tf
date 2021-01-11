# Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file
# except in compliance with the License. A copy of the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed on an "AS IS"
# BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under the License.
variable "region" {
  default = "eu-west-3" # Paris
}

variable "ip_range" { # Set you IP.
}

variable "availability_zones" {
  default = ["eu-west-1","eu-west-2"]
}

variable "instance_type" {
  default = "t2.nano"
}

variable "asg_min" {
  default = "1"
}
variable "asg_max" {
  default = "2"
}
variable "asg_desired" {
  default = "1"
}

variable "amis" {
  default = {
    eu-west-3 = "ami-00798d7180f25aac2"
  }
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default = "192.169.0.0/21"
}

variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default = "192.168.1.0/28"
}
variable "private_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = "192.168.2.0/28"
}
