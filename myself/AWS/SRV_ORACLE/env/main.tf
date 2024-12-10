module "aws-dev" {
  source = "../infra"
  instancia = "t2.micro" # Nivel Gratuito
  regiao_aws = "sa-east-1" # Sao Paulo
  chave = "oracledb"
  aim_instance = "ami-06dec7e27b4abea7b" # Red Hat
  name_db = "SRV_ORACLE"
}

output "IP_ORACLE" {
  value = module.aws-dev.IP_Publico
}