
# Azure Private Endpoint is a network interface that connects you privately and securely to a service powered by Azure Private Link. 
# Private Endpoint uses a private IP address from your VNet, effectively bringing the service into your VNet. 
# The service could be an Azure service such as Azure Storage, SQL, etc. or your own Private Link Service.
# Note: Private Endpoint Cannot Be Created InSubnet That Has Network Policies Enabled 
resource "azurerm_private_endpoint" "mysql_endpoint" {
  name                = "mysql-endpoint-${var.names.product_name}-${var.names.environment}-mysql${var.db_id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "prv-serv-conn-${var.names.product_name}-${var.names.environment}-mysql${var.db_id}"
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone_group
    private_dns_zone_ids = [azurerm_private_dns_zone.dns_zone.id]
  }

   tags = var.tags
}
