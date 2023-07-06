variable "puerto_servidor" {
  description = "Puerto para las instancias EC2"
  type        = number
  default     = 8080

  validation {
    condition     = var.puerto_servidor > 0 && var.puerto_servidor <= 65536
    error_message = "El valor del puerto debe estar comprendido entre 1 y 65536."
  }
}

variable "ubuntu_ami" {
  description = "AMI por region"
  type        = map(string)

  default = {
    eu-west-3 = "ami-05b5a865c3579bbc4" # Ubuntu en Paris
    eu-west-1 = "ami-0aef57767f5404a3c" # Ubuntu en Dublin
  }
}

variable "servidores" {
  description = "Mapa de servidores con su correspondiente AZ"

  type = map(object({
    nombre = string,
    az     = string
    })
  )

  default = {
    "ser-1" = { nombre = "servidor-1", az = "a" },
    "ser-2" = { nombre = "servidor-2", az = "b" },
  }
}
