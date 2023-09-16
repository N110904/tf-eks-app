resource "kubernetes_config_map" "api_configmap" {
  metadata {
    name = "api-configmap"
  }

  data = {
    mysql-url = "jdbc:mysql://rdsmysqldb7879.cd2iutauviwh.us-east-1.rds.amazonaws.com:3306/my_schema"
    mysql-database = "my_schema"
    mysql-user = "admin"
    mysql-password = "1qazWSX12345"
  }
}