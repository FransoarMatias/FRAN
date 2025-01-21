module "aws-oracle" {
  source = "../infra"
  instancia = "t2.micro" # Nivel Gratuito
  regiao_aws = "us-west-2" # Oregon
  chave = "oracledb"
  aim_instance = "ami-00c257e12d6828491" # Ubuntu
  name_db = "SRV_ORACLE"
}

output "IP_ORACLE" {
  value = module.aws-oracle.IP_Publico
}