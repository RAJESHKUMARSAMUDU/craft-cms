resource "aws_db_subnet_group" "rds-private-subnet" {
  name = "rds-private-subnet-group"
  subnet_ids = [aws_subnet.private-subnet-1.id,aws_subnet.private-subnet-2.id]
}

#############   Creating Security_group for Mysql RDS #########

resource "aws_security_group" "mysql-sg" {
  name   = "my-rds-sg"
  vpc_id = aws_vpc.craftcms-vpc.id

}

# Ingress Security Port 3306
resource "aws_security_group_rule" "mysql_inbound_access" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.mysql-sg.id
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

######### Mysql RDS Creation ##########

resource "aws_db_instance" "craftcms" {
  allocated_storage           = 30
  max_allocated_storage       = 100
  apply_immediately           = true
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "${var.db_instance}"
  name                        = "craft"
  username                    = "craftcms2021"
  password                    = "craftcms2021"
  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name        = "${aws_db_subnet_group.rds-private-subnet.name}"
  vpc_security_group_ids      = [aws_security_group.mysql-sg.id]
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = true
  skip_final_snapshot         = true
}
