resource "aws_instance" "vm"{
    ami = var.vm_ami
    instance_type = var.vm_instance_type
    subnet_id = var.vm_subnet_id
    private_ip = var.vm_private_ip
    tags = {
        Name = var.vm_instance_name
    }
}

resource "aws_eip" "public_ip"{
    domain = "vpc"
    instance = aws_instance.vm.id
    associate_with_private_ip = aws_instance.vm.private_ip
    depends_on = [var.eip_gw]
}

resource "aws_network_interface_sg_attachment" "this" {
  security_group_id    = var.sg_id
  network_interface_id = aws_instance.vm.primary_network_interface_id
}

output "private_ip" {
    value = aws_instance.vm.private_ip
}
