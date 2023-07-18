table 50430 "NP Company List Update"
{
    Caption = 'Company List Update';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Company Name"; Text[50])
        {
            Caption = 'Company Name';
            DataClassification = SystemMetadata;
        }
        field(2; "Update"; Boolean)
        {
            Caption = 'Update Company';
            DataClassification = SystemMetadata;
        }
        field(3; "Master Company"; Boolean)
        {
            Caption = 'Master Company';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Company Name")
        {
            Clustered = true;
        }
    }
}
