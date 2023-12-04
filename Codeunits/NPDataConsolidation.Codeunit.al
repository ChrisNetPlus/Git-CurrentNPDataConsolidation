codeunit 50430 "NP Data Consolidation"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        begin
            ExportVendorsToModularPlus();
            SendRequest();
        end;
    end;

    procedure UpdateVendor()
    var
        Company: Record Company;
        CompanyInfo: Record "Company Information";
        CompanyList: Record "NP Company List Update";
        Vendor: Record Vendor;
        NewVendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        NewVendorBankAccount: Record "Vendor Bank Account";
        ErrorTxt: Label 'This function can only be used in the Master Data Company';
        CloseMessage: Label '%1 records Updated';
        CompanyCount: Integer;
    begin
        Clear(CompanyCount);
        Vendor.SetRange("NP Consolidated", false);
        if Vendor.FindSet() then
            repeat
                CompanyInfo.Get();
                Company.Get(CompanyName);
                if not CompanyInfo."NP Master Data Company" then
                    Error(ErrorTxt);
                CompanyList.SetRange(Update, true);
                if CompanyList.FindSet() then
                    repeat
                        CompanyCount += 1;
                        Clear(NewVendor);
                        NewVendor.ChangeCompany(CompanyList."Company Name");
                        NewVendor.TransferFields(Vendor);
                        NewVendor."NP Consolidated" := true;
                        if not NewVendor.Insert() then
                            NewVendor.Modify();
                        VendorBankAccount.SetRange("Vendor No.", Vendor."No.");
                        if VendorBankAccount.FindFirst() then begin
                            Clear(NewVendorBankAccount);
                            NewVendorBankAccount.ChangeCompany(CompanyList."Company Name");
                            NewVendorBankAccount.TransferFields(VendorBankAccount);
                            if not NewVendorBankAccount.Insert() then
                                NewVendorBankAccount.Modify();
                            UpdateLog(CompanyList."Company Name", 'Vendor Bank', Vendor.Name, 'Update');
                        end;
                        UpdateLog(CompanyList."Company Name", 'Vendor', Vendor.Name, 'Update');
                    Until CompanyList.Next() = 0;
                Vendor."NP Consolidated" := true;
                Vendor.Modify();
            until Vendor.Next() = 0;
        if GuiAllowed then
            Message(CloseMessage, CompanyCount);
    end;

    procedure UpdateVendorBank()
    var
        Company: Record Company;
        CompanyInfo: Record "Company Information";
        CompanyList: Record "NP Company List Update";
        VendorBankAccount: Record "Vendor Bank Account";
        NewVendorBankAccount: Record "Vendor Bank Account";
        ErrorTxt: Label 'This function can only be used in the Master Data Company';
        CloseMessage: Label '%1 records Updated';
        CompanyCount: Integer;
    begin
        Clear(CompanyCount);
        VendorBankAccount.SetRange("NP Consolidated", false);
        if VendorBankAccount.FindSet() then
            repeat
                CompanyInfo.Get();
                Company.Get(CompanyName);
                if not CompanyInfo."NP Master Data Company" then
                    Error(ErrorTxt);
                CompanyList.SetRange(Update, true);
                if CompanyList.FindSet() then
                    repeat
                        CompanyCount += 1;
                        Clear(NewVendorBankAccount);
                        NewVendorBankAccount.ChangeCompany(CompanyList."Company Name");
                        NewVendorBankAccount.TransferFields(VendorBankAccount);
                        NewVendorBankAccount."NP Consolidated" := true;
                        if not NewVendorBankAccount.Insert() then
                            NewVendorBankAccount.Modify();
                        UpdateLog(CompanyList."Company Name", 'Vendor Bank', VendorBankAccount.Name, 'Update');
                    Until CompanyList.Next() = 0;
            until VendorBankAccount.Next() = 0;
        if GuiAllowed then
            Message(CloseMessage, CompanyCount);
    end;

    procedure UpdateCustomer()
    var
        Company: Record Company;
        CompanyInfo: Record "Company Information";
        CompanyList: Record "NP Company List Update";
        Customer: Record Customer;
        NewCustomer: Record Customer;
        VendorBankAccount: Record "Vendor Bank Account";
        NewVendorBankAccount: Record "Vendor Bank Account";
        ErrorTxt: Label 'This function can only be used in the Master Data Company';
        CloseMessage: Label '%1 records Updated';
        CompanyCount: Integer;
    begin
        Clear(CompanyCount);
        Customer.SetRange("NP Consolidated", false);
        if Customer.FindSet() then
            repeat
                CompanyInfo.Get();
                Company.Get(CompanyName);
                if not CompanyInfo."NP Master Data Company" then
                    Error(ErrorTxt);
                CompanyList.SetRange(Update, true);
                if CompanyList.FindSet() then
                    repeat
                        CompanyCount += 1;
                        Clear(NewCustomer);
                        NewCustomer.ChangeCompany(CompanyList."Company Name");
                        NewCustomer.TransferFields(Customer);
                        NewCustomer."NP Consolidated" := true;
                        if not NewCustomer.Insert() then
                            NewCustomer.Modify();
                        UpdateLog(CompanyList."Company Name", 'Customer', Customer.Name, 'Update');
                    Until CompanyList.Next() = 0;
                Customer."NP Consolidated" := true;
                Customer.Modify();
            until Customer.Next() = 0;
        if GuiAllowed then
            Message(CloseMessage, CompanyCount);
    end;

    procedure UpdateGLCode()
    var
        Company: Record Company;
        CompanyInfo: Record "Company Information";
        CompanyList: Record "NP Company List Update";
        GL: Record "G/L Account";
        NewGL: Record "G/L Account";
        ErrorTxt: Label 'This function can only be used in the Master Data Company';
        CloseMessage: Label '%1 records Updated';
        CompanyCount: Integer;
    begin
        Clear(CompanyCount);
        GL.SetRange("NP Consolidated", false);
        if GL.FindSet() then
            repeat
                CompanyInfo.Get();
                Company.Get(CompanyName);
                if not CompanyInfo."NP Master Data Company" then
                    Error(ErrorTxt);
                CompanyList.SetRange(Update, true);
                if CompanyList.FindSet() then
                    repeat
                        CompanyCount += 1;
                        Clear(NewGL);
                        NewGL.ChangeCompany(CompanyList."Company Name");
                        NewGL.TransferFields(GL);
                        NewGL."NP Consolidated" := true;
                        if not NewGL.Insert() then
                            NewGL.Modify();
                        UpdateLog(CompanyList."Company Name", 'GL Account', GL.Name, 'Update');
                    Until CompanyList.Next() = 0;
            until GL.Next() = 0;
        if GuiAllowed then
            Message(CloseMessage, CompanyCount);
    end;

    procedure UpdateItems()
    var
        Company: Record Company;
        CompanyInfo: Record "Company Information";
        CompanyList: Record "NP Company List Update";
        Item: Record Item;
        NewItem: Record Item;
        SKU: Record "Stockkeeping Unit";
        NewSKU: Record "Stockkeeping Unit";
        ErrorTxt: Label 'This function can only be used in the Master Data Company';
        CloseMessage: Label '%1 records Updated';
        CompanyCount: Integer;
    begin
        Clear(CompanyCount);
        Item.SetRange("NP Consolidated", false);
        if Item.FindSet() then
            repeat
                CompanyInfo.Get();
                Company.Get(CompanyName);
                if not CompanyInfo."NP Master Data Company" then
                    Error(ErrorTxt);
                CompanyList.SetRange(Update, true);
                if CompanyList.FindSet() then
                    repeat
                        CompanyCount += 1;
                        Clear(NewItem);
                        NewItem.ChangeCompany(CompanyList."Company Name");
                        NewItem.TransferFields(Item);
                        NewItem."NP Consolidated" := true;
                        if not NewItem.Insert() then
                            NewItem.Modify();
                        UpdateLog(CompanyList."Company Name", 'Item', Item."No.", 'Update');
                    Until CompanyList.Next() = 0;
                Item."NP Consolidated" := true;
                Item.Modify();
                SKU.SetRange("Item No.", Item."No.");
                if SKU.FindSet() then
                    repeat
                        NewSKU.ChangeCompany(CompanyList."Company Name");
                        NewSKU.TransferFields(SKU);
                        if not NewSKU.Insert() then
                            NewSKU.Modify();
                        UpdateLog(CompanyList."Company Name", 'SKU', SKU."Location Code", 'Update');
                    until
                SKU.Next() = 0;
            until Item.Next() = 0;
        if GuiAllowed then
            Message(CloseMessage, CompanyCount);
    end;

    procedure UpdateDimensionValue()
    var
        Company: Record Company;
        CompanyInfo: Record "Company Information";
        CompanyList: Record "NP Company List Update";
        DimValue: Record "Dimension Value";
        NewDimValue: Record "Dimension Value";
        ContractWorkstreams: Record "NP Contract Workstreams";
        NewContractWorkstreams: Record "NP Contract Workstreams";
        ErrorTxt: Label 'This function can only be used in the Master Data Company';
        CloseMessage: Label '%1 records Updated';
        CompanyCount: Integer;
    begin
        Clear(CompanyCount);
        DimValue.Reset();
        DimValue.SetRange("NP Consolidated", false);
        if DimValue.FindSet() then
            repeat
                CompanyInfo.Get();
                Company.Get(CompanyName);
                if not CompanyInfo."NP Master Data Company" then
                    Error(ErrorTxt);
                CompanyList.SetRange(Update, true);
                if CompanyList.FindSet() then
                    repeat
                        CompanyCount += 1;
                        Clear(NewDimValue);
                        NewDimValue.ChangeCompany(CompanyList."Company Name");
                        NewDimValue.TransferFields(DimValue);
                        NewDimValue."NP Consolidated" := true;
                        if not NewDimValue.Insert() then
                            NewDimValue.Modify();
                        UpdateLog(CompanyList."Company Name", DimValue."Dimension Code", DimValue.Code, 'Update');
                    Until CompanyList.Next() = 0;
                DimValue."NP Consolidated" := true;
                DimValue.Modify();
            until DimValue.Next() = 0;
        if GuiAllowed then
            Message(CloseMessage, CompanyCount);
    end;

    procedure CheckConsolidationEnabled(): Integer
    var
        Company: Record Company;
        CompanyInf: Record "Company Information";
        Enabled: Integer;
    begin
        Clear(Enabled);
        if Company.FindSet() then
            repeat
                Clear(CompanyInf);
                CompanyInf.ChangeCompany(Company.Name);
                CompanyInf.Get();
                if CompanyInf."NP Master Data Company" = true then
                    Enabled += 1;
            until Company.Next() = 0;
        exit(Enabled);
    end;

    local procedure UpdateLog(CompanyName: Text; RecordType: Text; RecordTxt: Text; ChangeType: Text)
    var
        DataMgmntLog: Record "NP Data Management Log";
        EntryNo: Integer;
    begin
        if DataMgmntLog.FindLast() then
            EntryNo := DataMgmntLog."Entry No." + 1
        else
            EntryNo := 1;
        Clear(DataMgmntLog);
        DataMgmntLog."Entry No." := EntryNo;
        DataMgmntLog."Company Name" := CompanyName;
        DataMgmntLog."Record Type" := RecordType;
        DataMgmntLog.Record := RecordTxt;
        DataMgmntLog."Change Type" := ChangeType;
        DataMgmntLog."Record Date" := Today;
        DataMgmntLog.Insert();
    end;

    procedure CopyVendorData(var Vendor: Record Vendor; Company: Text[50]; Deleted: Boolean)
    var
        ModPlusVendor: Record "NP Modular Plus Vendors";
        VenBankAcc: Record "Vendor Bank Account";
        CompanyInfo: Record "Company Information";
        VendorRec: Record Vendor;
    begin
        if CompanyInfo."NP Master Data Company" = false then begin
            ModPlusVendor.Init();
            ModPlusVendor.Address := Vendor.Address;
            ModPlusVendor."Address 2" := Vendor."Address 2";
            ModPlusVendor."Vendor No." := Vendor."No.";
            ModPlusVendor.Name := Vendor.Name;
            ModPlusVendor.Company := CompanyName;
            ModPlusVendor.City := Vendor.City;
            ModPlusVendor."Company Registration No." := Vendor."NP Company Registration No.";
            ModPlusVendor.Contact := Vendor.Contact;
            ModPlusVendor.County := Vendor.County;
            ModPlusVendor."E-Mail" := Vendor."E-Mail";
            ModPlusVendor."Home Page" := Vendor."Home Page";
            ModPlusVendor."Mobile Phone No." := Vendor."Mobile Phone No.";
            ModPlusVendor."Phone No." := Vendor."Phone No.";
            ModPlusVendor."Post Code" := Vendor."Post Code";
            ModPlusVendor."Primary Contact No." := Vendor."Primary Contact No.";
            ModPlusVendor."Gen. Bus. Posting Group" := Vendor."Gen. Bus. Posting Group";
            ModPlusVendor."VAT Bus. Posting Group" := Vendor."VAT Bus. Posting Group";
            ModPlusVendor."Vendor Posting Group" := Vendor."Vendor Posting Group";
            ModPlusVendor."AP Contact" := Vendor."AP Contact";
            ModPlusVendor.NPSCL := Vendor."NP NPSCL";
            ModPlusVendor."Insurance Broker" := Vendor."NP Insurance Broker";
            ModPlusVendor."Value Insured" := Vendor."NP Value Insured";
            ModPlusVendor."Payment Terms Code" := Vendor."Payment Terms Code";
            VenBankAcc.Reset();
            VenBankAcc.SetRange("Vendor No.", Vendor."No.");
            if VenBankAcc.FindFirst() then begin
                ModPlusVendor."Bank Acc. Code" := VenBankAcc.Code;
                ModPlusVendor."Bank Account No." := VenBankAcc."Bank Account No.";
                ModPlusVendor."Bank Branch No." := VenBankAcc."Bank Branch No.";
                ModPlusVendor."Bank Name" := VenBankAcc.Name;
            end;
            if not ModPlusVendor.Insert() then
                ModPlusVendor.Modify();
        end;
    end;

    procedure CopyCustomerData(var Customer: Record Customer; Company: Text[50]; Deleted: Boolean)
    var
        NPCustomers: Record "NP Customers";
        CompanyInfo: Record "Company Information";
        CustomerRec: Record Customer;
    begin
        if CompanyInfo."NP Master Data Company" = false then begin
            NPCustomers.Init();
            NPCustomers.Company := CompanyName;
            NPCustomers.Address := Customer.Address;
            NPCustomers."Address 2" := Customer."Address 2";
            NPCustomers."Customer No." := Customer."No.";
            NPCustomers.Name := Customer.Name;
            NPCustomers."InspHire Cust. No." := Customer."InspHire Customer No.";
            NPCustomers.City := Customer.City;
            NPCustomers."Company Registration No." := Customer."Registration Number";
            NPCustomers.Contact := Customer.Contact;
            NPCustomers.County := Customer.County;
            NPCustomers."E-Mail" := Customer."E-Mail";
            NPCustomers."Home Page" := Customer."Home Page";
            NPCustomers."Mobile Phone No." := Customer."Mobile Phone No.";
            NPCustomers."Phone No." := Customer."Phone No.";
            NPCustomers."Post Code" := Customer."Post Code";
            NPCustomers."Primary Contact No." := Customer."Primary Contact No.";
            NPCustomers."Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
            NPCustomers."VAT Bus. Posting Group" := Customer."VAT Bus. Posting Group";
            NPCustomers."Customer Posting Group" := Customer."Customer Posting Group";
            NPCustomers."Payment Terms Code" := Customer."Payment Terms Code";
            if not NPCustomers.Insert() then
                NPCustomers.Modify();
        end;
    end;

    procedure UpdateVendors()
    var
        Company: Record Company;
        CompanyInfo: Record "Company Information";
        ModPlusVendor: Record "NP Modular Plus Vendors";
        DataModPlusVendor: Record "NP Modular Plus Vendors";
        CompanyCount: Integer;
        Window: Dialog;
        ErrorMessage: Label 'The Master Data Company must be selected in the Company Information';
    begin
        Clear(CompanyCount);
        CompanyInfo.Get();
        if not CompanyInfo."NP Master Data Company" = true then begin
            if CompanyInfo."NP Data Company" = '' then
                Error(ErrorMessage);
        end;
        if GuiAllowed then
            Window.Open('##1####################');
        if ModPlusVendor.FindSet() then
            repeat
                Clear(DataModPlusVendor);
                if GuiAllowed then
                    Window.Update(1, ModPlusVendor."Vendor No.");
                DataModPlusVendor.ChangeCompany(CompanyInfo."NP Data Company");
                DataModPlusVendor.TransferFields(ModPlusVendor);
                if not DataModPlusVendor.Insert() then
                    DataModPlusVendor.Modify(false);
                Commit();
            Until ModPlusVendor.Next() = 0;
        if GuiAllowed then
            Message('Transfer Complete');
        Window.Close();
    end;

    procedure UpdateCustomers()
    var
        Company: Record Company;
        CompanyInfo: Record "Company Information";
        NPCustomers: Record "NP Customers";
        DataNPCustomers: Record "NP Customers";
        CompanyCount: Integer;
        Window: Dialog;
        ErrorMessage: Label 'The Master Data Company must be selected in the Company Information';
    begin
        Clear(CompanyCount);
        CompanyInfo.Get();
        if not CompanyInfo."NP Master Data Company" = true then begin
            if CompanyInfo."NP Data Company" = '' then
                Error(ErrorMessage);
        end;
        if GuiAllowed then
            Window.Open('##1####################');
        if NPCustomers.FindSet() then
            repeat
                Clear(DataNPCustomers);
                if GuiAllowed then
                    Window.Update(1, NPCustomers."Customer No.");
                DataNPCustomers.ChangeCompany(CompanyInfo."NP Data Company");
                DataNPCustomers.TransferFields(NPCustomers);
                if not DataNPCustomers.Insert() then
                    DataNPCustomers.Modify(false);
                Commit();
            Until NPCustomers.Next() = 0;
        if GuiAllowed then
            Message('Transfer Complete');
        Window.Close();
    end;

    procedure InsertModPlusVendor(var Vendor: Record Vendor)
    var
        Company: Record Company;
        CompanyInfo: Record "Company Information";
        ModPlusVendor: Record "NP Modular Plus Vendors";
        DataModPlusVendor: Record "NP Modular Plus Vendors";
        CompanyCount: Integer;
    begin
        CompanyInfo.Get();
        if not CompanyInfo."NP Master Data Company" = true then begin
            ModPlusVendor.SetRange("Vendor No.", Vendor."No.");
            ModPlusVendor.SetRange(Company, CompanyName);
            if ModPlusVendor.FindFirst() then begin
                Clear(DataModPlusVendor);
                DataModPlusVendor.ChangeCompany(CompanyInfo."NP Data Company");
                DataModPlusVendor.TransferFields(ModPlusVendor);
                if not DataModPlusVendor.Insert() then
                    DataModPlusVendor.Modify();
            end else begin
                Clear(DataModPlusVendor);
                DataModPlusVendor.ChangeCompany(CompanyInfo."NP Data Company");
                DataModPlusVendor.TransferFields(ModPlusVendor);
                if not DataModPlusVendor.Insert() then
                    DataModPlusVendor.Modify();
            end;
        end;
    end;

    procedure CreateMasterDataRecords()
    var
        VendorDataList: Record "NP Modular Plus Vendors";
        Vendor: Record Vendor;
        VendorBank: Record "Vendor Bank Account";
        Window: Dialog;
    begin
        Window.Open('##1####################');
        if VendorDataList.FindSet() then
            repeat
                Window.Update(1, VendorDataList."Vendor No.");
                Vendor.Init();
                Vendor."No." := VendorDataList."Vendor No.";
                Vendor.Name := VendorDataList.Name;
                Vendor."NP Company Name" := VendorDataList.Company;
                Vendor.Address := VendorDataList.Address;
                Vendor."Address 2" := VendorDataList."Address 2";
                Vendor.City := VendorDataList.City;
                Vendor.County := VendorDataList.County;
                Vendor."Post Code" := VendorDataList."Post Code";
                Vendor."Primary Contact No." := VendorDataList."Primary Contact No.";
                Vendor.Contact := VendorDataList.Contact;
                Vendor."Phone No." := VendorDataList."Phone No.";
                Vendor."Mobile Phone No." := VendorDataList."Mobile Phone No.";
                Vendor."E-Mail" := VendorDataList."E-Mail";
                Vendor."Home Page" := VendorDataList."Home Page";
                Vendor."Gen. Bus. Posting Group" := VendorDataList."Gen. Bus. Posting Group";
                Vendor."VAT Bus. Posting Group" := VendorDataList."VAT Bus. Posting Group";
                Vendor."Vendor Posting Group" := VendorDataList."Vendor Posting Group";
                Vendor."NP Company Registration No." := VendorDataList."Company Registration No.";
                if VendorDataList."Vendor Type" = 'Subcontractor Only' then
                    Vendor."MCI Vendor Type" := Vendor."MCI Vendor Type"::"Subcontractor Only"
                else
                    if VendorDataList."Vendor Type" = 'Vendor Only' then
                        Vendor."MCI Vendor Type" := Vendor."MCI Vendor Type"::"Vendor Only"
                    else
                        if VendorDataList."Vendor Type" = 'Vendor and Subcontractor' then
                            Vendor."MCI Vendor Type" := Vendor."MCI Vendor Type"::"Vendor and Subcontractor";
                Vendor."NP NPSCL" := VendorDataList.NPSCL;
                Vendor."NP Insurance Broker" := VendorDataList."Insurance Broker";
                Vendor."NP Value Insured" := VendorDataList."Value Insured";
                Vendor."NP Consolidated" := true;
                Vendor."Payment Terms Code" := VendorDataList."Payment Terms Code";
                If not Vendor.Insert() then
                    Vendor.Modify();
                Commit();
                VendorBank.Init();
                VendorBank."Vendor No." := VendorDataList."Vendor No.";
                VendorBank.Code := VendorDataList."Bank Acc. Code";
                VendorBank.Name := VendorDataList."Bank Name";
                VendorBank."Bank Account No." := VendorDataList."Bank Account No.";
                VendorBank."Bank Branch No." := VendorDataList."Bank Branch No.";
                if not VendorBank.Insert() then
                    VendorBank.Modify();
                VendorDataList.Delete();
            until VendorDataList.Next() = 0;
        Window.Close();
    end;

    procedure CreateCustDataRecords()
    var
        CustDataList: Record "NP Customers";
        Customer: Record Customer;
        Window: Dialog;
    begin
        Window.Open('##1####################');
        if CustDataList.FindSet() then
            repeat
                Window.Update(1, CustDataList."Customer No.");
                Customer.Init();
                Customer."No." := CustDataList."Customer No.";
                Customer.Name := CustDataList.Name;
                Customer."NP Company Name" := CustDataList.Company;
                Customer.Address := CustDataList.Address;
                Customer."Address 2" := CustDataList."Address 2";
                Customer.City := CustDataList.City;
                Customer.County := CustDataList.County;
                Customer."Post Code" := CustDataList."Post Code";
                Customer."Primary Contact No." := CustDataList."Primary Contact No.";
                Customer.Contact := CustDataList.Contact;
                Customer."Phone No." := CustDataList."Phone No.";
                Customer."Mobile Phone No." := CustDataList."Mobile Phone No.";
                Customer."E-Mail" := CustDataList."E-Mail";
                Customer."Home Page" := CustDataList."Home Page";
                Customer."Registration Number" := CustDataList."Company Registration No.";
                Customer."NP Consolidated" := true;
                Customer."Gen. Bus. Posting Group" := CustDataList."Gen. Bus. Posting Group";
                Customer."VAT Bus. Posting Group" := CustDataList."VAT Bus. Posting Group";
                Customer."Customer Posting Group" := CustDataList."Customer Posting Group";
                Customer."Payment Terms Code" := CustDataList."Payment Terms Code";
                If not Customer.Insert() then
                    Customer.Modify();
                Commit();
                CustDataList.Delete();
            until CustDataList.Next() = 0;
        Window.Close();
    end;

    procedure MarkUpdated()
    var
        GL: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        Item: Record Item;
        DimValue: Record "Dimension Value";
    begin
        GL.Reset();
        GL.SetRange("NP Consolidated", false);
        if GL.FindSet() then
            repeat
                GL."NP Consolidated" := true;
                GL.Modify();
            until GL.Next() = 0;
        Cust.Reset();
        Cust.SetRange("NP Consolidated", false);
        if Cust.FindSet() then
            repeat
                Cust."NP Consolidated" := true;
                Cust.Modify();
            until Cust.Next() = 0;
        Vend.Reset();
        Vend.SetRange("NP Consolidated", false);
        if Vend.FindSet() then
            repeat
                Vend."NP Consolidated" := true;
                Vend.Modify();
            until Vend.Next() = 0;
        Item.Reset();
        Item.SetRange("NP Consolidated", false);
        if Item.FindSet() then
            repeat
                Item."NP Consolidated" := true;
                Item.Modify();
            until Item.Next() = 0;
        Item.Reset();
        DimValue.SetRange("NP Consolidated", false);
        if DimValue.FindSet() then
            repeat
                DimValue."NP Consolidated" := true;
                DimValue.Modify();
            until DimValue.Next() = 0;
    end;
    // [EventSubscriber(ObjectType::Table, Database::"NP Contract Workstreams", 'OnAfterInsertEvent', '', false, false)]
    // local procedure InsertContractWorkstreams(var Rec: Record "NP Contract Workstreams")
    // var
    //     CompanyInfo: Record "Company Information";
    // begin
    //     CompanyInfo.Get();
    //     if CompanyInfo."NP Enable Manual Data Upload" = false then
    //         ChangeDimensionWorkstreamValue(Rec);
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"NP Contract Workstreams", 'OnAfterValidateEvent', 'Description', false, false)]
    // local procedure ModifyContractWorkstreams(var Rec: Record "NP Contract Workstreams")
    // var
    //     CompanyInfo: Record "Company Information";
    // begin
    //     CompanyInfo.Get();
    //     if CompanyInfo."NP Enable Manual Data Upload" = false then
    //         ChangeDimensionWorkstreamValue(Rec);
    // end;

    // procedure ChangeDimensionWorkstreamValue(Dimension: Record "NP Contract Workstreams")
    // var
    //     CompanyInfo: Record "Company Information";
    //     NewDimValue: Record "NP Contract Workstreams";
    // begin
    //     CompanyInfo.Get();
    //     Clear(NewDimValue);
    //     NewDimValue.ChangeCompany(CompanyInfo."NP Data Company");
    //     // NewDimValue.TransferFields(Dimension, false);
    //     NewDimValue."Contract Code" := Dimension."Contract Code";
    //     NewDimValue."Workstream Code" := Dimension."Workstream Code";
    //     NewDimValue.Description := Dimension.Description;
    //     if not NewDimValue.Insert() then
    //         NewDimValue.Modify();
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Dimension Value", 'OnAfterInsertEvent', '', false, false)]
    // local procedure InsertDimension(var Rec: Record "Dimension Value")
    // var
    //     CompanyInfo: Record "Company Information";
    // begin
    //     CompanyInfo.Get();
    //     if CompanyInfo."NP Enable Manual Data Upload" = false then
    //         ChangeDimensionValue(Rec);
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Dimension Value", 'OnAfterValidateEvent', 'Name', false, false)]
    // local procedure ModifyDimension(var Rec: Record "Dimension Value"; var xRec: Record "Dimension Value")
    // var
    //     CompanyInfo: Record "Company Information";
    // begin
    //     CompanyInfo.Get();
    //     if CompanyInfo."NP Enable Manual Data Upload" = false then
    //         ChangeDimensionValue(Rec);
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Dimension Value", 'OnAfterValidateEvent', 'Dimension Value Type', false, false)]
    // local procedure ModifyDimension2(var Rec: Record "Dimension Value")
    // var
    //     CompanyInfo: Record "Company Information";
    // begin
    //     CompanyInfo.Get();
    //     if CompanyInfo."NP Enable Manual Data Upload" = false then
    //         ChangeDimensionValue(Rec);
    // end;

    procedure ChangeDimensionValue(Dimension: Record "Dimension Value")
    var
        CompanyInfo: Record "Company Information";
        NewDimValue: Record "Dimension Value";
    begin
        CompanyInfo.Get();
        begin
            // Clear(NewDimValue);
            // NewDimValue.ChangeCompany(CompanyInfo."NP Data Company");
            // NewDimValue."Dimension Code" := Dimension."Dimension Code";
            // NewDimValue.Code := Dimension.Code;
            // NewDimValue.Name := Dimension.Name;
            // NewDimValue."Dimension Value ID" := Dimension."Dimension Value ID";
            // NewDimValue."Dimension Value Type" := Dimension."Dimension Value Type";
            // if not NewDimValue.Insert(false) then
            //     NewDimValue.Modify(false);
        end;
    end;

    procedure ExportVendorsToModularPlus()
    var
        TempCSVBuffer: Record "CSV Buffer" temporary;
        ModularPlusSetup: Record "NP Modular Plus Setup";
        ModularPlusVendors: Record "NP Modular Plus Vendors";
        CompanyLbl: Label 'Company';
        VendorNoLbl: Label 'Vendor No.';
        NameLbl: Label 'Name';
        AddressLbl: Label 'Address';
        Address2Lbl: Label 'Address 2';
        CityLbl: Label 'City';
        CountyLbl: Label 'County';
        PostCodeLbl: Label 'Post Code';
        PrimaryContactNoLbl: Label 'Primary Contact No.';
        ContactNoLbl: Label 'Contact';
        PhoneNoLbl: Label 'Phone No.';
        MobilePhoneNoLbl: Label 'Mobile Phone No.';
        EmailLbl: Label 'E-Mail';
        HomePageLbl: Label 'Home Page';
        CompanyRegNoLbl: Label 'Company Registration No.';
        VendorTypeLbl: Label 'Vendor Type';
        LineNo: Integer;
        Filename: Text;
        AmountTxt: Text;
    begin
        LineNo := 1;
        TempCSVBuffer.InsertEntry(LineNo, 1, CompanyLbl);
        TempCSVBuffer.InsertEntry(LineNo, 2, VendorNoLbl);
        TempCSVBuffer.InsertEntry(LineNo, 3, NameLbl);
        TempCSVBuffer.InsertEntry(LineNo, 4, AddressLbl);
        TempCSVBuffer.InsertEntry(LineNo, 5, Address2Lbl);
        TempCSVBuffer.InsertEntry(LineNo, 6, CityLbl);
        TempCSVBuffer.InsertEntry(LineNo, 7, CountyLbl);
        TempCSVBuffer.InsertEntry(LineNo, 8, PostCodeLbl);
        TempCSVBuffer.InsertEntry(LineNo, 9, PrimaryContactNoLbl);
        TempCSVBuffer.InsertEntry(LineNo, 10, ContactNoLbl);
        TempCSVBuffer.InsertEntry(LineNo, 11, PhoneNoLbl);
        TempCSVBuffer.InsertEntry(LineNo, 12, MobilePhoneNoLbl);
        TempCSVBuffer.InsertEntry(LineNo, 13, EmailLbl);
        TempCSVBuffer.InsertEntry(LineNo, 14, HomePageLbl);
        TempCSVBuffer.InsertEntry(LineNo, 15, CompanyRegNoLbl);
        TempCSVBuffer.InsertEntry(LineNo, 16, VendorTypeLbl);

        if ModularPlusVendors.FindSet() then
            repeat
                LineNo += 1;
                TempCSVBuffer.InsertEntry(LineNo, 1, ModularPlusVendors.Company);
                TempCSVBuffer.InsertEntry(LineNo, 2, ModularPlusVendors."Vendor No.");
                TempCSVBuffer.InsertEntry(LineNo, 3, ModularPlusVendors.Name);
                TempCSVBuffer.InsertEntry(LineNo, 4, ModularPlusVendors.Address);
                TempCSVBuffer.InsertEntry(LineNo, 5, ModularPlusVendors."Address 2");
                TempCSVBuffer.InsertEntry(LineNo, 6, ModularPlusVendors.City);
                TempCSVBuffer.InsertEntry(LineNo, 7, ModularPlusVendors.County);
                TempCSVBuffer.InsertEntry(LineNo, 8, ModularPlusVendors."Post Code");
                TempCSVBuffer.InsertEntry(LineNo, 9, ModularPlusVendors."Primary Contact No.");
                TempCSVBuffer.InsertEntry(LineNo, 10, ModularPlusVendors.Contact);
                TempCSVBuffer.InsertEntry(LineNo, 11, ModularPlusVendors."Phone No.");
                TempCSVBuffer.InsertEntry(LineNo, 12, ModularPlusVendors."Mobile Phone No.");
                TempCSVBuffer.InsertEntry(LineNo, 13, ModularPlusVendors."E-Mail");
                TempCSVBuffer.InsertEntry(LineNo, 14, ModularPlusVendors."Home Page");
                TempCSVBuffer.InsertEntry(LineNo, 15, ModularPlusVendors."Company Registration No.");
                TempCSVBuffer.InsertEntry(LineNo, 16, ModularPlusVendors."Vendor Type");
            until ModularPlusVendors.Next() = 0;
        TempCSVBuffer.SaveDataToBlob(TempBlob, ',');
    end;

    local procedure SendRequest()
    var
        ModularPlusSetup: Record "NP Modular Plus Setup";
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpResponse: HttpResponseMessage;
        HttpHeaders: HttpHeaders;
        AuthString: Text;
        Base64Convert: Codeunit "Base64 Convert";
        QueryTxt: Text;
        NoSeriesMngt: Codeunit NoSeriesManagement;
        Filename: Text;
    begin
        ModularPlusSetup.Get();
        QueryTxt := ModularPlusSetup."Modular Plus Webservice URL" + '?';
        // QueryTxt += 'TRADEX_SID=DATASTREAM&';
        // QueryTxt += 'PARTNERID=' + PartnerID + '&';
        QueryTxt += 'USERNAME=' + ModularPlusSetup.Username + '&';
        QueryTxt += 'PASSWORD=' + GetPassword1() + '&';
        QueryTxt += 'DOCTYPE=LU&';
        // QueryTxt += 'MESSAGEID=' + NoSeriesMngt.DoGetNextNo(TradeXSetup."Unique Message ID No. Series", Today, true, false);

        TempBlob.CreateInStream(InStr);

        //Enable for Testing -
        // Filename := 'Test CSV.csv';
        // DownloadFromStream(InStr, '', '', '', Filename);

        HttpContent.WriteFrom(InStr);
        HttpClient.Post(QueryTxt, HttpContent, HttpResponse);
        // message(format(HttpResponse.HttpStatusCode));
    end;

    procedure GetPassword1(): Text
    var
        ModularPlusSetup: Record "NP Modular Plus Setup";
        EncryptionManagement: Codeunit "Cryptography Management";
        PasswordTxt: Text;
    begin
        ModularPlusSetup.Get();
        if IsolatedStorage.Contains(ModularPlusSetup.Username, DataScope::Module) then begin

            IsolatedStorage.Get(ModularPlusSetup.Username, DataScope::Module, PasswordTxt);

            if EncryptionManagement.IsEncryptionEnabled() and EncryptionManagement.IsEncryptionPossible() then
                PasswordTxt := EncryptionManagement.Decrypt(PasswordTxt);

            exit(PasswordTxt);
        end;
    end;

    // [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeInsertEvent', '', false, false)]
    // local procedure CheckDataCo()
    // var
    //     CompanyInfo: Record "Company Information";
    // begin
    //     CompanyInfo.Get();
    //     if CompanyInfo."NP Master Data Company" = false then
    //         Error('Inserts only allowed in the Data Company');
    // end;

    // [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterModifyEvent', '', false, false)]
    // local procedure CheckDataCo2(var Rec: Record Vendor)
    // var
    //     CompanyInfo: Record "Company Information";
    // begin
    //     CompanyInfo.Get();
    //     if CompanyInfo."NP Master Data Company" = false then
    //         Error('Changes only allowed in the Data Company');
    // end;

    // [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeDeleteEvent', '', false, false)]
    // local procedure SendDelete(var Rec: Record Vendor)
    // begin
    //     CopyVendorData(Rec, CompanyName, true);
    //     InsertModPlusVendor(Rec);
    // end;

    var
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";
}
