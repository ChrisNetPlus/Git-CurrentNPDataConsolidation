tableextension 50431 "NP VendorExt" extends Vendor
{
    fields
    {
        field(50430; "NP Consolidated"; Boolean)
        {
            Caption = 'Consolidated';
            DataClassification = SystemMetadata;
        }
        field(50431; "NP Company Name"; Text[50])
        {
            Caption = 'Company Name';
            DataClassification = SystemMetadata;
        }
    }
    trigger OnAfterModify()
    begin
        "NP Consolidated" := false;
        Modify();
    end;
}
