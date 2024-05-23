resource "aws_security_group" "allow_tls_cicd" {
    name        = "allow_tls cicd"
    description = "Allow TLS inbound traffic and all outbound traffic"
    vpc_id      = var.sg_vpc_id

    ingress {
    description = "ssh ipv4"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description      = "ssh ipv6"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "http ipv4"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
    description      = "http ipv6"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
    } 

     ingress {
    description = "jenkins master-slave"
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = [var.subnet_address]
    }

    egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    ipv6_cidr_blocks = ["::/0"]
  }
  
    tags = {
      Name = "allow_tls_cicd"
  }
}

resource "aws_security_group" "allow_tls_app" {
    name        = "allow_tls app"
    description = "Allow TLS inbound traffic and all outbound traffic"
    vpc_id      = var.sg_vpc_id

    ingress {
    description = "ssh ipv4"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description      = "ssh ipv6"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "http ipv4"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
    description      = "http ipv6"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
    } 

    ingress {
    description = "jenkins master-slave"
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = [var.subnet_address]
    }

   egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    ipv6_cidr_blocks = ["::/0"]
  }
    tags = {
      Name = "allow_tls_app"
  }
}

resource "aws_security_group" "allow_tls_db" {
    name        = "allow_tls db"
    description = "Allow TLS inbound traffic and all outbound traffic"
    vpc_id      = var.sg_vpc_id

  ingress {
    description = "ssh ipv4"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.db_ingress_rule_ip}/32"]
  }

   egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    ipv6_cidr_blocks = ["::/0"]
  }
    tags = {
      Name = "allow_tls_app"
  }

}

output "sg_cicd_id"{
  value = aws_security_group.allow_tls_cicd.id
}

output "sg_app_id"{
  value = aws_security_group.allow_tls_app.id
}

output "sg_db_id"{
  value = aws_security_group.allow_tls_db.id
}