terraform {
  backend "local" {
    path = "../../tmp/k8s-terraform.tfstate"
  }
}
