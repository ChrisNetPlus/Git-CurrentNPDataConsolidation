pageextension 50430 "NP Comapny Info Extension" extends "Company Information"
{
    layout
    {
        addbefore(Name)
        {
            field("NP Master Data Company"; Rec."NP Master Data Company")
            {
                ApplicationArea = All;
                Caption = 'Master Data Company';
                ToolTip = 'Defines this company as the Master Data Company';
            }
            field("NP Data Company"; Rec."NP Data Company")
            {
                ApplicationArea = All;
                Caption = 'Default Master Data Company';
                ToolTip = 'This identifies the Master Data Company';
            }
            field("NP Limit Changes to Master Co."; Rec."NP Limit Changes to Master Co.")
            {
                ApplicationArea = All;
                Caption = 'Limit Changes to Master Company';
                ToolTip = 'This will limit Changes to the Master Company Only';
            }
            field("NP Enable Manual Data Upload"; Rec."NP Enable Manual Data Upload")
            {
                ApplicationArea = All;
                Caption = 'Enable Manual Data Upload';
                ToolTip = 'Enable Manual Data Upload';
            }
        }
    }
}
