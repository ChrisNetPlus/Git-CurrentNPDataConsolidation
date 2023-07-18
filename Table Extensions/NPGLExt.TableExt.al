tableextension 50433 "NP GLExt" extends "G/L Account"
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
