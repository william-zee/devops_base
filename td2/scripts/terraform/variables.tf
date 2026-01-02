variable "ami_id" {
  description = "L'ID de l'image Packer"
  type        = string
}

variable "instance_type" {
  description = "La taille de la machine (ex: t3.micro, t3.small)"
  type        = string
  default     = "t3.micro"
}

variable "server_port" {
  description = "Le port sur lequel l'application écoute"
  type        = number
  default     = 8080
}

variable "instance_count" {
  description = "Nombre de serveurs à créer"
  type        = number
  default     = 2 # On en met 2 comme demandé dans l'Ex 10
}
