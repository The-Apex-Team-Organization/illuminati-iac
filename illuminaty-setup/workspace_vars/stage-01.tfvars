env               = "stage-01"
vpc-id            = "vpc-0ff1c205c39ef6fc5" #pass existing value
region            = "us-east-1"
availability-zone = "us-east-1a"

eks_cluster_name          = "illuminati-eks"
frontend_image_repository = "606207925787.dkr.ecr.us-east-1.amazonaws.com/illuminati-react-frontend"
frontend_image_tag        = "v-1"
frontend_replicas         = 1
app_namespace             = "app-namespace"
illuminati-eks-nodes-id   = "illuminati-eks:illuminati-node-group-stage-01"

domain-name = "buymeadoor.pp.ua"