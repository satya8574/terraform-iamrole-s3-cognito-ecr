output "iam_instance_profile" {
  value = aws_iam_instance_profile.test_profile.id
}
output "aws_iam_role" {
  value = aws_iam_role.veloce_role.id
}
output "aws_iam_role_policy" {
  value = aws_iam_role_policy.test_policy.id
}