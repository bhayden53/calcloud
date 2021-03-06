locals {
       batch_subnet_ids = split(",", data.aws_ssm_parameter.batch_subnet_ids.value)
       
       batch_sgs = split(",", data.aws_ssm_parameter.batch_sgs.value)

       # SSM environment value can be overridden,  also tweaked with "-" below
       pre_environment = var.environment != null ? var.environment : data.aws_ssm_parameter.environment.value

       # Unless the pre_environment is an empty string,  prepend an implicit "-" to the final environment value
       environment = local.pre_environment == "" ? "" : join("", ["-", local.pre_environment])

       job_definitions = "${aws_batch_job_definition.calcloud_2g.name},${aws_batch_job_definition.calcloud_8g.name},${aws_batch_job_definition.calcloud_16g.name},${aws_batch_job_definition.calcloud_64g.name}"
}
