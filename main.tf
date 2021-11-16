provider "azurerm" {
    version = "2.5.0"
    features {}
}

resource "azurerm_resource_group" "terraform_test" {
    name = "tf_rg"
    location =  "germanywestcentral"
}
# create container group
resource "azurerm_container_group" "tf_ct_grp" {
    name            = "wheather_grp"
    location        = azurerm_resource_group.terraform_test.location
    resource_group_name = azurerm_resource_group.terraform_test.name

    ip_address_type     = "public"
    dns_name_label      = "wheatherapitf"
    os_type             = "Linux"  

    container {
        name    = "wheather"
        image   = "mpardej/wheather"
        cpu     = "1"
        memory  = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        } 
    }
}