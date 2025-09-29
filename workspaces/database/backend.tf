terraform {
  backend "local" {
    path = "../../tmp/db-terraform.tfstate"
  }
}
