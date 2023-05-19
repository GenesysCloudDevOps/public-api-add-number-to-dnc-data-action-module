resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "dncListId" = {
                "type" = "string"
            },
            "phoneNumber" = {
                "type" = "string"
            }
        },
        "required" = [
            "dncListId",
            "phoneNumber"
        ],
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
        request_template     = "[ \"$${input.phoneNumber}\" ]"
        request_type         = "POST"
        request_url_template = "/api/v2/outbound/dnclists/$${input.dncListId}/phonenumbers"
    }

    config_response {
        success_template = "$${rawResult}"
    }
}