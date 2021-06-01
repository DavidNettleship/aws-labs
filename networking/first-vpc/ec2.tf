resource "aws_instance" "example" {
  ami           = "ami-0d53808c8c345ed07"
  instance_type = "t2.micro"

  # VPC subnet
  subnet_id = aws_subnet.public.id

  # Security Group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # Public SSH key
  key_name = aws_key_pair.mykeypair.key_name
}

resource "aws_ebs_volume" "ebs-volume" {
  availability_zone = "ap-northeast-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume.id
  instance_id = aws_instance.example.id
}
