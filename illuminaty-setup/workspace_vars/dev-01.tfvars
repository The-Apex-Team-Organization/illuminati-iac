env               = "dev-01"
vpc-id            = "vpc-03e298570c02a172d" #pass existing value
region            = "us-east-1"
availability-zone = "us-east-1a"

eks_cluster_name          = "illuminati-eks"
frontend_image_repository = "221416552528.dkr.ecr.us-east-1.amazonaws.com/illuminati-react-frontend"
frontend_image_tag        = "v-11"
frontend_replicas         = 1
app_namespace             = "app-namespace"
illuminati-eks-nodes-id   = "illuminati-eks:illuminati-node-group-dev-01"

domain-name = "buymeadoor.pp.ua"