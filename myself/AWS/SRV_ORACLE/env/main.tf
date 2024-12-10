module "aws-dev" {
  source = "../infra"
  instancia = "t2.micro"
  regiao_aws = "sa-east-1"
  chave = "iac-dev"
  aim_instance = "ami-0f16d0d3ac759edfa"
  name_db = "SRV_ORACLE"
}

output "IP_ORACLE" {
  value = module.aws-dev.IP_Publico
}