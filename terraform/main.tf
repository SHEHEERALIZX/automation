terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.23.0"
    }
  }
}

provider "digitalocean" {
    token = "dop_v1_9092f6d950a3da646899659507023ae7bc8d6d1c2d1adf2eef59cdee66054d07"
}


data "digitalocean_ssh_key" "ansible" {
  name = "ansible"
}


data "digitalocean_ssh_key" "pop-os" {
  name = "pop-os"
}


# resource "digitalocean_kubernetes_cluster" "foo" {
#   name   = "foo"
#   region = "nyc1"
#   # Grab the latest version slug from `doctl kubernetes options versions`
#   version = "1.24.4-do.0"

#   node_pool {
#     name       = "worker-pool"
#     size       = "s-2vcpu-2gb"
#     node_count = 3

#     taint {
#       key    = "workloadKind"
#       value  = "database"
#       effect = "NoSchedule"
#     }
#   }
# }




# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "webserver" {
  count = 1
  image  = "ubuntu-18-04-x64"
  name   = "web-1${count.index}nyc1"
  region = "nyc1"
  size   = "s-2vcpu-4gb"
  ssh_keys = [data.digitalocean_ssh_key.ansible.id,data.digitalocean_ssh_key.pop-os.id]
}






output "ip_address" {
  value = digitalocean_droplet.webserver[*].ipv4_address
  description = "The public IP address of your Droplet application."

}

 # size   = "s-1vcpu-512mb-10gb"




# data "digitalocean_kubernetes_cluster" "example" {
#   name = "prod-cluster-01"
# }

# provider "kubernetes" {
#   host             = data.digitalocean_kubernetes_cluster.example.endpoint
#   token            = data.digitalocean_kubernetes_cluster.example.kube_config[0].token
#   cluster_ca_certificate = base64decode(
#     data.digitalocean_kubernetes_cluster.example.kube_config[0].cluster_ca_certificate
#   )
# }

