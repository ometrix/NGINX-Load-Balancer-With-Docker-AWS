# Clave publica de SSH

resource "aws_key_pair" "terra" {
  key_name   = "terra"
  public_key = file("./terra.pub")
}