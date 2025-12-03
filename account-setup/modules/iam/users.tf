resource "aws_iam_user" "team" {
  count = length(var.username)
  name  = element(var.username, count.index)
}

resource "aws_iam_group" "Administrator" {
  name = "Administrator"
}

resource "aws_iam_group_policy_attachment" "admin-policy" {
  group      = aws_iam_group.Administrator.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "bill-policy" {
  group      = aws_iam_group.Administrator.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

resource "aws_iam_group_membership" "admin-membership" {
  name  = "admin-membership"
  users = aws_iam_user.team[*].name
  group = aws_iam_group.Administrator.name
}

resource "aws_iam_user_login_profile" "password-user" {
  count                   = length(var.username)
  user                    = aws_iam_user.team[count.index].name
  password_reset_required = true
}

resource "aws_iam_access_key" "access-key" {
  count = length(var.username)
  user  = aws_iam_user.team[count.index].name
}
