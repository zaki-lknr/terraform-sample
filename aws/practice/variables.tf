# 環境数
variable "host_count" {
    description = "host count"
    type        = number
    default     = 3
}

variable "host_list" {
    description = "host count"
    type        = list(string)
    default     = [
        "app",
        "db",
    ]
}
