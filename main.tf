resource "aws_cognito_user_pool" "this" {
  name                      = var.user_pool_name
  auto_verified_attributes  = var.auto_verified_attributes
  mfa_configuration         = var.mfa_configuration

  alias_attributes = ["email", "preferred_username"]

  password_policy {
    minimum_length                   = var.password_minimum_length
    require_lowercase                = var.require_lowercase
    require_numbers                  = var.require_numbers
    require_symbols                  = var.require_symbols
    require_uppercase                = var.require_uppercase
    temporary_password_validity_days = var.temporary_password_validity_days
  }

  admin_create_user_config {
    allow_admin_create_user_only = true
    invite_message_template {
      email_message = var.email_message_template
      email_subject = var.email_subject_template
      sms_message   = var.sms_message_template
    }
  }

  #tags = var.tags
}



resource "aws_cognito_user_pool_client" "this" {
  user_pool_id                = aws_cognito_user_pool.this.id
  name                        = var.user_pool_client_name
  generate_secret             = var.generate_secret
  allowed_oauth_flows         = var.allowed_oauth_flows
  allowed_oauth_scopes        = var.allowed_oauth_scopes
  callback_urls               = var.callback_urls
  logout_urls                 = var.logout_urls
  supported_identity_providers = var.supported_identity_providers
  explicit_auth_flows = var.explicit_auth_flows
}


resource "random_password" "temporary_password" {
  for_each = var.enable_user_creation ? { for user in var.users : user.username => user } : {}
  length   = 12
  special  = true
  upper    = true
  lower    = true
  number  = true
}


resource "aws_cognito_user" "this" {
  for_each          = var.enable_user_creation ? { for user in var.users : user.username => user } : {}
  user_pool_id      = aws_cognito_user_pool.this.id
  username          = each.key
  temporary_password = random_password.temporary_password[each.key].result

  attributes = {
    email          = each.value.email
    email_verified = "true"
  }
}



resource "aws_cognito_user_pool_domain" "this" {
  domain       = var.user_pool_domain_name
  user_pool_id = aws_cognito_user_pool.this.id
 
}
