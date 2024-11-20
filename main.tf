resource "aws_instance" "myinstnace" {

    ami = "ami-0da424eb883458071" 
    instance_type = "t2.micro"
    key_name = aws_key_pair.key.key_name
    security_groups = [aws_security_group.mySG.name]
    tags = {

        Name = "demo"
    }

    connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with the appropriate username for your EC2 instance
    private_key = file("/Users/bhaktathapa/Desktop/Provisionerterraform/mykey")  # Replace with the path to your private key
    host        = self.public_ip
  }

  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y",  # Update package lists (for ubuntu)
      "sudo apt-get install -y python3-pip",  # Example package installation
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
  }


}

resource "aws_key_pair" "key" {

    key_name = "mykey"
    public_key = file ("/Users/bhaktathapa/Desktop/Provisionerterraform/mykey.pub")
  
}

resource "aws_default_vpc" "name" {
  
}

resource "aws_security_group" "mySG" {

    name = "my_security_group"
    vpc_id = aws_default_vpc.name.id


 ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}
