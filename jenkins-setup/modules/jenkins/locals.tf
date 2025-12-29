locals {
  ssm_bucket_name = "birdwatching-ssm-${var.env}"

  common_tags = merge(
    var.common_tags,
    {
      Environment = var.env
      Project     = "birdwatching"
      ManagedBy   = "terraform"
    }
  )
}