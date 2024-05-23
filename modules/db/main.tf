resource "aws_db_instance" "db" {
  engine                  = "mysql"
  engine_version          = "8.0.35"
  multi_az                = false
  identifier              = "database-binary-tree-app"
  username                = var.username
  password                = var.password
  instance_class          = "db.t3.micro"
  allocated_storage       = 200
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = [var.sg_id]
  availability_zone       = var.available_zone
  db_name                 = "binarytreedb"
  skip_final_snapshot     = true
  publicly_accessible = true
}