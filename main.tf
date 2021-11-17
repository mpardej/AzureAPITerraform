provider "azurerm" {
    version = "2.5.0"
    features {}
}

terraform {
  backend "azurerm" {
      resource_group_name   = "tf_rg_blobstorage"
      storage_account_name  = "tfstorageaccountwm"
      container_name        = "tfstate"
      key                   = "terraform.tfstate"
  }
}
variable "imagebuild" {
    type        = string
    desciption  = "Latest build"
}

resource "azurerm_resource_group" "terraform_test" {
    name = "tf_rg"
    location =  "germanywestcentral"
}
# create container groupgit 
resource "azurerm_container_group" "tf_ct_grp" {
    name            = "wheather_grp"
    location        = azurerm_resource_group.terraform_test.location
    resource_group_name = azurerm_resource_group.terraform_test.name

    ip_address_type     = "public"
    dns_name_label      = "wheatherapitf1"
    os_type             = "Linux"  

    container {
        name    = "wheather"
        image   = "mpardej/wheather:${var.imagebuild}"
        cpu     = "1"
        memory  = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        } 
    }
}