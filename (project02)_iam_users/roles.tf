locals {
  role_policies = {
    readonly = [
      "ReadOnlyAccess"
    ]
    admin = [
      "AdministratorAccess"
    ]
    auditor = [
      "SecurityAudit"
    ]
    developer = [
      "AmazonVPCFullAccess",
      "AmazonEC2FullAccess",
      "AmazonRDSFullAccess",
    ]
  }

  roles_policies_list = flatten([
    for role, policies in local.role_policies : [
      for policy in policies : {
        role   = role
        policy = policy
      }
    ]
  ])
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role" {
  for_each = toset(keys(local.role_policies))

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        for username in keys(aws_iam_user.main) : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${username}"
        if contains(local.users_map[username], each.value)
      ]
    }
  }
}

resource "aws_iam_role" "main" {
  for_each = toset(keys(local.role_policies))

  name               = each.key
  assume_role_policy = data.aws_iam_policy_document.assume_role[each.value].json
}

data "aws_iam_policy" "policies" {
  for_each = toset(local.roles_policies_list[*].policy)
  arn      = "arn:aws:iam::aws:policy/${each.value}"
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  count = length(local.roles_policies_list)

  role       = aws_iam_role.main[local.roles_policies_list[count.index].role].name
  policy_arn = data.aws_iam_policy.policies[local.roles_policies_list[count.index].policy].arn
}
