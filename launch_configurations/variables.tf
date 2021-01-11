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
#
variable "region" {}

variable "key_name" {}

variable "instance_type" {}

variable "amis" {}

#
# From other modules
#
variable "webapp_http_inbound_sg_id" {}
variable "webapp_ssh_inbound_sg_id" {}
variable "webapp_outbound_sg_id" {}
