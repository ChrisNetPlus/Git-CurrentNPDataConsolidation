tableextension 50436 "NP VendBankExt" extends "Vendor Bank Account"
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
