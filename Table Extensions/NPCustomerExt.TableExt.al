tableextension 50432 "NP CustomerExt" extends Customer
{
    fields
    {
        field(50430; "NP Consolidated"; Boolean)
        {
            Caption = 'Consolidated';
            DataClassification = SystemMetadata;
        }
    }
    trigger OnAfterModify()
    begin
        "NP Consolidated" := false;
        Modify();
    end;
}

