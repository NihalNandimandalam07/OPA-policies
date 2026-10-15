package ec2_no_open_ports

import rego.v1

deny contains msg if {
	resource := input.resource_changes[_]
	resource.type == "aws_security_group"
	resource.change.after != null

	ports_public_access(resource.change.after)
	msg := sprintf("%s: Security Groups should not allow public access", [resource.address])
}

ports_public_access(sg) if {
	some rule in sg.ingress
	"0.0.0.0/0" in rule.cidr_blocks
}

ports_public_access(sg) if {
	some rule in sg.ingress
	"::/0" in rule.ipv6_cidr_blocks
}
