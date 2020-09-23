variable domain_name {
  type        = string
  description = "Nom du domaine Ex: infopix.fr"
}

variable tags {
  type        = map(string)
  description = "Tags AWS"
}

variable enable_index_file_in_bucket {
  type        = bool
  description = "Mettre à 'true' pour avoir un fichier index.html de Work In Progress"
  default     = false
}