table 50432 "NP Modular Plus Vendors"
{
    Caption = 'Modular Plus Vendors';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Company; Code[50])
        {
            Caption = 'Company';
            DataClassification = CustomerContent;
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(4; Address; Text[100])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(5; "Address 2"; Text[100])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(6; City; Text[100])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(7; Contact; Text[100])
        {
            Caption = 'Contact';
            DataClassification = CustomerContent;
        }
        field(8; "Phone No."; Text[20])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }
        field(9; "Post Code"; Text[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
        }
        field(10; County; Text[100])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
        field(11; "E-Mail"; Text[50])
        {
            Caption = 'E-Mail';
            DataClassification = CustomerContent;
        }
        field(12; "Home Page"; Text[50])
        {
            Caption = 'Home Page';
            DataClassification = CustomerContent;
        }
        field(13; "Primary Contact No."; Text[100])
        {
            Caption = 'Primary Contact No.';
            DataClassification = CustomerContent;
        }
        field(14; "Mobile Phone No."; Text[50])
        {
            Caption = 'Mobile Phone No.';
            DataClassification = CustomerContent;
        }
        field(15; "Company Registration No."; Text[50])
        {
            Caption = 'Company Registration No.';
            DataClassification = CustomerContent;
        }
        field(16; "Vendor Type"; Text[50])
        {
            Caption = 'Vendor Type';
            DataClassification = CustomerContent;
        }
        field(17; Transferred; Boolean)
        {
            Caption = 'Transferred';
            DataClassification = CustomerContent;
        }
        field(18; Deleted; Boolean)
        {
            Caption = 'Deleted';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; Company, "Vendor No.")
        {
            Clustered = true;
        }
    }
}
