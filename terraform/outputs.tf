output "instance_ip" {
  value       = openstack_compute_instance_v2.instance.access_ip_v4
  description = "The IP address of the compute instance."
}