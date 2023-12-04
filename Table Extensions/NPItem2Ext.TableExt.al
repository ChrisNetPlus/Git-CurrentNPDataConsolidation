tableextension 50435 "NP Item2Ext" extends Item
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
