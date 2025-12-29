module "aws_lambda_function" {
  source             = "./modules/aws_lambda_function"
  env                = var.env
  region             = var.region
  bird_user          = var.bird_user
  bird_pass          = var.bird_pass
  bird_app_url       = var.bird_app_url
  illuminati_api_url = var.illuminati_api_url
}