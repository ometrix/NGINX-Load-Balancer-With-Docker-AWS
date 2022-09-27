
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# AMI Ubuntu Linux

resource "aws_ami" "ubuntu" {
  name = "ubuntu"


}

variable "ami" {
  default = [

  ]
}

# AMI Rocky Linux

data "aws_ami" "rocky" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Rocky-8-ec2-8.6-20220515.0.x86_64-d6577ceb-8ea8-4e0e-84c6-f098fc302e82"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # Rocky
}