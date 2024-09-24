locals {
  # Load the YAML file with the users and their roles
  users_from_yaml = yamldecode(file("${path.module}/user-roles.yaml")).users

  # Convert the list of users from the YAML file to a map
  users_map = {
    for user_config in local.users_from_yaml : user_config.username => user_config.roles
  }
}

resource "aws_iam_user" "main" {
  for_each = toset(local.users_from_yaml[*].username)

  name = each.value
}

resource "aws_iam_user_login_profile" "main" {
  for_each = aws_iam_user.main

  user            = each.key
  password_length = 8

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

output "users" {
  value = local.users_from_yaml
}

output "password" {
  value = {
    for user in local.users_from_yaml : user.username => aws_iam_user_login_profile.main[user.username].password
  }
}
