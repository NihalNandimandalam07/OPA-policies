package ec2_imdsv2

import rego.v1

deny contains msg if {
	resource := input.resource_changes[_]
	resource.type == "aws_instance"
	resource.change.after != null

	not imdsv2_enabled(resource.change.after)
	msg := sprintf("%s: IMDSv2 must be enabled and required", [resource.address])
}

imdsv2_enabled(instance) if {
	some metadata in instance.metadata_options
	metadata.http_endpoint = "enabled"
	metadata.http_tokens = "required"
}
