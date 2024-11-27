module "aws-dev" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "sa-east-1"
  chave = "iac-dev"
  aim_instance = "ami-06dec7e27b4abea7b"
  name_db = "SRV_DEV_01"
}