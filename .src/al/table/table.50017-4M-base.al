table 50017 "SEI 4M change request"
{
    Caption = '4M change request';
    DataClassification = ToBeClassified;

    fields
    {
        field(010; "Serial Number"; Code[20])
        {
            trigger OnValidate()
            begin
                if "Serial Number" <> xRec."Serial Number" then begin
                    ManSetup.Get();
                    NoSeriesMgmnt.TestManual(ManSetup."Change management nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(011; "Status"; Option) { OptionMembers = Prepare,Active,Closed,"Under Approval"; InitValue = Prepare; }
        field(015; "Version"; Integer) { }
        field(020; "Area"; Option) { OptionMembers = FFC,MDH; }
        field(030; "Request by"; Code[50]) { }
        field(035; "Request by GUID"; Guid) { }
        field(040; "Request date"; Date) { }
        field(050; "Item number"; Code[20]) { TableRelation = Item."No."; }
        field(060; "Item description"; Text[250]) { }
        field(065; "Man / Machine description"; Text[250]) { }
        field(066; "Machine center"; Code[20]) { TableRelation = "Machine Center"; }
        field(070; "Type of 4M request"; Option) { OptionMembers = Temporary,Permanent; }
        field(080; "Scope of 4M request"; Option) { OptionMembers = Material,Method,Man,Machine; }
        field(090; "Work order numner"; Code[50]) { }
        field(100; "Duration of 4M"; Date) { }
        field(110; "Current regulation"; Blob) { }
        field(120; "Prupose of change with reason"; Blob) { }
        //field(130; "Attachment"; Blob) { }
        field(140; "Customer name"; Text[100]) { }
        field(145; "Customer item"; Code[50]) { }
        field(150; "Special work instruction"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(160; "Production release"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(165; "Customer notify"; Boolean) { InitValue = false; }
        field(166; "Work instruction details"; Blob) { }
        field(167; "Work instruction attachment"; Blob) { }
        field(170; "APQP"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(180; "Evaluation required"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(190; "Waiver"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(195; "Waiver number"; Code[20]) { }
        field(200; "PCN"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(205; "PCN number"; Code[20]) { }
        field(210; "Test production"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(220; "Test production quantity"; Integer) { }
        //field(230; "Cost of change"; Integer) { }
        field(240; "DE approved"; Option) { OptionMembers = Pending,Approved,Denied; InitValue = Pending; }
        field(245; "DE approved date"; Date) { }
        field(246; "DE approved user"; Text[40]) { }
        field(250; "PE approved"; Option) { OptionMembers = Approved,Denied,Pending; InitValue = Pending; }
        field(255; "PE approved date"; Date) { }
        field(256; "PE approved user"; Text[40]) { }
        field(260; "ENG leader approved"; Option) { OptionMembers = Approved,Denied,Pending; InitValue = Pending; }
        field(265; "ENG leader approved date"; Date) { }
        field(266; "ENG leade user"; Text[40]) { }
        field(270; "PP approved"; Option) { OptionMembers = Approved,Denied,Pending; InitValue = Pending; }
        field(275; "PP approved date"; Date) { }
        field(276; "PP approved user"; Text[40]) { }
        field(280; "Prod. manager approved"; Option) { OptionMembers = Approved,Denied,Pending; InitValue = Pending; }
        field(285; "Prod. manager approved date"; Date) { }
        field(286; "Prod. manager user"; Text[40]) { }
        field(290; "QA engineer approved"; Option) { OptionMembers = Approved,Denied,Pending; InitValue = Pending; }
        field(295; "QA engineer approved date"; Date) { }
        field(296; "QA approved user"; Text[40]) { }
        field(300; "Final decision"; Option) { OptionMembers = Approved,Denied,Pending; InitValue = Pending; }
        field(305; "Final decision date"; Date) { }
        field(306; "Final approved user"; Text[40]) { }
        field(310; "DE approve comments"; Text[300]) { }
        field(311; "PE approve comments"; Text[300]) { }
        field(312; "ENG approve comments"; Text[300]) { }
        field(313; "PP approve comments"; Text[300]) { }
        field(314; "ProdMan approve comments"; Text[300]) { }
        field(315; "QA approve comments"; Text[300]) { }
        field(316; "Final decision comments"; Text[300]) { }
        field(320; "No. Series"; Code[20])
        {
            Caption = 'No. Serise';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(330; "Cost estimation"; Decimal) { }
        field(335; "Unit of cost est."; Text[10]) { TableRelation = "Unit of Measure"; }
        field(340; "Waiver attachment"; Blob) { }
        field(350; "Measure attachment"; Blob) { }
        field(360; "PCN attachment"; Blob) { }
        field(370; "WI attachment"; Blob) { }
        //azért van fordítva, mert a vezérlők elérhetőségét ezzel vezérlem.
        field(380; "isDEApproved"; Boolean) { InitValue = true; }
        field(390; "isPEApproved"; Boolean) { InitValue = true; }
        field(400; "isENGLeaderApproved"; Boolean) { InitValue = true; }
        field(410; "isPPApproved"; Boolean) { InitValue = true; }
        field(420; "isProdManApproved"; Boolean) { InitValue = true; }
        field(430; "isQAApproved"; Boolean) { InitValue = true; }
        field(440; "isFinalApproved"; Boolean) { InitValue = true; }
        field(450; "isHeaderEditable"; Boolean) { InitValue = true; }
        field(460; "isNotificationSent"; Boolean) { InitValue = false; }
        field(465; "isFinalNotificationSent"; Boolean) { InitValue = false; }

    }

    keys
    {
        key(PK; "Serial Number") { Clustered = true; }
    }

    var
        myInt: Integer;
        NoSeriesMgmnt: Codeunit NoSeriesManagement;
        ManSetup: Record "Manufacturing Setup";

    trigger OnInsert()
    begin
        if "Serial Number" = '' then begin

            ManSetup.Get();
            ManSetup.TestField("Change management nos");
            NoSeriesMgmnt.InitSeries(ManSetup."Change management nos", xRec."No. Series", 0D, "Serial Number", "No. Series");
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}