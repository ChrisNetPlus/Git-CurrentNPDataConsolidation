table 50431 "NP Data Management Log"
{
    Caption = 'Data Management Log';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
            DataClassification = SystemMetadata;
        }
        field(2; "Record Type"; Text[50])
        {
            Caption = 'Record Type';
            DataClassification = SystemMetadata;
        }
        field(3; "Record"; Text[100])
        {
            Caption = 'Record';
            DataClassification = SystemMetadata;
        }
        field(4; "Change Type"; Text[20])
        {
            Caption = 'Change Type';
            DataClassification = SystemMetadata;
        }
        field(5; "Entry No."; Integer)
        {
            Caption = 'Entry Type';
            DataClassification = SystemMetadata;
        }
        field(6; "Record Date"; Date)
        {
            Caption = 'Record Date';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
