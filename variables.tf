variable "enable_user_creation" {
  description = "Enable or disable user creation in the Cognito User Pool."
  type        = bool
  default     = false
}

variable "aws_region" {
  description = "The AWS region where the Cognito User Pool is deployed"
  type        = string
  default     = "us-west-2"  # You can set a default region if you want
}

# Variable for user pool name
variable "user_pool_name" {
  description = "The name of the Cognito User Pool"
  type        = string
}

# Variable for auto verified attributes (such as email, phone number)
variable "auto_verified_attributes" {
  description = "List of attributes to auto-verify (email, phone_number)"
  type        = list(string)
}

# Variable for MFA configuration
variable "mfa_configuration" {
  description = "MFA configuration for the Cognito User Pool"
  type        = string
  default     = "OFF"
}

# Variable for password policy settings
variable "password_minimum_length" {
  description = "Minimum password length for user pool"
  type        = number
  default     = 12
}

variable "require_lowercase" {
  description = "Require lowercase letters in the password"
  type        = bool
  default     = true
}

variable "require_numbers" {
  description = "Require numbers in the password"
  type        = bool
  default     = false
}

variable "require_symbols" {
  description = "Require symbols in the password"
  type        = bool
  default     = true
}

variable "require_uppercase" {
  description = "Require uppercase letters in the password"
  type        = bool
  default     = true
}

variable "temporary_password_validity_days" {
  description = "Validity period (in days) for temporary passwords"
  type        = number
  default     = 2
}

# Variable for user pool client settings
variable "user_pool_client_name" {
  description = "The name of the Cognito User Pool Client"
  type        = string
}

variable "generate_secret" {
  description = "Whether to generate a secret for the user pool client"
  type        = bool
  default     = false
}


variable "explicit_auth_flows" {
  description = "List of explicit authentication flows enabled for the user pool client."
  type        = list(string)
  default     = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_CUSTOM_AUTH"]
}

variable "allowed_oauth_flows" {
  description = "The allowed OAuth flows"
  type        = list(string)
  default     = ["code"]
}

variable "allowed_oauth_scopes" {
  description = "The allowed OAuth scopes"
  type        = list(string)
  default     = ["openid", "profile","email"]
}

variable "callback_urls" {
  description = "List of callback URLs for the user pool client"
  type        = list(string)
  default     = []
}

variable "logout_urls" {
  description = "List of logout URLs for the user pool client"
  type        = list(string)
  default     = []
}

variable "supported_identity_providers" {
  description = "List of identity providers supported by the user pool client"
  type        = list(string)
  default     = ["COGNITO"]
}

variable "users" {
  description = "List of users to create"
  type = list(object({
    username = string
    email    = string
  }))
  default = []
}



variable "user_pool_domain_name" {
  description = "Optional domain name for the Cognito User Pool. Defaults to the user pool ID if not provided."
  type        = string
  default     = null
}

variable "email_message_template" {
  description = "The template for the email message sent during user creation"
  type        = string
  default     = "Your username is {username} and temporary password is {####}"
}

variable "email_subject_template" {
  description = "The subject of the email sent during user creation"
  type        = string
  default     = "Your temporary password"
}

variable "sms_message_template" {
  description = "The template for the SMS message sent during user creation"
  type        = string
  default     = "Your username is {username} and temporary password is {####}"
}

