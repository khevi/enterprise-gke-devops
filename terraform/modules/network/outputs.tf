output "vpc_id" {
  value = google_compute_network.gke_vpc.id
}

output "subnet_id" {
  value = google_compute_subnetwork.gke_subnet.id
}

output "subnet_name" {
  value = google_compute_subnetwork.gke_subnet.name
}

output "pods_range_name" {
  value = var.pods_range_name
}

output "services_range_name" {
  value = var.services_range_name
}
