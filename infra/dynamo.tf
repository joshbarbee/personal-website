
resource "aws_dynamodb_table" "website-tracking-table" {
    name           = "website-tracking-table"
    billing_mode   = "PAY_PER_REQUEST"
    hash_key       = "UUID"
    range_key = "Timestamp"

    attribute {
        name = "UUID"
        type = "S"
    }

    attribute {
        name = "Timestamp"
        type = "N"
    }

    ttl {
        attribute_name = "TTL"
        enabled        = true
    }

    global_secondary_index {
        name            = "FingerprintIndex"
        hash_key        = "Fingerprint"
        projection_type = "INCLUDE"
        non_key_attributes = ["Actions"]
    }

    attribute {
        name = "Fingerprint"
        type = "N"
    }
}
    
    