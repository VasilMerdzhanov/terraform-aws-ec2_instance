#
output "VM_public_IP" {
value = aws_instance.VM.public_ip
}
