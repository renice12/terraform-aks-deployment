variable "resource_group" {
    type = string
    description = "Name of the resource group to create"
    default = "rgcergiaks"
}

variable "location" {
    type = string
    description = "Localisation de ma ressource"
    default = "West US"
}

variable "node_count_linux" {
    type = number
    description = "Number of Linux nodes"
    default = 1
}

variable "node_count_windows" {
    type = number
    description = "Number of Windows nodes"
    default = 1
}