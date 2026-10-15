package evaluation

import rego.v1

deny contains msg if{
    msg := data.ec2_no_open_ports.deny[_]
}

deny contains msg if{
    msg := data.ec2_imdsv2.deny[_]
}

deny contains msg if{
    msg := data.ec2_ebs_encrypt.deny[_]
}