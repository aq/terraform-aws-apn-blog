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
provider "aws" {
  region = var.region
}

module "site" {
  source              = "./site"
  ip_range            = var.ip_range
  availability_zones  = var.availability_zones
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "launch_configurations" {
  source                    = "./launch_configurations"
  region                    = var.region
  instance_type             = var.instance_type
  amis                      = var.amis
  webapp_http_inbound_sg_id = module.site.webapp_http_inbound_sg_id
  webapp_ssh_inbound_sg_id  = module.site.webapp_ssh_inbound_sg_id
  webapp_outbound_sg_id     = module.site.webapp_outbound_sg_id
  key_name                  = aws_key_pair.this.key_name
}

module "load_balancers" {
  source                    = "./load_balancers"
  availability_zones        = var.availability_zones
  public_subnet_id          = module.site.public_subnet_id
  webapp_http_inbound_sg_id = module.site.webapp_http_inbound_sg_id
}

module "autoscaling_groups" {
  source             = "./autoscaling_groups"
  availability_zones = var.availability_zones
  asg_min            = var.asg_min
  asg_max            = var.asg_max
  public_subnet_id   = module.site.public_subnet_id
  webapp_lc_id       = module.launch_configurations.webapp_lc_id
  webapp_lc_name     = module.launch_configurations.webapp_lc_name
  webapp_elb_name    = module.load_balancers.webapp_elb_name
}

module "instances" {
  source                    = "./instances"
  region                    = var.region
  key_name                  = aws_key_pair.this.key_name
  amis                      = var.amis
  instance_type             = var.instance_type
  public_subnet_id          = module.site.public_subnet_id
  bastion_ssh_sg_id         = module.site.bastion_ssh_sg_id
  private_subnet_id         = module.site.private_subnet_id
  ssh_from_bastion_sg_id    = module.site.ssh_from_bastion_sg_id
  web_access_from_nat_sg_id = module.site.web_access_from_nat_sg_id
}
