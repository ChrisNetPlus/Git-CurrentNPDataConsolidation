table 50433 "NP Modular Plus Setup"
{
    Caption = 'Modular Plus Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PK; Code[20])
        {
            Caption = 'PK';
            DataClassification = SystemMetadata;
        }
        field(2; "Modular Plus Webservice URL"; Text[1024])
        {
            Caption = 'Modular Plus Webservice URL';
            DataClassification = SystemMetadata;
        }
        field(3; Username; Text[100])
        {
            Caption = 'Username';
            DataClassification = SystemMetadata;
        }
        field(4; Password; Guid)
        {
            Caption = 'Password';
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
            trigger OnValidate()
            begin
                SetPassword1(Password);
                Commit;
            end;
        }
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
    procedure SetPassword1(NewPassword: Text)
    var
        EncryptionManagement: Codeunit "Cryptography Management";
    begin
        if IsNullGuid(Username) then
            Username := CreateGuid;

        if IsolatedStorage.Contains(Username, DataScope::Module) then
            IsolatedStorage.Delete(Username, DataScope::Module);

        if EncryptionManagement.IsEncryptionEnabled() and EncryptionManagement.IsEncryptionPossible() then
            NewPassword := EncryptionManagement.EncryptText(NewPassword);

        IsolatedStorage.Set(Username, NewPassword, DATASCOPE::Module);
    end;

}