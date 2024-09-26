output "module_public_subnets" {
  description = "The public subnets"
  value       = module.networking.public_subnets
}

output "module_private_subnets" {
  description = "The private subnets"
  value       = module.networking.private_subnets
}
