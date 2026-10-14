package ec2_ebs_encrypt

import rego.v1

deny contains msg if {
	resource := input.resource_changes[_]
	resource.type == "aws_instance"
	resource.change.after != null

	not ebs_encrypted(resource.change.after)
	msg := sprintf("%s: EBS must be encrypted", [resource.address])
}

ebs_encrypted(instance) if {
	some volume in instance.root_block_device
	volume.encrypted == true
}
