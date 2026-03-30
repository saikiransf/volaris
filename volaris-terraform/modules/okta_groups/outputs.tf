output "group_ids" {
  description = "The list of Okta Groups created by this module."
  value       = okta_group.groups
}
