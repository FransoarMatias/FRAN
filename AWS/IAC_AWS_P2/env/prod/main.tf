module "aws-prod" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "sa-east-1"
  chave = "iac-prod"
  aim_instance = "ami-0f16d0d3ac759edfa"
  name_db = "SRV_PROD_01"
}

output "IP_EC2_PROD" {
  value = module.aws-prod.IP_Publico
}