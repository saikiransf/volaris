terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "6.6.0"
    }
  }
}

# Common Okta user schema properties
resource "okta_user_schema_property" "custom_boolean" {
  for_each = {
    for k, value in var.user_schema_property_data : k => value
    if value.type == "boolean"
  }

  index       = each.key
  title       = each.value.title
  description = each.value.description

  type = each.value.type

  #   master      = each.value.master
  #   scope       = each.value.scope
  #   permissions = each.value.permissions
  #   required    = each.value.required
}

resource "okta_user_schema_property" "custom_string" {
  for_each = {
    for k, value in var.user_schema_property_data : k => value
    if value.type == "string" && (
        lookup(value, "enum_type", null) == null || lookup(value, "enum_type", null) == false
    )
  }

  index       = each.key
  title       = each.value.title
  description = each.value.description

  type = each.value.type

  min_length = lookup(each.value, "min_length", null)
  max_length = lookup(each.value, "max_length", null)

  #   master      = each.value.master
  #   scope       = each.value.scope
  #   permissions = each.value.permissions
  #   required    = each.value.required
}

resource "okta_user_schema_property" "custom_string_array" {
  for_each = {
    for k, value in var.user_schema_property_data : k => value
    if value.type == "array" &&
    lookup(value, "array_type", "unknown") == "string" &&
    (
        lookup(value, "enum_type", null) == null || lookup(value, "enum_type", null) == false
    )
  }

  index       = each.key
  title       = each.value.title
  description = each.value.description

  type       = each.value.type
  array_type = lookup(each.value, "array_type", null)

  min_length = lookup(each.value, "min_length", null)
  max_length = lookup(each.value, "max_length", null)

  #   master      = each.value.master
  #   scope       = each.value.scope
  #   permissions = each.value.permissions
  #   required    = each.value.required
}

resource "okta_user_schema_property" "custom_enum" {
  for_each = {
    for k, value in var.user_schema_property_data : k => value
    if value.type == "string" && lookup(value, "enum_type", null) == true
  }

  index       = each.key
  title       = each.value.title
  description = each.value.description

  type = each.value.type

  dynamic "one_of" {
    for_each = lookup(each.value, "enums", toset([]))

    content {
      const = one_of.value.const
      title = one_of.value.title
    }
  }

  #   master      = each.value.master
  #   scope       = each.value.scope
  #   permissions = each.value.permissions
  #   required    = each.value.required
}

resource "okta_user_schema_property" "custom_enum_array" {
  for_each = {
    for k, value in var.user_schema_property_data : k => value
    if value.type == "array" &&
    lookup(value, "array_type", "unknown") == "string" &&
    lookup(value, "enum_type", null) == true
  }

  index       = each.key
  title       = each.value.title
  description = each.value.description

  type       = each.value.type
  array_type = lookup(each.value, "array_type", null)

  dynamic "array_one_of" {
    for_each = lookup(each.value, "enums", toset([]))

    content {
      const = array_one_of.value.const
      title = array_one_of.value.title
    }
  }

  #   master      = each.value.master
  #   scope       = each.value.scope
  #   permissions = each.value.permissions
  #   required    = each.value.required
}
