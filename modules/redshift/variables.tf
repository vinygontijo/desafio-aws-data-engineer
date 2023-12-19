variable "subnet_group_name" {
  description = "Name for the Redshift subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Redshift subnet group"
  type        = list(string)
}

variable "cluster_identifier" {
  description = "Identifier for the Redshift cluster"
  type        = string
}

variable "database_name" {
  description = "Name of the database to create when the cluster is created"
  type        = string
}

variable "master_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "master_password" {
  description = "Password for the master DB user"
  type        = string
}

variable "node_type" {
  description = "Node type to be used for the cluster"
  type        = string
}

variable "cluster_type" {
  description = "The cluster type to use"
  type        = string
}

variable "number_of_nodes" {
  description = "Number of nodes in the cluster"
  type        = number
}

variable "skip_final_snapshot" {
  description = "Determines whether a final snapshot of the cluster is created before it is deleted"
  type        = bool
}

variable "publicly_accessible" {
  description = "If 'false', the cluster will not be publicly accessible"
  type        = bool
}

variable "security_group_id" {
  description = "ID of the security group for the Redshift cluster"
  type        = string
}

